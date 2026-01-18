#tag Class
Protected Class Audit
	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Timestamp As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty

	#tag Property, Flags = &h0
		UserFullName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TableName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RecordID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Action As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ChangedFields As String
	#tag EndProperty

	#tag Method, Flags = &h0
		Shared Function GetRecent(Optional limit As Integer = 50) As Audit()
		  '/// Fetches recent audit entries (REQUIRES AUTHENTICATION)
		  '///
		  '/// @param limit Number of entries to fetch (default 50, max 1000)
		  '/// @returns Array of Audit objects

		  Var results() As Audit

		  Try
		    Var params As New Dictionary
		    params.Value("limit") = limit.ToString

		    Var response As Dictionary = APIClient.Get("audit.lc", "recent", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var audit As Audit = FromDictionary(Dictionary(item))
		          If audit <> Nil Then
		            results.Add(audit)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Audit.GetRecent error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("Audit.GetRecent exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByTable(tableName As String, Optional limit As Integer = 50) As Audit()
		  '/// Fetches audit entries for a specific table (REQUIRES AUTHENTICATION)
		  '///
		  '/// @param tableName Table name to filter by (e.g., "indications", "contexts")
		  '/// @param limit Number of entries to fetch (default 50, max 1000)
		  '/// @returns Array of Audit objects

		  Var results() As Audit

		  Try
		    Var params As New Dictionary
		    params.Value("table") = tableName
		    params.Value("limit") = limit.ToString

		    Var response As Dictionary = APIClient.Get("audit.lc", "by_table", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var audit As Audit = FromDictionary(Dictionary(item))
		          If audit <> Nil Then
		            results.Add(audit)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Audit.GetByTable error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("Audit.GetByTable exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByRecord(tableName As String, recordID As Integer) As Audit()
		  '/// Fetches audit history for a specific record (REQUIRES AUTHENTICATION)
		  '///
		  '/// @param tableName Table name (e.g., "indications")
		  '/// @param recordID ID of the specific record
		  '/// @returns Array of Audit objects showing full history for this record

		  Var results() As Audit

		  Try
		    Var params As New Dictionary
		    params.Value("table") = tableName
		    params.Value("record_id") = recordID.ToString

		    Var response As Dictionary = APIClient.Get("audit.lc", "by_record", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var audit As Audit = FromDictionary(Dictionary(item))
		          If audit <> Nil Then
		            results.Add(audit)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Audit.GetByRecord error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("Audit.GetByRecord exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByUser(username As String, Optional limit As Integer = 50) As Audit()
		  '/// Fetches audit entries for a specific user (REQUIRES AUTHENTICATION)
		  '///
		  '/// @param username Username to filter by
		  '/// @param limit Number of entries to fetch (default 50, max 1000)
		  '/// @returns Array of Audit objects showing user's activity

		  Var results() As Audit

		  Try
		    Var params As New Dictionary
		    params.Value("username") = username
		    params.Value("limit") = limit.ToString

		    Var response As Dictionary = APIClient.Get("audit.lc", "by_user", params)

		    If response.Value("status") = "success" Then
		      Var dataVariant As Variant = response.Value("data")
		      Var items() As Variant = dataVariant

		      For Each item As Variant In items
		        If item IsA Dictionary Then
		          Var audit As Audit = FromDictionary(Dictionary(item))
		          If audit <> Nil Then
		            results.Add(audit)
		          End If
		        End If
		      Next
		    Else
		      System.DebugLog("Audit.GetByUser error: " + response.Value("message").StringValue)
		    End If

		  Catch err As RuntimeException
		    System.DebugLog("Audit.GetByUser exception: " + err.Message)
		  End Try

		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromDictionary(data As Dictionary) As Audit
		  '/// Creates an Audit object from API response dictionary
		  '///
		  '/// @param data Dictionary from API
		  '/// @returns Audit object or Nil

		  Try
		    Var audit As New Audit

		    audit.ID = data.Value("id").IntegerValue

		    If data.HasKey("timestamp") And data.Value("timestamp") <> Nil Then
		      Try
		        Var timestampStr As String = data.Value("timestamp").StringValue
		        audit.Timestamp = DateTime.Now // Simplified - would need proper parsing
		      Catch
		        // Ignore date parsing errors
		      End Try
		    End If

		    If data.HasKey("username") And data.Value("username") <> Nil Then
		      audit.Username = data.Value("username").StringValue
		    End If

		    If data.HasKey("user_name") And data.Value("user_name") <> Nil Then
		      audit.UserFullName = data.Value("user_name").StringValue
		    End If

		    If data.HasKey("table") And data.Value("table") <> Nil Then
		      audit.TableName = data.Value("table").StringValue
		    End If

		    If data.HasKey("record_id") And data.Value("record_id") <> Nil Then
		      audit.RecordID = data.Value("record_id").IntegerValue
		    End If

		    If data.HasKey("action") And data.Value("action") <> Nil Then
		      audit.Action = data.Value("action").StringValue
		    End If

		    If data.HasKey("changed_fields") And data.Value("changed_fields") <> Nil Then
		      audit.ChangedFields = data.Value("changed_fields").StringValue
		    End If

		    Return audit

		  Catch err As RuntimeException
		    System.DebugLog("Audit.FromDictionary error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  '/// Returns a string representation of this audit entry
		  '///
		  '/// @returns String description

		  Var result As String = Action

		  If UserFullName.Length > 0 Then
		    result = result + " by " + UserFullName
		  ElseIf Username.Length > 0 Then
		    result = result + " by " + Username
		  End If

		  result = result + " on " + TableName

		  If RecordID > 0 Then
		    result = result + " #" + RecordID.ToString
		  End If

		  If ChangedFields.Length > 0 Then
		    result = result + " (" + ChangedFields + ")"
		  End If

		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFormattedTimestamp() As String
		  '/// Returns formatted timestamp for display
		  '///
		  '/// @returns Formatted date/time string

		  If Timestamp <> Nil Then
		    Return Timestamp.ToString
		  Else
		    Return "Unknown"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetActionIcon() As String
		  '/// Returns an icon/emoji for the action type
		  '///
		  '/// @returns Icon character

		  Select Case Action
		  Case "INSERT"
		    Return "+"
		  Case "UPDATE"
		    Return "✎"
		  Case "DELETE"
		    Return "✗"
		  Else
		    Return "•"
		  End Select
		End Function
	#tag EndMethod
End Class
#tag EndClass