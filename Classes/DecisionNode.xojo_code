#tag Class
Protected Class DecisionNode
	#tag Method, Flags = &h0
		Shared Function GetRoots(db As MySQLCommunityServer) As DecisionNode()
		  // Top-level options the user starts from (parent_id IS NULL).
		  Var results() As DecisionNode
		  Try
		    Var sql As String = "SELECT * FROM decision_nodes WHERE parent_id IS NULL ORDER BY sort_order, option_label"
		    Var rs As RowSet = db.SelectSQL(sql)
		    While Not rs.AfterLastRow
		      results.Add(NodeFromRow(rs))
		      rs.MoveToNextRow
		    Wend
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.GetRoots: " + err.Message)
		  End Try
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetChildren(db As MySQLCommunityServer, parentID As Integer) As DecisionNode()
		  Var results() As DecisionNode
		  Try
		    Var sql As String = "SELECT * FROM decision_nodes WHERE parent_id = ? ORDER BY sort_order, option_label"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, parentID)
		    Var rs As RowSet = ps.SelectSQL
		    While Not rs.AfterLastRow
		      results.Add(NodeFromRow(rs))
		      rs.MoveToNextRow
		    Wend
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.GetChildren: " + err.Message)
		  End Try
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetByID(db As MySQLCommunityServer, id As Integer) As DecisionNode
		  Try
		    Var sql As String = "SELECT * FROM decision_nodes WHERE id = ?"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, id)
		    Var rs As RowSet = ps.SelectSQL
		    If Not rs.AfterLastRow Then Return NodeFromRow(rs)
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.GetByID: " + err.Message)
		  End Try
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NodeFromRow(rs As RowSet) As DecisionNode
		  Var n As New DecisionNode
		  n.ID = rs.Column("id").IntegerValue
		  n.ParentID = If(rs.Column("parent_id").Value = Nil, 0, rs.Column("parent_id").IntegerValue)
		  n.OptionLabel = rs.Column("option_label").StringValue
		  n.Prompt = If(rs.Column("prompt").Value = Nil, "", rs.Column("prompt").StringValue)
		  n.SortOrder = rs.Column("sort_order").IntegerValue
		  n.VerdictPrimary = If(rs.Column("verdict_primary").Value = Nil, "", rs.Column("verdict_primary").StringValue)
		  n.VerdictSecondaryInpatient = If(rs.Column("verdict_secondary_inpatient").Value = Nil, "", rs.Column("verdict_secondary_inpatient").StringValue)
		  n.VerdictSecondaryOutpatient = If(rs.Column("verdict_secondary_outpatient").Value = Nil, "", rs.Column("verdict_secondary_outpatient").StringValue)
		  n.Urgency = If(rs.Column("urgency").Value = Nil, "", rs.Column("urgency").StringValue)
		  n.Rationale = If(rs.Column("rationale").Value = Nil, "", rs.Column("rationale").StringValue)
		  n.IndicationID = If(rs.Column("indication_id").Value = Nil, 0, rs.Column("indication_id").IntegerValue)
		  Return n
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTerminal() As Boolean
		  // A node is terminal if it carries any custom verdict (any of the three
		  // settings) or is linked to an indication.
		  Return VerdictPrimary <> "" _
		    Or VerdictSecondaryInpatient <> "" _
		    Or VerdictSecondaryOutpatient <> "" _
		    Or IndicationID > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAnyCustomVerdict() As Boolean
		  // True if at least one custom verdict is set (regardless of indication link).
		  Return VerdictPrimary <> "" _
		    Or VerdictSecondaryInpatient <> "" _
		    Or VerdictSecondaryOutpatient <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save(db As MySQLCommunityServer) As Boolean
		  // INSERT if ID = 0, otherwise UPDATE.
		  Try
		    If Me.ID = 0 Then
		      Var sql As String = "INSERT INTO decision_nodes (parent_id, option_label, prompt, " + _
		      "sort_order, verdict_primary, verdict_secondary_inpatient, verdict_secondary_outpatient, " + _
		      "urgency, rationale, indication_id) " + _
		      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      BindNodeParams(ps, False)
		      ps.ExecuteSQL
		      Me.ID = db.LastInsertedRowID
		    Else
		      Var sql As String = "UPDATE decision_nodes SET parent_id=?, option_label=?, prompt=?, " + _
		      "sort_order=?, verdict_primary=?, verdict_secondary_inpatient=?, " + _
		      "verdict_secondary_outpatient=?, urgency=?, rationale=?, indication_id=? WHERE id=?"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      BindNodeParams(ps, True)
		      ps.ExecuteSQL
		    End If
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.Save: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BindNodeParams(ps As MySQLPreparedStatement, includeID As Boolean)
		  // Binds the ten column params (and ID if updating). The MySQL driver
		  // requires BindType = MYSQL_TYPE_NULL whenever we Bind(n, Nil) — declaring
		  // a regular type and binding Nil raises "Mismatched parameter and type".
		  // We therefore interleave BindType and Bind per parameter.

		  // 0: parent_id — NULL for roots
		  If Me.ParentID > 0 Then
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Me.ParentID)
		  Else
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		    ps.Bind(0, Nil)
		  End If

		  // 1: option_label — NOT NULL
		  ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(1, Me.OptionLabel)

		  // 2: prompt — NULL when empty
		  If Me.Prompt = "" Then
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		    ps.Bind(2, Nil)
		  Else
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(2, Me.Prompt)
		  End If

		  // 3: sort_order — always set
		  ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ps.Bind(3, Me.SortOrder)

		  // 4: verdict_primary — ENUM, NULL when empty
		  BindEnumOrNull(ps, 4, Me.VerdictPrimary)

		  // 5: verdict_secondary_inpatient — ENUM, NULL when empty
		  BindEnumOrNull(ps, 5, Me.VerdictSecondaryInpatient)

		  // 6: verdict_secondary_outpatient — ENUM, NULL when empty
		  BindEnumOrNull(ps, 6, Me.VerdictSecondaryOutpatient)

		  // 7: urgency — ENUM, NULL when empty
		  BindEnumOrNull(ps, 7, Me.Urgency)

		  // 8: rationale — NULL when empty
		  If Me.Rationale = "" Then
		    ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		    ps.Bind(8, Nil)
		  Else
		    ps.BindType(8, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(8, Me.Rationale)
		  End If

		  // 9: indication_id — NULL when 0
		  If Me.IndicationID > 0 Then
		    ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(9, Me.IndicationID)
		  Else
		    ps.BindType(9, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		    ps.Bind(9, Nil)
		  End If

		  // 10: id — only for UPDATE
		  If includeID Then
		    ps.BindType(10, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(10, Me.ID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub BindEnumOrNull(ps As MySQLPreparedStatement, idx As Integer, value As String)
		  // ENUM columns reject empty string — bind NULL when value is empty.
		  If value = "" Then
		    ps.BindType(idx, MySQLPreparedStatement.MYSQL_TYPE_NULL)
		    ps.Bind(idx, Nil)
		  Else
		    ps.BindType(idx, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(idx, value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  Var isNew As Boolean = (Me.ID = 0)
		  Var oldData As Dictionary
		  If Not isNew Then
		    Var existing As DecisionNode = DecisionNode.GetByID(db, Me.ID)
		    If existing <> Nil Then oldData = existing.GetFieldValues
		  End If

		  If Not Me.Save(db) Then
		    System.DebugLog("DecisionNode.SaveWithAudit: Save returned False for id=" + Me.ID.ToString)
		    Return False
		  End If

		  Var newData As Dictionary = Me.GetFieldValues
		  Try
		    If isNew Then
		      Call AuditTracker.LogCreate("decision_nodes", Me.ID, username, newData)
		    Else
		      // Defensive: if oldData ended up Nil (e.g. GetByID couldn't load the pre-save
		      // state), skip the diff-based update log and just record what we have as new
		      // values. Without this, AuditTracker.LogUpdate would NilObjectException on
		      // oldData.HasKey(...).
		      If oldData Is Nil Then
		        System.DebugLog("DecisionNode.SaveWithAudit: oldData was Nil for id=" + Me.ID.ToString + " (skipping diff)")
		        Call AuditTracker.LogCreate("decision_nodes", Me.ID, username, newData)
		      Else
		        Call AuditTracker.LogUpdate("decision_nodes", Me.ID, username, oldData, newData)
		      End If
		    End If
		  Catch err As RuntimeException
		    // Never let an audit-log failure roll back a successful save.
		    System.DebugLog("DecisionNode.SaveWithAudit: audit-log error (save succeeded): " + err.Message)
		  End Try
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Delete(db As MySQLCommunityServer) As Boolean
		  // ON DELETE CASCADE in the schema removes the subtree.
		  Try
		    Var sql As String = "DELETE FROM decision_nodes WHERE id = ?"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Me.ID)
		    ps.ExecuteSQL
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.Delete: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteWithAudit(db As MySQLCommunityServer, username As String) As Boolean
		  If Me.ID = 0 Then Return False
		  Var oldData As Dictionary = Me.GetFieldValues
		  If Not Me.Delete(db) Then Return False
		  Call AuditTracker.LogDelete("decision_nodes", Me.ID, username, oldData)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFieldValues() As Dictionary
		  // Snapshot for audit before/after diffing.
		  Var data As New Dictionary
		  data.Value("parent_id")                    = Me.ParentID.ToString
		  data.Value("option_label")                 = Me.OptionLabel
		  data.Value("prompt")                       = Me.Prompt
		  data.Value("sort_order")                   = Me.SortOrder.ToString
		  data.Value("verdict_primary")              = Me.VerdictPrimary
		  data.Value("verdict_secondary_inpatient")  = Me.VerdictSecondaryInpatient
		  data.Value("verdict_secondary_outpatient") = Me.VerdictSecondaryOutpatient
		  data.Value("urgency")                      = Me.Urgency
		  data.Value("rationale")                    = Me.Rationale
		  data.Value("indication_id")                = Me.IndicationID.ToString
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ChildCount(db As MySQLCommunityServer, parentID As Integer) As Integer
		  Try
		    Var sql As String = "SELECT COUNT(*) AS n FROM decision_nodes WHERE parent_id = ?"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, parentID)
		    Var rs As RowSet = ps.SelectSQL
		    If Not rs.AfterLastRow Then Return rs.Column("n").IntegerValue
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.ChildCount: " + err.Message)
		  End Try
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveUp(db As MySQLCommunityServer) As Boolean
		  // Swap sort_order with the immediately-prior sibling.
		  Return SwapWithSibling(db, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveDown(db As MySQLCommunityServer) As Boolean
		  Return SwapWithSibling(db, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SwapWithSibling(db As MySQLCommunityServer, goingUp As Boolean) As Boolean
		  // Find the adjacent sibling (above or below by sort_order), swap our values.
		  Try
		    Var op As String = If(goingUp, "<", ">")
		    Var dir As String = If(goingUp, "DESC", "ASC")
		    Var sql As String

		    If Me.ParentID > 0 Then
		      sql = "SELECT id, sort_order FROM decision_nodes " + _
		      "WHERE parent_id = ? AND sort_order " + op + " ? " + _
		      "ORDER BY sort_order " + dir + " LIMIT 1"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, Me.ParentID)
		      ps.Bind(1, Me.SortOrder)
		      Return PerformSwap(db, ps.SelectSQL)
		    Else
		      sql = "SELECT id, sort_order FROM decision_nodes " + _
		      "WHERE parent_id IS NULL AND sort_order " + op + " ? " + _
		      "ORDER BY sort_order " + dir + " LIMIT 1"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, Me.SortOrder)
		      Return PerformSwap(db, ps.SelectSQL)
		    End If
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.SwapWithSibling: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PerformSwap(db As MySQLCommunityServer, rs As RowSet) As Boolean
		  // Helper for SwapWithSibling — given a rowset positioned at the sibling
		  // to swap with, exchange sort_order values.
		  If rs Is Nil Or rs.AfterLastRow Then Return False
		  Var otherID As Integer = rs.Column("id").IntegerValue
		  Var otherSort As Integer = rs.Column("sort_order").IntegerValue
		  Var mySort As Integer = Me.SortOrder

		  Try
		    Var sql As String = "UPDATE decision_nodes SET sort_order = ? WHERE id = ?"
		    Var ps As MySQLPreparedStatement = db.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, otherSort)
		    ps.Bind(1, Me.ID)
		    ps.ExecuteSQL

		    Var ps2 As MySQLPreparedStatement = db.Prepare(sql)
		    ps2.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps2.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps2.Bind(0, mySort)
		    ps2.Bind(1, otherID)
		    ps2.ExecuteSQL

		    Me.SortOrder = otherSort
		    Return True
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.PerformSwap: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function NextSortOrder(db As MySQLCommunityServer, parentID As Integer) As Integer
		  // Returns MAX(sort_order)+1 amongst the children of parentID
		  // (or amongst roots if parentID = 0).
		  Try
		    Var sql As String
		    If parentID > 0 Then
		      sql = "SELECT COALESCE(MAX(sort_order), -1) AS m FROM decision_nodes WHERE parent_id = ?"
		      Var ps As MySQLPreparedStatement = db.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, parentID)
		      Var rs As RowSet = ps.SelectSQL
		      If Not rs.AfterLastRow Then Return rs.Column("m").IntegerValue + 1
		    Else
		      sql = "SELECT COALESCE(MAX(sort_order), -1) AS m FROM decision_nodes WHERE parent_id IS NULL"
		      Var rs As RowSet = db.SelectSQL(sql)
		      If Not rs.AfterLastRow Then Return rs.Column("m").IntegerValue + 1
		    End If
		  Catch err As DatabaseException
		    System.DebugLog("DecisionNode.NextSortOrder: " + err.Message)
		  End Try
		  Return 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ParentID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		OptionLabel As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Prompt As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SortOrder As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VerdictPrimary As String
	#tag EndProperty

	#tag Property, Flags = &h0
		VerdictSecondaryInpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		VerdictSecondaryOutpatient As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Urgency As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Rationale As String
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
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
			Name="ParentID"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OptionLabel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Prompt"
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
		#tag ViewProperty
			Name="VerdictPrimary"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerdictSecondaryInpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerdictSecondaryOutpatient"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Urgency"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Rationale"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndicationID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
