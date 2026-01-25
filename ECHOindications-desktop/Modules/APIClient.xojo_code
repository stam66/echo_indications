#tag Module
Protected Module APIClient
	#tag Method, Flags = &h21
		Private Function BuildURL(endpoint As String, action As String, params As Dictionary) As String
		  Var url As String = AppConfig.API_BASE_URL + "/" + endpoint + "?action=" + action
		  
		  If params <> Nil Then
		    For Each key As Variant In params.Keys
		      Var value As Variant = params.Value(key)
		      url = url + "&" + key.StringValue + "=" + EncodeURLComponent(value.StringValue)
		    Next
		  End If
		  
		  Return url
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateErrorResponse(message As String, errorCode As String = "") As Dictionary
		  Var result As New Dictionary
		  result.Value("status") = "error"
		  result.Value("message") = message
		  If errorCode.Length > 0 Then
		    result.Value("errorCode") = errorCode
		  End If

		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("APIClient error: " + message)
		  End If

		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(endpoint As String, action As String, params As Dictionary = Nil) As Dictionary
		  
		  Var url As String = BuildURL(endpoint, action, params)
		  
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("APIClient.Get: " + url)
		  End If
		  
		  Try
		    Var socket As New URLConnection
		    socket.RequestHeader("User-Agent") = AppConfig.APP_NAME + "/" + AppConfig.APP_VERSION
		    socket.RequestHeader("Accept") = "application/json"
		    
		    If AuthManager.IsAuthenticated Then
		      socket.RequestHeader("Authorization") = AuthManager.GetAuthHeader
		    End If
		    
		    // Make request (no timeout setting available in this Xojo version)
		    Var response As String = socket.SendSync("GET", url)
		    
		    // Check HTTP status
		    Var httpStatus As Integer = socket.HTTPStatusCode

		    Select Case httpStatus
		    Case 200
		      Return ParseResponse(response)

		    Case 401
		      If AuthManager.IsAuthenticated Then
		        AuthManager.Logout
		        Return CreateErrorResponse("Your session has expired. Please log in again.", "SESSION_EXPIRED")
		      Else
		        Return ParseErrorResponse(response, "Authentication required.", "UNAUTHORIZED")
		      End If

		    Case 403
		      Return CreateErrorResponse("Access denied.", "FORBIDDEN")

		    Case 404
		      Return CreateErrorResponse("The requested resource was not found.", "NOT_FOUND")

		    Case 429
		      Return CreateErrorResponse("Too many requests. Please wait a moment and try again.", "RATE_LIMITED")

		    Case 500, 502, 503
		      Return CreateErrorResponse("Server error. Please try again later.", "SERVER_ERROR")

		    Case 504
		      Return CreateErrorResponse("The server took too long to respond. Please try again.", "GATEWAY_TIMEOUT")

		    Else
		      Return ParseErrorResponse(response, "Unexpected error (HTTP " + httpStatus.ToString + ").", "HTTP_" + httpStatus.ToString)

		    End Select

		  Catch err As IOException
		    Return CreateErrorResponse("Unable to connect to server. Please check your internet connection.", "NETWORK_ERROR")
		  Catch err As RuntimeException
		    Return CreateErrorResponse("Connection failed: " + err.Message, "CONNECTION_ERROR")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Try
		    Var socket As New URLConnection
		    
		    Var url As String = AppConfig.API_BASE_URL + "/auth.lc?action=refresh"
		    Var response As String = socket.SendSync("GET", url)
		    
		    Return True
		    
		  Catch err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseErrorResponse(json As String, defaultMessage As String, errorCode As String) As Dictionary
		  ' Try to extract error message from API response, fall back to default
		  Try
		    Var parsed As Variant = ParseJSON(json)
		    If parsed IsA Dictionary Then
		      Var responseDict As Dictionary = Dictionary(parsed)
		      ' Check for API error message in response
		      If responseDict.HasKey("message") Then
		        Return CreateErrorResponse(responseDict.Value("message").StringValue, errorCode)
		      ElseIf responseDict.HasKey("error") Then
		        Return CreateErrorResponse(responseDict.Value("error").StringValue, errorCode)
		      End If
		    End If
		  Catch err As RuntimeException
		    ' Failed to parse - use default message
		  End Try

		  Return CreateErrorResponse(defaultMessage, errorCode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseResponse(json As String) As Dictionary
		  Try
		    Var result As New Dictionary
		    Var parsed As Variant = ParseJSON(json)

		    If parsed IsA Dictionary Then
		      result = Dictionary(parsed)
		      Return result
		    Else
		      Return CreateErrorResponse("Invalid JSON response format")
		    End If

		  Catch err As RuntimeException
		    Return CreateErrorResponse("JSON parsing error: " + err.Message)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Post(endpoint As String, action As String, data As Dictionary) As Dictionary
		  Var url As String = BuildURL(endpoint, action, Nil)
		  
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("APIClient.Post: " + url)
		  End If
		  
		  Try
		    Var socket As New URLConnection
		    socket.RequestHeader("User-Agent") = AppConfig.APP_NAME + "/" + AppConfig.APP_VERSION
		    socket.RequestHeader("Content-Type") = "application/json"
		    socket.RequestHeader("Accept") = "application/json"
		    
		    If AuthManager.IsAuthenticated Then
		      socket.RequestHeader("Authorization") = AuthManager.GetAuthHeader
		    End If
		    
		    // Convert data to JSON
		    Var jsonData As String = GenerateJSON(data, False)
		    
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("APIClient.Post body: " + jsonData)
		    End If
		    
		    // Set request body
		    socket.SetRequestContent(jsonData, "application/json")
		    
		    // Make request
		    Var response As String = socket.SendSync("POST", url)
		    
		    // Check HTTP status
		    Var httpStatus As Integer = socket.HTTPStatusCode

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("APIClient.Post response: HTTP " + httpStatus.ToString)
		      System.DebugLog("APIClient.Post response body: " + response)
		    End If

		    Select Case httpStatus
		    Case 200, 201
		      // Success - parse the response
		      Return ParseResponse(response)

		    Case 400
		      // Bad Request - try to get error message from response
		      Return ParseErrorResponse(response, "Invalid request. Please check your input.", "BAD_REQUEST")

		    Case 401
		      // Unauthorized - could be invalid credentials or expired token
		      If AuthManager.IsAuthenticated Then
		        AuthManager.Logout
		        Return CreateErrorResponse("Your session has expired. Please log in again.", "SESSION_EXPIRED")
		      Else
		        // During login - try to get specific error from API response
		        Return ParseErrorResponse(response, "Invalid username or password.", "INVALID_CREDENTIALS")
		      End If

		    Case 403
		      Return CreateErrorResponse("Access denied. You don't have permission to perform this action.", "FORBIDDEN")

		    Case 404
		      Return CreateErrorResponse("The requested resource was not found.", "NOT_FOUND")

		    Case 429
		      Return CreateErrorResponse("Too many requests. Please wait a moment and try again.", "RATE_LIMITED")

		    Case 500
		      Return CreateErrorResponse("Internal server error. Please try again later.", "SERVER_ERROR")

		    Case 502
		      Return CreateErrorResponse("The server is temporarily unavailable. Please try again later.", "BAD_GATEWAY")

		    Case 503
		      Return CreateErrorResponse("The service is temporarily unavailable. Please try again later.", "SERVICE_UNAVAILABLE")

		    Case 504
		      Return CreateErrorResponse("The server took too long to respond. Please try again.", "GATEWAY_TIMEOUT")

		    Else
		      // Unknown error - try to parse response for details
		      Return ParseErrorResponse(response, "Unexpected error (HTTP " + httpStatus.ToString + ").", "HTTP_" + httpStatus.ToString)

		    End Select
		    
		  Catch err As IOException
		    Return CreateErrorResponse("Unable to connect to server. Please check your internet connection.", "NETWORK_ERROR")
		  Catch err As RuntimeException
		    Return CreateErrorResponse("Connection failed: " + err.Message, "CONNECTION_ERROR")
		  End Try
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
