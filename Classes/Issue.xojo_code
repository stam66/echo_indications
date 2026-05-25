#tag Class
Protected Class Issue
	#tag Method, Flags = &h0
		Function Delete(db As MySQLCommunityServer) As Boolean
		  Try
		    Var sql As String = "DELETE FROM changes WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Me.ID)
		    ps.ExecuteSQL
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("Error deleting issue: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  If Self.ID = 0 Then Return False
		  Var oldData As Dictionary = Self.GetFieldValues
		  If Not Self.Delete(db) Then Return False
		  Call AuditTracker.LogDelete(db, "changes", Self.ID, username, oldData)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll(db As MySQLCommunityServer) As Issue()
		  Var results() As Issue
		  Try
		    Var rs As RowSet = db.SelectSQL("SELECT * FROM changes ORDER BY created_at DESC")
		    While Not rs.AfterLastRow
		      results.Add Issue.FromRow(rs)
		      rs.MoveToNextRow
		    Wend
		  Catch err As DatabaseException
		    System.DebugLog("Error loading issues: " + err.Message)
		  End Try
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(db As MySQLCommunityServer, id As Integer) As Issue
		  Try
		    Var sql As String = "SELECT * FROM changes WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    Var rs As RowSet = ps.SelectSQL
		    If Not rs.AfterLastRow Then Return Issue.FromRow(rs)
		  Catch err As DatabaseException
		    System.DebugLog("Error loading issue: " + err.Message)
		  End Try
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromRow(rs As RowSet) As Issue
		  Var i As New Issue
		  i.ID = rs.Column("id").IntegerValue
		  i.Request = rs.Column("changes_request").StringValue
		  i.Requestor = rs.Column("changes_requestor").StringValue
		  i.Status = rs.Column("changes_status").StringValue
		  i.ExistingContexts = rs.Column("contexts_existing").StringValue
		  i.NewContexts = rs.Column("contexts_new").StringValue
		  i.ExistingIndication = rs.Column("indication_existing").StringValue
		  i.NewIndication = rs.Column("indication_new").StringValue
		  i.IndicationID = rs.Column("Indication_id").IntegerValue
		  i.ReasonForClose = rs.Column("reason_for_close").StringValue
		  i.ResolutionNotes = rs.Column("resolution_notes").StringValue
		  i.CreatedAt = rs.Column("created_at").StringValue
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFieldValues() As Dictionary
		  Var data As New Dictionary
		  data.Value("request") = Self.Request
		  data.Value("requestor") = Self.Requestor
		  data.Value("status") = Self.Status
		  data.Value("existing_contexts") = Self.ExistingContexts
		  data.Value("new_contexts") = Self.NewContexts
		  data.Value("existing_indication") = Self.ExistingIndication
		  data.Value("new_indication") = Self.NewIndication
		  data.Value("indication_id") = If(Self.IndicationID = 0, "", Self.IndicationID.ToString)
		  data.Value("reason_for_close") = Self.ReasonForClose
		  data.Value("resolution_notes") = Self.ResolutionNotes
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSONItem() As JSONItem
		  Var j As New JSONItem
		  j.Value("id") = Self.ID
		  j.Value("request") = Self.Request
		  j.Value("requestor") = Self.Requestor
		  j.Value("status") = Self.Status
		  j.Value("existing_contexts") = Self.ExistingContexts
		  j.Value("new_contexts") = Self.NewContexts
		  j.Value("existing_indication") = Self.ExistingIndication
		  j.Value("new_indication") = Self.NewIndication
		  // 0 sentinel becomes JSON null — no real indication has id 0.
		  If Self.IndicationID = 0 Then j.Value("indication_id") = Nil Else j.Value("indication_id") = Self.IndicationID
		  j.Value("reason_for_close") = Self.ReasonForClose
		  j.Value("resolution_notes") = Self.ResolutionNotes
		  j.Value("created_at") = Self.CreatedAt
		  Return j
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadFromJSON(j As JSONItem)
		  If j.HasName("request") Then Self.Request = j.Value("request").StringValue
		  If j.HasName("requestor") Then Self.Requestor = j.Value("requestor").StringValue
		  If j.HasName("status") Then Self.Status = j.Value("status").StringValue
		  If j.HasName("existing_contexts") Then Self.ExistingContexts = j.Value("existing_contexts").StringValue
		  If j.HasName("new_contexts") Then Self.NewContexts = j.Value("new_contexts").StringValue
		  If j.HasName("existing_indication") Then Self.ExistingIndication = j.Value("existing_indication").StringValue
		  If j.HasName("new_indication") Then Self.NewIndication = j.Value("new_indication").StringValue
		  If j.HasName("indication_id") Then Self.IndicationID = j.Value("indication_id").IntegerValue
		  If j.HasName("reason_for_close") Then Self.ReasonForClose = j.Value("reason_for_close").StringValue
		  If j.HasName("resolution_notes") Then Self.ResolutionNotes = j.Value("resolution_notes").StringValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save(db As MySQLCommunityServer) As Boolean
		  Try
		    If Me.ID = 0 Then
		      // Default status to "New" for fresh submissions if caller didn't set one.
		      If Me.Status = "" Then Me.Status = "New"

		      Var sql As String = "INSERT INTO changes (changes_request, changes_requestor, changes_status, " + _
		      "contexts_existing, contexts_new, indication_existing, indication_new, Indication_id, " + _
		      "reason_for_close, resolution_notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      // 7 (Indication_id) set conditionally for NULL
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_STRING)

		      ps.Bind(0, Me.Request)
		      ps.Bind(1, Me.Requestor)
		      ps.Bind(2, Me.Status)
		      ps.Bind(3, Me.ExistingContexts)
		      ps.Bind(4, Me.NewContexts)
		      ps.Bind(5, Me.ExistingIndication)
		      ps.Bind(6, Me.NewIndication)
		      If Me.IndicationID = 0 Then
		        ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(7, Nil)
		      Else
		        ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		        ps.Bind(7, Me.IndicationID)
		      End If
		      ps.Bind(8, Me.ReasonForClose)
		      ps.Bind(9, Me.ResolutionNotes)

		      ps.ExecuteSQL
		      Me.ID = db.LastInsertedRowID
		    Else
		      Var sql As String = "UPDATE changes SET changes_request=?, changes_requestor=?, changes_status=?, " + _
		      "contexts_existing=?, contexts_new=?, indication_existing=?, indication_new=?, Indication_id=?, " + _
		      "reason_for_close=?, resolution_notes=? WHERE id=?"
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      // 7 (Indication_id) set conditionally for NULL
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_LONG)

		      ps.Bind(0, Me.Request)
		      ps.Bind(1, Me.Requestor)
		      ps.Bind(2, Me.Status)
		      ps.Bind(3, Me.ExistingContexts)
		      ps.Bind(4, Me.NewContexts)
		      ps.Bind(5, Me.ExistingIndication)
		      ps.Bind(6, Me.NewIndication)
		      If Me.IndicationID = 0 Then
		        ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(7, Nil)
		      Else
		        ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		        ps.Bind(7, Me.IndicationID)
		      End If
		      ps.Bind(8, Me.ReasonForClose)
		      ps.Bind(9, Me.ResolutionNotes)
		      ps.Bind(10, Me.ID)

		      ps.ExecuteSQL
		    End If
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("Error saving issue: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  Var oldData As Dictionary
		  Var isNew As Boolean = (Self.ID = 0)
		  If Not isNew Then
		    Var existing As Issue = Issue.GetByID(db, Self.ID)
		    If existing <> Nil Then oldData = existing.GetFieldValues
		  End If
		  If Not Self.Save(db) Then Return False
		  Var newData As Dictionary = Self.GetFieldValues
		  If isNew Then
		    Call AuditTracker.LogCreate(db, "changes", Self.ID, username, newData)
		  Else
		    Call AuditTracker.LogUpdate(db, "changes", Self.ID, username, oldData, newData)
		  End If
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Request As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Requestor As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ExistingContexts As String
	#tag EndProperty

	#tag Property, Flags = &h0
		NewContexts As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ExistingIndication As String
	#tag EndProperty

	#tag Property, Flags = &h0
		NewIndication As String
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ReasonForClose As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ResolutionNotes As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CreatedAt As String
	#tag EndProperty


End Class
#tag EndClass
