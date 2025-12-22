#tag WebPage
Begin WebPage wp_issues
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
   Title           =   "Issues - Changes"
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
      SectionTitle    =   "Issues / Change requests"
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
   Begin WebListBox lstIssues
      AllowRowReordering=   False
      ColumnCount     =   4
      ColumnWidths    =   "45%,20%,15%,20%"
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   485
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Change request/Issue	Requestor	Status	Date submitted"
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
      Top             =   209
      Visible         =   True
      Width           =   1076
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblFoundCount
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   "Found count"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   172
      Underline       =   False
      Visible         =   True
      Width           =   244
      _mPanelIndex    =   -1
   End
   Begin WebSearchField txtSearch
      Columns         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      ErrorMessage    =   "Something went wrong with the search."
      Height          =   38
      Hint            =   "Search"
      HintPrefix      =   "Search"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ShowAllRowsByDefault=   "True"
      TabIndex        =   4
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   98
      Visible         =   True
      Width           =   464
      _mPanelIndex    =   -1
   End
   Begin WebSegmentedButton segStatusSelector
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      LastSegmentIndex=   0
      Left            =   536
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   0
      SegmentCount    =   0
      Segments        =   "All Open\n\nTrue\rNew\n\nFalse\rIn Progress\n\nFalse\rClosed\n\nFalse\rAll\n\nFalse"
      SelectedSegmentIndex=   0
      SelectionStyle  =   1
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   98
      Visible         =   True
      Width           =   560
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  segStatusSelector.SelectedSegmentIndex = 0  // Default to "All open"
		  LoadIssues("All open")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  lstIssues.Enabled = Session.IsAuthenticated Or True  // Allow viewing by all 
		  
		  
		  // Update header
		  wc_header.UpdateAuthenticationStatus(session.IsAuthenticated)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub FillListRow(rs As RowSet)
		  Var changeRequest As String = rs.Column("changes_request").StringValue
		  Var requestor As String = rs.Column("changes_requestor").StringValue
		  Var status As String = rs.Column("changes_status").StringValue
		  Var issueID As Integer = rs.Column("id").IntegerValue
		  
		  // Format date
		  Var createdAt As String
		  Try
		    Var dt As DateTime = rs.Column("created_at").DateTimeValue
		    createdAt = dt.ToString("yyyy-MM-dd HH:mm", Locale.Current)
		  Catch
		    createdAt = "N/A"
		  End Try
		  
		  // Truncate request if too long
		  If changeRequest.Length > 100 Then
		    changeRequest = changeRequest.Left(97) + "..."
		  End If
		  
		  lstIssues.AddRow(changeRequest, requestor, status, createdAt, issueID.ToString)
		  lstIssues.RowTagAt(lstIssues.LastAddedRowIndex) = issueID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleIssueSaved(sender As dlg_Issue, issueID As Integer)
		  #Pragma Unused sender
		  #Pragma Unused issueID
		  
		  // Reload with current filter
		  Var currentFilter As String
		  Select Case segStatusSelector.SelectedSegmentIndex
		  Case 0
		    currentFilter = "All open"
		  Case 1
		    currentFilter = "New"
		  Case 2
		    currentFilter = "In Progress"
		  Case 3
		    currentFilter = "Closed"
		  Case 4
		    currentFilter = "All"
		  Else
		    currentFilter = "All open"  // Default
		  End Select
		  
		  LoadIssues(currentFilter)
		  
		  // Update badges
		  Session.UpdateAllIssuesBadges
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadIssues(statusFilter As String)
		  lstIssues.RemoveAllRows
		  
		  Try
		    Var sql As String
		    Var ps As MySQLPreparedStatement
		    
		    If statusFilter = "All" Then
		      sql = "SELECT id, changes_request, changes_requestor, changes_status, " + _
		      "created_at FROM changes ORDER BY created_at DESC"
		      Var rs As RowSet = Session.DB.SelectSQL(sql)
		      
		      While Not rs.AfterLastRow
		        FillListRow(rs)
		        rs.MoveToNextRow
		      Wend
		      
		    ElseIf statusFilter = "All open" Then
		      sql = "SELECT id, changes_request, changes_requestor, changes_status, " + _
		      "created_at FROM changes WHERE changes_status != 'Closed' AND changes_status != 'Rejected' ORDER BY created_at DESC"
		      Var rs As RowSet = Session.DB.SelectSQL(sql)
		      
		      While Not rs.AfterLastRow
		        FillListRow(rs)
		        rs.MoveToNextRow
		      Wend
		      
		    Else
		      sql = "SELECT id, changes_request, changes_requestor, changes_status, " + _
		      "created_at FROM changes WHERE changes_status = ? ORDER BY created_at DESC"
		      ps = Session.DB.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		      ps.Bind(0, statusFilter)
		      
		      Var rs As RowSet = ps.SelectSQL
		      
		      While Not rs.AfterLastRow
		        FillListRow(rs)
		        rs.MoveToNextRow
		      Wend
		    End If
		    
		    lblFoundCount.Text = "Found: " + lstIssues.RowCount.ToString + " issues"
		    
		  Catch err As DatabaseException
		    MessageBox("Error loading issues: " + err.Message)
		    System.DebugLog("LoadIssues Error: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events lstIssues
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  #Pragma Unused column
		  
		  If row >= 0 And row <= lstIssues.LastRowIndex Then
		    Var issueID As Integer = lstIssues.RowTagAt(row)
		    
		    Var dlg As New dlg_Issue
		    dlg.IssueID = issueID
		    AddHandler dlg.IssueSaved, AddressOf HandleIssueSaved
		    Session.NavigationManager.NavigateToPage(dlg)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContextualMenuSelected(hitItem As WebMenuItem)
		  If lstIssues.SelectedRowIndex < 0 Then Return
		  
		  Var issueID As Integer = lstIssues.RowTagAt(lstIssues.SelectedRowIndex)
		  
		  Select Case hitItem.Text
		  Case "View/Edit"
		    Var dlg As New dlg_Issue
		    dlg.IssueID = issueID
		    AddHandler dlg.IssueSaved, AddressOf HandleIssueSaved
		    Session.NavigationManager.NavigateToPage(dlg)
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Var m As New WebMenuItem("actions")
		  m.AddMenuItem("View/Edit")
		  me.ContextualMenu = m
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events segStatusSelector
	#tag Event
		Sub Opening()
		  me.Style.BorderColor = app.NHSBlue
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  Var status As String
		  
		  Select Case segmentIndex
		  Case 0
		    status = "All Open"
		  Case 1
		    status = "New"
		  Case 2
		    status = "In Progress"
		  Case 3
		    status = "Closed"
		  Case 4
		    status = "All"
		  End Select
		  
		  LoadIssues(status)
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
