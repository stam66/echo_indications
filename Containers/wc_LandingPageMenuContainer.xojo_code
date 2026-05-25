#tag WebContainerControl
Begin WebContainer wc_LandingPageMenuContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   663
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   PanelIndex      =   0
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   740
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebRectangle rectBrowse
      BorderColor     =   &c000000FF
      BorderThickness =   1
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   8
      CSSClasses      =   "clickable-card"
      Enabled         =   True
      FillColor       =   &cFFFFFF
      HasFillColor    =   False
      Height          =   131
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   70
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   11
      TabStop         =   True
      Tooltip         =   ""
      Top             =   471
      Visible         =   True
      Width           =   269
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel zLabel
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   0.0
         Height          =   38
         HTMLElement     =   0
         Index           =   0
         Indicator       =   ""
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "rectBrowse"
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Browse All Indications"
         TextAlignment   =   0
         TextColor       =   &c006AB500
         Tooltip         =   ""
         Top             =   477
         Underline       =   False
         Visible         =   True
         Width           =   202
         _mPanelIndex    =   -1
      End
      Begin WebLabel zLabel
         Bold            =   False
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   12.0
         Height          =   28
         HTMLElement     =   0
         Index           =   1
         Indicator       =   ""
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   True
         PanelIndex      =   0
         Parent          =   "rectBrowse"
         Scope           =   0
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Browse All Indications by search criteria or context."
         TextAlignment   =   0
         TextColor       =   &c000000FF
         Tooltip         =   ""
         Top             =   523
         Underline       =   False
         Visible         =   True
         Width           =   194
         _mPanelIndex    =   -1
      End
      Begin WebImageViewer imgChecklist
         ControlID       =   ""
         CSSClasses      =   ""
         DisplayMode     =   3
         Enabled         =   True
         Height          =   32
         Image           =   0
         Index           =   -2147483648
         Indicator       =   ""
         Left            =   85
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "rectBrowse"
         Scope           =   0
         SVGData         =   ""
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   480
         URL             =   "https://api.iconify.design/material-symbols/checklist.svg?color=%23006AB5&height=32"
         Visible         =   True
         Width           =   32
         _mPanelIndex    =   -1
         _ProtectImage   =   False
      End
      Begin WebLabel lblViewIndications
         Bold            =   False
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   14.0
         Height          =   28
         HTMLElement     =   0
         Index           =   -2147483648
         Indicator       =   ""
         Italic          =   False
         Left            =   125
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "rectBrowse"
         Scope           =   0
         TabIndex        =   19
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "View library →"
         TextAlignment   =   0
         TextColor       =   &c006AB500
         Tooltip         =   ""
         Top             =   559
         Underline       =   False
         Visible         =   True
         Width           =   126
         _mPanelIndex    =   -1
      End
      Begin WebButton btnViewLibrary
         AllowAutoDisable=   False
         Cancel          =   False
         Caption         =   ""
         ControlID       =   ""
         CSSClasses      =   ""
         Default         =   False
         Enabled         =   True
         Height          =   120
         Index           =   -2147483648
         Indicator       =   9
         Left            =   74
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Outlined        =   False
         PanelIndex      =   0
         Parent          =   "rectBrowse"
         Scope           =   0
         TabIndex        =   20
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   476
         Visible         =   True
         Width           =   260
         _mPanelIndex    =   -1
      End
   End
   Begin WebButton btnSearch
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Search"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   570
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Parent          =   "Rectangle1"
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   335
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebSearchField txtSearch
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   46
      Hint            =   "e.g. dyspnoea, palpitations, syncope"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   70
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Parent          =   "Rectangle1"
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   335
      Visible         =   True
      Width           =   484
      _mPanelIndex    =   -1
   End
   Begin WebRectangle rect_guidance
      BorderColor     =   &c000000FF
      BorderThickness =   1
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   10
      CSSClasses      =   ""
      Enabled         =   True
      FillColor       =   &cE0E6FD00
      HasFillColor    =   True
      Height          =   25
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   239
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   12
      Visible         =   True
      Width           =   261
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel Label1
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   12.0
         Height          =   18
         HTMLElement     =   0
         Index           =   -2147483648
         Indicator       =   ""
         InitialParent   =   "rect_guidance"
         Italic          =   False
         Left            =   271
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "rect_guidance"
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Clinical reference - evidence-based"
         TextAlignment   =   0
         TextColor       =   &c006AB500
         Tooltip         =   ""
         Top             =   15
         Underline       =   False
         Visible         =   True
         Width           =   224
         _mPanelIndex    =   -1
      End
      Begin WebImageViewer ImageViewer1
         ControlID       =   ""
         CSSClasses      =   ""
         DisplayMode     =   3
         Enabled         =   True
         Height          =   20
         Image           =   0
         Index           =   -2147483648
         Indicator       =   ""
         InitialParent   =   "rect_guidance"
         Left            =   247
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "rect_guidance"
         Scope           =   0
         SVGData         =   ""
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   14
         URL             =   "https://api.iconify.design/material-symbols/verified-user-outline.svg?color=%23006AB5&height=16"
         Visible         =   True
         Width           =   20
         _mPanelIndex    =   -1
         _ProtectImage   =   False
      End
   End
   Begin WebLabel lblTitle
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   "Bricolage Grotesque"
      FontSize        =   54.0
      Height          =   68
      HTMLElement     =   0
      Index           =   1
      Indicator       =   ""
      Italic          =   False
      Left            =   187
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   4
      TabStop         =   True
      Text            =   "appropriate"
      TextAlignment   =   0
      TextColor       =   &c006AB500
      Tooltip         =   ""
      Top             =   117
      Underline       =   False
      Visible         =   True
      Width           =   322
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblTitle
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   "Bricolage Grotesque"
      FontSize        =   54.0
      Height          =   68
      HTMLElement     =   0
      Index           =   0
      Indicator       =   ""
      Italic          =   False
      Left            =   77
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   5
      TabStop         =   True
      Text            =   "Is echocardiography"
      TextAlignment   =   2
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   61
      Underline       =   False
      Visible         =   True
      Width           =   585
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblTitle
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   "Bricolage Grotesque"
      FontSize        =   54.0
      Height          =   68
      HTMLElement     =   0
      Index           =   2
      Indicator       =   ""
      Italic          =   False
      Left            =   506
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   6
      TabStop         =   True
      Text            =   "?"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   117
      Underline       =   False
      Visible         =   True
      Width           =   31
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblTagLine
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   "bricolage grotesque"
      FontSize        =   0.0
      Height          =   46
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   107
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   7
      TabStop         =   True
      Text            =   "Search 290+ clinical presentations, stratified by care setting, graded against ASE, EACVI, BSE and BHVS guidance."
      TextAlignment   =   2
      TextColor       =   &c92929200
      Tooltip         =   ""
      Top             =   193
      Underline       =   False
      Visible         =   True
      Width           =   527
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblStats
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   205
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Database statistics"
      TextAlignment   =   2
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   372
      Underline       =   False
      Visible         =   True
      Width           =   331
      _mPanelIndex    =   -1
   End
   Begin WebRectangle rectCDS
      BorderColor     =   &c000000FF
      BorderThickness =   1
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   8
      CSSClasses      =   "clickable-card"
      Enabled         =   True
      FillColor       =   &cFFFFFF
      HasFillColor    =   False
      Height          =   131
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   401
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   15
      TabStop         =   True
      Tooltip         =   ""
      Top             =   471
      Visible         =   True
      Width           =   269
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel zLabel
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   0.0
         Height          =   38
         HTMLElement     =   0
         Index           =   2
         Indicator       =   ""
         InitialParent   =   "rectCDS"
         Italic          =   False
         Left            =   456
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "rectCDS"
         Scope           =   0
         TabIndex        =   16
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Clinical Decision Support"
         TextAlignment   =   0
         TextColor       =   &c006AB500
         Tooltip         =   ""
         Top             =   477
         Underline       =   False
         Visible         =   True
         Width           =   207
         _mPanelIndex    =   -1
      End
      Begin WebLabel zLabel
         Bold            =   False
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   12.0
         Height          =   28
         HTMLElement     =   0
         Index           =   3
         Indicator       =   ""
         InitialParent   =   "rectCDS"
         Italic          =   False
         Left            =   456
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   True
         PanelIndex      =   0
         Parent          =   "rectCDS"
         Scope           =   0
         TabIndex        =   17
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Step through a guided tree to reach the right indication."
         TextAlignment   =   0
         TextColor       =   &c000000FF
         Tooltip         =   ""
         Top             =   523
         Underline       =   False
         Visible         =   True
         Width           =   194
         _mPanelIndex    =   -1
      End
      Begin WebImageViewer imgStethoscope
         ControlID       =   ""
         CSSClasses      =   ""
         DisplayMode     =   3
         Enabled         =   True
         Height          =   32
         Image           =   0
         Index           =   -2147483648
         Indicator       =   ""
         InitialParent   =   "rectCDS"
         Left            =   417
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "rectCDS"
         Scope           =   0
         SVGData         =   ""
         TabIndex        =   18
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   482
         URL             =   "https://api.iconify.design/material-symbols/stethoscope.svg?color=%23006AB5&height=32"
         Visible         =   True
         Width           =   32
         _mPanelIndex    =   -1
         _ProtectImage   =   False
      End
      Begin WebLabel lblStartCDS
         Bold            =   False
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   14.0
         Height          =   28
         HTMLElement     =   0
         Index           =   -2147483648
         Indicator       =   ""
         InitialParent   =   "rectCDS"
         Italic          =   False
         Left            =   457
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "rectCDS"
         Scope           =   0
         TabIndex        =   20
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Start CDS →"
         TextAlignment   =   0
         TextColor       =   &c006AB500
         Tooltip         =   ""
         Top             =   559
         Underline       =   False
         Visible         =   True
         Width           =   126
         _mPanelIndex    =   -1
      End
      Begin WebButton btnStartCDS
         AllowAutoDisable=   False
         Cancel          =   False
         Caption         =   ""
         ControlID       =   ""
         CSSClasses      =   ""
         Default         =   False
         Enabled         =   True
         Height          =   120
         Index           =   -2147483648
         Indicator       =   9
         InitialParent   =   "rectCDS"
         Left            =   405
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Outlined        =   False
         PanelIndex      =   0
         Parent          =   "rectCDS"
         Scope           =   0
         TabIndex        =   21
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   476
         Visible         =   True
         Width           =   260
         _mPanelIndex    =   -1
      End
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Shown()
		  UpdateStats
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub DoSearch()
		  // The query is passed via Session, not a wp_indications property:
		  // wp_indications is an implicit-instance page, so a value set on a
		  // New instance is lost when the framework shows its own instance.
		  Var q As String = txtSearch.Text.Trim
		  If q = "" Then Return
		  
		  // Clear the field so returning here via Back doesn't show a stale query.
		  txtSearch.Text = ""
		  
		  Session.PendingSearch = q
		  Var w As New wp_indications
		  Session.NavigationManager.NavigateToPage(w)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateStats()
		  // Live counts for the landing-page summary line.
		  // Only counts active contexts (matching what the user can actually filter by).
		  Try
		    Var rs As RowSet = Session.DB.SelectSQL( _
		    "SELECT (SELECT COUNT(*) FROM indications) AS ind_count, " + _
		    "(SELECT COUNT(*) FROM contexts WHERE is_active = 1) AS ctx_count")
		    
		    If Not rs.AfterLastRow Then
		      Var indCount As Integer = rs.Column("ind_count").IntegerValue
		      Var ctxCount As Integer = rs.Column("ctx_count").IntegerValue
		      Var indWord As String = If(indCount = 1, "indication", "indications")
		      Var ctxWord As String = If(ctxCount = 1, "context", "contexts")
		      lblStats.Text = indCount.ToString + " " + indWord + " across " + ctxCount.ToString + " " + ctxWord
		    Else
		      lblStats.Text = ""
		    End If
		    
		  Catch err As DatabaseException
		    System.DebugLog("UpdateStats Error: " + err.Message)
		    lblStats.Text = ""
		  End Try
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events lblViewIndications
	#tag Event
		Sub Pressed()
		  ' var w as new wp_indications
		  ' Session.NavigationManager.NavigateToPage(w)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnViewLibrary
	#tag Event
		Sub Pressed()
		  var w as new wp_indications
		  Session.NavigationManager.NavigateToPage(w)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnSearch
	#tag Event
		Sub Pressed()
		  DoSearch
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lblStartCDS
	#tag Event
		Sub Pressed()
		  ' var dlg as new dlg_cds
		  ' dlg.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnStartCDS
	#tag Event
		Sub Pressed()
		  var dlg as new dlg_cds
		  dlg.Show
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
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
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
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
		Name="Visible"
		Visible=true
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
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
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
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
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
		Name="Width"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
