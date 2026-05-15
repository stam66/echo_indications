#tag WebPage
Begin WebDialog dlg_ChangeLogViewer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   642
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
   Width           =   698
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
      TabIndex        =   6
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   698
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
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "Rectangle2"
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   -1
         TabStop         =   True
         Text            =   "Change Log"
         TextAlignment   =   0
         TextColor       =   &cFAFAFA00
         Tooltip         =   ""
         Top             =   12
         Underline       =   False
         Visible         =   True
         Width           =   656
         _mPanelIndex    =   -1
      End
      Begin WebButton btnClose
         AllowAutoDisable=   False
         Cancel          =   True
         Caption         =   "Close"
         ControlID       =   ""
         CSSClasses      =   ""
         Default         =   False
         Enabled         =   True
         Height          =   38
         Index           =   -2147483648
         Indicator       =   7
         Left            =   578
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         LockVertical    =   False
         Outlined        =   True
         PanelIndex      =   0
         Parent          =   "Rectangle2"
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   12
         Visible         =   True
         Width           =   100
         _mPanelIndex    =   -1
      End
   End
   Begin WebHTMLViewer htmlChangeLogViewer
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   552
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   8
      TabStop         =   True
      Tooltip         =   ""
      Top             =   70
      UseSandbox      =   False
      Visible         =   True
      Width           =   658
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  htmlChangeLogViewer.LoadHTML("about:blank")
		  htmlChangeLogViewer.LoadHTML(BuildChangelogHTML)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BuildChangelogHTML() As String
		  // Markdown is rendered server-side via RenderMarkdown. No JS/CDN
		  // dependency — works behind any firewall or with ad-blockers active.
		  Var html As String = _
		  "<!doctype html><html><head><meta charset='utf-8'>" + _
		  "<style>" + _
		  "body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;padding:8px 12px;color:#222;}" + _
		  "article{margin:0 0 22px 0;padding:14px 16px;background:#f5f7fa;border-radius:8px;border-left:4px solid #006AB5;}" + _
		  "h3.entry-date{margin:0 0 8px 0;color:#006AB5;font-size:16px;}" + _
		  ".md-body p{margin:6px 0;}" + _
		  ".md-body ul,.md-body ol{margin:6px 0 6px 22px;padding:0;}" + _
		  ".md-body li{margin:2px 0;}" + _
		  ".md-body h1,.md-body h2,.md-body h3,.md-body h4{margin:10px 0 6px 0;}" + _
		  ".md-body code{background:#eef2f7;padding:1px 5px;border-radius:3px;font-family:ui-monospace,Menlo,Consolas,monospace;font-size:0.9em;}" + _
		  ".md-body pre{background:#eef2f7;padding:10px;border-radius:6px;overflow-x:auto;}" + _
		  ".md-body pre code{background:transparent;padding:0;}" + _
		  ".md-body a{color:#006AB5;}" + _
		  ".md-body blockquote{margin:6px 0;padding:4px 12px;border-left:3px solid #c0c0c0;color:#555;}" + _
		  "em.empty{color:#888;}" + _
		  "@media (prefers-color-scheme: dark){" + _
		  "  body{background:#1f1f1f;color:#eee;}" + _
		  "  article{background:#2a2a2a;border-left-color:#4aa3e0;}" + _
		  "  h3.entry-date{color:#4aa3e0;}" + _
		  "  .md-body code,.md-body pre{background:#3a3a3a;}" + _
		  "  .md-body a{color:#4aa3e0;}" + _
		  "  .md-body blockquote{border-left-color:#555;color:#bbb;}" + _
		  "}" + _
		  "</style></head><body>"
		  
		  Try
		    Var rs As RowSet = Session.DB.SelectSQL("SELECT id, entry_date, body FROM changelog ORDER BY entry_date DESC, id DESC")
		    Var any As Boolean = False
		    While Not rs.AfterLastRow
		      any = True
		      Var dt As DateTime = rs.Column("entry_date").DateTimeValue
		      Var body As String = If(rs.Column("body").Value = Nil, "", rs.Column("body").StringValue)
		      html = html + "<article><h3 class='entry-date'>" + _
		      EscapeHTML(dt.ToString(Locale.Current, DateTime.FormatStyles.Long, DateTime.FormatStyles.None)) + _
		      "</h3><div class='md-body'>" + RenderMarkdown(body) + "</div></article>"
		      rs.MoveToNextRow
		    Wend
		    If Not any Then
		      html = html + "<p><em class='empty'>No changelog entries yet.</em></p>"
		    End If
		  Catch err As DatabaseException
		    html = html + "<p><em>Error loading changelog: " + EscapeHTML(err.Message) + "</em></p>"
		  End Try
		  
		  html = html + "</body></html>"
		  Return html
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EscapeHTML(s As String) As String
		  Return s.ReplaceAll("&", "&amp;").ReplaceAll("<", "&lt;").ReplaceAll(">", "&gt;").ReplaceAll("""", "&quot;")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InlineFormat(s As String) As String
		  // Order matters: HTML-escape first, then inline replacements.
		  // Caveat: Markdown formatting inside `code` spans is NOT preserved
		  // (rare in changelog content; can be added with a placeholder pass
		  // if it ever bites).
		  s = s.ReplaceAll("&", "&amp;").ReplaceAll("<", "&lt;").ReplaceAll(">", "&gt;")
		  s = RxReplace(s, "`([^`]+)`", "<code>$1</code>")
		  s = RxReplace(s, "\*\*([^\*]+)\*\*", "<strong>$1</strong>")
		  s = RxReplace(s, "\*([^\*]+)\*", "<em>$1</em>")
		  s = RxReplace(s, "\[([^\]]+)\]\(([^\)]+)\)", "<a href=""$2"" target=""_blank"" rel=""noopener"">$1</a>")
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RenderMarkdown(md As String) As String
		  // Subset Markdown → HTML, sufficient for changelog entries.
		  // Handles: # ## ### #### #####, **bold**, *italic*, `code`,
		  // ``` code blocks ```, - / * unordered lists, 1. ordered lists,
		  // > blockquotes, --- horizontal rules, [text](url), paragraphs.
		  md = md.ReplaceLineEndings(Chr(10))
		  Var lines() As String = md.Split(Chr(10))
		  Var html As String
		  Var i As Integer = 0
		  
		  While i < lines.Count
		    Var line As String = lines(i)
		    
		    // Fenced code block
		    If line.BeginsWith("```") Then
		      i = i + 1
		      Var code As String
		      While i < lines.Count And Not lines(i).BeginsWith("```")
		        code = code + EscapeHTML(lines(i)) + Chr(10)
		        i = i + 1
		      Wend
		      html = html + "<pre><code>" + code + "</code></pre>"
		      If i < lines.Count Then i = i + 1   // skip closing ```
		      Continue
		    End If
		    
		    // Headings #..######
		    Var hashes As Integer = 0
		    While hashes < line.Length And line.Middle(hashes, 1) = "#"
		      hashes = hashes + 1
		    Wend
		    If hashes >= 1 And hashes <= 6 And line.Length > hashes And line.Middle(hashes, 1) = " " Then
		      Var text As String = line.Middle(hashes + 1).Trim
		      html = html + "<h" + hashes.ToString + ">" + InlineFormat(text) + "</h" + hashes.ToString + ">"
		      i = i + 1
		      Continue
		    End If
		    
		    // Horizontal rule
		    If line.Trim = "---" Or line.Trim = "***" Or line.Trim = "___" Then
		      html = html + "<hr>"
		      i = i + 1
		      Continue
		    End If
		    
		    // Blockquote
		    If line.BeginsWith(">") Then
		      Var quoted As String
		      While i < lines.Count And lines(i).BeginsWith(">")
		        Var t As String = lines(i)
		        // strip leading > and optional space
		        t = If(t.BeginsWith("> "), t.Middle(2), t.Middle(1))
		        quoted = quoted + " " + t
		        i = i + 1
		      Wend
		      html = html + "<blockquote><p>" + InlineFormat(quoted.Trim) + "</p></blockquote>"
		      Continue
		    End If
		    
		    // Unordered list
		    If line.BeginsWith("- ") Or line.BeginsWith("* ") Then
		      html = html + "<ul>"
		      While i < lines.Count And (lines(i).BeginsWith("- ") Or lines(i).BeginsWith("* "))
		        html = html + "<li>" + InlineFormat(lines(i).Middle(2).Trim) + "</li>"
		        i = i + 1
		      Wend
		      html = html + "</ul>"
		      Continue
		    End If
		    
		    // Ordered list (lines starting with "N. ")
		    Var rxOrdered As New RegEx
		    rxOrdered.SearchPattern = "^\d+\.\s"
		    If rxOrdered.Search(line) <> Nil Then
		      html = html + "<ol>"
		      While i < lines.Count And rxOrdered.Search(lines(i)) <> Nil
		        Var idx As Integer = lines(i).IndexOf(". ")
		        html = html + "<li>" + InlineFormat(lines(i).Middle(idx + 2).Trim) + "</li>"
		        i = i + 1
		      Wend
		      html = html + "</ol>"
		      Continue
		    End If
		    
		    // Blank line
		    If line.Trim = "" Then
		      i = i + 1
		      Continue
		    End If
		    
		    // Paragraph — collect until next blank line or block-starting line
		    Var para As String = line
		    i = i + 1
		    While i < lines.Count
		      Var nxt As String = lines(i)
		      If nxt.Trim = "" Then Exit
		      If nxt.BeginsWith("#") Or nxt.BeginsWith("- ") Or nxt.BeginsWith("* ") Or nxt.BeginsWith(">") Or nxt.BeginsWith("```") Then Exit
		      Var rxN As New RegEx
		      rxN.SearchPattern = "^\d+\.\s"
		      If rxN.Search(nxt) <> Nil Then Exit
		      para = para + " " + nxt
		      i = i + 1
		    Wend
		    html = html + "<p>" + InlineFormat(para) + "</p>"
		  Wend
		  
		  Return html
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RxReplace(haystack As String, pattern As String, replacement As String) As String
		  Var rx As New RegEx
		  rx.SearchPattern = pattern
		  rx.ReplacementPattern = replacement
		  rx.Options.ReplaceAllMatches = True
		  Return rx.Replace(haystack)
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events btnClose
	#tag Event
		Sub Pressed()
		  self.close
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
