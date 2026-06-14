#tag Module
Protected Module ChangelogEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/changelog — PUBLIC (landing-page content). Newest first.
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var sql As String = "SELECT id, entry_date, body, created_at, updated_at, created_by " + _
		    "FROM changelog ORDER BY entry_date DESC, id DESC"
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
		  // GET /api/v1/changelog/:id — PUBLIC.
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var entry As JSONItem = FetchOne(db, id)
		    If entry Is Nil Then
		      APIResponse.WriteError(response, 404, "Changelog entry not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, entry, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleCreate(request As WebRequest, response As WebResponse)
		  // POST /api/v1/changelog — auth required.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    Var bodyText As String = If(body.HasName("body"), body.Value("body").StringValue, "")
		    If bodyText.Trim = "" Then
		      APIResponse.WriteError(response, 400, "body is required")
		      Return
		    End If

		    Var entryDate As String = If(body.HasName("entry_date"), body.Value("entry_date").StringValue, "")
		    If entryDate.Trim = "" Then entryDate = DateTime.Now.SQLDate

		    Var ps As PreparedSQLStatement = db.Prepare("INSERT INTO changelog (entry_date, body, created_by) VALUES (?, ?, ?)")
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(0, entryDate)
		    ps.Bind(1, bodyText)
		    ps.Bind(2, caller.Username)
		    ps.SQLExecute

		    Var newID As Integer = db.LastInsertedRowID
		    Var saved As JSONItem = FetchOne(db, newID)
		    APIResponse.WriteJSON(response, saved, 201)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleUpdate(request As WebRequest, response As WebResponse, id As Integer)
		  // PUT /api/v1/changelog/:id — auth required. Updates entry_date / body
		  // (only the fields supplied).
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var existing As JSONItem = FetchOne(db, id)
		    If existing Is Nil Then
		      APIResponse.WriteError(response, 404, "Changelog entry not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    // Start from existing values; override with whatever was supplied.
		    Var entryDate As String = existing.Value("entry_date").StringValue
		    Var bodyText As String = existing.Value("body").StringValue
		    If body.HasName("entry_date") Then entryDate = body.Value("entry_date").StringValue
		    If body.HasName("body") Then bodyText = body.Value("body").StringValue

		    If bodyText.Trim = "" Then
		      APIResponse.WriteError(response, 400, "body is required")
		      Return
		    End If

		    Var ps As PreparedSQLStatement = db.Prepare("UPDATE changelog SET entry_date = ?, body = ? WHERE id = ?")
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, entryDate)
		    ps.Bind(1, bodyText)
		    ps.Bind(2, id)
		    ps.SQLExecute

		    Var saved As JSONItem = FetchOne(db, id)
		    APIResponse.WriteJSON(response, saved, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  // DELETE /api/v1/changelog/:id — auth required.
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var existing As JSONItem = FetchOne(db, id)
		    If existing Is Nil Then
		      APIResponse.WriteError(response, 404, "Changelog entry not found")
		      Return
		    End If

		    Var ps As PreparedSQLStatement = db.Prepare("DELETE FROM changelog WHERE id = ?")
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    ps.SQLExecute

		    response.Status = 204
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FetchOne(db As MySQLCommunityServer, id As Integer) As JSONItem
		  Var ps As PreparedSQLStatement = db.Prepare("SELECT id, entry_date, body, " + _
		  "created_at, updated_at, created_by FROM changelog WHERE id = ?")
		  ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ps.Bind(0, id)
		  Var rs As RowSet = ps.SelectSQL
		  If rs.AfterLastRow Then Return Nil
		  Return RowToJSON(rs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowToJSON(rs As RowSet) As JSONItem
		  Var j As New JSONItem
		  j.Value("id") = rs.Column("id").IntegerValue
		  j.Value("entry_date") = rs.Column("entry_date").StringValue
		  j.Value("body") = rs.Column("body").StringValue
		  j.Value("created_at") = If(rs.Column("created_at").Value = Nil, "", rs.Column("created_at").StringValue)
		  j.Value("updated_at") = If(rs.Column("updated_at").Value = Nil, "", rs.Column("updated_at").StringValue)
		  j.Value("created_by") = If(rs.Column("created_by").Value = Nil, "", rs.Column("created_by").StringValue)
		  Return j
		End Function
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
