#tag WebPage
Begin WebDialog dlg_Issue
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   702
   Index           =   -2147483648
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   PanelIndex      =   0
   Position        =   1
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   1054
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebRectangle Rectangle2
      BorderColor     =   &c000000FF
      BorderThickness =   0
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   0
      CSSClasses      =   ""
      Enabled         =   True
      FillColor       =   &c006AB500
      HasFillColor    =   True
      Height          =   62
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
      Scope           =   0
      TabIndex        =   24
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1054
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel lblDialogTitle
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   22.0
         Height          =   38
         Index           =   -2147483648
         Indicator       =   0
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
         Parent          =   "Rectangle2"
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Change request / Issue Details"
         TextAlignment   =   0
         TextColor       =   &cFFFFFF00
         Tooltip         =   ""
         Top             =   12
         Underline       =   False
         Visible         =   True
         Width           =   433
         _mPanelIndex    =   -1
      End
   End
   Begin WebButton btnSave
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Save"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   934
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   21
      TabStop         =   True
      Tooltip         =   ""
      Top             =   644
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton btnCancel
      AllowAutoDisable=   False
      Cancel          =   True
      Caption         =   "Cancel"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   826
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   22
      TabStop         =   True
      Tooltip         =   ""
      Top             =   644
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebTextArea txtRequest
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      Height          =   93
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   26
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   209
      Visible         =   True
      Width           =   1014
      _mPanelIndex    =   -1
   End
   Begin webTextArea txtIndicationExisting
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      Height          =   128
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   27
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   402
      Visible         =   True
      Width           =   498
      _mPanelIndex    =   -1
   End
   Begin webTextArea txtIndicationNew
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      Height          =   128
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   545
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   28
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   402
      Visible         =   True
      Width           =   489
      _mPanelIndex    =   -1
   End
   Begin webTextField txtContextsExisting
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   29
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   570
      Visible         =   True
      Width           =   498
      _mPanelIndex    =   -1
   End
   Begin webTextField txtContextsNew
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   545
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   30
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   570
      Visible         =   True
      Width           =   489
      _mPanelIndex    =   -1
   End
   Begin WebTextField txtRequestor
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      Caption         =   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   41
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   307
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   1
      TabIndex        =   31
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   104
      Visible         =   True
      Width           =   262
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popStatus
      AutoPopulate    =   "False"
      AutoPopulateColumn=   ""
      AutoPopulateTable=   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Open\nIn progress\nClosed\nRejected"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   84
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   1
      SelectedRowIndex=   -1
      SelectedRowText =   ""
      TabIndex        =   32
      Table           =   ""
      TabStop         =   True
      Tooltip         =   ""
      Top             =   99
      Visible         =   True
      Width           =   156
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblStatus
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   33
      TabStop         =   True
      Text            =   "Status"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   102
      Underline       =   False
      Visible         =   True
      Width           =   64
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblRequestor
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   254
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   34
      TabStop         =   True
      Text            =   "User"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   102
      Underline       =   False
      Visible         =   True
      Width           =   52
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblChangeRequest
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   35
      TabStop         =   True
      Text            =   "Issue / Change request"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   177
      Underline       =   False
      Visible         =   True
      Width           =   353
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblIndicationExisting
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   True
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   36
      TabStop         =   True
      Text            =   "Existing Indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   366
      Underline       =   False
      Visible         =   True
      Width           =   353
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblContextsExisting
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   True
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   37
      TabStop         =   True
      Text            =   "Existing Contexts"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   534
      Underline       =   False
      Visible         =   True
      Width           =   353
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblIndicationNew
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   True
      Left            =   545
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   38
      TabStop         =   True
      Text            =   "Proposal for modified indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   361
      Underline       =   False
      Visible         =   True
      Width           =   353
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblContextsNew
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   True
      Left            =   545
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   39
      TabStop         =   True
      Text            =   "Proposal for modified Contexts"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   529
      Underline       =   False
      Visible         =   True
      Width           =   353
      _mPanelIndex    =   -1
   End
   Begin WebCombobox popReasonForClose
      AutoPopulate    =   "False"
      AutoPopulateColumn=   ""
      AutoPopulateTable=   ""
      Column          =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DisplayName     =   ""
      Enabled         =   True
      FilteringMode   =   1
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Resolved\nNot needed\nDuplicate\nCannot reproduce\nOther"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   804
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Mandatory       =   "False"
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   -1
      SelectedRowText =   ""
      TabIndex        =   41
      Table           =   ""
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   104
      Visible         =   True
      Width           =   224
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblReasonForClose
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   659
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   42
      TabStop         =   True
      Text            =   "Reason for Close"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   104
      Underline       =   False
      Visible         =   True
      Width           =   137
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblIndicationChange
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   43
      TabStop         =   True
      Text            =   "Amendment request for specific indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   332
      Underline       =   False
      Visible         =   True
      Width           =   378
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  btnSave.Enabled = Session.IsAuthenticated
		  
		  If IssueID > 0 Then
		    LoadIssue
		  Else
		    MessageBox("No issue specified")
		    Self.Close
		  End If
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LoadIssue()
		  Try
		    Var sql As String = "SELECT * FROM changes WHERE id = ?"
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, IssueID)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    If Not rs.AfterLastRow Then
		      // Load basic info
		      txtRequest.Text = rs.Column("changes_request").StringValue
		      txtRequestor.Text = rs.Column("changes_requestor").StringValue
		      
		      // Set status
		      Var status As String = rs.Column("changes_status").StringValue
		      Select Case status
		      Case "Open"
		        popStatus.SelectedRowIndex = 0
		      Case "In Progress"
		        popStatus.SelectedRowIndex = 1
		      Case "Closed"
		        popStatus.SelectedRowIndex = 2
		      Case "Rejected"
		        popStatus.SelectedRowIndex = 3
		      Else
		        popStatus.SelectedRowIndex = 0
		      End Select
		      
		      // Load indication change details if they exist
		      If  rs.Column("indication_existing").value <> nil Then
		        txtIndicationExisting.Text = rs.Column("indication_existing").StringValue
		      Else
		        txtIndicationExisting.Text = ""
		      End If
		      
		      If  rs.Column("indication_new").value <>  nil Then
		        txtIndicationNew.Text = rs.Column("indication_new").StringValue
		      Else
		        txtIndicationNew.Text = ""
		      End If
		      
		      If  rs.Column("contexts_existing").value <> nil Then
		        txtContextsExisting.Text = rs.Column("contexts_existing").StringValue
		      Else
		        txtContextsExisting.Text = ""
		      End If
		      
		      If  rs.Column("contexts_new").value <> nil Then
		        txtContextsNew.Text = rs.Column("contexts_new").StringValue
		      Else
		        txtContextsNew.Text = ""
		      End If
		      
		      // Load reason for close and select in popup
		      If  rs.Column("reason_for_close").value <> nil Then
		        Var reason As String = rs.Column("reason_for_close").StringValue
		        If reason <> "" Then
		          // Try to select the matching row
		          For i As Integer = 0 To popReasonForClose.LastRowIndex
		            If popReasonForClose.RowTextAt(i) = reason Then
		              popReasonForClose.SelectedRowIndex = i
		              Exit For i
		            End If
		          Next
		        Else
		          popReasonForClose.SelectedRowIndex = -1
		        End If
		      Else
		        popReasonForClose.SelectedRowIndex = -1
		      End If
		    Else
		      MessageBox("Issue not found")
		      Self.Close
		    End If
		    
		  Catch err As DatabaseException
		    MessageBox("Error loading issue: " + err.Message)
		    System.DebugLog("LoadIssue Error: " + err.Message)
		    Self.Close
		  End Try
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event IssueSaved(issueID As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private ButtonClicked As WebButton
	#tag EndProperty

	#tag Property, Flags = &h0
		IssueID As Integer = 0
	#tag EndProperty


#tag EndWindowCode

#tag Events btnSave
	#tag Event
		Sub Pressed()
		  If Not Session.IsAuthenticated Then
		    MessageBox("You must be authenticated to save changes")
		    Return
		  End If
		  
		  Try
		    Var status As String
		    Select Case popStatus.SelectedRowIndex
		    Case 0
		      status = "Open"
		    Case 1
		      status = "In Progress"
		    Case 2
		      status = "Closed"
		    Case 3
		      status = "Rejected"
		    Else
		      status = "Open"
		    End Select
		    
		    // Get reason for close from popup (if selected)
		    Var reasonForClose As String = ""
		    If popReasonForClose.SelectedRowIndex >= 0 Then
		      reasonForClose = popReasonForClose.SelectedRowText
		    End If
		    
		    Var sql As String = "UPDATE changes SET changes_status = ?, reason_for_close = ? WHERE id = ?"
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    
		    ps.Bind(0, status)
		    ps.Bind(1, reasonForClose)
		    ps.Bind(2, IssueID)
		    
		    ps.ExecuteSQL
		    
		    MessageBox("Issue updated successfully")
		    RaiseEvent IssueSaved(IssueID)
		    Self.Close
		    
		  Catch err As DatabaseException
		    MessageBox("Error saving issue: " + err.Message)
		    System.DebugLog("SaveIssue Error: " + err.Message)
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCancel
	#tag Event
		Sub Pressed()
		  self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popStatus
	#tag Event
		Sub Opening()
		  me.addrow ("New")
		  me.addrow("In progress")
		  me.addrow("Closed")
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
		Name="Index"
		Visible=false
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
		Name="Position"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="WebDialog.Positions"
		EditorType="Enum"
		#tag EnumValues
			"0 - Top"
			"1 - Center"
		#tag EndEnumValues
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Name="IssueID"
		Visible=false
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
