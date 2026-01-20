#tag DesktopWindow
Begin DesktopContainer dlg_Indication
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cF9FCFC00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   True
   Height          =   768
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   False
   Visible         =   True
   Width           =   1044
   Begin DesktopRectangle HeaderRect
      AllowAutoDeactivate=   True
      BorderColor     =   &c0060BE00
      BorderThickness =   0.0
      CornerSize      =   0.0
      Enabled         =   True
      FillColor       =   &c0060BE00
      Height          =   62
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   1044
      Begin DesktopLabel lblDialogHeader
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   22.0
         FontUnit        =   0
         Height          =   42
         Index           =   -2147483648
         InitialParent   =   "HeaderRect"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Indication Detail"
         TextAlignment   =   0
         TextColor       =   &cFFFFFF00
         Tooltip         =   ""
         Top             =   10
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   508
      End
      Begin DesktopButton btnNextIndication
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "❯"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   32
         Index           =   -2147483648
         InitialParent   =   "HeaderRect"
         Italic          =   False
         Left            =   995
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   6
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   15
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   36
      End
      Begin DesktopButton btnPreviousIndication
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "❮"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   32
         Index           =   -2147483648
         InitialParent   =   "HeaderRect"
         Italic          =   False
         Left            =   949
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   6
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   15
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   36
      End
   End
   Begin DesktopButton btnSave
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Save"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   944
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   728
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton btnCancel
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   852
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   728
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopListBox lstContexts
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   "50,*"
      DefaultRowHeight=   30
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   624
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   202
      _ScrollWidth    =   -1
   End
   Begin DesktopLabel lblContexts
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   27
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Contexts"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   97
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopTextArea txtIndication
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   147
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   234
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "test"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   790
   End
   Begin DesktopLabel lblIndication
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   234
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Indication"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   97
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopTextArea txtKeywords
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   170
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   452
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   327
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   280
   End
   Begin DesktopTextArea txtComments
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   170
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   744
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   327
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   280
   End
   Begin DesktopLabel lblKeywords
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   452
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Keywords/Synonyms"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   296
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopLabel lblComments
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   744
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Comments"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   296
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopLabel lblAttribution
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Attribution"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   296
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   161
   End
   Begin DesktopCheckBox chkSourceBSE
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "BSE"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   327
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   0
      Width           =   142
   End
   Begin DesktopCheckBox chkSourceEACVI
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "EACVI"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   359
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   0
      Width           =   142
   End
   Begin DesktopCheckBox chkSourceASE
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "ASE"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   391
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   0
      Width           =   142
   End
   Begin DesktopCheckBox chkSourceConsensus
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Consensus"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   423
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   0
      Width           =   142
   End
   Begin DesktopPopupMenu popPrimaryCare
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   29
      Index           =   -2147483648
      InitialValue    =   "Indicated\nNot indicated\nMay be considered"
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   606
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopLabel lblPrimaryCare
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Primary Care"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   584
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopPopupMenu popSecondaryOP
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   29
      Index           =   -2147483648
      InitialValue    =   "Indicated\nNot indicated\nMay be considered"
      Italic          =   False
      Left            =   438
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   606
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopLabel lblSecondaryOP
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   438
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Secondary Care (OP)"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   584
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopPopupMenu popSecondaryIP
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   29
      Index           =   -2147483648
      InitialValue    =   "Indicated\nNot indicated\nMay be considered"
      Italic          =   False
      Left            =   617
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   606
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopLabel lblSecondaryIP
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   617
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   26
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Secondary Care (IP)"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   584
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopPopupMenu popUrgency
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   29
      Index           =   -2147483648
      InitialValue    =   "Not indicated\nCan be considered\nRoutine\nSoon\nUrgent"
      Italic          =   False
      Left            =   873
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   27
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   606
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopLabel lblDialogHeader9
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
      FontUnit        =   0
      Height          =   19
      Index           =   -2147483648
      Italic          =   False
      Left            =   873
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Priority/Urgency"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   584
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  ' Load contexts for the checkbox list
		  LoadContextsList()

		  ' Set up form based on authentication
		  SetupFormAccess()

		  ' If this is a new indication (LoadIndication wasn't called), initialize
		  If mCurrentIndication = Nil Then
		    mIsNewIndication = True
		    ClearForm()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LoadIndication(indication As Indication)
		  ' Load an existing indication for viewing/editing
		  mCurrentIndication = indication
		  mIsNewIndication = False

		  If indication = Nil Then Return

		  ' Update header
		  lblDialogHeader.Text = "Indication Detail - " + indication.Title

		  ' Populate fields
		  txtIndication.Text = indication.Title
		  txtKeywords.Text = indication.Keywords
		  txtComments.Text = indication.Comments

		  ' Set attribution checkboxes
		  chkSourceASE.Value = indication.SourceASE
		  chkSourceEACVI.Value = indication.SourceEACVI
		  chkSourceBSE.Value = indication.SourceBSE
		  chkSourceConsensus.Value = indication.SourceConsensus

		  ' Set care settings (popup menu indices: 0=Indicated, 1=Not indicated, 2=May be considered)
		  popPrimaryCare.SelectedRowIndex = MapCareSettingToIndex(indication.PrimaryCare)
		  popSecondaryOP.SelectedRowIndex = MapCareSettingToIndex(indication.SecondaryOutpatient)
		  popSecondaryIP.SelectedRowIndex = MapCareSettingToIndex(indication.SecondaryInpatient)

		  ' Set urgency
		  popUrgency.SelectedRowIndex = MapUrgencyToIndex(indication.Urgency)

		  ' Check contexts that this indication belongs to
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    Var contextID As Integer = lstContexts.RowTagAt(i)
		    If indication.ContextIDs.IndexOf(contextID) >= 0 Then
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked
		    Else
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Unchecked
		    End If
		  Next

		  ' Enable/disable navigation buttons (would need context from parent)
		  btnPreviousIndication.Enabled = False
		  btnNextIndication.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ClearForm()
		  ' Clear all form fields for new indication
		  lblDialogHeader.Text = "New Indication"

		  txtIndication.Text = ""
		  txtKeywords.Text = ""
		  txtComments.Text = ""

		  chkSourceASE.Value = False
		  chkSourceEACVI.Value = False
		  chkSourceBSE.Value = False
		  chkSourceConsensus.Value = False

		  popPrimaryCare.SelectedRowIndex = -1
		  popSecondaryOP.SelectedRowIndex = -1
		  popSecondaryIP.SelectedRowIndex = -1
		  popUrgency.SelectedRowIndex = -1

		  ' Uncheck all contexts
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Unchecked
		  Next

		  ' Disable navigation buttons for new indication
		  btnPreviousIndication.Enabled = False
		  btnNextIndication.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadContextsList()
		  Try
		    lstContexts.RemoveAllRows()

		    Var contexts() As Context = Context.GetAll()

		    For Each ctx As Context In contexts
		      If ctx.IsActive Then
		        lstContexts.AddRow("")
		        Var row As Integer = lstContexts.LastAddedRowIndex
		        lstContexts.CellTypeAt(row, 0) = DesktopListBox.CellTypes.CheckBox
		        lstContexts.CellTextAt(row, 0) = ctx.Name
		        lstContexts.RowTagAt(row) = ctx.ID
		        lstContexts.CellCheckBoxStateAt(row, 0) = DesktopCheckBox.VisualStates.Unchecked
		      End If
		    Next

		  Catch err As RuntimeException
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("dlg_Indication: Error loading contexts - " + err.Message)
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupFormAccess()
		  ' Enable/disable form controls based on authentication
		  Var isAuthenticated As Boolean = AuthManager.IsAuthenticated

		  txtIndication.ReadOnly = Not isAuthenticated
		  txtKeywords.ReadOnly = Not isAuthenticated
		  txtComments.ReadOnly = Not isAuthenticated

		  chkSourceASE.Enabled = isAuthenticated
		  chkSourceEACVI.Enabled = isAuthenticated
		  chkSourceBSE.Enabled = isAuthenticated
		  chkSourceConsensus.Enabled = isAuthenticated

		  popPrimaryCare.Enabled = isAuthenticated
		  popSecondaryOP.Enabled = isAuthenticated
		  popSecondaryIP.Enabled = isAuthenticated
		  popUrgency.Enabled = isAuthenticated

		  lstContexts.Enabled = isAuthenticated
		  btnSave.Enabled = isAuthenticated
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateForm() As Boolean
		  ' Validate required fields
		  If txtIndication.Text.Trim.Length = 0 Then
		    MessageBox("Please enter an indication title.")
		    txtIndication.SetFocus()
		    Return False
		  End If

		  ' Ensure at least one context is selected
		  Var hasContext As Boolean = False
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		      hasContext = True
		      Exit For
		    End If
		  Next

		  If Not hasContext Then
		    MessageBox("Please select at least one context.")
		    Return False
		  End If

		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveIndication()
		  If Not ValidateForm() Then Return

		  Try
		    ' Collect selected context IDs
		    Var contextIDs() As Integer
		    For i As Integer = 0 To lstContexts.LastRowIndex
		      If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		        contextIDs.Add(lstContexts.RowTagAt(i))
		      End If
		    Next

		    ' Prepare data dictionary for API
		    Var data As New Dictionary
		    data.Value("title") = txtIndication.Text.Trim
		    data.Value("keywords") = txtKeywords.Text.Trim
		    data.Value("comments") = txtComments.Text.Trim
		    data.Value("source_ase") = chkSourceASE.Value
		    data.Value("source_eacvi") = chkSourceEACVI.Value
		    data.Value("source_bse") = chkSourceBSE.Value
		    data.Value("source_consensus") = chkSourceConsensus.Value
		    data.Value("primary_care") = MapIndexToCareSetting(popPrimaryCare.SelectedRowIndex)
		    data.Value("secondary_outpatient") = MapIndexToCareSetting(popSecondaryOP.SelectedRowIndex)
		    data.Value("secondary_inpatient") = MapIndexToCareSetting(popSecondaryIP.SelectedRowIndex)
		    data.Value("urgency") = MapIndexToUrgency(popUrgency.SelectedRowIndex)
		    data.Value("context_ids") = contextIDs

		    Var result As Dictionary

		    If mIsNewIndication Then
		      ' Create new indication
		      result = APIClient.Post("indications.lc", "create", data)

		      If result.Value("status") = "success" Then
		        ' Broadcast creation event
		        PubSub.Broadcast(EventConstants.INDICATION_CREATED, result.Value("data"))
		        MessageBox("Indication created successfully.")
		        Self.Close()
		      Else
		        MessageBox("Failed to create indication: " + result.Value("message").StringValue)
		      End If

		    Else
		      ' Update existing indication
		      data.Value("id") = mCurrentIndication.ID
		      result = APIClient.Post("indications.lc", "update", data)

		      If result.Value("status") = "success" Then
		        ' Broadcast update event
		        PubSub.Broadcast(EventConstants.INDICATION_UPDATED, result.Value("data"))
		        MessageBox("Indication updated successfully.")
		        Self.Close()
		      Else
		        MessageBox("Failed to update indication: " + result.Value("message").StringValue)
		      End If
		    End If

		  Catch err As RuntimeException
		    MessageBox("Error saving indication: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapCareSettingToIndex(setting As String) As Integer
		  ' Map care setting string to popup menu index
		  Select Case setting.Lowercase
		  Case "indicated"
		    Return 0
		  Case "not indicated"
		    Return 1
		  Case "may be considered"
		    Return 2
		  Else
		    Return -1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapIndexToCareSetting(index As Integer) As String
		  ' Map popup menu index to care setting string
		  Select Case index
		  Case 0
		    Return "Indicated"
		  Case 1
		    Return "Not indicated"
		  Case 2
		    Return "May be considered"
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapUrgencyToIndex(urgency As String) As Integer
		  ' Map urgency string to popup menu index
		  Select Case urgency.Lowercase
		  Case "not indicated"
		    Return 0
		  Case "can be considered"
		    Return 1
		  Case "routine"
		    Return 2
		  Case "soon"
		    Return 3
		  Case "urgent"
		    Return 4
		  Else
		    Return -1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapIndexToUrgency(index As Integer) As String
		  ' Map popup menu index to urgency string
		  Select Case index
		  Case 0
		    Return "Not indicated"
		  Case 1
		    Return "Can be considered"
		  Case 2
		    Return "Routine"
		  Case 3
		    Return "Soon"
		  Case 4
		    Return "Urgent"
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentIndication As Indication
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsNewIndication As Boolean = True
	#tag EndProperty


#tag EndWindowCode

#tag Events btnSave
	#tag Event
		Sub Pressed()
		  SaveIndication()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCancel
	#tag Event
		Sub Pressed()
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnPreviousIndication
	#tag Event
		Sub Pressed()
		  ' TODO: Implement previous/next navigation
		  ' This would require passing the full list context from parent
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnNextIndication
	#tag Event
		Sub Pressed()
		  ' TODO: Implement previous/next navigation
		  ' This would require passing the full list context from parent
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
