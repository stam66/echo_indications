#tag WebPage
Begin WebDialog dlg_ChangeIndication
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   492
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
   Position        =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   636
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebRectangle Rectangle1
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
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   636
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel lblDialogTitle
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   24.0
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
         Parent          =   "Rectangle1"
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   -1
         TabStop         =   True
         Text            =   "Request change for existing indication"
         TextAlignment   =   0
         TextColor       =   &cFAFAFA00
         Tooltip         =   ""
         Top             =   12
         Underline       =   False
         Visible         =   True
         Width           =   560
         _mPanelIndex    =   -1
      End
   End
   Begin WebTextField txtExistingContexts
      AllowAutoComplete=   False
      AllowReturnKey  =   "True"
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   271
      Visible         =   True
      Width           =   259
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblExistingIndication
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   22
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Text            =   "Existing Indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   79
      Underline       =   False
      Visible         =   True
      Width           =   132
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblExistingContexts
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   22
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
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Text            =   "Existing Contexts"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   245
      Underline       =   False
      Visible         =   True
      Width           =   132
      _mPanelIndex    =   -1
   End
   Begin WebTextArea txtNewIndication
      AllowReturnKey  =   True
      AllowSpellChecking=   True
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   128
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   357
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   109
      Visible         =   True
      Width           =   259
      _mPanelIndex    =   -1
   End
   Begin WebTextField txtNewContexts
      AllowAutoComplete=   False
      AllowReturnKey  =   "True"
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   357
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   271
      Visible         =   True
      Width           =   259
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblRevisedIndication
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   22
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   357
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   7
      TabStop         =   True
      Text            =   "Revised Indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   79
      Underline       =   False
      Visible         =   True
      Width           =   132
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblRevisedContexts
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   22
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   357
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
      TabIndex        =   8
      TabStop         =   True
      Text            =   "Revised Contexts"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   245
      Underline       =   False
      Visible         =   True
      Width           =   132
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
      Left            =   347
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   9
      TabStop         =   True
      Tooltip         =   ""
      Top             =   434
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton btnSubmit
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Submit request"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   455
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   10
      TabStop         =   True
      Tooltip         =   ""
      Top             =   434
      Visible         =   True
      Width           =   161
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblID
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
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   11
      TabStop         =   True
      Text            =   "ID"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   434
      Underline       =   False
      Visible         =   True
      Width           =   37
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblPrimaryKey
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   43
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   12
      TabStop         =   True
      Text            =   "Primary Key "
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   434
      Underline       =   False
      Visible         =   True
      Width           =   214
      _mPanelIndex    =   -1
   End
   Begin WebTextArea txtExistingIndication
      AllowReturnKey  =   True
      AllowSpellChecking=   True
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   128
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   13
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   109
      Visible         =   True
      Width           =   259
      _mPanelIndex    =   -1
   End
   Begin WebTextField txtRequestor
      AllowAutoComplete=   False
      AllowReturnKey  =   "True"
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   "Enter name and/or email"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Mandatory       =   "False"
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   14
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   367
      Visible         =   True
      Width           =   596
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblReqeustor
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   22
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
      Scope           =   2
      TabIndex        =   15
      TabStop         =   True
      Text            =   "Requested by"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   341
      Underline       =   False
      Visible         =   True
      Width           =   259
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  Try
		    // Load existing indication details
		    Var sql As String = "SELECT title FROM indications WHERE id = ?"
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Session.SelectedIndicationID)
		    
		    Var rs As RowSet = ps.SelectSQL
		    
		    If Not rs.AfterLastRow Then
		      txtExistingIndication.Text = rs.Column("title").StringValue
		    End If
		    
		    // Load existing contexts
		    sql = "SELECT c.name FROM contexts c " + _
		    "INNER JOIN indication_contexts ic ON c.id = ic.context_id " + _
		    "WHERE ic.indication_id = ? ORDER BY c.sort_order"
		    
		    ps = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.Bind(0, Session.SelectedIndicationID)
		    
		    rs = ps.SelectSQL
		    
		    Var contextNames() As String
		    While Not rs.AfterLastRow
		      contextNames.Add(rs.Column("name").StringValue)
		      rs.MoveToNextRow
		    Wend
		    
		    txtExistingContexts.Text = String.FromArray(contextNames, ", ")
		    
		    lblPrimaryKey.Text = "Indication ID: " + Session.SelectedIndicationID.ToString
		    
		  Catch err As DatabaseException
		    MessageBox("Error loading indication: " + err.Message)
		    System.DebugLog("LoadIndication Error: " + err.Message)
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  // Pre-populate requestor if authenticated
		  If Session.IsAuthenticated Then
		    txtRequestor.Text = Session.CurrentUsername
		    txtRequestor.ReadOnly = True
		  Else
		    txtRequestor.Text = ""
		    txtRequestor.ReadOnly = False
		    btnSubmit.Enabled = False  // Disable until name is entered
		  End If
		  
		  If Session.SelectedIndicationID > 0 Then
		    Try
		      // Load existing indication details
		      Var sql As String = "SELECT title FROM indications WHERE id = ?"
		      Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, Session.SelectedIndicationID)
		      
		      Var rs As RowSet = ps.SelectSQL
		      
		      If Not rs.AfterLastRow Then
		        txtExistingIndication.Text = rs.Column("title").StringValue
		      End If
		      
		      // Load existing contexts
		      sql = "SELECT c.name FROM contexts c " + _
		      "INNER JOIN indication_contexts ic ON c.id = ic.context_id " + _
		      "WHERE ic.indication_id = ? ORDER BY c.sort_order"
		      
		      ps = Session.DB.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, Session.SelectedIndicationID)
		      
		      rs = ps.SelectSQL
		      
		      Var contextNames() As String
		      While Not rs.AfterLastRow
		        contextNames.Add(rs.Column("name").StringValue)
		        rs.MoveToNextRow
		      Wend
		      
		      txtExistingContexts.Text = String.FromArray(contextNames, ", ")
		      
		      lblPrimaryKey.Text = "Indication ID: " + Session.SelectedIndicationID.ToString
		      
		    Catch err As DatabaseException
		      MessageBox("Error loading indication: " + err.Message)
		      System.DebugLog("LoadIndication Error: " + err.Message)
		    End Try
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ValidateForm()
		  // For non-authenticated users, require:
		  // 1. Name/requestor
		  // 2. At least one change (indication or contexts)
		  
		  Var hasRequestor As Boolean = txtRequestor.Text.Trim <> ""
		  Var hasChange As Boolean = (txtNewIndication.Text.Trim <> "") Or (txtNewContexts.Text.Trim <> "")
		  
		  If Session.IsAuthenticated Then
		    // Authenticated users only need at least one change
		    btnSubmit.Enabled = hasChange
		  Else
		    // Non-authenticated users need both name and at least one change
		    btnSubmit.Enabled = hasRequestor And hasChange
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ButtonClicked As WebButton
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events txtNewIndication
	#tag Event
		Sub TextChanged()
		  If Not Session.IsAuthenticated Then
		    ValidateForm
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtNewContexts
	#tag Event
		Sub TextChanged()
		  If Not Session.IsAuthenticated Then
		    ValidateForm
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCancel
	#tag Event
		Sub Pressed()
		  self.close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnSubmit
	#tag Event
		Sub Pressed()
		  // Validate requestor name
		  If txtRequestor.Text.Trim = "" Then
		    MessageBox("Please enter your name")
		    txtRequestor.SetFocus
		    Return
		  End If
		  
		  // Validate at least one change
		  If txtNewIndication.Text.Trim = "" And txtNewContexts.Text.Trim = "" Then
		    MessageBox("You must enter at least one change to submit")
		    Return
		  End If
		  
		  Try
		    Var sql As String = "INSERT INTO changes (changes_request, changes_requestor, changes_status, " + _
		    "indication_existing, indication_new, contexts_existing, contexts_new, Indication_id) " + _
		    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
		    
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    
		    // IMPROVED: More descriptive request text with indication ID
		    Var requestText As String = "Change request for indication ID " + Session.SelectedIndicationID.ToString + ": " + txtExistingIndication.Text.Left(50)
		    
		    ps.Bind(0, requestText)
		    ps.Bind(1, txtRequestor.Text.Trim)
		    ps.Bind(2, "New")  // CHANGED FROM "Open" TO "New"
		    ps.Bind(3, txtExistingIndication.Text)
		    ps.Bind(4, txtNewIndication.Text)
		    ps.Bind(5, txtExistingContexts.Text)
		    ps.Bind(6, txtNewContexts.Text)
		    ps.Bind(7, Session.SelectedIndicationID)
		    
		    ps.ExecuteSQL
		    
		    MessageBox("Change request submitted successfully")
		    
		    // Update badge if on landing page
		    If wp_LandingPage <> Nil Then
		      wp_LandingPage.wc_menu.UpdateIssuesBadge
		    End If
		    
		    Self.Close
		    
		  Catch err As DatabaseException
		    MessageBox("Error submitting change request: " + err.Message)
		    System.DebugLog("SubmitIndicationChange Error: " + err.Message)
		  End Try
		  
		  ' // Validate requestor name
		  ' If txtRequestor.Text.Trim = "" Then
		  ' MessageBox("Please enter your name")
		  ' txtRequestor.SetFocus
		  ' Return
		  ' End If
		  ' 
		  ' // Validate at least one change
		  ' If txtNewIndication.Text.Trim = "" And txtNewContexts.Text.Trim = "" Then
		  ' MessageBox("You must enter at least one change to submit")
		  ' Return
		  ' End If
		  ' 
		  ' Try
		  ' Var sql As String = "INSERT INTO changes (changes_request, changes_requestor, changes_status, " + _
		  ' "indication_existing, indication_new, contexts_existing, contexts_new, Indication_id) " + _
		  ' "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
		  ' 
		  ' Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		  ' 
		  ' ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(6, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.BindType(7, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ' 
		  ' Var requestText As String = "Change request for indication: " + txtExistingIndication.Text.Left(50)
		  ' 
		  ' ps.Bind(0, requestText)
		  ' ps.Bind(1, txtRequestor.Text.Trim)
		  ' ps.Bind(2, "Open")
		  ' ps.Bind(3, txtExistingIndication.Text)
		  ' ps.Bind(4, txtNewIndication.Text)
		  ' ps.Bind(5, txtExistingContexts.Text)
		  ' ps.Bind(6, txtNewContexts.Text)
		  ' ps.Bind(7, Session.SelectedIndicationID)
		  ' 
		  ' ps.ExecuteSQL
		  ' 
		  ' MessageBox("Change request submitted successfully")
		  ' 
		  ' // Update badge if on landing page
		  ' If wp_LandingPage <> Nil Then
		  ' wp_LandingPage.wc_menu.UpdateIssuesBadge
		  ' End If
		  ' 
		  ' Self.Close
		  ' 
		  ' Catch err As DatabaseException
		  ' MessageBox("Error submitting change request: " + err.Message)
		  ' System.DebugLog("SubmitIndicationChange Error: " + err.Message)
		  ' End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtRequestor
	#tag Event
		Sub TextChanged()
		  If Not Session.IsAuthenticated Then
		    ValidateForm
		  End If
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
#tag EndViewBehavior
