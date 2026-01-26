#tag Class
Protected Class Indication
	#tag Method, Flags = &h0
		Function Delete() As Boolean
		  '/// Deletes this indication (requires authentication)
		  '///
		  '/// @returns True if successful, False otherwise

		  If Not AuthManager.IsAuthenticated Then
		    System.DebugLog("Indication.Delete: Not authenticated")
		    Return False
		  End If

		  Try
		    Var data As New Dictionary
		    data.Value("indication_id") = ID

		    Var response As Dictionary = APIClient.Post("indications.lc", "delete", data)

		    If response.Value("status") = "success" Then
		      Return True
		    Else
		      System.DebugLog("Indication.Delete error: " + response.Value("message").StringValue)
		      Return False
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("Indication.Delete exception: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromDictionary(data As Dictionary) As Indication
		  '/// Creates an Indication object from API response dictionary
		  '///
		  '/// @param data Dictionary from API
		  '/// @returns Indication object or Nil
		  
		  Try
		    Var indication As New Indication
		    
		    indication.ID = data.Value("id").IntegerValue
		    indication.Title = data.Value("title").StringValue
		    
		    If data.HasKey("keywords") And data.Value("keywords") <> Nil Then
		      indication.Keywords = data.Value("keywords").StringValue
		    End If
		    
		    If data.HasKey("comments") And data.Value("comments") <> Nil Then
		      indication.Comments = data.Value("comments").StringValue
		    End If
		    
		    If data.HasKey("primary_care") And data.Value("primary_care") <> Nil Then
		      indication.PrimaryCare = data.Value("primary_care").StringValue
		    End If
		    
		    If data.HasKey("secondary_inpatient") And data.Value("secondary_inpatient") <> Nil Then
		      indication.SecondaryInpatient = data.Value("secondary_inpatient").StringValue
		    End If
		    
		    If data.HasKey("secondary_outpatient") And data.Value("secondary_outpatient") <> Nil Then
		      indication.SecondaryOutpatient = data.Value("secondary_outpatient").StringValue
		    End If
		    
		    If data.HasKey("source_ase") Then
		      indication.SourceASE = (data.Value("source_ase").IntegerValue = 1)
		    End If
		    
		    If data.HasKey("source_eacvi") Then
		      indication.SourceEACVI = (data.Value("source_eacvi").IntegerValue = 1)
		    End If
		    
		    If data.HasKey("source_bse") Then
		      indication.SourceBSE = (data.Value("source_bse").IntegerValue = 1)
		    End If
		    
		    If data.HasKey("source_consensus") Then
		      indication.SourceConsensus = (data.Value("source_consensus").IntegerValue = 1)
		    End If
		    
		    If data.HasKey("urgency") And data.Value("urgency") <> Nil Then
		      indication.Urgency = data.Value("urgency").StringValue
		    End If
		    
		    // Parse context_ids array if available (IDs only, no names)
		    If data.HasKey("context_ids") And data.Value("context_ids") <> Nil Then
		      Var contextIDsVariant As Variant = data.Value("context_ids")
		      Var tempContextIDs() As Integer
		      
		      If (VarType(contextIDsVariant) And 4096) = 4096 Then // Check if array bit is set
		        Var idsArray() As Variant = contextIDsVariant
		        For Each idVariant As Variant In idsArray
		          tempContextIDs.Add(idVariant.IntegerValue)
		        Next
		      End If
		      
		      indication.ContextIDs = tempContextIDs
		      
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("Indication " + indication.ID.ToString + " parsed context_ids: " + tempContextIDs.Count.ToString + " IDs")
		      End If
		    End If
		    
		    // Parse contexts array - handle both array and string formats (includes names and possibly IDs)
		    If data.HasKey("contexts") And data.Value("contexts") <> Nil Then
		      Var contextsValue As Variant = data.Value("contexts")
		      Var contextNames() As String
		      Var tempContextIDs() As Integer
		      Var valueType As Integer = VarType(contextsValue)
		      
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("FromDictionary ID=" + indication.ID.ToString + ": contexts field type=" + valueType.ToString)
		      End If
		      
		      If valueType = 8 Then
		        // String type - parse as comma-separated string
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("  Processing as String")
		        End If
		        
		        Var contextsStr As String = contextsValue.StringValue
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("  String length=" + contextsStr.Length.ToString + ", content: '" + contextsStr + "'")
		        End If
		        
		        If contextsStr.Length > 0 Then
		          contextNames = contextsStr.Split(",")
		          // Trim whitespace from each context name
		          For i As Integer = 0 To contextNames.LastIndex
		            contextNames(i) = contextNames(i).Trim
		          Next
		        End If
		        
		      ElseIf (valueType And 4096) = 4096 Then
		        // Array type - check if array bit is set (handles 4096, 4106, etc.)
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("  Processing as Array (type includes array bit 4096)")
		        End If
		        
		        Var contextsArray() As Variant = contextsValue
		        
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("  Array has " + contextsArray.Count.ToString + " elements")
		        End If
		        
		        For Each ctx As Variant In contextsArray
		          If ctx IsA Dictionary Then
		            Var ctxDict As Dictionary = Dictionary(ctx)
		            If ctxDict.HasKey("name") And ctxDict.Value("name") <> Nil Then
		              contextNames.Add(ctxDict.Value("name").StringValue)
		            End If
		            If ctxDict.HasKey("id") And ctxDict.Value("id") <> Nil Then
		              tempContextIDs.Add(ctxDict.Value("id").IntegerValue)
		            End If
		          End If
		        Next
		        
		      Else
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("  Unexpected type (not string or array)")
		        End If
		      End If
		      
		      indication.ContextNames = contextNames
		      // Only overwrite ContextIDs if we got IDs from contexts array
		      If tempContextIDs.Count > 0 Then
		        indication.ContextIDs = tempContextIDs
		      End If
		      
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("  Parsed contexts: " + contextNames.Count.ToString + " names, " + tempContextIDs.Count.ToString + " IDs")
		        System.DebugLog("  Final ContextIDs count: " + indication.ContextIDs.Count.ToString)
		        System.DebugLog("  Final ContextNames count: " + indication.ContextNames.Count.ToString)
		      End If
		    End If
		    
		    Return indication
		    
		  Catch err As RuntimeException
		    System.DebugLog("Indication.FromDictionary error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll() As Indication()
		  Var results() As Indication
		  
		  Try
		    Var response As Dictionary = APIClient.Get("indications.lc", "list")
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant
		      
		      ' ← ADD THE DEBUG CODE HERE, RIGHT AFTER "Var items() As Variant = dataVariant"
		      If AppConfig.DEBUG_MODE And items.Count > 0 Then
		        Var firstItem As Dictionary = Dictionary(items(0))
		        System.DebugLog("GetAll: First item has " + firstItem.KeyCount.ToString + " keys")
		        
		        Var keysList As String = ""
		        For Each key As Variant In firstItem.Keys
		          If keysList.Length > 0 Then keysList = keysList + ", "
		          keysList = keysList + key.StringValue
		        Next
		        System.DebugLog("  Keys: " + keysList)
		        
		        If firstItem.HasKey("context_ids") Then
		          System.DebugLog("  Has context_ids key")
		        End If
		        If firstItem.HasKey("contexts") Then
		          System.DebugLog("  Has contexts key")
		        End If
		      End If
		      ' ← END OF DEBUG CODE
		      
		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var indication As Indication = FromDictionary(Dictionary(item))
		          If indication <> Nil Then
		            results.Add(indication)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Indication.GetAll error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("Indication.GetAll exception: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByContext(contextID As Integer) As Indication()
		  '/// Fetches all indications for a specific context
		  '///
		  '/// @param contextID The context ID to filter by
		  '/// @returns Array of Indication objects
		  
		  Var results() As Indication
		  
		  Try
		    Var params As New Dictionary
		    params.Value("context_id") = contextID.ToString
		    
		    Var response As Dictionary = APIClient.Get("indications.lc", "list_by_context", params)
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant
		      
		      If AppConfig.DEBUG_MODE And items.Count > 0 Then
		        Var firstItem As Dictionary = Dictionary(items(0))
		        System.DebugLog("GetByContext: First item has " + firstItem.KeyCount.ToString + " keys")
		        
		        Var keysList As String = ""
		        For Each key As Variant In firstItem.Keys
		          If keysList.Length > 0 Then keysList = keysList + ", "
		          keysList = keysList + key.StringValue
		        Next
		        System.DebugLog("  Keys: " + keysList)
		        
		        If firstItem.HasKey("context_ids") Then
		          System.DebugLog("  Has context_ids key - value type: " + VarType(firstItem.Value("context_ids")).ToString)
		        End If
		        If firstItem.HasKey("contexts") Then
		          System.DebugLog("  Has contexts key - value type: " + VarType(firstItem.Value("contexts")).ToString)
		        End If
		      End If
		      
		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var indication As Indication = FromDictionary(Dictionary(item))
		          If indication <> Nil Then
		            results.Add(indication)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Indication.GetByContext error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("Indication.GetByContext exception: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(id As Integer) As Indication
		  '/// Fetches a single indication by ID
		  '///
		  '/// @param id The indication ID
		  '/// @returns Indication object or Nil if not found
		  
		  Try
		    Var params As New Dictionary
		    params.Value("id") = id.ToString
		    
		    Var response As Dictionary = APIClient.Get("indications.lc", "read", params)
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      
		      If dataVariant IsA Dictionary Then
		        Return FromDictionary(Dictionary(dataVariant))
		      End If
		    Else
		      System.DebugLog("Indication.GetByID error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("Indication.GetByID exception: " + err.Message)
		  End Try
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Search(keyword As String) As Indication()
		  '/// Searches for indications by keyword
		  '///
		  '/// @param keyword The search term
		  '/// @returns Array of matching Indication objects
		  
		  Var results() As Indication
		  
		  Try
		    Var params As New Dictionary
		    params.Value("keyword") = keyword
		    
		    Var response As Dictionary = APIClient.Get("search.lc", "keyword", params)
		    
		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant
		      
		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var indication As Indication = FromDictionary(Dictionary(item))
		          If indication <> Nil Then
		            results.Add(indication)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Indication.Search error: " + response.Value("message").StringValue)
		    End If
		    
		  Catch err As RuntimeException
		    System.DebugLog("Indication.Search exception: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  '/// Returns a string representation of this indication
		  '///
		  '/// @returns String description
		  
		  Var result As String = "[" + ID.ToString + "] " + Title
		  
		  If Keywords.Length > 0 Then
		    result = result + " (Keywords: " + Keywords + ")"
		  End If
		  
		  If ContextNames.Count > 0 Then
		    result = result + " {Contexts: " + String.FromArray(ContextNames, ", ") + "}"
		  End If
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Comments As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ContextIDs() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ContextNames() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Keywords As String
	#tag EndProperty

	#tag Property, Flags = &h0
		PrimaryCare As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryInpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryOutpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceASE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceBSE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceConsensus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceEACVI As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Title As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Urgency As String
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
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Keywords"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Comments"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrimaryCare"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryInpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryOutpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceASE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceEACVI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceBSE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceConsensus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Urgency"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
