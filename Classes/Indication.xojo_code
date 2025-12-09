#tag Class
Protected Class Indication
	#tag Method, Flags = &h0
		Function Delete(db As MySQLCommunityServer) As Boolean
		  Try
		    // Soft delete
		    Var sql As String = "UPDATE indications SET is_active = FALSE WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Me.ID)
		    ps.SQLExecute
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error deleting indication: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll(db As MySQLCommunityServer) As Indication()
		  Var results() As Indication
		  
		  Try
		    Var sql As String = "SELECT * FROM indications WHERE is_active = TRUE ORDER BY title"
		    Var rs As RowSet = db.SelectSQL(sql)
		    
		    While Not rs.AfterLastRow
		      Var ind As New Indication
		      ind.ID = rs.Column("id").IntegerValue
		      ind.Title = rs.Column("title").StringValue
		      ind.Description = rs.Column("description").StringValue
		      ind.Keywords = rs.Column("keywords").StringValue
		      ind.Comments = rs.Column("comments").StringValue
		      ind.PrimaryCare = rs.Column("primary_care").StringValue
		      ind.SecondaryInpatient = rs.Column("secondary_inpatient").StringValue
		      ind.SecondaryOutpatient = rs.Column("secondary_outpatient").StringValue
		      ind.SourceASE = rs.Column("source_ase").BooleanValue
		      ind.SourceEACVI = rs.Column("source_eacvi").BooleanValue
		      ind.SourceBSE = rs.Column("source_bse").BooleanValue
		      ind.SourceConsensus = rs.Column("source_consensus").BooleanValue
		      ind.IsActive = rs.Column("is_active").BooleanValue
		      
		      // Load contexts
		      ind.LoadContexts db
		      
		      results.Add ind
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading indications: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(db As MySQLCommunityServer, id As Integer) As Indication
		  Try
		    Var sql As String = "SELECT * FROM indications WHERE id = ?"
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    If Not rs.AfterLastRow Then
		      Var ind As New Indication
		      ind.ID = rs.Column("id").IntegerValue
		      ind.Title = rs.Column("title").StringValue
		      ind.Description = rs.Column("description").StringValue
		      ind.Keywords = rs.Column("keywords").StringValue
		      ind.Comments = rs.Column("comments").StringValue
		      ind.PrimaryCare = rs.Column("primary_care").StringValue
		      ind.SecondaryInpatient = rs.Column("secondary_inpatient").StringValue
		      ind.SecondaryOutpatient = rs.Column("secondary_outpatient").StringValue
		      ind.SourceASE = rs.Column("source_ase").BooleanValue
		      ind.SourceEACVI = rs.Column("source_eacvi").BooleanValue
		      ind.SourceBSE = rs.Column("source_bse").BooleanValue
		      ind.SourceConsensus = rs.Column("source_consensus").BooleanValue
		      ind.IsActive = rs.Column("is_active").BooleanValue
		      ind.LoadContexts db
		      Return ind
		    End If
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading indication: " + err.Message)
		  End Try
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadContexts(db As MySQLCommunityServer)
		  Try
		    Var sql As String = "SELECT c.id, c.name FROM contexts c " + _
		    "INNER JOIN indication_contexts ic ON c.id = ic.context_id " + _
		    "WHERE ic.indication_id = ? ORDER BY c.sort_order"
		    
		    Var ps As PreparedSQLStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Me.ID)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    ContextIDs.ResizeTo(-1)
		    ContextNames.ResizeTo(-1)
		    
		    While Not rs.AfterLastRow
		      ContextIDs.Add rs.Column("id").IntegerValue
		      ContextNames.Add rs.Column("name").StringValue
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading contexts: " + err.Message)
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save(db As MySQLCommunityServer) As Boolean
		  Try
		    If Me.ID = 0 Then
		      // Insert
		      Var sql As String = "INSERT INTO indications (title, description, keywords, comments, " + _
		      "primary_care, secondary_inpatient, secondary_outpatient, " + _
		      "source_ase, source_eacvi, source_bse, source_consensus, is_active) " + _
		      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		      
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      
		      ps.Bind(0, Me.Title)
		      ps.Bind(1, Me.Description)
		      ps.Bind(2, Me.Keywords)
		      ps.Bind(3, Me.Comments)
		      ps.Bind(4, Me.PrimaryCare)
		      ps.Bind(5, Me.SecondaryInpatient)
		      ps.Bind(6, Me.SecondaryOutpatient)
		      ps.Bind(7, Me.SourceASE)
		      ps.Bind(8, Me.SourceEACVI)
		      ps.Bind(9, Me.SourceBSE)
		      ps.Bind(10, Me.SourceConsensus)
		      ps.Bind(11, Me.IsActive)
		      
		      ps.SQLExecute
		      Me.ID = db.LastInsertedRowID
		      
		    Else
		      // Update
		      Var sql As String = "UPDATE indications SET title=?, description=?, keywords=?, comments=?, " + _
		      "primary_care=?, secondary_inpatient=?, secondary_outpatient=?, " + _
		      "source_ase=?, source_eacvi=?, source_bse=?, source_consensus=?, is_active=? " + _
		      "WHERE id=?"
		      
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(12, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      
		      ps.Bind(0, Me.Title)
		      ps.Bind(1, Me.Description)
		      ps.Bind(2, Me.Keywords)
		      ps.Bind(3, Me.Comments)
		      ps.Bind(4, Me.PrimaryCare)
		      ps.Bind(5, Me.SecondaryInpatient)
		      ps.Bind(6, Me.SecondaryOutpatient)
		      ps.Bind(7, Me.SourceASE)
		      ps.Bind(8, Me.SourceEACVI)
		      ps.Bind(9, Me.SourceBSE)
		      ps.Bind(10, Me.SourceConsensus)
		      ps.Bind(11, Me.IsActive)
		      ps.Bind(12, Me.ID)
		      
		      ps.SQLExecute
		    End If
		    
		    // Save contexts
		    SaveContexts db
		    
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error saving indication: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveContexts(db As MySQLCommunityServer)
		  Try
		    // Delete existing contexts
		    Var delSql As String = "DELETE FROM indication_contexts WHERE indication_id = ?"
		    Var delPs As PreparedSQLStatement = db.Prepare(delSql)
		    delPs.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    delPs.Bind(0, Me.ID)
		    delPs.SQLExecute
		    
		    // Insert new contexts
		    For Each contextID As Integer In Me.ContextIDs
		      Var insSql As String = "INSERT INTO indication_contexts (indication_id, context_id) VALUES (?, ?)"
		      Var insPs As PreparedSQLStatement = db.Prepare(insSql)
		      insPs.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      insPs.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      insPs.Bind(0, Me.ID)
		      insPs.Bind(1, contextID)
		      insPs.SQLExecute
		    Next
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error saving contexts: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Comments As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ContextIDs() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ContextNames() As String
	#tag EndProperty

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
		Keywords As String
	#tag EndProperty

	#tag Property, Flags = &h0
		PrimaryCare As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryInpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SecondaryOutpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceASE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceBSE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceConsensus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceEACVI As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Title As String
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
			Name="Comments"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Keywords"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrimaryCare"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryInpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryOutpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceASE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceBSE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceConsensus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceEACVI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
