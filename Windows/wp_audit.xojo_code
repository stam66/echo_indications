#tag WebPage
Begin WebPage wp_audit
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   714
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   PanelIndex      =   0
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "Audit of all changes"
   Top             =   0
   Visible         =   True
   Width           =   1116
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin wc_WebPageHeader wc_header
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   74
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      SectionTitle    =   "Audit of changes"
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1116
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebListBox lstAudit
      AllowRowReordering=   False
      ColumnCount     =   4
      ColumnWidths    =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   566
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Timestamp	Action	User	Table"
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   ""
      PanelIndex      =   0
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   2
      SearchCriteria  =   ""
      SelectedRowColor=   &c006AB500
      SelectedRowIndex=   0
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   128
      Visible         =   True
      Width           =   1076
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  lstAudit.RemoveAllRows
		  
		  Try
		    Var sql As String = "SELECT * FROM audit ORDER BY audit_timestamp DESC LIMIT 100"
		    Var rs As RowSet = Session.DB.SelectSQL(sql)
		    
		    // Define styles for action types
		    Var darkMode As Boolean = Session.IsDarkMode
		    Var createStyle As New WebStyle
		    Var updateStyle As New WebStyle
		    Var deleteStyle As New WebStyle
		    Var defaultStyle As New WebStyle
		    
		    createStyle.ForegroundColor = Color.RGB(34, 139, 34) // Green
		    updateStyle.ForegroundColor = Color.RGB(255, 140, 0) // Orange
		    deleteStyle.ForegroundColor = Color.RGB(220, 20, 60) // Red
		    defaultStyle.ForegroundColor = If(darkMode, Color.White, Color.Black)
		    
		    While Not rs.AfterLastRow
		      // Add empty row first
		      lstAudit.AddRow()
		      Var rowIdx As Integer = lstAudit.LastAddedRowIndex
		      
		      // Read data
		      Var ts As DateTime = rs.Column("audit_timestamp").DateTimeValue
		      Var action As String = rs.Column("action").StringValue.Uppercase
		      Var username As String = rs.Column("audit_user").StringValue
		      If username = "" Then username = "(system)"
		      Var tableName As String = rs.Column("audit_table").StringValue
		      
		      // Store audit ID in RowTag for later retrieval
		      lstAudit.RowTagAt(rowIdx) = rs.Column("id").IntegerValue
		      
		      // Choose style for action column
		      Var actionStyle As WebStyle
		      Select Case action
		      Case "CREATE"
		        actionStyle = createStyle
		      Case "UPDATE"
		        actionStyle = updateStyle
		      Case "DELETE"
		        actionStyle = deleteStyle
		      Else
		        actionStyle = defaultStyle
		      End Select
		      
		      // Format timestamp
		      Var timestampText As String = ts.ToString(Locale.Current, DateTime.FormatStyles.Short, DateTime.FormatStyles.Short)
		      
		      // Apply styled text to columns
		      lstAudit.CellValueAt(rowIdx, 0) = New WebListBoxStyleRenderer(defaultStyle, timestampText)
		      lstAudit.CellValueAt(rowIdx, 1) = New WebListBoxStyleRenderer(actionStyle, action)
		      lstAudit.CellValueAt(rowIdx, 2) = New WebListBoxStyleRenderer(defaultStyle, username)
		      lstAudit.CellValueAt(rowIdx, 3) = New WebListBoxStyleRenderer(defaultStyle, tableName)
		      
		      // Store action color for this row
		      If RowActionColors = Nil Then RowActionColors = New Dictionary
		      RowActionColors.Value(rowIdx) = actionStyle.ForegroundColor
		      
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    MessageBox("Error loading audit log: " + err.Message)
		  End Try
		  
		  
		  // Update header
		  wc_header.UpdateAuthenticationStatus(session.IsAuthenticated)
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h21
		Private PreviousSelectedRow As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RowActionColors As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events lstAudit
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  #Pragma Unused column
		  
		  If row < 0 Then Return
		  
		  // Get audit ID from RowTag
		  Var auditID As Integer = lstAudit.RowTagAt(row)
		  
		  // Show detail dialog
		  Var dlg As New dlg_AuditEntry
		  dlg.auditID = auditID
		  dlg.Show
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(rows() As Integer)
		  #Pragma Unused rows
		  
		  // Restore original colors for previous row
		  If PreviousSelectedRow >= 0 And PreviousSelectedRow <= me.LastRowIndex Then
		    If RowActionColors <> Nil And RowActionColors.HasKey(PreviousSelectedRow) Then
		      Var darkMode As Boolean = Session.IsDarkMode
		      Var defaultColor As Color = If(darkMode, Color.White, Color.Black)
		      
		      // Update cells - only column 1 (action) has special color
		      For col As Integer = 0 To me.ColumnCount - 1
		        Var cellText As String = me.CellTextAt(PreviousSelectedRow, col)
		        
		        Var originalStyle As New WebStyle
		        If col = 1 Then
		          // Action column - use stored color
		          originalStyle.ForegroundColor = RowActionColors.Value(PreviousSelectedRow)
		        Else
		          // Other columns - use default
		          originalStyle.ForegroundColor = defaultColor
		        End If
		        
		        me.CellValueAt(PreviousSelectedRow, col) = New WebListBoxStyleRenderer(originalStyle, cellText)
		      Next
		    End If
		  End If
		  
		  // Apply readable colors to newly selected row
		  If me.SelectedRowIndex >= 0 Then
		    If RowActionColors <> Nil And RowActionColors.HasKey(me.SelectedRowIndex) Then
		      Var bgColor As Color = EchoIndicationsApp.NHSBlue
		      Var darkMode As Boolean = Session.IsDarkMode
		      Var defaultColor As Color = If(darkMode, Color.White, Color.Black)
		      
		      // Update cells
		      For col As Integer = 0 To me.ColumnCount - 1
		        Var cellText As String = me.CellTextAt(me.SelectedRowIndex, col)
		        
		        Var readableStyle As New WebStyle
		        If col = 1 Then
		          // Action column - adjust stored color for readability
		          Var originalColor As Color = RowActionColors.Value(me.SelectedRowIndex)
		          readableStyle.ForegroundColor = EchoIndicationsApp.GetReadableColorForBackground(originalColor, bgColor)
		        Else
		          // Other columns - adjust default color
		          readableStyle.ForegroundColor = EchoIndicationsApp.GetReadableColorForBackground(defaultColor, bgColor)
		        End If
		        
		        me.CellValueAt(me.SelectedRowIndex, col) = New WebListBoxStyleRenderer(readableStyle, cellText)
		      Next
		    End If
		  End If
		  
		  // Store current selection
		  PreviousSelectedRow = me.SelectedRowIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
