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
		  mPasswordExpired = False

		  If username.Trim.Length = 0 Or password.Trim.Length = 0 Then
		    mLastError = "Username and password are required"
		    Return False
		  End If

		  Try
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("=== AuthManager.Login starting ===")
		      System.DebugLog("Username: " + username.Trim)
		    End If

		    ' Send plain text password - API handles hashing (PBKDF2 for new users, SHA-256 for legacy web app users)
		    Var data As New Dictionary
		    data.Value("username") = username.Trim
		    data.Value("password") = password

		    Var result As Dictionary = APIClient.Post("auth.lc", "login", data)

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("Login result status: " + result.Value("status").StringValue)
		    End If

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

		      ' Check if password is expired (OTP login)
		      If responseData.HasKey("password_expired") Then
		        mPasswordExpired = responseData.Value("password_expired").BooleanValue
		      End If

		      mIsAuthenticated = True

		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("AuthManager: Login successful for " + mCurrentUsername)
		        If mPasswordExpired Then
		          System.DebugLog("AuthManager: Password expired - user must change password")
		        End If
		      End If

		      Return True

		    Else
		      mLastError = result.Value("message").StringValue

		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("Login failed: " + mLastError)
		        System.DebugLog("=== AuthManager.Login failed ===")
		      End If

		      Return False
		    End If

		  Catch err As RuntimeException
		    mLastError = "Login error: " + err.Message

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("Login exception: " + err.Message)
		      System.DebugLog("=== AuthManager.Login exception ===")
		    End If

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

	#tag Method, Flags = &h0
		Function RequestPasswordReset(email As String) As Boolean
		  ' Request password reset via API (sends OTP email)
		  ' Returns True if reset email was sent successfully, False otherwise
		  ' Check mLastError for error message on failure
		  ' Note: API returns same message for valid/invalid emails for security

		  mLastError = ""

		  ' Validate email format
		  If Not General.isValidEmail(email) Then
		    mLastError = "The email address entered is not valid. Please check and try again."
		    Return False
		  End If

		  Try
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("=== AuthManager.RequestPasswordReset starting ===")
		      System.DebugLog("Email: " + email)
		    End If

		    ' Build request data
		    Var data As New Dictionary
		    data.Value("email") = email.Trim

		    ' Call requestReset API endpoint
		    Var result As Dictionary = APIClient.Post("auth.lc", "requestReset", data)

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("RequestPasswordReset result status: " + result.Value("status").StringValue)
		    End If

		    If result.Value("status") = "success" Then
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("AuthManager: Password reset email sent successfully")
		      End If
		      Return True
		    Else
		      mLastError = result.Value("message").StringValue

		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("Password reset failed: " + mLastError)
		      End If

		      Return False
		    End If

		  Catch err As RuntimeException
		    mLastError = "Password reset error: " + err.Message

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("Password reset exception: " + err.Message)
		    End If

		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChangePassword(newPassword As String) As Boolean
		  ' Change password for authenticated user (typically after OTP login)
		  ' Returns True if password was changed successfully, False otherwise
		  ' Check mLastError for error message on failure

		  mLastError = ""

		  ' Must be authenticated to change password
		  If Not mIsAuthenticated Then
		    mLastError = "You must be logged in to change your password."
		    Return False
		  End If

		  ' Validate new password
		  If newPassword.Length < 6 Then
		    mLastError = "Password must be at least 6 characters long."
		    Return False
		  End If

		  Try
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("=== AuthManager.ChangePassword starting ===")
		    End If

		    ' Build request data
		    Var data As New Dictionary
		    data.Value("new_password") = newPassword

		    ' Call changePassword API endpoint
		    Var result As Dictionary = APIClient.Post("auth.lc", "changePassword", data)

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("ChangePassword result status: " + result.Value("status").StringValue)
		    End If

		    If result.Value("status") = "success" Then
		      ' Clear the password expired flag
		      mPasswordExpired = False

		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("AuthManager: Password changed successfully")
		      End If
		      Return True
		    Else
		      mLastError = result.Value("message").StringValue

		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("Password change failed: " + mLastError)
		      End If

		      Return False
		    End If

		  Catch err As RuntimeException
		    mLastError = "Password change error: " + err.Message

		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("Password change exception: " + err.Message)
		    End If

		    Return False
		  End Try
		End Function
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPasswordExpired
			End Get
		#tag EndGetter
		PasswordExpired As Boolean
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
		Private mPasswordExpired As Boolean = False
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
		#tag ViewProperty
			Name="PasswordExpired"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
