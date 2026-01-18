#tag Class
Protected Class User
	#tag Method, Flags = &h21
		Private Shared Function FromDictionary(data As Dictionary) As User
		  '/// Creates a User object from API response dictionary
		  '///
		  '/// @param data Dictionary from API
		  '/// @returns User object or Nil
		  
		  Try
		    Var user As New User
		    
		    user.ID = data.Value("id").IntegerValue
		    user.Username = data.Value("username").StringValue
		    
		    If data.HasKey("email") And data.Value("email") <> Nil Then
		      user.Email = data.Value("email").StringValue
		    End If
		    
		    If data.HasKey("name") And data.Value("name") <> Nil Then
		      user.Name = data.Value("name").StringValue
		    End If
		    
		    If data.HasKey("title") And data.Value("title") <> Nil Then
		      user.Title = data.Value("title").StringValue
		    End If
		    
		    If data.HasKey("is_active") Then
		      user.IsActive = (data.Value("is_active").IntegerValue = 1)
		    Else
		      user.IsActive = True // Default to active
		    End If
		    
		    Return user
		    
		  Catch err As RuntimeException
		    System.DebugLog("User.FromDictionary error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll() As User()
		  '/// Fetches all users from the API (requires authentication)
		  '///
		  '/// @returns Array of User objects
		  
		  If Not AuthManager.IsAuthenticated Then
		    System.DebugLog("User.GetAll: Not authenticated")
		    Var results() As User
		    Return results
		  End If
		  
		  Var results() As User
		  
		  Try
		    Var response As Dictionary = APIClient.Get("users.lc", "list")
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant
		      
		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var user As User = FromDictionary(Dictionary(item))
		          If user <> Nil Then
		            results.Add(user)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("User.GetAll error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("User.GetAll exception: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(id As Integer) As User
		  '/// Fetches a single user by ID (requires authentication)
		  '///
		  '/// @param id The user ID
		  '/// @returns User object or Nil if not found
		  
		  If Not AuthManager.IsAuthenticated Then
		    System.DebugLog("User.GetByID: Not authenticated")
		    Return Nil
		  End If
		  
		  Try
		    Var params As New Dictionary
		    params.Value("id") = id.ToString
		    
		    Var response As Dictionary = APIClient.Get("users.lc", "read", params)
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      
		      If dataVariant IsA Dictionary Then
		        Return FromDictionary(Dictionary(dataVariant))
		      End If
		    Else
		      System.DebugLog("User.GetByID error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("User.GetByID exception: " + err.Message)
		  End Try
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  '/// Returns a string representation of this user
		  '///
		  '/// @returns String description
		  
		  Var result As String = "[" + ID.ToString + "] " + Name + " (" + Username + ")"
		  
		  If Title.Length > 0 Then
		    result = result + " - " + Title
		  End If
		  
		  If Not IsActive Then
		    result = result + " [INACTIVE]"
		  End If
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Email As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Title As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
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
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Email"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
