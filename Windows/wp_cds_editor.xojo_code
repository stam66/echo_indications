#tag WebPage
Begin WebPage wp_cds_editor
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   820
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
   Title           =   "Decision tree editor"
   Top             =   0
   Visible         =   True
   Width           =   1117
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebBreadcrumb bcTreeNavigation
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   69
      Index           =   -2147483648
      Indicator       =   ""
      InitialValue    =   "One/Two/Three"
      LastAddedIndex  =   0
      LastRowIndex    =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   2
      TabIndex        =   36
      TabStop         =   True
      Tooltip         =   ""
      Top             =   82
      Visible         =   True
      Width           =   1077
      _mPanelIndex    =   -1
   End
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
      SectionTitle    =   "Settings"
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1117
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebTextArea txtSelectedNode
      AllowAutoComplete=   "False"
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   "0"
      Height          =   95
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   887
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   9
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   279
      Visible         =   True
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblSelectedNode
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   887
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   10
      TabStop         =   True
      Text            =   "Selected node"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   238
      Underline       =   False
      Visible         =   True
      Width           =   127
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblRationale
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   887
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   12
      TabStop         =   True
      Text            =   "Rationale"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   382
      Underline       =   False
      Visible         =   True
      Width           =   119
      _mPanelIndex    =   -1
   End
   Begin WebButton btnPickIndication
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Change"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   26
      Index           =   -2147483648
      Indicator       =   0
      Left            =   209
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   16
      TabStop         =   True
      Tooltip         =   ""
      Top             =   655
      Visible         =   True
      Width           =   90
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popVerdictPrimary
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   False
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Verdict"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   359
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   17
      TabStop         =   True
      Tooltip         =   ""
      Top             =   647
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebTextArea txtRationale
      AllowReturnKey  =   True
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   82
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   887
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   19
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   428
      Visible         =   True
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblChooseFromList
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   39
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   27
      TabStop         =   True
      Text            =   "Linked indication"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   614
      Underline       =   False
      Visible         =   True
      Width           =   211
      _mPanelIndex    =   -1
   End
   Begin WebListBox lstParent
      AllowRowReordering=   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   319
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Roots"
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   ""
      PanelIndex      =   0
      Parent          =   "nil"
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   0
      SearchCriteria  =   ""
      SelectedRowColor=   &c0d6efd
      SelectedRowIndex=   0
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   187
      Visible         =   True
      Width           =   430
      _mPanelIndex    =   -1
   End
   Begin WebButton btnAddChild
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "+ child"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   2
      Left            =   359
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   0
      TabIndex        =   33
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   514
      Visible         =   True
      Width           =   91
      _mPanelIndex    =   -1
   End
   Begin WebListBox lstChild
      AllowRowReordering=   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   319
      HighlightSortedColumn=   False
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Children of root"
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   449
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   "No child branches found"
      PanelIndex      =   0
      Parent          =   "nil"
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   0
      SearchCriteria  =   ""
      SelectedRowColor=   &c0d6efd
      SelectedRowIndex=   0
      TabIndex        =   34
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   187
      Visible         =   True
      Width           =   430
      _mPanelIndex    =   -1
   End
   Begin WebButton btnAddSibling
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "+ sibling"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   2
      Left            =   260
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   0
      TabIndex        =   35
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   514
      Visible         =   True
      Width           =   91
      _mPanelIndex    =   -1
   End
   Begin WebButton btnDeleteSelected
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Delete selected"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   2
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   0
      TabIndex        =   39
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   514
      Visible         =   True
      Width           =   143
      _mPanelIndex    =   -1
   End
   Begin WebSegmentedButton segNodeKind
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   43
      Index           =   -2147483648
      Indicator       =   1
      LastSegmentIndex=   0
      Left            =   887
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   0
      SegmentCount    =   0
      Segments        =   "Branch\n\nFalse\rVerdict leaf\n\nFalse"
      SelectedSegmentIndex=   0
      SelectionStyle  =   1
      TabIndex        =   41
      TabStop         =   True
      Tooltip         =   ""
      Top             =   187
      Visible         =   True
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popVerdictSecondaryOP
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   False
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Verdict"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   539
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   43
      TabStop         =   True
      Tooltip         =   ""
      Top             =   647
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popVerdictSecondaryIP
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   False
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Verdict"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   719
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   44
      TabStop         =   True
      Tooltip         =   ""
      Top             =   647
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popUrgency
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   False
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Urgency"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   719
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   45
      TabStop         =   True
      Tooltip         =   ""
      Top             =   743
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblPrimaryCareVerdict
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   359
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   46
      TabStop         =   True
      Text            =   "Primary care"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   614
      Underline       =   False
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblSecondaryOPVerdict
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   539
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   47
      TabStop         =   True
      Text            =   "Secondary care (OP)"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   614
      Underline       =   False
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblSecondaryIPVerdict
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   719
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   48
      TabStop         =   True
      Text            =   "Secondary care (IP)"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   614
      Underline       =   False
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblUrgency
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   719
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   49
      TabStop         =   True
      Text            =   "Priority"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   710
      Underline       =   False
      Visible         =   True
      Width           =   172
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblSelectedIndicationID
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   39
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   50
      TabStop         =   True
      Text            =   "ID: 273"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   647
      Underline       =   False
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblSelectedIndication
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   71
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   359
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   51
      TabStop         =   True
      Text            =   "Indication text shows here."
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   710
      Underline       =   False
      Visible         =   True
      Width           =   331
      _mPanelIndex    =   -1
   End
   Begin WebButton btnViewIndication
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "View"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   26
      Index           =   -2147483648
      Indicator       =   0
      Left            =   111
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   52
      TabStop         =   True
      Tooltip         =   ""
      Top             =   654
      Visible         =   True
      Width           =   90
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  // Populate the three verdict popups and the urgency popup. The user-facing
		  // labels and underlying ENUM strings are mapped via VerdictForIndex /
		  // UrgencyForIndex.
		  PopulateVerdictPopup(popVerdictPrimary)
		  PopulateVerdictPopup(popVerdictSecondaryIP)
		  PopulateVerdictPopup(popVerdictSecondaryOP)
		  
		  // popUrgency mirrors the linked indication's urgency, which can be any
		  // of five values (matches dlg_Indication's popup ordering exactly).
		  popUrgency.RemoveAllRows
		  popUrgency.AddRow("Not indicated")
		  popUrgency.AddRow("Can be considered")
		  popUrgency.AddRow("Routine")
		  popUrgency.AddRow("Soon")
		  popUrgency.AddRow("Urgent")
		  
		  // PathIDs starts empty → lstParent shows roots; lstChild empty until a
		  // parent is selected. Detail panel is blank until something is focused.
		  PathIDs.ResizeTo(-1)
		  ReloadView
		  ClearDetail
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  Var auth As Boolean = Session.IsAuthenticated
		  btnAddSibling.Enabled = auth
		  btnAddChild.Enabled = auth
		  btnDeleteSelected.Enabled = auth
		  btnPickIndication.Enabled = auth
		  wc_header.UpdateAuthenticationStatus(auth)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AppendNodeRow(lb As WebListBox, n As DecisionNode)
		  // Adds one row to the given list. Always uses a StyleRenderer (even for
		  // non-terminal rows with no extra styling) so the cell type stays
		  // consistent — switching a cell between String and Renderer at runtime
		  // can confuse the Xojo Web 2.0 render pipeline.
		  lb.AddRow("")
		  Var rowIdx As Integer = lb.LastAddedRowIndex
		  lb.RowTagAt(rowIdx) = n.ID
		  AssignRowCell(lb, rowIdx, n.OptionLabel, n.IsTerminal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ApplyAllVerdictRagIndicators()
		  ApplyRagIndicator(popVerdictPrimary)
		  ApplyRagIndicator(popVerdictSecondaryIP)
		  ApplyRagIndicator(popVerdictSecondaryOP)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ApplyLeafModeUI()
		  // Branch nodes have no indication-related controls visible — clutter
		  // free. Verdict leaves show the picker button, the linked-indication
		  // labels, and the four read-only popups that mirror the indication's
		  // GP/IP/OP/urgency. txtRationale stays available for both kinds.
		  Var hasNode As Boolean = (CurrentNode <> Nil)
		  Var isLeaf As Boolean = hasNode And (segNodeKind.SelectedSegmentIndex = 1)
		  Var auth As Boolean = Session.IsAuthenticated
		  
		  txtSelectedNode.Enabled = hasNode And auth
		  segNodeKind.Enabled = hasNode And auth
		  txtRationale.Enabled = hasNode And auth
		  
		  // Indication-related controls: visible only on leaves.
		  btnPickIndication.Visible = isLeaf
		  btnPickIndication.Enabled = isLeaf And auth
		  btnViewIndication.Visible = isLeaf
		  btnViewIndication.Enabled = isLeaf And SelectedIndicationID > 0
		  lblSelectedIndicationID.Visible = isLeaf
		  lblSelectedIndication.Visible = isLeaf
		  
		  popVerdictPrimary.Visible = isLeaf
		  popVerdictSecondaryIP.Visible = isLeaf
		  popVerdictSecondaryOP.Visible = isLeaf
		  popUrgency.Visible = isLeaf
		  popVerdictPrimary.Enabled = False
		  popVerdictSecondaryIP.Enabled = False
		  popVerdictSecondaryOP.Enabled = False
		  popUrgency.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ApplyListHeadings()
		  // lstParent: "Roots" at top level, else "Children of {tail label}".
		  Var parentHeading As String = "Roots"
		  If PathIDs.Count > 0 Then
		    Var tailID As Integer = PathIDs(PathIDs.LastIndex)
		    Var tail As DecisionNode = DecisionNode.GetByID(Session.DB, tailID)
		    If tail <> Nil Then parentHeading = "Children of " + tail.OptionLabel
		  End If
		  lstParent.HeaderAt(0) = parentHeading
		  
		  // lstChild: "Children of {selected parent}" or a hint string.
		  Var childHeading As String = "(Select a parent on the left)"
		  If lstParent.SelectedRowIndex >= 0 Then
		    Var pid As Integer = lstParent.RowTagAt(lstParent.SelectedRowIndex).IntegerValue
		    Var p As DecisionNode = DecisionNode.GetByID(Session.DB, pid)
		    If p <> Nil Then childHeading = "Children of " + p.OptionLabel
		  End If
		  lstChild.HeaderAt(0) = childHeading
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ApplyRagIndicator(p As WebPopupMenu)
		  // Tint the popup the same RAG colours as dlg_indication:
		  //   Indicated         → Success (green)
		  //   Not indicated     → Danger  (red)
		  //   Can be considered → Warning (amber)
		  //   No selection      → Default (neutral)
		  Select Case p.SelectedRowIndex
		  Case 0
		    p.Indicator = WebUIControl.Indicators.Success
		  Case 1
		    p.Indicator = WebUIControl.Indicators.Danger
		  Case 2
		    p.Indicator = WebUIControl.Indicators.Warning
		  Else
		    p.Indicator = WebUIControl.Indicators.Default
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AssignRowCell(lb As WebListBox, rowIdx As Integer, labelText As String, terminal As Boolean)
		  // Always assign a renderer (even for non-terminal rows, with no special
		  // styling). Keeping the cell type consistent prevents Xojo's render
		  // pipeline from getting confused when a row toggles between Branch and
		  // Verdict leaf.
		  Var s As New WebStyle
		  Var displayText As String = labelText
		  If terminal Then
		    // Italic + a high-contrast amber/gold that reads on both light and
		    // dark backgrounds. The trailing " ▸ verdict" cue identifies leaf rows.
		    s.Italic = True
		    s.Bold = True
		    s.ForegroundColor = Color.RGB(255, 200, 0)
		    displayText = labelText + "   ▸ verdict"
		  End If
		  lb.CellValueAt(rowIdx, 0) = New WebListBoxStyleRenderer(s, displayText)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildBreadcrumb()
		  bcTreeNavigation.RemoveAllRows
		  bcTreeNavigation.AddRow("Decision tree")
		  bcTreeNavigation.RowTagAt(0) = 0
		  For Each id As Integer In PathIDs
		    Var n As DecisionNode = DecisionNode.GetByID(Session.DB, id)
		    If n <> Nil Then
		      bcTreeNavigation.AddRow(n.OptionLabel)
		      bcTreeNavigation.RowTagAt(bcTreeNavigation.LastAddedIndex) = id
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ClearDetail()
		  CurrentNode = Nil
		  SuppressDirty = True
		  txtSelectedNode.Text = ""
		  txtRationale.Text = ""
		  segNodeKind.SelectedSegmentIndex = 0
		  popVerdictPrimary.SelectedRowIndex = -1
		  popVerdictSecondaryIP.SelectedRowIndex = -1
		  popVerdictSecondaryOP.SelectedRowIndex = -1
		  popUrgency.SelectedRowIndex = -1
		  ApplyAllVerdictRagIndicators
		  UpdateIndicationLabels
		  ApplyLeafModeUI
		  SuppressDirty = False
		  IsDirty = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CollectDetailIntoNode() As String
		  // Pull control state into CurrentNode. "" on success, validation message
		  // otherwise. Only option_label is strictly required (NOT NULL in schema).
		  // CurrentNode.IndicationID is managed elsewhere (segNodeKind.Pressed for
		  // Branch-toggle clears, HandleIndicationPicked for picker-select sets) —
		  // both paths immediately persist, so this function doesn't touch it.
		  If CurrentNode Is Nil Then Return "No node selected."
		  
		  Var label As String = txtSelectedNode.Text.Trim
		  If label = "" Then Return "Option label is required."
		  
		  CurrentNode.OptionLabel = label
		  CurrentNode.Rationale = txtRationale.Text.Trim
		  CurrentNode.Prompt = ""   // Field is no longer exposed in the UI.
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDeleteConfirm(sender As WebMessageDialog, button As WebMessageDialogButton)
		  If button <> sender.ActionButton Then
		    PendingDeleteID = 0
		    Return
		  End If
		  
		  Var nodeID As Integer = PendingDeleteID
		  PendingDeleteID = 0
		  If nodeID = 0 Then Return
		  
		  Var n As DecisionNode = DecisionNode.GetByID(Session.DB, nodeID)
		  If n Is Nil Then
		    MessageBox("Node not found — it may already have been deleted.")
		    Return
		  End If
		  
		  If Not n.DeleteWithAudit(Session.DB, Session.CurrentUsername) Then
		    MessageBox("Error deleting node. See debug log.")
		    Return
		  End If
		  
		  // The deleted node may have been the breadcrumb tail (in which case the
		  // entire view shifts up), or just a row in lstParent / lstChild. Easiest
		  // correct behaviour is to truncate PathIDs at the deleted node and reload.
		  Var idx As Integer = PathIDs.IndexOf(nodeID)
		  If idx >= 0 Then PathIDs.ResizeTo(idx - 1)
		  
		  ClearDetail
		  ReloadView
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleIndicationPicked(sender As dlg_select_indication, indicationID As Integer)
		  // Callback for dlg_select_indication.
		  //   id > 0 → user picked: assign + immediate save + refresh UI.
		  //   id = 0 → user cancelled. If the node had no prior indication (i.e. this
		  //            dialog opened because of a fresh Branch→Leaf toggle), revert
		  //            segNodeKind back to Branch. If the node already had one, the
		  //            user was changing it but backed out — leave state untouched.
		  #Pragma Unused sender
		  System.DebugLog("HandleIndicationPicked: indID=" + indicationID.ToString + _
		  ", CurrentNode=" + If(CurrentNode Is Nil, "Nil", CurrentNode.ID.ToString))
		  If CurrentNode Is Nil Then Return
		  
		  If indicationID > 0 Then
		    CurrentNode.IndicationID = indicationID
		    SuppressDirty = True
		    segNodeKind.SelectedSegmentIndex = 1
		    MirrorIndicationToPopups(indicationID)
		    SuppressDirty = False
		    SaveCurrentNodeImmediately
		    UpdateIndicationLabels
		    ApplyLeafModeUI
		    RefreshFocusedRowStyle
		    Return
		  End If
		  
		  // Cancelled — only revert if no existing indication.
		  If CurrentNode.IndicationID = 0 Then
		    SuppressDirty = True
		    segNodeKind.SelectedSegmentIndex = 0   // → Branch
		    SuppressDirty = False
		    ApplyLeafModeUI
		    RefreshFocusedRowStyle
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexForUrgency(u As String) As Integer
		  // Matches the popUrgency row order set up in Opening.
		  Select Case u
		  Case "not_indicated"
		    Return 0
		  Case "can_be_considered"
		    Return 1
		  Case "routine"
		    Return 2
		  Case "soon"
		    Return 3
		  Case "urgent"
		    Return 4
		  End Select
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexForVerdict(v As String) As Integer
		  Select Case v
		  Case "indicated"
		    Return 0
		  Case "not_indicated"
		    Return 1
		  Case "can_be_considered"
		    Return 2
		  End Select
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InsertNewNodeIntoView(n As DecisionNode)
		  // A newly-inserted node belongs in lstParent if its parent matches
		  // ParentIDForLstParent, or in lstChild if its parent matches the currently
		  // selected lstParent row. Uses AppendNodeRow so the cell type is
		  // consistent with the rest of the populated rows.
		  Var lstParentParent As Integer = ParentIDForLstParent
		  If n.ParentID = lstParentParent Then
		    AppendNodeRow(lstParent, n)
		    Return
		  End If
		  
		  If lstParent.SelectedRowIndex >= 0 Then
		    Var selID As Integer = lstParent.RowTagAt(lstParent.SelectedRowIndex).IntegerValue
		    If n.ParentID = selID Then
		      AppendNodeRow(lstChild, n)
		      Return
		    End If
		  End If
		  
		  // Anywhere else (parent is offscreen) → a full reload is the safest fallback.
		  ReloadView
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LiveUpdateRowLabel(nodeID As Integer, newLabel As String)
		  // Reflect a label edit in whichever listbox row carries the node, without
		  // triggering selection changes. If the row corresponds to a terminal node
		  // (CurrentNode is the only candidate that could be edited live), re-apply
		  // the leaf style + suffix so the visual cue stays consistent.
		  Var isTerminal As Boolean = (CurrentNode <> Nil And CurrentNode.ID = nodeID And CurrentNode.IsTerminal)
		  
		  For i As Integer = 0 To lstParent.LastRowIndex
		    If lstParent.RowTagAt(i).IntegerValue = nodeID Then
		      AssignRowCell(lstParent, i, newLabel, isTerminal)
		      Exit For
		    End If
		  Next
		  For i As Integer = 0 To lstChild.LastRowIndex
		    If lstChild.RowTagAt(i).IntegerValue = nodeID Then
		      AssignRowCell(lstChild, i, newLabel, isTerminal)
		      Exit For
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadChildList(parentID As Integer)
		  lstChild.RemoveAllRows
		  If parentID = 0 Then
		    ApplyListHeadings
		    Return
		  End If
		  Var nodes() As DecisionNode = DecisionNode.GetChildren(Session.DB, parentID)
		  For Each n As DecisionNode In nodes
		    AppendNodeRow(lstChild, n)
		  Next
		  ApplyListHeadings
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadParentList(parentID As Integer)
		  lstParent.RemoveAllRows
		  Var nodes() As DecisionNode
		  If parentID = 0 Then
		    nodes = DecisionNode.GetRoots(Session.DB)
		  Else
		    nodes = DecisionNode.GetChildren(Session.DB, parentID)
		  End If
		  For Each n As DecisionNode In nodes
		    AppendNodeRow(lstParent, n)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MarkDirty()
		  // Call from any editable control's change event. SuppressDirty is set while
		  // we programmatically populate controls (PopulateDetail/ClearDetail) so
		  // that loading a node doesn't immediately count as a user edit.
		  If SuppressDirty Then Return
		  If CurrentNode Is Nil Then Return
		  IsDirty = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MaybeSaveCurrent() As Boolean
		  // Called before any navigation. Returns False if a save was attempted
		  // and failed validation — the caller should abort navigation in that case.
		  If CurrentNode Is Nil Then Return True
		  // Nothing to do if the user hasn't touched anything since the node loaded.
		  If Not IsDirty Then Return True
		  
		  If Not Session.IsAuthenticated Then
		    MessageBox("You must be authenticated to save changes.")
		    Return False
		  End If
		  
		  Var validationError As String = CollectDetailIntoNode
		  If validationError <> "" Then
		    MessageBox(validationError)
		    txtSelectedNode.SetFocus
		    Return False
		  End If
		  
		  Var savedID As Integer = CurrentNode.ID
		  System.DebugLog("MaybeSaveCurrent: saving id=" + savedID.ToString)
		  
		  Try
		    If Not CurrentNode.SaveWithAudit(Session.DB, Session.CurrentUsername) Then
		      System.DebugLog("MaybeSaveCurrent: SaveWithAudit returned False for id=" + savedID.ToString)
		      MessageBox("Error saving node. See debug log.")
		      Return False
		    End If
		  Catch err As RuntimeException
		    System.DebugLog("MaybeSaveCurrent: " + Introspection.GetType(err).Name + " during save: " + err.Message)
		    MessageBox("Unexpected error saving node — see debug log.")
		    Return False
		  End Try
		  
		  // Reflect the saved label / kind in whichever list the node is in.
		  // (New nodes are inserted directly in StartNewNode, so this is always an
		  // update path now.) A row-style update failure should NOT block navigation.
		  Try
		    LiveUpdateRowLabel(CurrentNode.ID, CurrentNode.OptionLabel)
		  Catch err As RuntimeException
		    System.DebugLog("MaybeSaveCurrent: row-style update failed (" + Introspection.GetType(err).Name + "): " + err.Message)
		  End Try
		  
		  IsDirty = False
		  System.DebugLog("MaybeSaveCurrent: success for id=" + savedID.ToString)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MirrorIndicationToPopups(indicationID As Integer)
		  // The four verdict / urgency popups display the linked indication's
		  // values read-only. For non-linked nodes (no indication) they're cleared.
		  If indicationID = 0 Then
		    popVerdictPrimary.SelectedRowIndex     = -1
		    popVerdictSecondaryIP.SelectedRowIndex = -1
		    popVerdictSecondaryOP.SelectedRowIndex = -1
		    popUrgency.SelectedRowIndex            = -1
		    ApplyAllVerdictRagIndicators
		    Return
		  End If
		  Var ind As Indication = Indication.GetByID(Session.DB, indicationID)
		  If ind Is Nil Then Return
		  popVerdictPrimary.SelectedRowIndex     = IndexForVerdict(ind.PrimaryCare)
		  popVerdictSecondaryIP.SelectedRowIndex = IndexForVerdict(ind.SecondaryInpatient)
		  popVerdictSecondaryOP.SelectedRowIndex = IndexForVerdict(ind.SecondaryOutpatient)
		  popUrgency.SelectedRowIndex            = IndexForUrgency(ind.Urgency)
		  ApplyAllVerdictRagIndicators
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenIndicationPicker()
		  // Opens dlg_select_indication; HandleIndicationPicked handles both
		  // "user picked" (id > 0) and "user cancelled" (id = 0) outcomes.
		  Var dlg As New dlg_select_indication
		  AddHandler dlg.IndicationPicked, AddressOf HandleIndicationPicked
		  dlg.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParentIDForLstParent() As Integer
		  // The "parent" of lstParent's contents = breadcrumb tail, or 0 for roots.
		  If PathIDs.Count = 0 Then Return 0
		  Return PathIDs(PathIDs.LastIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateDetail(n As DecisionNode)
		  System.DebugLog("PopulateDetail: enter for id=" + n.ID.ToString)
		  CurrentNode = n
		  // Bypass dirty marking while we programmatically populate controls.
		  SuppressDirty = True
		  
		  txtSelectedNode.Text = n.OptionLabel
		  txtRationale.Text = n.Rationale
		  
		  // Branch vs Verdict leaf, determined solely by IndicationID.
		  If n.IsTerminal Then
		    segNodeKind.SelectedSegmentIndex = 1   // Verdict leaf
		    // Mirror the linked indication's verdicts into the (read-only) popups.
		    MirrorIndicationToPopups(n.IndicationID)
		  Else
		    segNodeKind.SelectedSegmentIndex = 0   // Branch
		    popVerdictPrimary.SelectedRowIndex = -1
		    popVerdictSecondaryIP.SelectedRowIndex = -1
		    popVerdictSecondaryOP.SelectedRowIndex = -1
		    popUrgency.SelectedRowIndex = -1
		    ApplyAllVerdictRagIndicators
		  End If
		  
		  UpdateIndicationLabels
		  ApplyLeafModeUI
		  SuppressDirty = False
		  IsDirty = False
		  System.DebugLog("PopulateDetail: done for id=" + n.ID.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateVerdictPopup(p As WebPopupMenu)
		  p.RemoveAllRows
		  p.AddRow("Indicated")
		  p.AddRow("Not indicated")
		  p.AddRow("Can be considered")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshFocusedRowStyle()
		  // Update the listbox row visual to reflect the current UI's intent for
		  // terminal-vs-branch, BEFORE save — so toggling segNodeKind immediately
		  // re-styles the row in whichever listbox it lives in.
		  If CurrentNode Is Nil Or CurrentNode.ID = 0 Then Return
		  Var pendingTerminal As Boolean = (segNodeKind.SelectedSegmentIndex = 1)
		  Var labelText As String = txtSelectedNode.Text
		  For i As Integer = 0 To lstParent.LastRowIndex
		    If lstParent.RowTagAt(i).IntegerValue = CurrentNode.ID Then
		      AssignRowCell(lstParent, i, labelText, pendingTerminal)
		      Return
		    End If
		  Next
		  For i As Integer = 0 To lstChild.LastRowIndex
		    If lstChild.RowTagAt(i).IntegerValue = CurrentNode.ID Then
		      AssignRowCell(lstChild, i, labelText, pendingTerminal)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReloadView()
		  // Rebuilds both listboxes + their headings + the breadcrumb from PathIDs.
		  LoadParentList(ParentIDForLstParent)
		  lstChild.RemoveAllRows
		  ApplyListHeadings
		  BuildBreadcrumb
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveCurrentNodeImmediately()
		  // Atomic save — used for structural changes (toggle to Branch, indication
		  // picked) that need to persist without waiting for navigation-away. Pulls
		  // text fields through CollectDetailIntoNode so the on-screen label /
		  // rationale aren't lost.
		  If CurrentNode Is Nil Or CurrentNode.ID = 0 Then Return
		  If Not Session.IsAuthenticated Then Return
		  Var validationError As String = CollectDetailIntoNode
		  If validationError <> "" Then
		    MessageBox(validationError)
		    Return
		  End If
		  Try
		    If Not CurrentNode.SaveWithAudit(Session.DB, Session.CurrentUsername) Then
		      MessageBox("Error saving node. See debug log.")
		      Return
		    End If
		    LiveUpdateRowLabel(CurrentNode.ID, CurrentNode.OptionLabel)
		    IsDirty = False
		  Catch err As RuntimeException
		    System.DebugLog("SaveCurrentNodeImmediately: " + Introspection.GetType(err).Name + " — " + err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectedIndicationID() As Integer
		  // The "selected" indication is now read directly from CurrentNode —
		  // there's no cmbIndication anymore; the link is the source of truth.
		  If CurrentNode Is Nil Then Return 0
		  Return CurrentNode.IndicationID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectRowByID(lb As WebListBox, nodeID As Integer) As Boolean
		  // Move selection in the given list to the row carrying nodeID.
		  // The SelectionChanged event handlers short-circuit if id matches the
		  // current focus (same-ID = no-op), so this is safe to call freely.
		  For i As Integer = 0 To lb.LastRowIndex
		    If lb.RowTagAt(i).IntegerValue = nodeID Then
		      lb.SelectedRowIndex = i
		      Return True
		    End If
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartNewNode(parentID As Integer)
		  // Used by both Add Sibling and Add Child after we've decided the parent.
		  // We persist immediately with a placeholder label so the row appears in
		  // the listbox right away. Subsequent edits flow through the regular
		  // MaybeSaveCurrent path. If the user changes their mind they can use
		  // btnDeleteSelected.
		  Var n As New DecisionNode
		  n.ID = 0
		  n.ParentID = parentID
		  n.OptionLabel = "(new)"
		  n.SortOrder = DecisionNode.NextSortOrder(Session.DB, parentID)
		  
		  If Not n.SaveWithAudit(Session.DB, Session.CurrentUsername) Then
		    MessageBox("Error creating node. See debug log.")
		    Return
		  End If
		  
		  // The node is now saved with a real ID — show it in the listbox and load
		  // the detail panel pointing at the persisted record (not the in-memory
		  // unsaved stub), so subsequent edits update rather than re-insert.
		  InsertNewNodeIntoView(n)
		  PopulateDetail(n)
		  txtSelectedNode.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateIndicationLabels()
		  // Mirror the linked indication into the two read-only labels.
		  // For non-linked nodes (no indication picked) the labels are blanked.
		  Var indID As Integer = SelectedIndicationID
		  If indID > 0 Then
		    Var ind As Indication = Indication.GetByID(Session.DB, indID)
		    If ind <> Nil Then
		      lblSelectedIndicationID.Text = "ID: " + indID.ToString
		      lblSelectedIndication.Text = ind.Title
		      Return
		    End If
		  End If
		  lblSelectedIndicationID.Text = "ID:"
		  lblSelectedIndication.Text = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UrgencyForIndex(idx As Integer) As String
		  Select Case idx
		  Case 0
		    Return "routine"
		  Case 1
		    Return "soon"
		  Case 2
		    Return "urgent"
		  End Select
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function VerdictForIndex(idx As Integer) As String
		  Select Case idx
		  Case 0
		    Return "indicated"
		  Case 1
		    Return "not_indicated"
		  Case 2
		    Return "can_be_considered"
		  End Select
		  Return ""
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CurrentNode As DecisionNode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsDirty As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PathIDs() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PendingDeleteID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SuppressDirty As Boolean = False
	#tag EndProperty


#tag EndWindowCode

#tag Events bcTreeNavigation
	#tag Event
		Sub Pressed(index As Integer)
		  Try
		    System.DebugLog("bcTreeNavigation.Pressed: index=" + index.ToString)
		    If Not MaybeSaveCurrent Then Return
		    // index 0 = "Decision tree" → roots; index N = drill back to that depth.
		    PathIDs.ResizeTo(index - 1)
		    ClearDetail
		    ReloadView
		    System.DebugLog("bcTreeNavigation.Pressed: done (index=" + index.ToString + ")")
		  Catch err As RuntimeException
		    System.DebugLog("bcTreeNavigation.Pressed: " + Introspection.GetType(err).Name + " — " + err.Message)
		    MessageBox("Internal error navigating — see debug log.")
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtSelectedNode
	#tag Event
		Sub TextChanged()
		  If SuppressDirty Then Return
		  MarkDirty
		  // Live-update the listbox row so the user sees their edit immediately.
		  If CurrentNode <> Nil And CurrentNode.ID > 0 Then
		    LiveUpdateRowLabel(CurrentNode.ID, txtSelectedNode.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnPickIndication
	#tag Event
		Sub Pressed()
		  // Browse — change the linked indication on an existing leaf. (For new
		  // leaves, the picker auto-opens via segNodeKind.Pressed.)
		  OpenIndicationPicker
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popVerdictPrimary
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  MarkDirty
		  ApplyRagIndicator(popVerdictPrimary)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtRationale
	#tag Event
		Sub TextChanged()
		  MarkDirty
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstParent
	#tag Event
		Sub SelectionChanged(rows() As Integer)
		  #Pragma Unused rows
		  Try
		    Var row As Integer = lstParent.SelectedRowIndex
		    If row < 0 Then
		      // Deselected (rare). Clear the right side.
		      lstChild.RemoveAllRows
		      ApplyListHeadings
		      Return
		    End If
		    
		    Var id As Integer = lstParent.RowTagAt(row).IntegerValue
		    System.DebugLog("lstParent.SelectionChanged: clicked id=" + id.ToString)
		    
		    // Same-ID guard: programmatic re-selection of the focused node is a no-op.
		    If CurrentNode <> Nil And id = CurrentNode.ID Then
		      Return
		    End If
		    
		    If Not MaybeSaveCurrent Then
		      // Revert visual selection back to CurrentNode's row. The resulting
		      // SelectionChanged fires with id = CurrentNode.ID and short-circuits above.
		      If CurrentNode <> Nil Then Call SelectRowByID(lstParent, CurrentNode.ID)
		      Return
		    End If
		    
		    System.DebugLog("lstParent.SelectionChanged: loading child list for id=" + id.ToString)
		    LoadChildList(id)
		    System.DebugLog("lstParent.SelectionChanged: fetching node id=" + id.ToString)
		    Var n As DecisionNode = DecisionNode.GetByID(Session.DB, id)
		    If n <> Nil Then
		      System.DebugLog("lstParent.SelectionChanged: populating detail for id=" + id.ToString)
		      PopulateDetail(n)
		    End If
		    System.DebugLog("lstParent.SelectionChanged: done (id=" + id.ToString + ")")
		  Catch err As RuntimeException
		    System.DebugLog("lstParent.SelectionChanged: " + Introspection.GetType(err).Name + " — " + err.Message)
		    MessageBox("Internal error handling selection — see debug log.")
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnAddChild
	#tag Event
		Sub Pressed()
		  If Not Session.IsAuthenticated Then
		    MessageBox("You must be authenticated to add nodes.")
		    Return
		  End If
		  If CurrentNode Is Nil Or CurrentNode.ID = 0 Then
		    MessageBox("Select a saved node first to add a child.")
		    Return
		  End If
		  If Not MaybeSaveCurrent Then Return
		  
		  // If the focus is in lstChild, the new row would land in a level the UI
		  // doesn't currently show. Drill first so the new sibling-set is visible.
		  Var lstParentParent As Integer = ParentIDForLstParent
		  If CurrentNode.ParentID <> lstParentParent Then
		    PathIDs.Add(CurrentNode.ParentID)
		    ReloadView
		    Call SelectRowByID(lstParent, CurrentNode.ID)
		    LoadChildList(CurrentNode.ID)
		  End If
		  
		  StartNewNode(CurrentNode.ID)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstChild
	#tag Event
		Sub SelectionChanged(rows() As Integer)
		  #Pragma Unused rows
		  Try
		    Var row As Integer = lstChild.SelectedRowIndex
		    If row < 0 Then Return
		    
		    Var id As Integer = lstChild.RowTagAt(row).IntegerValue
		    // Same-ID guard — programmatic re-selection is a no-op.
		    If CurrentNode <> Nil And id = CurrentNode.ID Then
		      Return
		    End If
		    
		    System.DebugLog("lstChild.SelectionChanged: clicked id=" + id.ToString)
		    
		    If Not MaybeSaveCurrent Then
		      If CurrentNode <> Nil Then Call SelectRowByID(lstChild, CurrentNode.ID)
		      Return
		    End If
		    
		    Var n As DecisionNode = DecisionNode.GetByID(Session.DB, id)
		    If n Is Nil Then
		      System.DebugLog("lstChild.SelectionChanged: GetByID returned Nil for id=" + id.ToString)
		      Return
		    End If
		    
		    // Auto-drill on click when the clicked node is a branch (not a verdict
		    // leaf). The clicked node becomes the new lstParent selection, lstChild
		    // reloads with its children, and the breadcrumb gains one crumb. The
		    // detail panel populates either way.
		    If n.IsTerminal Then
		      PopulateDetail(n)
		      Return
		    End If
		    
		    // To drill we need a currently-selected row in lstParent — that becomes
		    // the new breadcrumb tail.
		    If lstParent.SelectedRowIndex < 0 Then
		      PopulateDetail(n)
		      Return
		    End If
		    Var newCrumbID As Integer = lstParent.RowTagAt(lstParent.SelectedRowIndex).IntegerValue
		    
		    PathIDs.Add(newCrumbID)
		    ReloadView
		    Call SelectRowByID(lstParent, id)
		    LoadChildList(id)
		    PopulateDetail(n)
		  Catch err As RuntimeException
		    System.DebugLog("lstChild.SelectionChanged: " + Introspection.GetType(err).Name + " — " + err.Message)
		    MessageBox("Internal error handling selection — see debug log.")
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnAddSibling
	#tag Event
		Sub Pressed()
		  If Not Session.IsAuthenticated Then
		    MessageBox("You must be authenticated to add nodes.")
		    Return
		  End If
		  If Not MaybeSaveCurrent Then Return
		  
		  // A "sibling" is a node sharing CurrentNode's parent. If no node is focused
		  // we treat it as "add a root".
		  Var parentID As Integer = 0
		  If CurrentNode <> Nil Then parentID = CurrentNode.ParentID
		  StartNewNode(parentID)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnDeleteSelected
	#tag Event
		Sub Pressed()
		  If Not Session.IsAuthenticated Then
		    MessageBox("You must be authenticated to delete nodes.")
		    Return
		  End If
		  If CurrentNode Is Nil Then
		    MessageBox("Select a node to delete first.")
		    Return
		  End If
		  
		  Var n As Integer = DecisionNode.ChildCount(Session.DB, CurrentNode.ID)
		  Var explanation As String = "Delete '" + CurrentNode.OptionLabel + "'?"
		  If n > 0 Then
		    explanation = explanation + EndOfLine + EndOfLine + _
		    "This will also delete " + n.ToString + " descendant node" + If(n = 1, "", "s") + "."
		  End If
		  
		  PendingDeleteID = CurrentNode.ID
		  
		  Var dlg As New WebMessageDialog
		  dlg.Message = "Confirm delete"
		  dlg.Explanation = explanation
		  dlg.ActionButton.Caption = "Delete"
		  dlg.ActionButton.Indicator = WebUIControl.Indicators.Danger
		  dlg.CancelButton.Caption = "Cancel"
		  dlg.CancelButton.Visible = True
		  AddHandler dlg.ButtonPressed, AddressOf HandleDeleteConfirm
		  dlg.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events segNodeKind
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  #Pragma Unused segmentIndex
		  If CurrentNode Is Nil Then Return
		  
		  If segNodeKind.SelectedSegmentIndex = 1 Then
		    // → Verdict leaf. If no indication yet, open the picker immediately;
		    // HandleIndicationPicked will save on success or revert this toggle on
		    // cancel. If we already have an indication (re-toggling), just refresh.
		    ApplyLeafModeUI
		    RefreshFocusedRowStyle
		    If CurrentNode.IndicationID = 0 Then OpenIndicationPicker
		  Else
		    // → Branch. Immediately clear the indication link and save — atomic.
		    CurrentNode.IndicationID = 0
		    SaveCurrentNodeImmediately
		    MirrorIndicationToPopups(0)
		    UpdateIndicationLabels
		    ApplyLeafModeUI
		    RefreshFocusedRowStyle
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popVerdictSecondaryOP
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  MarkDirty
		  ApplyRagIndicator(popVerdictSecondaryOP)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popVerdictSecondaryIP
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  MarkDirty
		  ApplyRagIndicator(popVerdictSecondaryIP)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popUrgency
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  
		  MarkDirty
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnViewIndication
	#tag Event
		Sub Pressed()
		  // Navigate to wp_indications with the linked indication's ID as the deep
		  // link, so wp_indications auto-opens dlg_Indication for it on Shown.
		  // Same pattern as the landing-page → wp_indications deep-link flow.
		  Var indID As Integer = SelectedIndicationID
		  If indID = 0 Then
		    MessageBox("No indication picked yet.")
		    Return
		  End If
		  // Save any pending edits before leaving the page.
		  If Not MaybeSaveCurrent Then Return
		  Var w As New wp_indications
		  w.DeepLinkID = indID
		  Session.NavigationManager.NavigateToPage(w)
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
