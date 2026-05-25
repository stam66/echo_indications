#tag Module
Protected Module AuthEndpoints
	#tag Method, Flags = &h0
		Sub HandleLogin(request As WebRequest, response As WebResponse)
		  // POST /api/v1/login   body: {"username":"...","password":"..."}
		  // -> 200 {"token":"...","user":{...}}    on success
		  // -> 400 if body is malformed
		  // -> 401 if credentials are bad / account inactive / OTP-pending
		  If request.Method <> "POST" Then
		    APIResponse.WriteError(response, 405, "Method not allowed")
		    Return
		  End If

		  Var body As JSONItem
		  Try
		    body = New JSONItem(request.Body)
		  Catch
		    APIResponse.WriteError(response, 400, "Invalid JSON body")
		    Return
		  End Try

		  Var username As String = If(body.HasName("username"), body.Value("username").StringValue, "")
		  Var password As String = If(body.HasName("password"), body.Value("password").StringValue, "")

		  If username = "" Or password = "" Then
		    APIResponse.WriteError(response, 400, "username and password are required")
		    Return
		  End If

		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var user As User = APIAuth.VerifyPassword(db, username, password)
		    If user Is Nil Then
		      APIResponse.WriteError(response, 401, "Invalid credentials")
		      Return
		    End If

		    Var token As String = APIAuth.IssueToken(db, user.ID)

		    Var result As New JSONItem
		    result.Value("token") = token
		    result.Value("user") = user.ToJSONItem
		    APIResponse.WriteJSON(response, result, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleLogout(request As WebRequest, response As WebResponse)
		  // POST /api/v1/logout   Authorization: Bearer <token>
		  // -> 204 on success (also 204 if the token didn't exist — idempotent)
		  If request.Method <> "POST" Then
		    APIResponse.WriteError(response, 405, "Method not allowed")
		    Return
		  End If

		  Var auth As String = request.Header("Authorization")
		  If auth = "" Or Not auth.BeginsWith("Bearer ") Then
		    APIResponse.WriteError(response, 401, "Missing or malformed Authorization header")
		    Return
		  End If
		  Var token As String = auth.Middle(7).Trim

		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    APIAuth.Logout(db, token)
		    response.Status = 204
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleMe(request As WebRequest, response As WebResponse)
		  // GET /api/v1/me   Authorization: Bearer <token>
		  // -> 200 {...user fields...}
		  // -> 401 if no/invalid token
		  // Useful as a sanity-check endpoint for authenticated clients.
		  If request.Method <> "GET" Then
		    APIResponse.WriteError(response, 405, "Method not allowed")
		    Return
		  End If

		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var user As User = APIAuth.RequireUser(request, response, db)
		    If user Is Nil Then Return   // RequireUser already wrote the 401
		    APIResponse.WriteJSON(response, user.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod


End Module
#tag EndModule
