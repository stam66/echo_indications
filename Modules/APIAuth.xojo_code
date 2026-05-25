#tag Module
Protected Module APIAuth
	#tag Method, Flags = &h0
		Function IssueToken(db As MySQLCommunityServer, userID As Integer, lifetimeDays As Integer = 30) As String
		  // Generate a cryptographically random 32-byte token (64 hex chars)
		  // and store it in api_tokens. Returns the raw token string.
		  Var mb As MemoryBlock = Crypto.GenerateRandomBytes(32)
		  Var token As String = EncodeHex(mb)

		  Var sql As String = "INSERT INTO api_tokens (token, user_id, created_at, expires_at) " + _
		  "VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? DAY))"
		  Var ps As PreparedSQLStatement = db.Prepare(sql)
		  ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ps.Bind(0, token)
		  ps.Bind(1, userID)
		  ps.Bind(2, lifetimeDays)
		  ps.SQLExecute

		  Return token
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Logout(db As MySQLCommunityServer, token As String)
		  // Revoke a specific token. Silent no-op if the token doesn't exist.
		  Var sql As String = "DELETE FROM api_tokens WHERE token = ?"
		  Var ps As PreparedSQLStatement = db.Prepare(sql)
		  ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(0, token)
		  ps.SQLExecute
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireUser(request As WebRequest, response As WebResponse, db As MySQLCommunityServer) As User
		  // Read the Authorization header, validate the bearer token, and
		  // return the User. On any failure, writes a 401 to the response
		  // and returns Nil — caller should immediately Return.
		  Var auth As String = request.Header("Authorization")
		  If auth = "" Or Not auth.BeginsWith("Bearer ") Then
		    APIResponse.WriteError(response, 401, "Missing or malformed Authorization header")
		    Return Nil
		  End If

		  Var token As String = auth.Middle(7).Trim
		  Var user As User = ValidateToken(db, token)
		  If user Is Nil Then
		    APIResponse.WriteError(response, 401, "Invalid or expired token")
		    Return Nil
		  End If

		  Return user
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidateToken(db As MySQLCommunityServer, token As String) As User
		  // Look up the token; if found, not expired, and the user is active,
		  // return the User. Updates last_used. Returns Nil on any failure.
		  If token = "" Then Return Nil

		  Try
		    Var sql As String = "SELECT u.id, u.name, u.username, u.email, u.title, u.is_active " + _
		    "FROM api_tokens t " + _
		    "INNER JOIN users u ON u.id = t.user_id " + _
		    "WHERE t.token = ? AND t.expires_at > NOW() AND u.is_active = 1"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(0, token)
		    Var rs As RowSet = ps.SelectSQL

		    If rs.AfterLastRow Then Return Nil

		    Var u As New User
		    u.ID = rs.Column("id").IntegerValue
		    u.Name = rs.Column("name").StringValue
		    u.Username = rs.Column("username").StringValue
		    u.Email = rs.Column("email").StringValue
		    u.Title = rs.Column("title").StringValue
		    u.IsActive = rs.Column("is_active").BooleanValue

		    // Refresh last_used (best-effort; ignore failure)
		    Try
		      Var upd As PreparedSQLStatement = db.Prepare("UPDATE api_tokens SET last_used = NOW() WHERE token = ?")
		      upd.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      upd.Bind(0, token)
		      upd.SQLExecute
		    Catch
		    End Try

		    Return u
		  Catch err As DatabaseException
		    System.DebugLog("ValidateToken error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VerifyPassword(db As MySQLCommunityServer, username As String, password As String) As User
		  // Verify credentials using the same PBKDF2 scheme as dlg_Login
		  // (SHA-256, 10000 iterations, 32-byte derived key, hex-encoded).
		  // Returns the User on success, Nil otherwise.
		  // Also enforces is_active = 1 and rejects accounts with OTP = 1
		  // (those need to complete password reset via the web UI first).
		  Try
		    Var sql As String = "SELECT * FROM users WHERE username = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(0, username)
		    Var rs As RowSet = ps.SelectSQL

		    If rs.AfterLastRow Then Return Nil
		    If Not rs.Column("is_active").BooleanValue Then Return Nil
		    If rs.Column("OTP").IntegerValue = 1 Then Return Nil

		    Var storedHash As String = rs.Column("password_hash").StringValue
		    Var storedSalt As String = rs.Column("password_salt").StringValue

		    Var passwordData As New MemoryBlock(password.LenB)
		    passwordData.StringValue(0, password.LenB) = password
		    Var computedHash As MemoryBlock = Crypto.PBKDF2(storedSalt, passwordData, 10000, 32, Crypto.HashAlgorithms.SHA2_256)
		    Var computedHashHex As String = EncodeHex(computedHash)

		    If computedHashHex <> storedHash Then Return Nil

		    Var u As New User
		    u.ID = rs.Column("id").IntegerValue
		    u.Name = rs.Column("name").StringValue
		    u.Username = rs.Column("username").StringValue
		    u.Email = rs.Column("email").StringValue
		    u.Title = rs.Column("title").StringValue
		    u.IsActive = rs.Column("is_active").BooleanValue
		    Return u
		  Catch err As DatabaseException
		    System.DebugLog("VerifyPassword error: " + err.Message)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncodeHex(mb As MemoryBlock) As String
		  // Local copy of the same routine on EchoIndicationsApp — keeps APIAuth
		  // independent of the app class so it can be used outside a session.
		  Var hexChars As String = "0123456789abcdef"
		  Var result As String = ""
		  For i As Integer = 0 To mb.Size - 1
		    Var b As UInt8 = mb.UInt8Value(i)
		    Var highNibble As Integer = b \ 16
		    Var lowNibble As Integer = b Mod 16
		    result = result + hexChars.Middle(highNibble, 1) + hexChars.Middle(lowNibble, 1)
		  Next
		  Return result
		End Function
	#tag EndMethod


End Module
#tag EndModule
