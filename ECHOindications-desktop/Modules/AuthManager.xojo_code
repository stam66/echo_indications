#tag Module
Protected Module AuthManager
	#tag Method, Flags = &h0
		Function GetAuthHeader() As String
		  If Not mIsAuthenticated Or mCurrentToken.Length = 0 Then
		    Return ""
		  End If
		  
		  Return "Bearer " + mCurrentToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Login(username As String, password As String) As Boolean
		  mLastError = ""

		  If username.Trim.Length = 0 Or password.Trim.Length = 0 Then
		    mLastError = "Username and password are required"
		    Return False
		  End If

		  Try
		    ' Send plain text password - API handles hashing (PBKDF2 for new users, SHA-256 for legacy web app users)
		    Var data As New Dictionary
		    data.Value("username") = username.Trim
		    data.Value("password") = password

		    Var result As Dictionary = APIClient.Post("auth.lc", "login", data)
		    
		    If result.Value("status") = "success" Then
		      Var responseData As Dictionary = result.Value("data")
		      
		      mCurrentToken = responseData.Value("token").StringValue
		      
		      Var now As DateTime = DateTime.Now
		      mTokenExpiry = new DateTime(now.SecondsFrom1970 + (AppConfig.TOKEN_EXPIRY_MINUTES * 60))
		      
		      If responseData.HasKey("user") Then
		        Var user As Dictionary = responseData.Value("user")
		        mCurrentUserID = user.Value("id").IntegerValue
		        mCurrentUsername = user.Value("username").StringValue
		        mCurrentUserEmail = user.Value("email").StringValue
		        If user.HasKey("name") Then
		          mCurrentUserFullName = user.Value("name").StringValue
		        End If
		      End If
		      
		      mIsAuthenticated = True
		      
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("AuthManager: Login successful for " + mCurrentUsername)
		      End If
		      
		      Return True
		      
		    Else
		      mLastError = result.Value("message").StringValue
		      Return False
		    End If
		    
		  Catch err As RuntimeException
		    mLastError = "Login error: " + err.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Logout()
		  mIsAuthenticated = False
		  mCurrentToken = ""
		  mTokenExpiry = Nil
		  mCurrentUserID = 0
		  mCurrentUsername = ""
		  mCurrentUserEmail = ""
		  mCurrentUserFullName = ""
		  mLastError = ""

		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("AuthManager: Logged out")
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mCurrentUserEmail
			End Get
		#tag EndGetter
		CurrentUserEmail As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mCurrentUserFullName
			End Get
		#tag EndGetter
		CurrentUserFullName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mCurrentUserID
			End Get
		#tag EndGetter
		CurrentUserID As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mCurrentUsername
			End Get
		#tag EndGetter
		CurrentUsername As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mIsAuthenticated
			End Get
		#tag EndGetter
		IsAuthenticated As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastError
			End Get
		#tag EndGetter
		LastError As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentUserEmail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentUserFullName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentUserID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentUsername As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsAuthenticated As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenExpiry As DateTime
	#tag EndProperty


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
		#tag ViewProperty
			Name="IsAuthenticated"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUserID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUsername"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUserEmail"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUserFullName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
