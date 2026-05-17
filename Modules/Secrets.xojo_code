#tag Module
Protected Module Secrets
	#tag Method, Flags = &h0
		Sub Load()
		  Var f As FolderItem 
		  #If TargetXojoCloud then
		    f = SpecialFolder.SharedDocuments.Child("secrets.env")
		  #Else
		    f = SpecialFolder.Etc.Child("ECHOINDICATIONS").Child("secrets.env")
		  #EndIf
		  If f Is Nil Or Not f.Exists Then
		    Raise New RuntimeException("Secrets file not found at " + If(f Is Nil, "<nil path>", f.NativePath))
		  End If
		  
		  
		  // Reset so a second Load doesn't keep stale values
		  DB_USERNAME = ""
		  DB_PASSWORD = ""
		  MAILJET_API_KEY = ""
		  MAILJET_SECRET_KEY = ""
		  XOJO_DB_USERNAME = ""
		  XOJO_DB_PASSWORD = ""
		  
		  Var t As TextInputStream = TextInputStream.Open(f)
		  While Not t.EndOfFile
		    Var line As String = t.ReadLine.Trim
		    
		    // Skip blank lines and comments
		    If Not line.IsEmpty And line.Left(1) <> "#" Then
		      // Split on the FIRST '=' so values containing '=' (e.g. base64) survive intact
		      Var eqPos As Integer = line.IndexOf("=")
		      If eqPos > 0 Then
		        Var key As String = line.Left(eqPos).Trim
		        Var value As String = line.Right(line.Length - eqPos - 1).Trim
		        
		        // Strip a single pair of surrounding quotes if present
		        If value.Length >= 2 Then
		          Var firstChar As String = value.Left(1)
		          Var lastChar As String = value.Right(1)
		          If (firstChar = """" And lastChar = """") Or (firstChar = "'" And lastChar = "'") Then
		            value = value.Middle(1, value.Length - 2)
		          End If
		        End If
		        
		        Select Case key
		        Case "ECHO_DB_USERNAME"
		          DB_USERNAME = value
		        Case "ECHO_DB_PASSWORD"
		          DB_PASSWORD = value
		        Case "ECHO_MAILJET_API_KEY"
		          MAILJET_API_KEY = value
		        Case "ECHO_MAILJET_SECRET_KEY"
		          MAILJET_SECRET_KEY = value
		        case "XOJO_DB_USERNAME"
		          XOJO_DB_USERNAME = value
		        case "XOJO_DB_PASSWORD"
		          XOJO_DB_PASSWORD = value
		        End Select
		      End If
		    End If
		  Wend
		  t.Close
		  
		  // Log which keys loaded (values redacted) so we can diagnose missing entries
		  System.DebugLog("Secrets loaded — DB_USERNAME:" + If(DB_USERNAME.IsEmpty, "MISSING", "ok") _
		  + ", DB_PASSWORD:" + If(DB_PASSWORD.IsEmpty, "MISSING", "ok") _
		  + ", MAILJET_API_KEY:" + If(MAILJET_API_KEY.IsEmpty, "MISSING", "ok") _
		  + ", MAILJET_SECRET_KEY:" + If(MAILJET_SECRET_KEY.IsEmpty, "MISSING", "ok"))
		  
		  Var missing() As String
		  If DB_USERNAME.IsEmpty Then missing.Add("ECHO_DB_USERNAME")
		  If DB_PASSWORD.IsEmpty Then missing.Add("ECHO_DB_PASSWORD")
		  If MAILJET_API_KEY.IsEmpty Then missing.Add("ECHO_MAILJET_API_KEY")
		  If MAILJET_SECRET_KEY.IsEmpty Then missing.Add("ECHO_MAILJET_SECRET_KEY")
		  
		  SecretsLoaded = (missing.Count = 0)
		  
		  If Not SecretsLoaded Then
		    Raise New RuntimeException("Missing keys in secrets.env: " + String.FromArray(missing, ", "))
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DB_PASSWORD As string
	#tag EndProperty

	#tag Property, Flags = &h0
		DB_USERNAME As string
	#tag EndProperty

	#tag Property, Flags = &h0
		MAILJET_API_KEY As string
	#tag EndProperty

	#tag Property, Flags = &h0
		MAILJET_SECRET_KEY As string
	#tag EndProperty

	#tag Property, Flags = &h0
		SecretsLoaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		XOJO_DB_PASSWORD As string
	#tag EndProperty

	#tag Property, Flags = &h0
		XOJO_DB_USERNAME As string
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
			Name="DB_USERNAME"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DB_PASSWORD"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MAILJET_API_KEY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MAILJET_SECRET_KEY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecretsLoaded"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="XOJO_DB_PASSWORD"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="XOJO_DB_USERNAME"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
