#tag WebContainerControl
Begin WebContainer wc_MainMenu
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   363
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
   Width           =   879
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebButton btnIndications
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "View Appropriate Use Criteria"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   58
      Index           =   -2147483648
      Indicator       =   1
      Left            =   536
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   343
      _mPanelIndex    =   -1
   End
   Begin WebButton btnIssues
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Issues"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   58
      Index           =   -2147483648
      Indicator       =   0
      Left            =   536
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   303
      Visible         =   True
      Width           =   343
      _mPanelIndex    =   -1
   End
   Begin WebButton btnRequestChange
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Request Changes"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   58
      Index           =   -2147483648
      Indicator       =   0
      Left            =   536
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   6
      TabStop         =   True
      Tooltip         =   ""
      Top             =   202
      Visible         =   True
      Width           =   343
      _mPanelIndex    =   -1
   End
   Begin WebButton btnLogin
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Admin login"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   58
      Index           =   -2147483648
      Indicator       =   0
      Left            =   536
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   7
      TabStop         =   True
      Tooltip         =   ""
      Top             =   101
      Visible         =   True
      Width           =   343
      _mPanelIndex    =   -1
   End
   Begin WebHTMLViewer html_InfoText
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   363
      Index           =   -2147483648
      Indicator       =   0
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   8
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      UseSandbox      =   False
      Visible         =   True
      Width           =   387
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Shown()
		  UpdateIssuesBadge
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub UpdateIssuesBadge()
		  Try
		    Var sql As String = "SELECT COUNT(*) as count FROM changes WHERE changes_status = 'New' OR changes_status = 'In Progress'"
		    Var rs As RowSet = Session.DB.SelectSQL(sql)
		    
		    If Not rs.AfterLastRow Then
		      Var count As Integer = rs.Column("count").IntegerValue
		      If count > 0 Then
		        btnIssues.SetBadge(count.ToString)
		      Else
		        btnIssues.RemoveBadge // REMOVE badge when count is 0
		      End If
		    End If
		    
		  Catch err As DatabaseException
		    System.DebugLog("UpdateIssuesBadge Error: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events btnIndications
	#tag Event
		Sub Pressed()
		  var w as new wp_indications
		  Session.NavigationManager.NavigateToPage(w)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  var tStyle as new WebStyle
		  tStyle.Bold  = true
		  me.Style = tStyle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnIssues
	#tag Event
		Sub Pressed()
		  var w as new wp_issues
		  session.NavigationManager.NavigateToPage(w)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Shown()
		  UpdateIssuesBadge
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnRequestChange
	#tag Event
		Sub Pressed()
		  var dlg as new dlg_ChangeRequest
		  Session.NavigationManager.NavigateToPage(dlg)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnLogin
	#tag Event
		Sub Pressed()
		  var dlg as new dlg_Login
		  Session.NavigationManager.NavigateToPage(dlg)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events html_InfoText
	#tag Event
		Sub Opening()
		  Var html As String = "<html><head><style>" + _
		  "body { margin: 0; padding: 10px; font-family: Arial, sans-serif; font-size: 16px; line-height: 1.4; }" + _
		  "</style></head><body>" + _
		  "<div style='font-size: 28px; font-weight: bold;'>ECHOindications web app</div>" + _
		  "<div style='font-style: italic; font-size: 14px; margin-bottom: 25px;'>Version 1.5</div>" + _
		  "<div style='margin-bottom: 15px;'>Appropriate Use Criteria for Echocardiography drawn from national and international guidelines and consensus across trusts in SE London.</div>" + _
		  "<div style='font-weight: bold; margin-bottom: 5px;'>Appropriate Use Criteria</div>" + _
		  "<div>• Indications for echocardiography grouped by context, with appropriate use criteria for primary care, outpatient and inpatient secondary care, and appropriate priority/urgency.</div>" + _
		  "<div>• Fuzzy search, context filtering</div>" + _
		  "<div>• Double-click to view all details.</div>" + _
		  "<div style='margin-bottom: 15px;'>• Right-click to request changes for an indication.</div>" + _
		  "</body></html>"
		  
		  me.LoadHTML(html)
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
