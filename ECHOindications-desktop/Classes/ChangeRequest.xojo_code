#tag Class
Protected Class ChangeRequest
	#tag Method, Flags = &h0
		Shared Function CountNew() As Integer
		  '/// Gets count of new/open change requests (PUBLIC - no auth required)
		  '///
		  '/// @returns Count of new/in-progress requests (useful for badge display)

		  Try
		    Var response As Dictionary = APIClient.Get("changes.lc", "count_new")

		    If response.Value("status") = "success" Then
		      Var dataDict As Dictionary = response.Value("data")
		      Return dataDict.Value("count").IntegerValue
		    Else
		      System.DebugLog("ChangeRequest.CountNew error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.CountNew exception: " + err.Message)
		  End Try

		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Create() As Boolean
		  '/// Creates a new change request (PUBLIC - no auth required)
		  '///
		  '/// @returns True if created successfully

		  Try
		    Var data As New Dictionary
		    data.Value("changes_request") = Description
		    data.Value("changes_requestor") = ReporterName
		    data.Value("changes_status") = "New"

		    If IndicationID > 0 Then
		      data.Value("indication_id") = IndicationID
		    End If

		    If IndicationExisting.Length > 0 Then
		      data.Value("indication_existing") = IndicationExisting
		    End If

		    If IndicationNew.Length > 0 Then
		      data.Value("indication_new") = IndicationNew
		    End If

		    If ContextsExisting.Length > 0 Then
		      data.Value("contexts_existing") = ContextsExisting
		    End If

		    If ContextsNew.Length > 0 Then
		      data.Value("contexts_new") = ContextsNew
		    End If

		    Var response As Dictionary = APIClient.Post("changes.lc", "create", data)

		    If response.Value("status") = "success" Then
		      Var responseData As Dictionary = response.Value("data")
		      If responseData.HasKey("id") Then
		        ID = responseData.Value("id").IntegerValue
		      End If

		      ' Broadcast event for UI refresh
		      PubSub.Publish("ISSUE_CREATED", Self)

		      Return True
		    Else
		      System.DebugLog("ChangeRequest.Create error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.Create exception: " + err.Message)
		  End Try

		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromDictionary(data As Dictionary) As ChangeRequest
		  '/// Creates a ChangeRequest object from API response dictionary
		  '///
		  '/// @param data Dictionary from API
		  '/// @returns ChangeRequest object or Nil

		  Try
		    Var change As New ChangeRequest

		    change.ID = data.Value("id").IntegerValue

		    If data.HasKey("indication_id") And data.Value("indication_id") <> Nil Then
		      change.IndicationID = data.Value("indication_id").IntegerValue
		    End If

		    ' Map database field names to properties
		    If data.HasKey("changes_request") And data.Value("changes_request") <> Nil Then
		      change.Description = data.Value("changes_request").StringValue
		    End If

		    If data.HasKey("changes_requestor") And data.Value("changes_requestor") <> Nil Then
		      change.ReporterName = data.Value("changes_requestor").StringValue
		    End If

		    If data.HasKey("changes_status") And data.Value("changes_status") <> Nil Then
		      change.Status = data.Value("changes_status").StringValue
		    End If

		    If data.HasKey("reason_for_close") And data.Value("reason_for_close") <> Nil Then
		      change.ReasonForClose = data.Value("reason_for_close").StringValue
		    End If

		    If data.HasKey("indication_existing") And data.Value("indication_existing") <> Nil Then
		      change.IndicationExisting = data.Value("indication_existing").StringValue
		    End If

		    If data.HasKey("indication_new") And data.Value("indication_new") <> Nil Then
		      change.IndicationNew = data.Value("indication_new").StringValue
		    End If

		    If data.HasKey("contexts_existing") And data.Value("contexts_existing") <> Nil Then
		      change.ContextsExisting = data.Value("contexts_existing").StringValue
		    End If

		    If data.HasKey("contexts_new") And data.Value("contexts_new") <> Nil Then
		      change.ContextsNew = data.Value("contexts_new").StringValue
		    End If

		    If data.HasKey("created_at") And data.Value("created_at") <> Nil Then
		      Try
		        change.CreatedAtString = data.Value("created_at").StringValue
		      Catch
		        // Ignore date parsing errors
		      End Try
		    End If

		    Return change

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.FromDictionary error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll() As ChangeRequest()
		  '/// Fetches all change requests from the API (PUBLIC - no auth required)
		  '///
		  '/// @returns Array of ChangeRequest objects

		  Var results() As ChangeRequest

		  Try
		    Var response As Dictionary = APIClient.Get("changes.lc", "list")

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")

		      ' API may return data as dictionary with "changes" key or direct array
		      Var items() As Variant

		      If dataVariant IsA Dictionary Then
		        Var dataDict As Dictionary = Dictionary(dataVariant)
		        If dataDict.HasKey("changes") Then
		          items = dataDict.Value("changes")
		        End If
		      Else
		        ' Direct array
		        items = dataVariant
		      End If

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var change As ChangeRequest = FromDictionary(Dictionary(item))
		          If change <> Nil Then
		            results.Add(change)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("ChangeRequest.GetAll error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.GetAll exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(id As Integer) As ChangeRequest
		  '/// Fetches a single change request by ID (PUBLIC - no auth required)
		  '///
		  '/// @param id The change request ID
		  '/// @returns ChangeRequest object or Nil if not found

		  Try
		    Var params As New Dictionary
		    params.Value("id") = id.ToString

		    Var response As Dictionary = APIClient.Get("changes.lc", "read", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")

		      If dataVariant IsA Dictionary Then
		        Return FromDictionary(Dictionary(dataVariant))
		      End If
		    Else
		      System.DebugLog("ChangeRequest.GetByID error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.GetByID exception: " + err.Message)
		  End Try

		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByStatus(status As String) As ChangeRequest()
		  '/// Fetches change requests by status (PUBLIC - no auth required)
		  '///
		  '/// @param status Status to filter by (New, In Progress, Closed, Rejected)
		  '/// @returns Array of ChangeRequest objects

		  Var results() As ChangeRequest

		  Try
		    Var params As New Dictionary
		    params.Value("status") = status

		    Var response As Dictionary = APIClient.Get("changes.lc", "by_status", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")

		      ' API may return data as dictionary with "changes" key or direct array
		      Var items() As Variant

		      If dataVariant IsA Dictionary Then
		        Var dataDict As Dictionary = Dictionary(dataVariant)
		        If dataDict.HasKey("changes") Then
		          items = dataDict.Value("changes")
		        End If
		      Else
		        ' Direct array
		        items = dataVariant
		      End If

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var change As ChangeRequest = FromDictionary(Dictionary(item))
		          If change <> Nil Then
		            results.Add(change)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("ChangeRequest.GetByStatus error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.GetByStatus exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetOpen() As ChangeRequest()
		  '/// Fetches all open change requests (New or In Progress)
		  '///
		  '/// @returns Array of ChangeRequest objects

		  Var results() As ChangeRequest

		  Try
		    Var response As Dictionary = APIClient.Get("changes.lc", "list_open")

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")

		      ' API may return data as dictionary with "changes" key or direct array
		      Var items() As Variant

		      If dataVariant IsA Dictionary Then
		        Var dataDict As Dictionary = Dictionary(dataVariant)
		        If dataDict.HasKey("changes") Then
		          items = dataDict.Value("changes")
		        End If
		      Else
		        ' Direct array
		        items = dataVariant
		      End If

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var change As ChangeRequest = FromDictionary(Dictionary(item))
		          If change <> Nil Then
		            results.Add(change)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("ChangeRequest.GetOpen error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.GetOpen exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetShortDescription() As String
		  '/// Returns a shortened description for list display
		  '///
		  '/// @returns Truncated description (max 100 chars)

		  If Description.Length > 100 Then
		    Return Description.Left(97) + "..."
		  Else
		    Return Description
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  '/// Returns a string representation of this change request
		  '///
		  '/// @returns String description

		  Var result As String = "[" + ID.ToString + "] " + Status

		  If ReporterName.Length > 0 Then
		    result = result + " from " + ReporterName
		  End If

		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Update() As Boolean
		  '/// Updates an existing change request (REQUIRES AUTH for status changes)
		  '///
		  '/// @returns True if updated successfully

		  If ID <= 0 Then
		    System.DebugLog("ChangeRequest.Update error: No ID set")
		    Return False
		  End If

		  Try
		    Var data As New Dictionary
		    data.Value("id") = ID
		    data.Value("changes_status") = Status

		    If ReasonForClose.Length > 0 Then
		      data.Value("reason_for_close") = ReasonForClose
		    End If

		    Var response As Dictionary = APIClient.Post("changes.lc", "update", data)

		    If response.Value("status") = "success" Then
		      ' Broadcast event for UI refresh
		      PubSub.Publish("ISSUE_UPDATED", Self)

		      Return True
		    Else
		      System.DebugLog("ChangeRequest.Update error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("ChangeRequest.Update exception: " + err.Message)
		  End Try

		  Return False
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ContextsExisting As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ContextsNew As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CreatedAtString As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationExisting As String
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationNew As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ReasonForClose As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ReporterName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As String
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
			Name="IndicationID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReporterName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReasonForClose"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndicationExisting"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndicationNew"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContextsExisting"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContextsNew"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CreatedAtString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
