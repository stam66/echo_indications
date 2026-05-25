#tag Module
Protected Module IssueEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/issues   auth required (admin-only list view)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var issues() As Issue = Issue.GetAll(db)
		    Var json As New JSONItem
		    json.Load("[]")
		    For Each i As Issue In issues
		      json.Add(i.ToJSONItem)
		    Next
		    APIResponse.WriteJSON(response, json, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleGet(request As WebRequest, response As WebResponse, id As Integer)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var i As Issue = Issue.GetByID(db, id)
		    If i Is Nil Then
		      APIResponse.WriteError(response, 404, "Issue not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, i.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleCreate(request As WebRequest, response As WebResponse)
		  // POST /api/v1/issues   NO AUTH — anyone can submit a bug/change request.
		  // Matches the existing landing-page behaviour where anonymous users
		  // can file feedback. The "requestor" field is whatever the client sends
		  // (typically a name/email or just "anonymous"); audit log records the
		  // create with username "anonymous" to make the API origin visible.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    Var i As New Issue
		    i.LoadFromJSON(body)

		    If i.Request.Trim = "" Then
		      APIResponse.WriteError(response, 400, "request is required")
		      Return
		    End If

		    // Anonymous submitter — use the requestor field if present, else "anonymous"
		    Var auditUser As String = If(i.Requestor.Trim <> "", i.Requestor.Trim, "anonymous")

		    If Not i.SaveWithAudit(db, auditUser) Then
		      APIResponse.WriteError(response, 500, "Failed to save issue")
		      Return
		    End If

		    Var saved As Issue = Issue.GetByID(db, i.ID)
		    APIResponse.WriteJSON(response, If(saved <> Nil, saved.ToJSONItem, i.ToJSONItem), 201)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleUpdate(request As WebRequest, response As WebResponse, id As Integer)
		  // PUT /api/v1/issues/:id   auth required — admin resolves / re-assigns / closes
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var i As Issue = Issue.GetByID(db, id)
		    If i Is Nil Then
		      APIResponse.WriteError(response, 404, "Issue not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    i.LoadFromJSON(body)

		    If Not i.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save issue")
		      Return
		    End If

		    Var saved As Issue = Issue.GetByID(db, i.ID)
		    APIResponse.WriteJSON(response, saved.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var i As Issue = Issue.GetByID(db, id)
		    If i Is Nil Then
		      APIResponse.WriteError(response, 404, "Issue not found")
		      Return
		    End If

		    If Not i.DeleteWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to delete issue")
		      Return
		    End If

		    response.Status = 204
		  Finally
		    db.Close
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
