#tag DesktopWindow
Begin DesktopContainer IssuesContainer
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   600
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   False
   Visible         =   True
   Width           =   1100
   Begin DesktopSearchField txtSearch
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      Enabled         =   True
      Height          =   26
      Hint            =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Visible         =   True
      Width           =   552
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel lblSearchInfo
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   10.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   True
      Left            =   24
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Separate search terms with a comma"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   45
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   213
   End
   Begin DesktopLabel lblFoundCount
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Found Count"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   198
   End
   Begin DesktopListBox listIssues
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   4
      ColumnWidths    =   "55%, 15%, 15%, 15%"
      DefaultRowHeight=   30
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   430
      Index           =   -2147483648
      InitialValue    =   "Change request/Issue	Requestor	Status	Date submitted"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   150
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   1060
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   BeginDesktopSegmentedButton DesktopSegmentedButton segFilterIssues
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      Left            =   584
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      Segments        =   "All Open\n\nTrue\rNew\n\nFalse\rIn Progress\n\nFalse\rClosed\n\nFalse\rAll\n\nFalse"
      SelectionStyle  =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   22
      Transparent     =   False
      Visible         =   True
      Width           =   496
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  ' Subscribe to PubSub events
		  PubSub.Subscribe("ISSUE_CREATED", AddressOf HandleIssueChanged, Self)
		  PubSub.Subscribe("ISSUE_UPDATED", AddressOf HandleIssueChanged, Self)
		  PubSub.Subscribe("DATA_REFRESH", AddressOf HandleDataRefresh, Self)

		  ' Load initial data with "All Open" filter
		  LoadIssues("All Open")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Closing()
		  ' Unsubscribe from PubSub events
		  PubSub.Unsubscribe("ISSUE_CREATED", AddressOf HandleIssueChanged, Self)
		  PubSub.Unsubscribe("ISSUE_UPDATED", AddressOf HandleIssueChanged, Self)
		  PubSub.Unsubscribe("DATA_REFRESH", AddressOf HandleDataRefresh, Self)
		End Sub
	#tag EndEvent

	#tag Method, Flags = &h0
		Sub LoadIssues(filter As String)
		  ' Load issues based on filter selection
		  listIssues.RemoveAllRows

		  Var issues() As ChangeRequest

		  Select Case filter
		  Case "All Open"
		    issues = ChangeRequest.GetOpen
		  Case "New"
		    issues = ChangeRequest.GetByStatus("New")
		  Case "In Progress"
		    issues = ChangeRequest.GetByStatus("In Progress")
		  Case "Closed"
		    issues = ChangeRequest.GetByStatus("Closed")
		  Case "Rejected"
		    issues = ChangeRequest.GetByStatus("Rejected")
		  Case "All"
		    issues = ChangeRequest.GetAll
		  Else
		    issues = ChangeRequest.GetOpen
		  End Select

		  ' Apply search filter if set
		  Var searchText As String = txtSearch.Text.Trim.Lowercase

		  For Each issue As ChangeRequest In issues
		    ' Skip if doesn't match search
		    If searchText.Length > 0 Then
		      If issue.Description.Lowercase.IndexOf(searchText) < 0 And _
		        issue.ReporterName.Lowercase.IndexOf(searchText) < 0 Then
		        Continue
		      End If
		    End If

		    ' Add row to list
		    listIssues.AddRow(issue.GetShortDescription, issue.ReporterName, issue.Status, issue.CreatedAtString)
		    listIssues.RowTagAt(listIssues.LastAddedRowIndex) = issue.ID
		  Next

		  ' Update count label
		  lblFoundCount.Text = listIssues.RowCount.ToString + " issue(s) found"

		  ' Store current filter
		  mCurrentFilter = filter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleIssueChanged(data As Variant)
		  #Pragma Unused data
		  ' Reload with current filter when an issue is created/updated
		  LoadIssues(mCurrentFilter)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDataRefresh(data As Variant)
		  #Pragma Unused data
		  ' Reload with current filter on general data refresh
		  LoadIssues(mCurrentFilter)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCurrentFilter() As String
		  Select Case segFilterIssues.SelectedSegmentIndex
		  Case 0
		    Return "All Open"
		  Case 1
		    Return "New"
		  Case 2
		    Return "In Progress"
		  Case 3
		    Return "Closed"
		  Case 4
		    Return "All"
		  Else
		    Return "All Open"
		  End Select
		End Function
	#tag EndMethod

	#tag Property, Flags = &h21
		Private mCurrentFilter As String = "All Open"
	#tag EndProperty

	#tag Constant, Name = kSectionTitle, Type = String, Dynamic = False, Default = \"Change requests / Issues", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  ' Reload with current filter when search text changes
		  LoadIssues(GetCurrentFilter)
		End Sub
	#tag EndEvent
#tag EndEvents

#tag Events listIssues
	#tag Event
		Sub DoublePressed()
		  Var row As Integer = listIssues.SelectedRowIndex
		  If row < 0 Then Return

		  Var issueID As Integer = listIssues.RowTagAt(row).IntegerValue

		  ' Open issue detail dialog
		  Var dlg As New dlg_Issue
		  dlg.IssueID = issueID
		  dlg.ShowModal
		End Sub
	#tag EndEvent
#tag EndEvents

#tag Events segFilterIssues
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  Select Case segmentIndex
		  Case 0
		    LoadIssues("All Open")
		  Case 1
		    LoadIssues("New")
		  Case 2
		    LoadIssues("In Progress")
		  Case 3
		    LoadIssues("Closed")
		  Case 4
		    LoadIssues("All")
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents

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
		Name="Super"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
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
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
