#tag Class
Protected Class Context
	#tag Method, Flags = &h0
		Shared Function GetAll(db As MySQLCommunityServer) As Context()
		  Var results() As Context
		  
		  Try
		    Var sql As String = "SELECT * FROM contexts ORDER BY sort_order, name"
		    Var rs As RowSet = db.SelectSQL(sql)
		    
		    While Not rs.AfterLastRow
		      Var ctx As New Context
		      ctx.ID = rs.Column("id").IntegerValue
		      ctx.Name = rs.Column("name").StringValue
		      ctx.Description = rs.Column("description").StringValue
		      ctx.SortOrder = rs.Column("sort_order").IntegerValue
		      ctx.IsActive = rs.Column("is_active").BooleanValue  // ADD THIS LINE
		      
		      results.Add(ctx)
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading contexts: " + err.Message)
		  End Try
		  
		  Return results
		  
		  ' Var results() As Context
		  ' 
		  ' Try
		  ' Var sql As String = "SELECT * FROM contexts ORDER BY sort_order, name"
		  ' Var rs As RowSet = db.SelectSQL(sql)
		  ' 
		  ' While Not rs.AfterLastRow
		  ' Var ctx As New Context
		  ' ctx.ID = rs.Column("id").IntegerValue
		  ' ctx.Name = rs.Column("name").StringValue
		  ' ctx.Description = If(rs.Column("description").Value = Nil, "", rs.Column("description").StringValue)
		  ' ctx.SortOrder = rs.Column("sort_order").IntegerValue
		  ' ctx.IsActive = rs.Column("is_active").BooleanValue
		  ' 
		  ' results.Add(ctx)
		  ' rs.MoveToNextRow
		  ' Wend
		  ' 
		  ' Catch err As DatabaseException
		  ' System.DebugLog("Error loading contexts: " + err.Message)
		  ' End Try
		  ' 
		  ' Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAllActive(db As MySQLCommunityServer) As Context()
		  Var results() As Context
		  
		  Try
		    Var sql As String = "SELECT * FROM contexts WHERE is_active = 1 ORDER BY sort_order, name"
		    Var rs As RowSet = db.SelectSQL(sql)
		    
		    While Not rs.AfterLastRow
		      Var ctx As New Context
		      ctx.ID = rs.Column("id").IntegerValue
		      ctx.Name = rs.Column("name").StringValue
		      ctx.Description = rs.Column("description").StringValue
		      ctx.SortOrder = rs.Column("sort_order").IntegerValue
		      ctx.IsActive = rs.Column("is_active").BooleanValue
		      
		      results.Add(ctx)
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading contexts: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(db As MySQLCommunityServer, contextID As Integer) As Context
		  Try
		    Var sql As String = "SELECT * FROM contexts WHERE id = ?"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, contextID)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    If Not rs.AfterLastRow Then
		      Var ctx As New Context
		      ctx.ID = rs.Column("id").IntegerValue
		      ctx.Name = rs.Column("name").StringValue
		      ctx.Description = If(rs.Column("description").Value = Nil, "", rs.Column("description").StringValue)
		      ctx.SortOrder = rs.Column("sort_order").IntegerValue
		      ctx.IsActive = rs.Column("is_active").BooleanValue
		      Return ctx
		    End If
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading context: " + err.Message)
		  End Try
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFieldValues() As Dictionary
		  Var d As New Dictionary
		  d.Value("name") = Me.Name
		  d.Value("description") = If(Me.Description = "", "", Me.Description)
		  d.Value("sort_order") = Me.SortOrder
		  d.Value("is_active") = If(Me.IsActive, 1, 0)
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save(db As MySQLCommunityServer) As Boolean
		  Try
		    If Me.ID = 0 Then
		      // Insert new context
		      Var sql As String = "INSERT INTO contexts (name, description, sort_order, is_active) VALUES (?, ?, ?, ?)"
		      Var ps As MySQLPreparedStatement = session.DB.Prepare(sql)
		      
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      if me.Description.IsEmpty  then
		        ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		      else
		        ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      end If
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      
		      ps.Bind(0, Me.Name)
		      if me.Description.IsEmpty then
		        ps.Bind(1, nil)
		      else
		        ps.Bind(1, Me.Description)
		      end if
		      ps.Bind(2, Me.SortOrder)
		      ps.Bind(3, If(Me.IsActive, 1, 0))
		      
		      ps.ExecuteSQL
		      Var idSQL As String = "SELECT LAST_INSERT_ID() AS id"
		      Var idRS As RowSet = db.SelectSQL(idSQL)
		      If Not idRS.AfterLastRow Then
		        Me.ID = idRS.Column("id").IntegerValue
		      End If
		      
		    Else
		      // Update existing context
		      Var sql As String = "UPDATE contexts SET name = ?, description = ?, sort_order = ?, is_active = ? WHERE id = ?"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      if me.Description.IsEmpty  then
		        ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		      else
		        ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      end If
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      
		      ps.Bind(0, Me.Name)
		      if me.Description.IsEmpty then
		        ps.Bind(1, nil)
		      else
		        ps.Bind(1, Me.Description)
		      end if
		      ps.Bind(2, Me.SortOrder)
		      ps.Bind(3, If(Me.IsActive, 1, 0))
		      ps.Bind(4, Me.ID)
		      
		      ps.ExecuteSQL
		    End If
		    
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error saving context: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  // Store old data if updating
		  Var oldData As Dictionary
		  Var isNew As Boolean = (Me.ID = 0)
		  
		  If Not isNew Then
		    // Load current state for comparison
		    Var existing As Context = Context.GetByID(db, Me.ID)
		    If existing <> Nil Then
		      oldData = existing.GetFieldValues
		    End If
		  End If
		  
		  // Perform the actual save
		  If Not Me.Save(db) Then Return False
		  
		  // Build new data dictionary
		  Var newData As Dictionary = Me.GetFieldValues
		  
		  // Log to audit
		  If isNew Then
		    Call AuditTracker.LogCreate("contexts", Me.ID, username, newData)
		  Else
		    Call AuditTracker.LogUpdate("contexts", Me.ID, username, oldData, newData)
		  End If
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SortOrder As Integer
	#tag EndProperty


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
		#tag ViewProperty
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SortOrder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
