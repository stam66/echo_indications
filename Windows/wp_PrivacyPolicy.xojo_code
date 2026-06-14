#tag WebPage
Begin WebPage wp_PrivacyPolicy
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   780
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
   Title           =   "Privacy policy"
   Top             =   0
   Visible         =   True
   Width           =   890
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin WebLabel lblBody
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   12.0
      Height          =   669
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   0
      TabStop         =   True
      Text            =   "ECHOindications – Privacy Policy\nLast updated: 26 May 2026\n\nECHOindications (""we"", ""us"", ""the app"") is a clinical reference tool listing Appropriate Use Criteria (AUC) for echocardiography. This policy describes what data we hold, how we use it, and how to ask for its removal.\n\n1. What we collect\n- Public use: nothing. You can browse indications, search, and use Decision Support without creating an account or providing any personal information. We do not use analytics, cookies, or third-party trackers.\n- Admin login: if you are an administrator and log in, we store your username, a salted PBKDF2 password hash, and a session token. The username and token are stored in your device's secure keychain. The password itself is never stored — only its irreversibly hashed form.\n- Feedback submissions: if you use the Submit Feedback feature and choose to provide a name or email address, that information is stored alongside your submission so we can follow up. You may leave the contact field blank to submit anonymously.\n\n2. How we use it\n- Login credentials authenticate administrative actions (creating, editing or deleting indications).\n- Session tokens keep you signed in across app restarts.\n- Feedback submissions are used to improve the reference content. We do not share submitter contact details with third parties.\n\n3. How long we keep it\n- Session tokens expire 30 days after issue.\n- Feedback submissions are retained indefinitely for audit purposes but contact details can be removed on request.\n- Admin accounts are retained for as long as the administrator remains active. Inactive accounts may be deactivated.\n\n4. Where it is stored\n- Data is held on a server hosted in the United Kingdom (DigitalOcean, London region) and protected by industry-standard transport encryption (HTTPS / TLS).\n- Backups are encrypted at rest.\n- On your device, authentication tokens are stored in the iOS Keychain, which is encrypted by the operating system.\n\n5. Sharing\n- We do not sell, rent, or share any user data with third parties.\n- Aggregated, anonymised usage statistics may be published for research or quality-improvement purposes but will never include identifying information.\n\n6. Your rights\nYou have the right to:\n- request a copy of any data we hold about you;\n- request correction or deletion of that data;\n- withdraw consent for ongoing storage of any feedback contact details you have provided.\n\nTo exercise any of these rights, email contact@heartimaging.org with the subject line ""ECHOindications data request"". We will respond within 30 days.\n\n7. Children\nThe app is intended for healthcare professionals. We do not knowingly collect data from children under 13.\n\n8. Changes to this policy\nWe may update this policy as the app evolves. The ""Last updated"" date at the top will reflect the most recent revision. Material changes will be communicated via the app's release notes.\n\n9. Contact\nStamatis Kapetanakis\nheartimaging.org\ncontact@heartimaging.org"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   91
      Underline       =   False
      Visible         =   True
      Width           =   839
      _mPanelIndex    =   -1
   End
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
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   890
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel lblDialogTitle
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   "Bricolage Grotesque"
         FontSize        =   24.0
         Height          =   38
         HTMLElement     =   0
         Index           =   -2147483648
         Indicator       =   0
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "Rectangle2"
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   -1
         TabStop         =   True
         Text            =   "Privacy policy for ECHOindications.org"
         TextAlignment   =   0
         TextColor       =   &cFAFAFA00
         Tooltip         =   ""
         Top             =   12
         Underline       =   False
         Visible         =   True
         Width           =   845
         _mPanelIndex    =   -1
      End
      Begin WebButton btnGoWebapp
         AllowAutoDisable=   False
         Cancel          =   False
         Caption         =   "Go to web app"
         ControlID       =   ""
         CSSClasses      =   ""
         Default         =   False
         Enabled         =   True
         Height          =   38
         Index           =   -2147483648
         Indicator       =   0
         Left            =   709
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         LockVertical    =   False
         Outlined        =   False
         PanelIndex      =   0
         Parent          =   "Rectangle2"
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   12
         Visible         =   True
         Width           =   156
         _mPanelIndex    =   -1
      End
   End
End
#tag EndWebPage

#tag WindowCode
#tag EndWindowCode

#tag Events btnGoWebapp
	#tag Event
		Sub Pressed()
		  session.NavigationManager.NavigateToPage(wp_LandingPage)
		End Sub
	#tag EndEvent
#tag EndEvents
