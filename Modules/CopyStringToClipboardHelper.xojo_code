#tag Module
Protected Module CopyStringToClipboardHelper
	#tag Method, Flags = &h0
		Sub CopyTextDirectly(textValue As String, page As WebPage)
		  // Copy text directly without needing a button
		  Dim escaped As String = textValue
		  escaped = escaped.ReplaceAll("\", "\\")
		  escaped = escaped.ReplaceAll("'", "\'")
		  escaped = escaped.ReplaceAll(Chr(10), "\n")
		  escaped = escaped.ReplaceAll(Chr(13), "")
		  
		  Dim js As String
		  js = "var temp = document.createElement('textarea');" + _
		  "temp.value = '" + escaped + "';" + _
		  "temp.style.position = 'fixed';" + _
		  "temp.style.left = '-9999px';" + _
		  "document.body.appendChild(temp);" + _
		  "temp.focus();" + _
		  "temp.select();" + _
		  "document.execCommand('copy');" + _
		  "document.body.removeChild(temp);"
		  
		  page.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCopyText(btn As WebButton, textValue As String)
		  
		  Dim escaped As String = textValue
		  escaped = escaped.ReplaceAll("&", "&amp;")
		  escaped = escaped.ReplaceAll("""", "&quot;")
		  escaped = escaped.ReplaceAll("'", "&#39;")
		  escaped = escaped.ReplaceAll(Chr(10), "\n")
		  escaped = escaped.ReplaceAll(Chr(13), "")
		  
		  Dim js As String
		  js = "var btn = document.getElementById('" + btn.ControlID + "');" + _
		  "if (btn) btn.setAttribute('data-copy-text', '" + escaped + "');" + _
		  "window._xojoCopyMRN = '" + escaped + "';"
		  
		  btn.Page.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupCopyButton(btn As WebButton)
		  Dim js As String
		  js = "setTimeout(function() {" + _
		  "  var btn = document.getElementById('" + btn.ControlID + "');" + _
		  "  if (btn) {" + _
		  "    btn.onclick = function(e) {" + _
		  "      var text = this.getAttribute('data-copy-text');" + _
		  "      if (text) {" + _
		  "        var temp = document.createElement('textarea');" + _
		  "        temp.value = text;" + _
		  "        temp.style.position = 'fixed';" + _
		  "        temp.style.left = '-9999px';" + _
		  "        document.body.appendChild(temp);" + _
		  "        temp.focus();" + _
		  "        temp.select();" + _
		  "        document.execCommand('copy');" + _
		  "        document.body.removeChild(temp);" + _
		  "      }" + _
		  "    };" + _
		  "  }" + _
		  "}, 100);"
		  
		  btn.Page.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupCopyOnListBoxDoubleClick(listbox As WebListBox)
		  Var js As String
		  js = "setTimeout(function() {" + _
		  "  var container = document.getElementById('" + listbox.ControlID + "');" + _
		  "  if (container) {" + _
		  "    container.addEventListener('dblclick', function(e) {" + _
		  "      var textToCopy = this.getAttribute('data-copy-text');" + _
		  "      if (textToCopy) {" + _
		  "        var temp = document.createElement('textarea');" + _
		  "        temp.value = textToCopy;" + _
		  "        temp.style.position = 'fixed';" + _
		  "        temp.style.left = '-9999px';" + _
		  "        document.body.appendChild(temp);" + _
		  "        temp.focus();" + _
		  "        temp.select();" + _
		  "        document.execCommand('copy');" + _
		  "        document.body.removeChild(temp);" + _
		  "      }" + _
		  "    });" + _
		  "  }" + _
		  "}, 100);"
		  
		  listbox.Page.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupDeepLinkButton(btn As WebButton, flashCaption As String = "Link copied!", flashMs As Integer = 1500)
		  // Wire the button to copy `window.location.origin + "/?id=" + ID`
		  // at click time AND flash a "copied" caption afterwards — both inside
		  // the same in-gesture onclick handler. Doing the copy via Xojo's
		  // Pressed event won't work: navigator.clipboard.writeText requires
		  // a synchronous user gesture, which is lost on the server round-trip.
		  // The ID is stamped separately via SetDeepLinkID.
		  Dim esc As String = flashCaption.ReplaceAll("'", "\'")
		  Dim js As String
		  js = "setTimeout(function() {" + _
		  "  var btn = document.getElementById('" + btn.ControlID + "');" + _
		  "  if (!btn) return;" + _
		  "  function findText(el) {" + _
		  "    for (var i = 0; i < el.childNodes.length; i++) {" + _
		  "      var n = el.childNodes[i];" + _
		  "      if (n.nodeType === 3 && n.nodeValue.trim()) return n;" + _
		  "      if (n.nodeType === 1) { var f = findText(n); if (f) return f; }" + _
		  "    }" + _
		  "    return null;" + _
		  "  }" + _
		  "  btn.onclick = function(e) {" + _
		  "    var id = this.getAttribute('data-deeplink-id');" + _
		  "    if (!id || id === '0') return;" + _
		  "    var url = window.location.origin + '/?id=' + id;" + _
		  "    if (navigator.clipboard && navigator.clipboard.writeText) {" + _
		  "      navigator.clipboard.writeText(url).catch(function() {" + _
		  "        var t = document.createElement('textarea');" + _
		  "        t.value = url; t.style.position = 'fixed'; t.style.left = '-9999px';" + _
		  "        document.body.appendChild(t); t.focus(); t.select();" + _
		  "        document.execCommand('copy'); document.body.removeChild(t);" + _
		  "      });" + _
		  "    } else {" + _
		  "      var t = document.createElement('textarea');" + _
		  "      t.value = url; t.style.position = 'fixed'; t.style.left = '-9999px';" + _
		  "      document.body.appendChild(t); t.focus(); t.select();" + _
		  "      document.execCommand('copy'); document.body.removeChild(t);" + _
		  "    }" + _
		  "    var tn = findText(btn);" + _
		  "    if (tn) {" + _
		  "      if (tn._origText === undefined) tn._origText = tn.nodeValue;" + _
		  "      tn.nodeValue = '" + esc + "';" + _
		  "      if (btn._flashTimer) clearTimeout(btn._flashTimer);" + _
		  "      btn._flashTimer = setTimeout(function() {" + _
		  "        tn.nodeValue = tn._origText;" + _
		  "      }, " + flashMs.ToString + ");" + _
		  "    }" + _
		  "  };" + _
		  "}, 100);"

		  // Route via Session, not btn.Page — controls inside a WebDialog
		  // have a Nil .Page property, which crashes the dialog flow.
		  Session.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDeepLinkID(btn As WebButton, indicationID As Integer)
		  // Stamp the ID on the button as a data attribute. The onclick
		  // handler installed by SetupDeepLinkButton reads this at click time
		  // and builds the full URL from window.location.origin.
		  Dim js As String
		  js = "var btn = document.getElementById('" + btn.ControlID + "');" + _
		  "if (btn) btn.setAttribute('data-deeplink-id', '" + indicationID.ToString + "');"
		  Session.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupListBoxDblClickCopy(lb As WebListBox, copyBtn As WebButton)
		  // Use document-level capture-phase listener so it fires even if
		  // Xojo's framework stops dblclick propagation on the listbox.
		  // Read MRN from global window._xojoCopyMRN (set by SetCopyText
		  // during SelectionChanged), falling back to the button's data attribute.
		  Dim lbId As String = lb.ControlID
		  Dim btnId As String = copyBtn.ControlID
		  
		  Dim js As String
		  js = "setTimeout(function() {" + _
		  "  function doCopy(text) {" + _
		  "    if (navigator.clipboard && navigator.clipboard.writeText) {" + _
		  "      navigator.clipboard.writeText(text).catch(function() {" + _
		  "        var t = document.createElement('textarea');" + _
		  "        t.value = text; t.style.position = 'fixed'; t.style.left = '-9999px';" + _
		  "        document.body.appendChild(t); t.focus(); t.select();" + _
		  "        document.execCommand('copy'); document.body.removeChild(t);" + _
		  "      });" + _
		  "    } else {" + _
		  "      var t = document.createElement('textarea');" + _
		  "      t.value = text; t.style.position = 'fixed'; t.style.left = '-9999px';" + _
		  "      document.body.appendChild(t); t.focus(); t.select();" + _
		  "      document.execCommand('copy'); document.body.removeChild(t);" + _
		  "    }" + _
		  "  }" + _
		  "  document.addEventListener('dblclick', function(e) {" + _
		  "    var lb = document.getElementById('" + lbId + "');" + _
		  "    if (lb && (lb === e.target || lb.contains(e.target))) {" + _
		  "      var text = window._xojoCopyMRN || '';" + _
		  "      if (!text) {" + _
		  "        var btn = document.getElementById('" + btnId + "');" + _
		  "        if (btn) text = btn.getAttribute('data-copy-text') || '';" + _
		  "      }" + _
		  "      if (text) doCopy(text);" + _
		  "    }" + _
		  "  }, true);" + _
		  "}, 300);"
		  
		  lb.Page.ExecuteJavaScript(js)
		End Sub
	#tag EndMethod


	#tag Note, Name = Usage for button
		
		// In WebPage.Shown()
		CopyStringToClipboardHelper.SetupCopyButton(btnCopy)
		
		// Anywhere in code you want to set the text to copy
		CopyStringToClipboardHelper.SetCopyText(btnCopy, "String to copy")
		
		both can be in page.shown event to copy existing text, or set up the SetCopyText  when text is generated.
	#tag EndNote


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
	#tag EndViewBehavior
End Module
#tag EndModule
