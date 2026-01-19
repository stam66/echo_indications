#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Opening()
		  // ============================================================
		  // WORKING TEST CODE - Handles Direct Array Response
		  // ============================================================
		  // API returns arrays directly, not wrapped in dictionary
		  // Copy this into App.Opening event
		  // ============================================================
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "ECHO Indications API Test"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  // Test 1: Connectivity
		  System.DebugLog "Test 1: Checking API connectivity..."
		  If APIClient.IsConnected Then
		    System.DebugLog "✅ API is reachable"
		  Else
		    System.DebugLog "❌ API is not reachable"
		    Return
		  End If
		  System.DebugLog ""
		  
		  // Test 2: List indications
		  System.DebugLog "Test 2: Fetching all indications..."
		  Var result As Dictionary = APIClient.Get("indications.lc", "list")
		  
		  If result.Value("status") = "success" Then
		    Try
		      // Data is the array directly, not wrapped
		      Var dataVariant As Variant = result.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " indications"
		      System.DebugLog ""
		      
		      System.DebugLog "First 5 indications:"
		      For i As Integer = 0 To Min(4, items.Count - 1)
		        If items(i) IsA Dictionary Then
		          Var indication As Dictionary = items(i)
		          Var id As Integer = indication.Value("id").IntegerValue
		          Var title As String = indication.Value("title").StringValue
		          System.DebugLog "  [" + id.ToString + "] " + title
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing indications: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + result.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  // Test 3: List contexts
		  System.DebugLog "Test 3: Fetching contexts..."
		  Var contextResult As Dictionary = APIClient.Get("contexts.lc", "with_counts")
		  
		  If contextResult.Value("status") = "success" Then
		    Try
		      // Data is the array directly
		      Var dataVariant As Variant = contextResult.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " contexts"
		      System.DebugLog ""
		      
		      System.DebugLog "All contexts:"
		      For i As Integer = 0 To items.Count - 1
		        If items(i) IsA Dictionary Then
		          Var context As Dictionary = items(i)
		          Var name As String = context.Value("name").StringValue
		          Var count As Integer = context.Value("indication_count").IntegerValue
		          System.DebugLog "  • " + name + " (" + count.ToString + " indications)"
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing contexts: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + contextResult.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  // Test 4: Search
		  System.DebugLog "Test 4: Searching for 'coronary'..."
		  Var params As New Dictionary
		  params.Value("keyword") = "coronary"
		  Var searchResult As Dictionary = APIClient.Get("search.lc", "keyword", params)
		  
		  If searchResult.Value("status") = "success" Then
		    Try
		      // Data is the array directly
		      Var dataVariant As Variant = searchResult.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " matching indications"
		      
		      For i As Integer = 0 To Min(2, items.Count - 1)
		        If items(i) IsA Dictionary Then
		          Var indication As Dictionary = items(i)
		          Var title As String = indication.Value("title").StringValue
		          System.DebugLog "  • " + title
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing search results: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + searchResult.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "All tests complete!"
		  System.DebugLog "=========================================="
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
