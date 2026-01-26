#tag DesktopWindow
Begin DesktopWindow dlg_Indication
   Backdrop        =   0
   BackgroundColor =   &c00000000
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   706
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Log in as admin"
   Type            =   2
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
         Height          =   62
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
         Top             =   0
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   896
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
         MacButtonStyle  =   7
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
         MacButtonStyle  =   7
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   666
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton btnCancel
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Close"
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   666
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopListBox lstContexts
      AllowAutoDeactivate=   False
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   40
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
      Height          =   562
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   124
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   202
      _ScrollOffset   =   0
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Contexts"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
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
      Left            =   258
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
      TabIndex        =   5
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
      Width           =   766
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
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Indication"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   95
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
      TabIndex        =   7
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
      TabIndex        =   8
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
      TabIndex        =   9
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
      TabIndex        =   10
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
      TabIndex        =   11
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
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   327
      Transparent     =   False
      Underline       =   False
      Value           =   False
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
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   359
      Transparent     =   False
      Underline       =   False
      Value           =   False
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
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   391
      Transparent     =   False
      Underline       =   False
      Value           =   False
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
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   423
      Transparent     =   False
      Underline       =   False
      Value           =   False
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
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   581
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
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Primary Care"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   557
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
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   581
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
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Secondary Care (OP)"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   557
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
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   581
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
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Secondary Care (IP)"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   557
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
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   581
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
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Priority/Urgency"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   557
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  ' Update parent listbox selection to show last viewed indication
		  If mParentListbox <> Nil And mCurrentIndex >= 0 And mIndicationsList.Count > 0 Then
		    ' Find the row that matches the current indication
		    For i As Integer = 0 To mParentListbox.LastRowIndex
		      Var rowInd As Indication = mParentListbox.RowTagAt(i)
		      If rowInd <> Nil And mCurrentIndication <> Nil Then
		        If rowInd.ID = mCurrentIndication.ID Then
		          mParentListbox.SelectedRowIndex = i
		          mParentListbox.ScrollPosition = i
		          Exit For i
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  ' Load contexts for the checkbox list
		  LoadContextsList()
		  
		  ' Apply context checkboxes if we have a current indication
		  ApplyContextCheckboxes()
		  
		  ' Set up form based on authentication
		  SetupFormAccess()
		  
		  ' If this is a new indication (LoadIndication wasn't called), initialize
		  If mCurrentIndication = Nil Then
		    mIsNewIndication = True
		    ClearForm()
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ApplyContextCheckboxes()
		  ' Check the appropriate context checkboxes based on mCurrentIndication
		  If mCurrentIndication = Nil Then Return
		  If lstContexts.LastRowIndex < 0 Then Return
		  
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("ApplyContextCheckboxes: Indication ID=" + mCurrentIndication.ID.ToString)
		    System.DebugLog("  ContextIDs to check: " + mCurrentIndication.ContextIDs.Count.ToString)
		    Var rowCount As Integer = lstContexts.LastRowIndex + 1
		    System.DebugLog("  lstContexts rows: " + rowCount.ToString)
		  End If
		  
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    Var contextID As Integer = lstContexts.RowTagAt(i)
		    Var contextName As String = lstContexts.CellTextAt(i, 0)
		    
		    If mCurrentIndication.ContextIDs.IndexOf(contextID) >= 0 Then
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("  CHECKED row " + i.ToString + ": ID=" + contextID.ToString + " (" + contextName + ")")
		      End If
		    Else
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Unchecked
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CaptureOriginalState()
		  '/// Captures the current form state as the original state for change detection
		  
		  mOriginalTitle = txtIndication.Text
		  mOriginalKeywords = txtKeywords.Text
		  mOriginalComments = txtComments.Text
		  mOriginalSourceASE = chkSourceASE.Value
		  mOriginalSourceEACVI = chkSourceEACVI.Value
		  mOriginalSourceBSE = chkSourceBSE.Value
		  mOriginalSourceConsensus = chkSourceConsensus.Value
		  mOriginalPrimaryCare = popPrimaryCare.SelectedRowIndex
		  mOriginalSecondaryOP = popSecondaryOP.SelectedRowIndex
		  mOriginalSecondaryIP = popSecondaryIP.SelectedRowIndex
		  mOriginalUrgency = popUrgency.SelectedRowIndex
		  
		  ' Capture selected context IDs
		  Redim mOriginalContextIDs(-1)
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		      mOriginalContextIDs.Add(lstContexts.RowTagAt(i))
		    End If
		  Next
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
		  
		  ' Capture the original state (empty) for change detection
		  CaptureOriginalState()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasUnsavedChanges() As Boolean
		  '/// Checks if the form has been modified from its original state
		  '///
		  '/// @returns True if there are unsaved changes, False otherwise
		  
		  ' Check text fields
		  If txtIndication.Text <> mOriginalTitle Then Return True
		  If txtKeywords.Text <> mOriginalKeywords Then Return True
		  If txtComments.Text <> mOriginalComments Then Return True
		  
		  ' Check checkboxes
		  If chkSourceASE.Value <> mOriginalSourceASE Then Return True
		  If chkSourceEACVI.Value <> mOriginalSourceEACVI Then Return True
		  If chkSourceBSE.Value <> mOriginalSourceBSE Then Return True
		  If chkSourceConsensus.Value <> mOriginalSourceConsensus Then Return True
		  
		  ' Check popup menus
		  If popPrimaryCare.SelectedRowIndex <> mOriginalPrimaryCare Then Return True
		  If popSecondaryOP.SelectedRowIndex <> mOriginalSecondaryOP Then Return True
		  If popSecondaryIP.SelectedRowIndex <> mOriginalSecondaryIP Then Return True
		  If popUrgency.SelectedRowIndex <> mOriginalUrgency Then Return True
		  
		  ' Check context IDs
		  Var currentContextIDs() As Integer
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		      currentContextIDs.Add(lstContexts.RowTagAt(i))
		    End If
		  Next
		  
		  ' Compare context arrays
		  If currentContextIDs.Count <> mOriginalContextIDs.Count Then Return True
		  
		  For Each id As Integer In currentContextIDs
		    If mOriginalContextIDs.IndexOf(id) < 0 Then Return True
		  Next
		  
		  Return False
		End Function
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

	#tag Method, Flags = &h0
		Sub LoadIndication(indication As Indication)
		  ' Load an existing indication for viewing/editing
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("=== LoadIndication called ===")
		  End If
		  
		  mCurrentIndication = indication
		  mIsNewIndication = False
		  
		  If indication = Nil Then
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("LoadIndication: indication is Nil!")
		    End If
		    Return
		  End If
		  
		  ' Update header
		  lblDialogHeader.Text = "Indication Detail"
		  
		  ' Populate fields
		  txtIndication.Text = indication.Title
		  txtKeywords.Text = indication.Keywords
		  txtComments.Text = indication.Comments
		  
		  ' Set attribution checkboxes
		  chkSourceASE.Value = indication.SourceASE
		  chkSourceEACVI.Value = indication.SourceEACVI
		  chkSourceBSE.Value = indication.SourceBSE
		  chkSourceConsensus.Value = indication.SourceConsensus
		  
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("LoadIndication: Setting popup values")
		    System.DebugLog("  PrimaryCare value: '" + indication.PrimaryCare + "' -> index " + MapCareSettingToIndex(indication.PrimaryCare).ToString)
		    System.DebugLog("  SecondaryOutpatient value: '" + indication.SecondaryOutpatient + "' -> index " + MapCareSettingToIndex(indication.SecondaryOutpatient).ToString)
		    System.DebugLog("  SecondaryInpatient value: '" + indication.SecondaryInpatient + "' -> index " + MapCareSettingToIndex(indication.SecondaryInpatient).ToString)
		    System.DebugLog("  Urgency value: '" + indication.Urgency + "' -> index " + MapUrgencyToIndex(indication.Urgency).ToString)
		  End If
		  
		  ' Set care settings (popup menu indices: 0=Indicated, 1=Not indicated, 2=May be considered)
		  popPrimaryCare.SelectedRowIndex = MapCareSettingToIndex(indication.PrimaryCare)
		  popSecondaryOP.SelectedRowIndex = MapCareSettingToIndex(indication.SecondaryOutpatient)
		  popSecondaryIP.SelectedRowIndex = MapCareSettingToIndex(indication.SecondaryInpatient)
		  
		  ' Set urgency
		  popUrgency.SelectedRowIndex = MapUrgencyToIndex(indication.Urgency)
		  
		  ' Check contexts that this indication belongs to
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("LoadIndication: Indication ID=" + indication.ID.ToString + " Title='" + indication.Title + "'")
		    System.DebugLog("  ContextIDs.Count = " + indication.ContextIDs.Count.ToString)
		    System.DebugLog("  ContextNames.Count = " + indication.ContextNames.Count.ToString)
		    
		    If indication.ContextIDs.Count > 0 Then
		      Var idsList As String = ""
		      For Each id As Integer In indication.ContextIDs
		        If idsList.Length > 0 Then idsList = idsList + ", "
		        idsList = idsList + id.ToString
		      Next
		      System.DebugLog("  Context IDs: " + idsList)
		    End If
		    
		    If indication.ContextNames.Count > 0 Then
		      System.DebugLog("  Context Names: " + String.FromArray(indication.ContextNames, ", "))
		    End If
		    
		    System.DebugLog("  lstContexts has " + lstContexts.LastRowIndex.ToString + " rows")
		  End If
		  
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    Var contextID As Integer = lstContexts.RowTagAt(i)
		    Var contextName As String = lstContexts.CellTextAt(i, 0)
		    
		    If indication.ContextIDs.IndexOf(contextID) >= 0 Then
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("  CHECKED context ID " + contextID.ToString + " (" + contextName + ")")
		      End If
		    Else
		      lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Unchecked
		      If AppConfig.DEBUG_MODE Then
		        System.DebugLog("  unchecked context ID " + contextID.ToString + " (" + contextName + ")")
		      End If
		    End If
		  Next
		  
		  ' Capture the original state for change detection
		  CaptureOriginalState()
		  
		  If AppConfig.DEBUG_MODE Then
		    System.DebugLog("=== LoadIndication completed ===")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapCareSettingToIndex(setting As String) As Integer
		  ' Map care setting string to popup menu index
		  Select Case setting.Lowercase
		  Case "indicated"
		    Return 0
		  Case "not_indicated", "not indicated"
		    Return 1
		  Case "may_be_considered", "may be considered", "can_be_considered", "can be considered"
		    Return 2
		  Else
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("MapCareSettingToIndex: Unknown value '" + setting + "'")
		    End If
		    Return -1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapIndexToCareSetting(index As Integer) As String
		  ' Map popup menu index to database care setting string (with underscores)
		  Select Case index
		  Case 0
		    Return "indicated"
		  Case 1
		    Return "not_indicated"
		  Case 2
		    Return "may_be_considered"
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapIndexToUrgency(index As Integer) As String
		  ' Map popup menu index to database urgency string (with underscores)
		  Select Case index
		  Case 0
		    Return "not_indicated"
		  Case 1
		    Return "can_be_considered"
		  Case 2
		    Return "routine"
		  Case 3
		    Return "soon"
		  Case 4
		    Return "urgent"
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapUrgencyToIndex(urgency As String) As Integer
		  ' Map urgency string to popup menu index
		  ' Database uses underscores, popup shows spaces
		  Select Case urgency.Lowercase
		  Case "not_indicated", "not indicated"
		    Return 0
		  Case "can_be_considered", "can be considered"
		    Return 1
		  Case "routine"
		    Return 2
		  Case "soon"
		    Return 3
		  Case "urgent"
		    Return 4
		  Else
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("MapUrgencyToIndex: Unknown value '" + urgency + "'")
		    End If
		    Return -1
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SaveIndication(closeOnSuccess As Boolean = True) As Boolean
		  '/// Saves the current indication (create or update)
		  '/// @param closeOnSuccess If True, closes the dialog on successful save
		  '/// @returns True if save was successful, False otherwise

		  If Not ValidateForm() Then Return False

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
		        If closeOnSuccess Then Self.Close()
		        Return True
		      Else
		        MessageBox("Failed to create indication: " + result.Value("message").StringValue)
		        Return False
		      End If

		    Else
		      ' Update existing indication
		      data.Value("id") = mCurrentIndication.ID
		      result = APIClient.Post("indications.lc", "update", data)

		      If result.Value("status") = "success" Then
		        ' Broadcast update event
		        PubSub.Broadcast(EventConstants.INDICATION_UPDATED, result.Value("data"))
		        If closeOnSuccess Then Self.Close()
		        Return True
		      Else
		        MessageBox("Failed to update indication: " + result.Value("message").StringValue)
		        Return False
		      End If
		    End If

		  Catch err As RuntimeException
		    MessageBox("Error saving indication: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetNavigationContext(indications() As Indication, currentIndex As Integer, parentListbox As DesktopListBox)
		  ' Set up navigation through a list of indications
		  mIndicationsList = indications
		  mCurrentIndex = currentIndex
		  mParentListbox = parentListbox
		  
		  ' Enable navigation buttons if we have a list
		  If mIndicationsList.Count > 0 Then
		    btnPreviousIndication.Enabled = True
		    btnNextIndication.Enabled = True
		  Else
		    btnPreviousIndication.Enabled = False
		    btnNextIndication.Enabled = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupFormAccess()
		  ' Enable/disable form controls based on authentication
		  Var isAuthenticated As Boolean = AuthManager.IsAuthenticated
		  
		  txtIndication.ReadOnly = Not isAuthenticated
		  txtKeywords.ReadOnly = Not isAuthenticated
		  txtComments.ReadOnly = Not isAuthenticated
		  
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
		Private Sub CaptureOriginalState()
		  '/// Captures the current form state as the original state for change detection

		  mOriginalTitle = txtIndication.Text
		  mOriginalKeywords = txtKeywords.Text
		  mOriginalComments = txtComments.Text
		  mOriginalSourceASE = chkSourceASE.Value
		  mOriginalSourceEACVI = chkSourceEACVI.Value
		  mOriginalSourceBSE = chkSourceBSE.Value
		  mOriginalSourceConsensus = chkSourceConsensus.Value
		  mOriginalPrimaryCare = popPrimaryCare.SelectedRowIndex
		  mOriginalSecondaryOP = popSecondaryOP.SelectedRowIndex
		  mOriginalSecondaryIP = popSecondaryIP.SelectedRowIndex
		  mOriginalUrgency = popUrgency.SelectedRowIndex

		  ' Capture selected context IDs
		  Redim mOriginalContextIDs(-1)
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		      mOriginalContextIDs.Add(lstContexts.RowTagAt(i))
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasUnsavedChanges() As Boolean
		  '/// Checks if the form has been modified from its original state
		  '///
		  '/// @returns True if there are unsaved changes, False otherwise

		  ' Check text fields
		  If txtIndication.Text <> mOriginalTitle Then Return True
		  If txtKeywords.Text <> mOriginalKeywords Then Return True
		  If txtComments.Text <> mOriginalComments Then Return True

		  ' Check checkboxes
		  If chkSourceASE.Value <> mOriginalSourceASE Then Return True
		  If chkSourceEACVI.Value <> mOriginalSourceEACVI Then Return True
		  If chkSourceBSE.Value <> mOriginalSourceBSE Then Return True
		  If chkSourceConsensus.Value <> mOriginalSourceConsensus Then Return True

		  ' Check popup menus
		  If popPrimaryCare.SelectedRowIndex <> mOriginalPrimaryCare Then Return True
		  If popSecondaryOP.SelectedRowIndex <> mOriginalSecondaryOP Then Return True
		  If popSecondaryIP.SelectedRowIndex <> mOriginalSecondaryIP Then Return True
		  If popUrgency.SelectedRowIndex <> mOriginalUrgency Then Return True

		  ' Check context IDs
		  Var currentContextIDs() As Integer
		  For i As Integer = 0 To lstContexts.LastRowIndex
		    If lstContexts.CellCheckBoxStateAt(i, 0) = DesktopCheckBox.VisualStates.Checked Then
		      currentContextIDs.Add(lstContexts.RowTagAt(i))
		    End If
		  Next

		  ' Compare context arrays
		  If currentContextIDs.Count <> mOriginalContextIDs.Count Then Return True

		  For Each id As Integer In currentContextIDs
		    If mOriginalContextIDs.IndexOf(id) < 0 Then Return True
		  Next

		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NavigateToIndication(newIndex As Integer)
		  '/// Navigates to an indication, prompting to save if there are unsaved changes
		  '///
		  '/// @param newIndex The index of the indication to navigate to

		  If mIndicationsList.Count = 0 Then Return

		  ' Check for unsaved changes
		  If HasUnsavedChanges() Then
		    Var d As New MessageDialog
		    d.Message = "Save changes before navigating?"
		    d.Explanation = "You have unsaved changes. Would you like to save them before continuing?"
		    d.ActionButton.Caption = "Save"
		    d.CancelButton.Visible = True
		    d.AlternateActionButton.Visible = True
		    d.AlternateActionButton.Caption = "Don't Save"

		    Var result As MessageDialogButton = d.ShowModal(Self)

		    If result = d.ActionButton Then
		      ' User chose to save - don't close dialog, just save
		      If Not SaveIndication(False) Then
		        ' Save failed, don't navigate
		        Return
		      End If
		      ' Save succeeded - refresh the current indication in the list with updated data
		      If mCurrentIndication <> Nil And mCurrentIndex >= 0 Then
		        Var refreshed As Indication = Indication.GetByID(mCurrentIndication.ID)
		        If refreshed <> Nil Then
		          mIndicationsList(mCurrentIndex) = refreshed
		        End If
		      End If

		    ElseIf result = d.CancelButton Then
		      ' User chose Cancel, don't navigate
		      Return

		    ' If AlternateActionButton (Don't Save), continue with navigation
		    End If
		  End If

		  ' Update the index
		  mCurrentIndex = newIndex

		  ' Load the indication at new index
		  LoadIndication(mIndicationsList(mCurrentIndex))
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentIndication As Indication
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndicationsList() As Indication
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsNewIndication As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalComments As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalContextIDs() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalKeywords As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalPrimaryCare As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSecondaryIP As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSecondaryOP As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSourceASE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSourceBSE As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSourceConsensus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalSourceEACVI As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalTitle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalUrgency As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParentListbox As DesktopListBox
	#tag EndProperty


#tag EndWindowCode

#tag Events btnNextIndication
	#tag Event
		Sub Pressed()
		  ' Navigate to next indication with wrapping
		  If mIndicationsList.Count = 0 Then Return
		  
		  ' Calculate next index with wrapping
		  Var newIndex As Integer = mCurrentIndex + 1
		  If newIndex >= mIndicationsList.Count Then
		    newIndex = 0  ' Wrap to beginning
		  End If
		  
		  ' Navigate with save prompt
		  NavigateToIndication(newIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnPreviousIndication
	#tag Event
		Sub Pressed()
		  ' Navigate to previous indication with wrapping
		  If mIndicationsList.Count = 0 Then Return
		  
		  ' Calculate previous index with wrapping
		  Var newIndex As Integer = mCurrentIndex - 1
		  If newIndex < 0 Then
		    newIndex = mIndicationsList.Count - 1  ' Wrap to end
		  End If
		  
		  ' Navigate with save prompt
		  NavigateToIndication(newIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnSave
	#tag Event
		Sub Pressed()
		  Call SaveIndication()
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
#tag Events lstContexts
	#tag Event
		Sub Opening()
		  me.ColumnTypeAt(0) = DesktopListBox.CellTypes.CheckBox
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
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasTitleBar"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
