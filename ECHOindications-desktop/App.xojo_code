#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Opening()
		  // ============================================================
		  // AUTHENTICATION DEBUG TEST
		  // ============================================================
		  // Copy this code into App.Opening or a button handler
		  // This will show EXACT API request/response for login
		  // ============================================================
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "AUTHENTICATION DEBUG TEST"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  // Test credentials (REPLACE WITH YOUR ACTUAL CREDENTIALS)
		  Var testUsername As String = "stam66@mac.com"  // Try both "admin" and "stam66@mac.com"
		  Var testPassword As String = "reject66"   // Your actual password
		  
		  System.DebugLog "Testing with:"
		  System.DebugLog "  Username: " + testUsername
		  System.DebugLog "  Password: " + testPassword
		  System.DebugLog ""
		  
		  // MANUAL API CALL TO SEE RAW RESPONSE
		  System.DebugLog "=== MANUAL API TEST ==="
		  Try
		    Var url As String = "https://api.echoindications.org/auth.lc?action=login"
		    System.DebugLog "URL: " + url
		    
		    Var socket As New URLConnection
		    socket.RequestHeader("Content-Type") = "application/json"
		    socket.RequestHeader("Accept") = "application/json"
		    socket.RequestHeader("User-Agent") = "ECHO-Indications-Desktop/1.0"
		    
		    // Create JSON payload
		    Var data As New Dictionary
		    data.Value("username") = testUsername
		    data.Value("password") = testPassword
		    
		    Var jsonData As String = GenerateJSON(data, False)
		    System.DebugLog "Request Body: " + jsonData
		    System.DebugLog ""
		    
		    socket.SetRequestContent(jsonData, "application/json")
		    
		    System.DebugLog "Sending POST request..."
		    Var response As String = socket.SendSync("POST", url, 30)
		    
		    Var httpStatus As Integer = socket.HTTPStatusCode
		    System.DebugLog "HTTP Status: " + httpStatus.ToString
		    System.DebugLog "Response Body: " + response
		    System.DebugLog ""
		    
		    // Try to parse response
		    Try
		      Var parsed As Variant = ParseJSON(response)
		      If parsed IsA Dictionary Then
		        Var result As Dictionary = Dictionary(parsed)
		        
		        System.DebugLog "Parsed Response:"
		        System.DebugLog "  status: " + result.Value("status").StringValue
		        
		        If result.HasKey("message") Then
		          System.DebugLog "  message: " + result.Value("message").StringValue
		        End If
		        
		        If result.HasKey("data") And result.Value("status") = "success" Then
		          Var dataDict As Dictionary = result.Value("data")
		          System.DebugLog "  token: " + dataDict.Value("token").StringValue.Left(20) + "..."
		          
		          If dataDict.HasKey("user") Then
		            Var user As Dictionary = dataDict.Value("user")
		            var s as string = user.Value("id")
		            System.DebugLog ("  user.id: " + s)
		            System.DebugLog ("  user.username: " + user.Value("username").StringValue)
		          End If
		        End If
		      End If
		    Catch parseErr As RuntimeException
		      System.DebugLog "❌ JSON Parse Error: " + parseErr.Message
		    End Try
		    
		  Catch err As RuntimeException
		    System.DebugLog "❌ Request Error: " + err.Message
		  End Try
		  
		  System.DebugLog ""
		  System.DebugLog "=========================================="
		  
		  // NOW TRY WITH AuthManager
		  System.DebugLog "=== AUTHMANAGER TEST ==="
		  System.DebugLog ""
		  
		  If AuthManager.Login(testUsername, testPassword) Then
		    System.DebugLog "✅ AuthManager.Login SUCCESS"
		    System.DebugLog "  User ID: " + AuthManager.CurrentUserID.ToString
		    System.DebugLog "  Username: " + AuthManager.CurrentUsername
		    System.DebugLog "  Email: " + AuthManager.CurrentUserEmail
		    System.DebugLog "  Name: " + AuthManager.CurrentUserFullName
		  Else
		    System.DebugLog "❌ AuthManager.Login FAILED"
		    System.DebugLog "  Error: " + AuthManager.LastError
		  End If
		  
		  System.DebugLog ""
		  System.DebugLog "=========================================="
		  System.DebugLog "TEST COMPLETE"
		  System.DebugLog "=========================================="
		  
		  
		  // ============================================================
		  // WHAT TO LOOK FOR IN THE OUTPUT:
		  // ============================================================
		  
		  ' 1. HTTP Status Code:
		  ' - 200 = Request successful, check response body
		  ' - 401 = Unauthorized (wrong credentials or auth not implemented)
		  ' - 404 = Endpoint not found (wrong URL)
		  ' - 500 = Server error (API crash/bug)
		  ' 
		  ' 2. Response Body:
		  ' - {"status":"success","data":{"token":"...","user":{...}}} = LOGIN WORKS!
		  ' - {"status":"error","message":"Invalid credentials"} = Wrong password
		  ' - {"status":"error","message":"User not found"} = Wrong username
		  ' - {"status":"error","message":"..."} = Other API error
		  ' 
		  ' 3. Common Issues:
		  ' - If HTTP 404: API endpoint doesn't exist or wrong URL
		  ' - If HTTP 500: API has a bug or database connection issue
		  ' - If status="error" with "Invalid credentials":
		  ' * Try with email instead of username
		  ' * Check if password is correct in web app
		  ' - If status="error" with "User not found":
		  ' * Username format might be wrong (try email)
		  ' - If JSON parse error: API returned non-JSON (HTML error page?)
		  ' 
		  ' 4. Web App vs Desktop App Differences:
		  ' - Web app uses: username field from database
		  ' - Desktop app should use: same username OR email?
		  ' - Test both to see which works
		  
		  
		  
		  
		  
		  ' // ============================================================
		  ' // WORKING TEST CODE - Handles Direct Array Response
		  ' // ============================================================
		  ' // API returns arrays directly, not wrapped in dictionary
		  ' // Copy this into App.Opening event
		  ' // ============================================================
		  ' 
		  ' System.DebugLog "=========================================="
		  ' System.DebugLog "ECHO Indications API Test"
		  ' System.DebugLog "=========================================="
		  ' System.DebugLog ""
		  ' 
		  ' // Test 1: Connectivity
		  ' System.DebugLog "Test 1: Checking API connectivity..."
		  ' If APIClient.IsConnected Then
		  ' System.DebugLog "✅ API is reachable"
		  ' Else
		  ' System.DebugLog "❌ API is not reachable"
		  ' Return
		  ' End If
		  ' System.DebugLog ""
		  ' 
		  ' // Test 2: List indications
		  ' System.DebugLog "Test 2: Fetching all indications..."
		  ' Var result As Dictionary = APIClient.Get("indications.lc", "list")
		  ' 
		  ' If result.Value("status") = "success" Then
		  ' Try
		  ' // Data is the array directly, not wrapped
		  ' Var dataVariant As Variant = result.Value("data")
		  ' 
		  ' // Convert to array
		  ' Var items() As Variant
		  ' items = dataVariant
		  ' 
		  ' System.DebugLog "✅ Found " + items.Count.ToString + " indications"
		  ' System.DebugLog ""
		  ' 
		  ' System.DebugLog "First 5 indications:"
		  ' For i As Integer = 0 To Min(4, items.Count - 1)
		  ' If items(i) IsA Dictionary Then
		  ' Var indication As Dictionary = items(i)
		  ' Var id As Integer = indication.Value("id").IntegerValue
		  ' Var title As String = indication.Value("title").StringValue
		  ' System.DebugLog "  [" + id.ToString + "] " + title
		  ' End If
		  ' Next
		  ' 
		  ' Catch err As RuntimeException
		  ' System.DebugLog "❌ Error parsing indications: " + err.Message
		  ' End Try
		  ' Else
		  ' System.DebugLog "❌ Error: " + result.Value("message").StringValue
		  ' End If
		  ' System.DebugLog ""
		  ' 
		  ' // Test 3: List contexts
		  ' System.DebugLog "Test 3: Fetching contexts..."
		  ' Var contextResult As Dictionary = APIClient.Get("contexts.lc", "with_counts")
		  ' 
		  ' If contextResult.Value("status") = "success" Then
		  ' Try
		  ' // Data is the array directly
		  ' Var dataVariant As Variant = contextResult.Value("data")
		  ' 
		  ' // Convert to array
		  ' Var items() As Variant
		  ' items = dataVariant
		  ' 
		  ' System.DebugLog "✅ Found " + items.Count.ToString + " contexts"
		  ' System.DebugLog ""
		  ' 
		  ' System.DebugLog "All contexts:"
		  ' For i As Integer = 0 To items.Count - 1
		  ' If items(i) IsA Dictionary Then
		  ' Var context As Dictionary = items(i)
		  ' Var name As String = context.Value("name").StringValue
		  ' Var count As Integer = context.Value("indication_count").IntegerValue
		  ' System.DebugLog "  • " + name + " (" + count.ToString + " indications)"
		  ' End If
		  ' Next
		  ' 
		  ' Catch err As RuntimeException
		  ' System.DebugLog "❌ Error parsing contexts: " + err.Message
		  ' End Try
		  ' Else
		  ' System.DebugLog "❌ Error: " + contextResult.Value("message").StringValue
		  ' End If
		  ' System.DebugLog ""
		  ' 
		  ' // Test 4: Search
		  ' System.DebugLog "Test 4: Searching for 'coronary'..."
		  ' Var params As New Dictionary
		  ' params.Value("keyword") = "coronary"
		  ' Var searchResult As Dictionary = APIClient.Get("search.lc", "keyword", params)
		  ' 
		  ' If searchResult.Value("status") = "success" Then
		  ' Try
		  ' // Data is the array directly
		  ' Var dataVariant As Variant = searchResult.Value("data")
		  ' 
		  ' // Convert to array
		  ' Var items() As Variant
		  ' items = dataVariant
		  ' 
		  ' System.DebugLog "✅ Found " + items.Count.ToString + " matching indications"
		  ' 
		  ' For i As Integer = 0 To Min(2, items.Count - 1)
		  ' If items(i) IsA Dictionary Then
		  ' Var indication As Dictionary = items(i)
		  ' Var title As String = indication.Value("title").StringValue
		  ' System.DebugLog "  • " + title
		  ' End If
		  ' Next
		  ' 
		  ' Catch err As RuntimeException
		  ' System.DebugLog "❌ Error parsing search results: " + err.Message
		  ' End Try
		  ' Else
		  ' System.DebugLog "❌ Error: " + searchResult.Value("message").StringValue
		  ' End If
		  ' System.DebugLog ""
		  ' 
		  ' System.DebugLog "=========================================="
		  ' System.DebugLog "All tests complete!"
		  ' System.DebugLog "=========================================="
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProcessID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
