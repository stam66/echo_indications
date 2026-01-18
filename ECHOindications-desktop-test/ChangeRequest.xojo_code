#tag Class
Protected Class ChangeRequest
	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationTitle As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ReportedBy As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ReporterName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ResolutionNotes As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CreatedAt As DateTime
	#tag EndProperty

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
		      Var items() As Variant = dataVariant

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
		Shared Function GetByStatus(status As String) As ChangeRequest()
		  '/// Fetches change requests by status (PUBLIC - no auth required)
		  '///
		  '/// @param status Status to filter by (New, In progress, Closed)
		  '/// @returns Array of ChangeRequest objects

		  Var results() As ChangeRequest

		  Try
		    Var params As New Dictionary
		    params.Value("status") = status

		    Var response As Dictionary = APIClient.Get("changes.lc", "by_status", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant

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
		Shared Function CountNew() As Integer
		  '/// Gets count of new change requests (PUBLIC - no auth required)
		  '///
		  '/// @returns Count of new requests (useful for badge display)

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

		    If data.HasKey("indication_title") And data.Value("indication_title") <> Nil Then
		      change.IndicationTitle = data.Value("indication_title").StringValue
		    End If

		    If data.HasKey("description") And data.Value("description") <> Nil Then
		      change.Description = data.Value("description").StringValue
		    End If

		    If data.HasKey("reported_by") And data.Value("reported_by") <> Nil Then
		      change.ReportedBy = data.Value("reported_by").StringValue
		    End If

		    If data.HasKey("reporter_name") And data.Value("reporter_name") <> Nil Then
		      change.ReporterName = data.Value("reporter_name").StringValue
		    End If

		    If data.HasKey("status") And data.Value("status") <> Nil Then
		      change.Status = data.Value("status").StringValue
		    End If

		    If data.HasKey("resolution_notes") And data.Value("resolution_notes") <> Nil Then
		      change.ResolutionNotes = data.Value("resolution_notes").StringValue
		    End If

		    If data.HasKey("created_at") And data.Value("created_at") <> Nil Then
		      Try
		        Var dateStr As String = data.Value("created_at").StringValue
		        change.CreatedAt = DateTime.Now // Simplified - would need proper parsing
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
		Function ToString() As String
		  '/// Returns a string representation of this change request
		  '///
		  '/// @returns String description

		  Var result As String = "[" + ID.ToString + "] " + Status

		  If ReporterName.Length > 0 Then
		    result = result + " from " + ReporterName
		  ElseIf ReportedBy.Length > 0 Then
		    result = result + " from " + ReportedBy
		  End If

		  If IndicationTitle.Length > 0 Then
		    result = result + " - " + IndicationTitle
		  End If

		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetShortDescription() As String
		  '/// Returns a shortened description for list display
		  '///
		  '/// @returns Truncated description

		  If Description.Length > 100 Then
		    Return Description.Left(100) + "..."
		  Else
		    Return Description
		  End If
		End Function
	#tag EndMethod
End Class
#tag EndClass