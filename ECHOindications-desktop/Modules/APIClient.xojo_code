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
		Private Function CreateErrorResponse(message As String) As Dictionary
		  Var result As New Dictionary
		  result.Value("status") = "error"
		  result.Value("message") = message
		  
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
		    If httpStatus <> 200 Then
		      Return CreateErrorResponse("HTTP " + httpStatus.ToString + ": " + response)
		    End If
		    
		    Return ParseResponse(response)
		    
		  Catch err As IOException
		    Return CreateErrorResponse("Network error: " + err.Message)
		  Catch err As RuntimeException
		    Return CreateErrorResponse("Request failed: " + err.Message)
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
		      // Success
		    Case 401
		      AuthManager.Logout
		      Return CreateErrorResponse("Authentication required. Please log in again.")
		    Case 429
		      Return CreateErrorResponse("Rate limit exceeded. Please wait and try again.")
		    Case 500, 502, 503
		      Return CreateErrorResponse("Server error. Please try again later.")
		    Else
		      Return CreateErrorResponse("HTTP " + httpStatus.ToString + ": " + response)
		    End Select

		    Return ParseResponse(response)
		    
		  Catch err As IOException
		    Return CreateErrorResponse("Network error: " + err.Message)
		  Catch err As RuntimeException
		    Return CreateErrorResponse("Request failed: " + err.Message)
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
