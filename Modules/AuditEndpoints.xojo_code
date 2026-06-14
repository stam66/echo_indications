#tag Module
Protected Module AuditEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/audit — auth required (admin only). Returns the most
		  // recent entries, newest first (capped). Clients filter by table /
		  // action / search locally.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var sql As String = "SELECT id, audit_timestamp, audit_user, audit_table, " + _
		    "audit_primarykey, action, changed_fields, old_values, new_values " + _
		    "FROM audit ORDER BY audit_timestamp DESC, id DESC LIMIT 500"
		    Var rs As RowSet = db.SelectSQL(sql)

		    Var json As New JSONItem
		    json.Load("[]")
		    While Not rs.AfterLastRow
		      json.Add(RowToJSON(rs))
		      rs.MoveToNextRow
		    Wend
		    APIResponse.WriteJSON(response, json, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleGet(request As WebRequest, response As WebResponse, id As Integer)
		  // GET /api/v1/audit/:id — auth required.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var ps As PreparedSQLStatement = db.Prepare("SELECT id, audit_timestamp, " + _
		    "audit_user, audit_table, audit_primarykey, action, changed_fields, " + _
		    "old_values, new_values FROM audit WHERE id = ?")
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    Var rs As RowSet = ps.SelectSQL

		    If rs.AfterLastRow Then
		      APIResponse.WriteError(response, 404, "Audit entry not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, RowToJSON(rs), 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowToJSON(rs As RowSet) As JSONItem
		  Var j As New JSONItem
		  j.Value("id") = rs.Column("id").IntegerValue
		  j.Value("timestamp") = rs.Column("audit_timestamp").StringValue
		  j.Value("user") = If(rs.Column("audit_user").Value = Nil, "", rs.Column("audit_user").StringValue)
		  j.Value("table") = rs.Column("audit_table").StringValue
		  j.Value("primary_key") = rs.Column("audit_primarykey").IntegerValue
		  j.Value("action") = rs.Column("action").StringValue
		  SetJSONField(j, "changed_fields", rs.Column("changed_fields").StringValue)
		  SetJSONField(j, "old_values", rs.Column("old_values").StringValue)
		  SetJSONField(j, "new_values", rs.Column("new_values").StringValue)
		  Return j
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetJSONField(j As JSONItem, key As String, raw As String)
		  // Embed a stored JSON-text column as nested JSON; null if empty or
		  // unparseable, so the client always sees valid JSON or null.
		  If raw.Trim = "" Then
		    j.Value(key) = Nil
		    Return
		  End If
		  Try
		    j.Value(key) = New JSONItem(raw)
		  Catch
		    j.Value(key) = Nil
		  End Try
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Module
#tag EndModule
