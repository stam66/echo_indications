#tag Module
Protected Module UserEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/users   auth required
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var json As New JSONItem
		    json.Load("[]")
		    Var rs As RowSet = db.SelectSQL("SELECT id FROM users ORDER BY username")
		    While Not rs.AfterLastRow
		      Var u As User = User.GetByID(db, rs.Column("id").IntegerValue)
		      If u <> Nil Then json.Add(u.ToJSONItem)
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
		  // GET /api/v1/users/:id   auth required
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var u As User = User.GetByID(db, id)
		    If u Is Nil Then
		      APIResponse.WriteError(response, 404, "User not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, u.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleCreate(request As WebRequest, response As WebResponse)
		  // POST /api/v1/users   auth required
		  // Body: {name, username, email, title, is_active}
		  // Password is NOT set here — the new user goes through the existing
		  // OTP/web-UI first-login flow to set their own password.
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

		    Var u As New User
		    If body.HasName("name") Then u.Name = body.Value("name").StringValue
		    If body.HasName("username") Then u.Username = body.Value("username").StringValue
		    If body.HasName("email") Then u.Email = body.Value("email").StringValue
		    If body.HasName("title") Then u.Title = body.Value("title").StringValue
		    If body.HasName("is_active") Then u.IsActive = body.Value("is_active").BooleanValue Else u.IsActive = True

		    If u.Username.Trim = "" Then
		      APIResponse.WriteError(response, 400, "username is required")
		      Return
		    End If

		    If Not u.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save user (username may already exist)")
		      Return
		    End If

		    Var saved As User = User.GetByID(db, u.ID)
		    APIResponse.WriteJSON(response, If(saved <> Nil, saved.ToJSONItem, u.ToJSONItem), 201)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleUpdate(request As WebRequest, response As WebResponse, id As Integer)
		  // PUT /api/v1/users/:id   auth required, PATCH-style
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var u As User = User.GetByID(db, id)
		    If u Is Nil Then
		      APIResponse.WriteError(response, 404, "User not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    If body.HasName("name") Then u.Name = body.Value("name").StringValue
		    If body.HasName("username") Then u.Username = body.Value("username").StringValue
		    If body.HasName("email") Then u.Email = body.Value("email").StringValue
		    If body.HasName("title") Then u.Title = body.Value("title").StringValue
		    If body.HasName("is_active") Then u.IsActive = body.Value("is_active").BooleanValue

		    // Refuse to let the calling user deactivate themselves — that would lock them out.
		    If u.ID = caller.ID And Not u.IsActive Then
		      APIResponse.WriteError(response, 400, "Cannot deactivate yourself")
		      Return
		    End If

		    If u.Username.Trim = "" Then
		      APIResponse.WriteError(response, 400, "username is required")
		      Return
		    End If

		    If Not u.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save user")
		      Return
		    End If

		    Var saved As User = User.GetByID(db, u.ID)
		    APIResponse.WriteJSON(response, saved.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  // DELETE /api/v1/users/:id   auth required
		  // Refuses to delete the calling user (self-lockout protection).
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    If id = caller.ID Then
		      APIResponse.WriteError(response, 400, "Cannot delete yourself")
		      Return
		    End If

		    Var u As User = User.GetByID(db, id)
		    If u Is Nil Then
		      APIResponse.WriteError(response, 404, "User not found")
		      Return
		    End If

		    If Not u.DeleteWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to delete user")
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
