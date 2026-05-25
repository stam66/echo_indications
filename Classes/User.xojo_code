#tag Class
Protected Class User
	#tag Method, Flags = &h0
		Function DeleteWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  If Self.ID = 0 Then Return False
		  
		  // Get current data before deletion
		  Var oldData As Dictionary = Self.GetFieldValues
		  
		  // Perform the actual delete
		  Try
		    Var sql As String = "DELETE FROM users WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Self.ID)
		    ps.ExecuteSQL
		    
		    // Log to audit
		    Call AuditTracker.LogDelete(db, "users", Self.ID, username, oldData)
		    
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("Error deleting user: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByUsername(db As MySQLCommunityServer, username As String) As User
		  Try
		    Var sql As String = "SELECT * FROM users WHERE username = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(0, username)

		    Var rs As RowSet = ps.SelectSQL

		    If Not rs.AfterLastRow Then
		      Var u As New User
		      u.ID = rs.Column("id").IntegerValue
		      u.Name = rs.Column("name").StringValue
		      u.Username = rs.Column("username").StringValue
		      u.Email = rs.Column("email").StringValue
		      u.Title = rs.Column("title").StringValue
		      u.IsActive = rs.Column("is_active").BooleanValue
		      Return u
		    End If
		  Catch err As DatabaseException
		    System.DebugLog("Error loading user by username: " + err.Message)
		  End Try

		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(db As MySQLCommunityServer, id As Integer) As User
		  Try
		    Var sql As String = "SELECT * FROM users WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    If Not rs.AfterLastRow Then
		      Var user As New User
		      user.ID = rs.Column("id").IntegerValue
		      user.Name = rs.Column("name").StringValue
		      user.Username = rs.Column("username").StringValue
		      user.Email = rs.Column("email").StringValue
		      user.Title = rs.Column("title").StringValue
		      user.IsActive = rs.Column("is_active").BooleanValue
		      Return user
		    End If
		  Catch err As DatabaseException
		    System.DebugLog("Error loading user: " + err.Message)
		  End Try
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSONItem() As JSONItem
		  // JSON-shaped projection of a User. Never includes password_hash
		  // or password_salt — those must not leave the server.
		  Var j As New JSONItem
		  j.Value("id") = Self.ID
		  j.Value("name") = Self.Name
		  j.Value("username") = Self.Username
		  j.Value("email") = Self.Email
		  j.Value("title") = Self.Title
		  j.Value("is_active") = Self.IsActive
		  Return j
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFieldValues() As Dictionary
		  Var data As New Dictionary
		  data.Value("name") = Self.Name
		  data.Value("username") = Self.Username
		  data.Value("email") = If(Self.Email = "", "", Self.Email)
		  data.Value("title") = If(Self.Title = "", "", Self.Title)
		  data.Value("is_active") = If(Self.IsActive, "1", "0")
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save(db As MySQLCommunityServer) As Boolean
		  Try
		    If Me.ID = 0 Then
		      // Insert
		      Var sql As String = "INSERT INTO users (name, username, email, title, is_active) VALUES (?, ?, ?, ?, ?)"
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      
		      ps.Bind(0, Me.Name)
		      ps.Bind(1, Me.Username)
		      ps.Bind(2, Me.Email)
		      ps.Bind(3, Me.Title)
		      ps.Bind(4, Me.IsActive)
		      
		      ps.ExecuteSQL
		      Me.ID = db.LastInsertedRowID
		    Else
		      // Update
		      Var sql As String = "UPDATE users SET name=?, username=?, email=?, title=?, is_active=? WHERE id=?"
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      
		      ps.Bind(0, Me.Name)
		      ps.Bind(1, Me.Username)
		      ps.Bind(2, Me.Email)
		      ps.Bind(3, Me.Title)
		      ps.Bind(4, Me.IsActive)
		      ps.Bind(5, Me.ID)
		      
		      ps.ExecuteSQL
		    End If
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("Error saving user: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  Var oldData As Dictionary
		  Var isNew As Boolean = (Self.ID = 0)
		  
		  If Not isNew Then
		    // Load existing for comparison
		    Var existing As User = User.GetByID(db, Self.ID)
		    If existing <> Nil Then
		      oldData = existing.GetFieldValues
		    End If
		  End If
		  
		  If Not Self.Save(db) Then Return False
		  
		  Var newData As Dictionary = Self.GetFieldValues
		  
		  If isNew Then
		    Call AuditTracker.LogCreate(db, "users", Self.ID, username, newData)
		  Else
		    Call AuditTracker.LogUpdate(db, "users", Self.ID, username, oldData, newData)
		  End If
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		email As String
	#tag EndProperty

	#tag Property, Flags = &h0
		id As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		isActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		title As string
	#tag EndProperty

	#tag Property, Flags = &h0
		username As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
			Name="id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
