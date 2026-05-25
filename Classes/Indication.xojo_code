#tag Class
Protected Class Indication
	#tag Method, Flags = &h0
		Function Delete(db As MySQLCommunityServer) As Boolean
		  Try
		    // Hard delete
		    Var sql As String = "DELETE FROM indications WHERE id = ?"
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
		Function DeleteWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  If Self.ID = 0 Then Return False
		  
		  // Get current data before deletion
		  Var oldData As Dictionary = Self.GetFieldValues
		  
		  // Perform the actual delete
		  If Not Self.Delete(db) Then Return False
		  
		  // Log to audit
		  Call AuditTracker.LogDelete(db, "indications", Self.ID, username, oldData)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAll(db As MySQLCommunityServer) As Indication()
		  Var results() As Indication
		  
		  Try
		    Var sql As String = "SELECT * FROM indications ORDER BY title"
		    Var rs As RowSet = db.SelectSQL(sql)
		    
		    While Not rs.AfterLastRow
		      Var ind As New Indication
		      ind.ID = rs.Column("id").IntegerValue
		      ind.Title = rs.Column("title").StringValue
		      ind.Keywords = rs.Column("keywords").StringValue
		      ind.Comments = rs.Column("comments").StringValue
		      ind.PrimaryCare = rs.Column("primary_care").StringValue
		      ind.SecondaryInpatient = rs.Column("secondary_inpatient").StringValue
		      ind.SecondaryOutpatient = rs.Column("secondary_outpatient").StringValue
		      ind.SourceASE = rs.Column("source_ase").BooleanValue
		      ind.SourceEACVI = rs.Column("source_eacvi").BooleanValue
		      ind.SourceBSE = rs.Column("source_bse").BooleanValue
		      ind.SourceBHVS = If(rs.Column("source_bhvs").Value = Nil, False, rs.Column("source_bhvs").BooleanValue)
		      ind.SourceConsensus = rs.Column("source_consensus").BooleanValue
		      ind.Urgency = If(rs.Column("urgency").Value = Nil, "", rs.Column("urgency").StringValue)

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
		      ind.Keywords = rs.Column("keywords").StringValue
		      ind.Comments = rs.Column("comments").StringValue
		      ind.PrimaryCare = rs.Column("primary_care").StringValue
		      ind.SecondaryInpatient = rs.Column("secondary_inpatient").StringValue
		      ind.SecondaryOutpatient = rs.Column("secondary_outpatient").StringValue
		      ind.SourceASE = rs.Column("source_ase").BooleanValue
		      ind.SourceEACVI = rs.Column("source_eacvi").BooleanValue
		      ind.SourceBSE = rs.Column("source_bse").BooleanValue
		      ind.SourceBHVS = If(rs.Column("source_bhvs").Value = Nil, False, rs.Column("source_bhvs").BooleanValue)
		      ind.SourceConsensus = rs.Column("source_consensus").BooleanValue
		      ind.Urgency = If(rs.Column("urgency").Value = Nil, "", rs.Column("urgency").StringValue)
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
		Function GetFieldValues() As Dictionary
		  Var data As New Dictionary
		  
		  data.Value("title") = Self.Title
		  data.Value("keywords") = If(Self.Keywords = "", "", Self.Keywords)
		  data.Value("comments") = If(Self.Comments = "", "", Self.Comments)
		  data.Value("primary_care") = Self.PrimaryCare
		  data.Value("secondary_inpatient") = Self.SecondaryInpatient
		  data.Value("secondary_outpatient") = Self.SecondaryOutpatient
		  data.Value("source_ase") = If(Self.SourceASE, "1", "0")
		  data.Value("source_eacvi") = If(Self.SourceEACVI, "1", "0")
		  data.Value("source_bse") = If(Self.SourceBSE, "1", "0")
		  data.Value("source_bhvs") = If(Self.SourceBHVS, "1", "0")
		  data.Value("source_consensus") = If(Self.SourceConsensus, "1", "0")
		  data.Value("contexts") = String.FromArray(Self.ContextNames, ", ")
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadFromJSON(j As JSONItem)
		  // Populate Self from a JSONItem body. Used by POST (create) and
		  // PUT (update) endpoints. Only assigns fields that are present —
		  // a missing key leaves the existing value alone (PATCH-friendly
		  // for update; for create, missing keys keep the default zero values).
		  //
		  // The "contexts" key, if present, fully replaces ContextIDs/ContextNames.
		  If j.HasName("title") Then Self.Title = j.Value("title").StringValue
		  If j.HasName("keywords") Then Self.Keywords = j.Value("keywords").StringValue
		  If j.HasName("comments") Then Self.Comments = j.Value("comments").StringValue
		  If j.HasName("primary_care") Then Self.PrimaryCare = j.Value("primary_care").StringValue
		  If j.HasName("secondary_inpatient") Then Self.SecondaryInpatient = j.Value("secondary_inpatient").StringValue
		  If j.HasName("secondary_outpatient") Then Self.SecondaryOutpatient = j.Value("secondary_outpatient").StringValue
		  If j.HasName("source_ase") Then Self.SourceASE = j.Value("source_ase").BooleanValue
		  If j.HasName("source_eacvi") Then Self.SourceEACVI = j.Value("source_eacvi").BooleanValue
		  If j.HasName("source_bse") Then Self.SourceBSE = j.Value("source_bse").BooleanValue
		  If j.HasName("source_bhvs") Then Self.SourceBHVS = j.Value("source_bhvs").BooleanValue
		  If j.HasName("source_consensus") Then Self.SourceConsensus = j.Value("source_consensus").BooleanValue
		  If j.HasName("urgency") Then Self.Urgency = j.Value("urgency").StringValue

		  If j.HasName("contexts") Then
		    Var ctxArr As JSONItem = j.Value("contexts")
		    Self.ContextIDs.ResizeTo(-1)
		    Self.ContextNames.ResizeTo(-1)
		    For i As Integer = 0 To ctxArr.Count - 1
		      Var c As JSONItem = ctxArr.Child(i)
		      If c.HasName("id") Then
		        Self.ContextIDs.Add c.Value("id").IntegerValue
		        Self.ContextNames.Add If(c.HasName("name"), c.Value("name").StringValue, "")
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSONItem() As JSONItem
		  // JSON-shaped projection of an Indication. Uses JSONItem directly
		  // rather than Dictionary so that nested arrays of objects (contexts)
		  // serialise cleanly — Xojo's typed-array rules don't play nicely
		  // with Variant-of-Dictionary-array round-tripping.
		  Var j As New JSONItem
		  j.Value("id") = Self.ID
		  j.Value("title") = Self.Title
		  j.Value("keywords") = Self.Keywords
		  j.Value("comments") = Self.Comments
		  // Nullable enum columns: "" sentinel becomes JSON null.
		  If Self.PrimaryCare = "" Then j.Value("primary_care") = Nil Else j.Value("primary_care") = Self.PrimaryCare
		  If Self.SecondaryInpatient = "" Then j.Value("secondary_inpatient") = Nil Else j.Value("secondary_inpatient") = Self.SecondaryInpatient
		  If Self.SecondaryOutpatient = "" Then j.Value("secondary_outpatient") = Nil Else j.Value("secondary_outpatient") = Self.SecondaryOutpatient
		  j.Value("source_ase") = Self.SourceASE
		  j.Value("source_eacvi") = Self.SourceEACVI
		  j.Value("source_bse") = Self.SourceBSE
		  j.Value("source_bhvs") = Self.SourceBHVS
		  j.Value("source_consensus") = Self.SourceConsensus
		  If Self.Urgency = "" Then j.Value("urgency") = Nil Else j.Value("urgency") = Self.Urgency

		  Var contexts As New JSONItem
		  contexts.Load("[]")
		  For i As Integer = 0 To Self.ContextIDs.LastIndex
		    Var c As New JSONItem
		    c.Value("id") = Self.ContextIDs(i)
		    c.Value("name") = Self.ContextNames(i)
		    contexts.Add(c)
		  Next
		  j.Value("contexts") = contexts

		  Return j
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
		      Var sql As String = "INSERT INTO indications (title, keywords, comments, " + _
		      "primary_care, secondary_inpatient, secondary_outpatient, " + _
		      "source_ase, source_eacvi, source_bse, source_bhvs, source_consensus, urgency) " + _
		      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		      
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      // BindType for nullable enum columns (3,4,5,11) is set conditionally below.
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_TINY)

		      ps.Bind(0, Me.Title)
		      ps.Bind(1, Me.Keywords)
		      ps.Bind(2, Me.Comments)
		      // Enum columns are nullable. BindType must be MYSQL_TYPE_NULL when
		      // binding Nil — otherwise MYSQL_TYPE_STRING coerces Nil back to ""
		      // and the row silently fails to insert under non-strict sql_mode.
		      If Me.PrimaryCare = "" Then
		        ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(3, Nil)
		      Else
		        ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(3, Me.PrimaryCare)
		      End If
		      If Me.SecondaryInpatient = "" Then
		        ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(4, Nil)
		      Else
		        ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(4, Me.SecondaryInpatient)
		      End If
		      If Me.SecondaryOutpatient = "" Then
		        ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(5, Nil)
		      Else
		        ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(5, Me.SecondaryOutpatient)
		      End If
		      ps.Bind(6, Me.SourceASE)
		      ps.Bind(7, Me.SourceEACVI)
		      ps.Bind(8, Me.SourceBSE)
		      ps.Bind(9, Me.SourceBHVS)
		      ps.Bind(10, Me.SourceConsensus)
		      If Me.Urgency = "" Then
		        ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(11, Nil)
		      Else
		        ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(11, Me.Urgency)
		      End If

		      ps.SQLExecute
		      Me.ID = db.LastInsertedRowID
		      
		    Else
		      // Update
		      Var sql As String = "UPDATE indications SET title=?, keywords=?, comments=?, " + _
		      "primary_care=?, secondary_inpatient=?, secondary_outpatient=?, " + _
		      "source_ase=?, source_eacvi=?, source_bse=?, source_bhvs=?, source_consensus=?, urgency=? " + _
		      "WHERE id=?"
		      
		      Var ps As PreparedSQLStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      // BindType for nullable enum columns (3,4,5,11) is set conditionally below.
		      ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_TINY)
		      ps.BindType(12, MySQLPreparedStatement.MYSQL_TYPE_LONG)

		      ps.Bind(0, Me.Title)
		      ps.Bind(1, Me.Keywords)
		      ps.Bind(2, Me.Comments)
		      // Enum columns are nullable — see INSERT branch above for rationale.
		      If Me.PrimaryCare = "" Then
		        ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(3, Nil)
		      Else
		        ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(3, Me.PrimaryCare)
		      End If
		      If Me.SecondaryInpatient = "" Then
		        ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(4, Nil)
		      Else
		        ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(4, Me.SecondaryInpatient)
		      End If
		      If Me.SecondaryOutpatient = "" Then
		        ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(5, Nil)
		      Else
		        ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(5, Me.SecondaryOutpatient)
		      End If
		      ps.Bind(6, Me.SourceASE)
		      ps.Bind(7, Me.SourceEACVI)
		      ps.Bind(8, Me.SourceBSE)
		      ps.Bind(9, Me.SourceBHVS)
		      ps.Bind(10, Me.SourceConsensus)
		      If Me.Urgency = "" Then
		        ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		        ps.Bind(11, Nil)
		      Else
		        ps.BindType(11, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(11, Me.Urgency)
		      End If
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

	#tag Method, Flags = &h0
		Function SaveWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  // Store old data if updating
		  Var oldData As Dictionary
		  Var isNew As Boolean = (Self.ID = 0)
		  
		  If Not isNew Then
		    // Load current state for comparison
		    Var existing As Indication = Indication.GetByID(db, Self.ID)
		    If existing <> Nil Then
		      oldData = existing.GetFieldValues
		    End If
		  End If
		  
		  // Perform the actual save
		  If Not Self.Save(db) Then Return False
		  
		  // Build new data dictionary
		  Var newData As Dictionary = Self.GetFieldValues
		  
		  // Log to audit
		  If isNew Then
		    Call AuditTracker.LogCreate(db, "indications", Self.ID, username, newData)
		  Else
		    Call AuditTracker.LogUpdate(db, "indications", Self.ID, username, oldData, newData)
		  End If
		  
		  Return True
		End Function
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
		ID As Integer
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
		SourceBHVS As Boolean
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

	#tag Property, Flags = &h0
		Urgency As String
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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Keywords"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrimaryCare"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryInpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondaryOutpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Urgency"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
