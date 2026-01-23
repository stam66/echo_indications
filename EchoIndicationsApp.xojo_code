#tag Class
Protected Class EchoIndicationsApp
Inherits WebApplication
	#tag Event
		Sub Opening(args() As String)
		  #Pragma Unused args
		  
		  ' Semaphore is used to ensure that only one session at a time tries
		  ' to send an email. Constructor defaults to count 1 (one resource available).
		  MailSemaphore = New Semaphore ' Mail Semaphore is a Property: MailSemaphore As Semaphore
		  
		  ' Global socket for sending emails
		  MailSocket = New SMTPSecureSocket ' MailSocket is a Property: MailSocket As SMTPSecureSocket
		  
		  ' Map the socket's error events to methods on the App object
		  AddHandler MailSocket.MailSent, AddressOf MailSentHandler
		  AddHandler MailSocket.ServerError, AddressOf MailServerErrorHandler
		  
		  
		  ' // populate users
		  ' all_users = users.GetInstance
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function AdjustColorBrightness(originalColor As Color, factor As Double) As Color
		  // Adjust brightness while preserving color identity
		  // factor > 1.0 makes brighter, < 1.0 makes darker, 1.0 = no change
		  
		  Var r As Integer = Min(255, originalColor.Red * factor)
		  Var g As Integer = Min(255, originalColor.Green * factor)
		  Var b As Integer = Min(255, originalColor.Blue * factor)
		  
		  Return Color.RGB(r, g, b)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetContrastingTextColor(backgroundColor As Color) As Color
		  // Get black or white text color based on background brightness
		  // Threshold of 128 is midpoint - below is dark, above is light
		  
		  Var luminance As Double = GetLuminance(backgroundColor)
		  
		  If luminance < 128 Then
		    // Dark background - use white text
		    Return Color.White
		  Else
		    // Light background - use black text
		    Return Color.Black
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetLuminance(backgroundColor As Color) As Double
		  // Calculate perceived brightness (luminance) of a color
		  // Returns value between 0 (black) and 255 (white)
		  // Uses YIQ formula: (R*299 + G*587 + B*114) / 1000
		  
		  Var r As Double = backgroundColor.Red
		  Var g As Double = backgroundColor.Green
		  Var b As Double = backgroundColor.Blue
		  
		  // YIQ formula weights green most heavily (human eye most sensitive to green)
		  Var luminance As Double = (r * 0.299) + (g * 0.587) + (b * 0.114)
		  
		  Return luminance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetReadableColorForBackground(textColor As Color, backgroundColor As Color, preserveHue As Boolean = True) As Color
		  Var bgLuminance As Double = GetLuminance(backgroundColor)
		  
		  // If not preserving hue, just return simple black or white
		  If Not preserveHue Then
		    Return GetContrastingTextColor(backgroundColor)
		  End If
		  
		  // Otherwise, preserve semantic meaning while ensuring readability
		  Var textLuminance As Double = GetLuminance(textColor)
		  
		  // Special case: if text is near-black on dark background, use white
		  If bgLuminance < 128 And textLuminance < 50 Then
		    Return Color.White
		  End If
		  
		  // Special case: if text is near-white on light background, use black
		  If bgLuminance >= 128 And textLuminance > 200 Then
		    Return Color.Black
		  End If
		  
		  // Minimum contrast needed for readability
		  Var contrastNeeded As Double = 128
		  
		  If bgLuminance < 128 Then
		    // Dark background - brighten text if needed
		    If textLuminance < bgLuminance + contrastNeeded Then
		      // Calculate brightness factor
		      Var factor As Double = (bgLuminance + contrastNeeded) / Max(textLuminance, 1)
		      factor = Min(factor, 3.0) // Cap at 3x
		      
		      // Apply brightness adjustment
		      Var r As Integer = Min(255, textColor.Red * factor)
		      Var g As Integer = Min(255, textColor.Green * factor)
		      Var b As Integer = Min(255, textColor.Blue * factor)
		      
		      Return Color.RGB(r, g, b)
		    Else
		      Return textColor
		    End If
		  Else
		    // Light background - darken text if needed
		    If textLuminance > bgLuminance - contrastNeeded Then
		      // Calculate darkness factor
		      Var factor As Double = (bgLuminance - contrastNeeded) / Max(textLuminance, 1)
		      factor = Max(factor, 0.3) // Don't go below 30%
		      
		      // Apply darkness adjustment
		      Var r As Integer = Max(0, textColor.Red * factor)
		      Var g As Integer = Max(0, textColor.Green * factor)
		      Var b As Integer = Max(0, textColor.Blue * factor)
		      
		      Return Color.RGB(r, g, b)
		    Else
		      Return textColor
		    End If
		  End If
		  
		  
		  ' // Returns a readable version of textColor on backgroundColor
		  ' // If preserveHue is True, adjusts brightness while keeping hue
		  ' // If preserveHue is False, returns simple black/white contrast
		  ' 
		  ' If Not preserveHue Then
		  ' Return GetContrastingTextColor(backgroundColor)
		  ' End If
		  ' 
		  ' // Calculate background luminance
		  ' Var bgLuminance As Double = GetLuminance(backgroundColor)
		  ' 
		  ' // Calculate text luminance
		  ' Var textLuminance As Double = GetLuminance(textColor)
		  ' 
		  ' // Determine if we need to lighten or darken
		  ' Var contrastNeeded As Double = 128 // Minimum luminance difference needed
		  ' 
		  ' If bgLuminance < 128 Then
		  ' // Dark background - need lighter text
		  ' If textLuminance < bgLuminance + contrastNeeded Then
		  ' // Text is too dark for dark background - brighten it
		  ' Var factor As Double = (bgLuminance + contrastNeeded) / textLuminance
		  ' factor = Min(factor, 3.0) // Cap at 3x to avoid over-brightening
		  ' Return AdjustColorBrightness(textColor, factor)
		  ' Else
		  ' // Text is already light enough
		  ' Return textColor
		  ' End If
		  ' Else
		  ' // Light background - need darker text
		  ' If textLuminance > bgLuminance - contrastNeeded Then
		  ' // Text is too light for light background - darken it
		  ' Var factor As Double = (bgLuminance - contrastNeeded) / textLuminance
		  ' factor = Max(factor, 0.3) // Don't go below 30% brightness
		  ' Return AdjustColorBrightness(textColor, factor)
		  ' Else
		  ' // Text is already dark enough
		  ' Return textColor
		  ' End If
		  ' End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetStyleForBackground(textColor As Color, backgroundColor As Color, preserveSemantics As Boolean = True, makeItalic As Boolean = False, makeBold As Boolean = False) As WebStyle
		  // Create a complete WebStyle with readable colors
		  Var style As New WebStyle
		  
		  // Set foreground color
		  If preserveSemantics Then
		    style.ForegroundColor = GetReadableColorForBackground(textColor, backgroundColor, True)
		  Else
		    style.ForegroundColor = GetContrastingTextColor(backgroundColor)
		  End If
		  
		  // Apply optional styling
		  style.Italic = makeItalic
		  style.Bold = makeBold
		  
		  Return style
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hashPassword(password as string) As string
		  var ps as MySQLPreparedStatement = session.db.Prepare("SELECT SHA2(?, 256) AS password_hash")
		  ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ps.Bind(0, password)
		  var rs as RowSet = ps.SelectSQL
		  return rs.Column("password_hash").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidEmail(email as string) As Boolean
		  var regex as new RegEx
		  regex.SearchPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
		  return regex.Search(email) <> nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevenshteinDistance(s1 As String, s2 As String) As Integer
		  Var len1 As Integer = s1.Length
		  Var len2 As Integer = s2.Length
		  
		  If len1 = 0 Then Return len2
		  If len2 = 0 Then Return len1
		  
		  // Create matrix using 1D array to simulate 2D
		  Var matrix() As Integer
		  matrix.ResizeTo((len1 + 1) * (len2 + 1) - 1)
		  
		  // Initialize first column and row
		  For i As Integer = 0 To len1
		    matrix(i * (len2 + 1)) = i
		  Next
		  
		  For j As Integer = 0 To len2
		    matrix(j) = j
		  Next
		  
		  // Calculate distances
		  For i As Integer = 1 To len1
		    For j As Integer = 1 To len2
		      Var cost As Integer
		      If s1.Middle(i - 1, 1) = s2.Middle(j - 1, 1) Then
		        cost = 0
		      Else
		        cost = 1
		      End If
		      
		      Var idx As Integer = i * (len2 + 1) + j
		      Var deletion As Integer = matrix((i - 1) * (len2 + 1) + j) + 1
		      Var insertion As Integer = matrix(i * (len2 + 1) + (j - 1)) + 1
		      Var substitution As Integer = matrix((i - 1) * (len2 + 1) + (j - 1)) + cost
		      
		      matrix(idx) = Min(Min(deletion, insertion), substitution)
		    Next
		  Next
		  
		  Return matrix(len1 * (len2 + 1) + len2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MailSentHandler(m As SMTPSecureSocket)
		  #Pragma Unused m
		  
		  #If TargetWeb Then
		    ' Log to all active sessions
		    For Each sess As WebSession In App.Sessions
		      If sess <> Nil Then
		        sess.ExecuteJavaScript("console.log('Email sent successfully, releasing semaphore');")
		      End If
		    Next
		  #EndIf
		  
		  MailSemaphore.Release ' Release the Semaphore to make the socket available for use
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MailServerErrorHandler(m As SMTPSecureSocket, errorID As Integer, errorMessage As String, email As EmailMessage)
		  #Pragma Unused m
		  #Pragma Unused email
		  
		  #If TargetWeb Then
		    ' Log to all active sessions
		    For Each sess As WebSession In App.Sessions
		      If sess <> Nil Then
		        sess.ExecuteJavaScript("console.error('Email error (ID: " + errorID.ToString + "): " + errorMessage.ReplaceAll("'", "\\'") + "');")
		        sess.ExecuteJavaScript("console.log('Releasing semaphore after error');")
		      End If
		    Next
		  #EndIf
		  
		  MailSemaphore.Release ' Release the Semaphore to make the socket available for use
		  MessageBox(errorMessage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RandomString(randomLength as Integer) As string
		  var s as string
		  var chars() as string = split("abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789%^!$*", "")
		  var numChars as integer = chars.Count -1
		  
		  
		  for i as integer = 1 to randomLength
		    var element as integer = System.Random.InRange(0, numChars)
		    s = s + chars(element)
		  next
		  
		  return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendMail(toAddress As String, subject As String, message As String, webSession As WebSession = Nil)
		  
		  ' Try to acquire the semaphore (non-blocking)
		  ' If we can't acquire it, another email is being sent - wait briefly and retry
		  Var retryCount As Integer = 0
		  Var maxRetries As Integer = 30  ' Wait up to ~30 seconds
		  
		  While Not MailSemaphore.TrySignal And retryCount < maxRetries
		    retryCount = retryCount + 1
		    
		    #If TargetWeb Then
		      If webSession <> Nil Then
		        webSession.ExecuteJavaScript("console.log('Waiting for email semaphore... attempt " + retryCount.ToString + "');")
		      End If
		    #EndIf
		    
		    ' Wait 1 second before retry
		    Var deadline As Double = System.Microseconds + 1000000
		    While System.Microseconds < deadline
		      ' Busy wait
		    Wend
		  Wend
		  
		  If retryCount >= maxRetries Then
		    ' Failed to acquire semaphore - another email is stuck
		    #If TargetWeb Then
		      If webSession <> Nil Then
		        webSession.ExecuteJavaScript("console.error('Failed to acquire email semaphore after " + maxRetries.ToString + " attempts. Forcing release.');")
		      End If
		    #EndIf
		    
		    ' Force release the stuck semaphore and try one more time
		    Try
		      MailSemaphore.Release
		    Catch e As RuntimeException
		      ' Ignore if already released
		    End Try
		    
		    If Not MailSemaphore.TrySignal Then
		      ' Still can't acquire - give up
		      MessageBox("Email system is busy. Please try again in a moment.")
		      Return
		    End If
		  End If
		  
		  #If TargetWeb Then
		    If webSession <> Nil Then
		      webSession.ExecuteJavaScript("console.log('Sending email via MailJet API to: " + toAddress + "');")
		    End If
		  #EndIf
		  
		  ' Send email via MailJet API v3.1
		  ' IMPORTANT: Replace these with your actual MailJet API credentials
		  Var apiKey As String = "aeb158a2ac1a32e526b124a2cb7aa3a7"
		  Var apiSecret As String = "384238973b036e63d5240aa0a3cfa65a"
		  
		  ' Build JSON payload for MailJet API v3.1
		  Var json As String = "{" + _
		  """Messages"": [{" + _
		  """From"": {" + _
		  """Email"": ""aucecho@gmail.com""," + _
		  """Name"": ""ECHOAUC""" + _
		  "}," + _
		  """To"": [{" + _
		  """Email"": """ + toAddress + """" + _
		  "}]," + _
		  """Subject"": """ + subject.ReplaceAll("""", "\""") + """," + _
		  """TextPart"": """ + message.ReplaceAll("""", "\""").ReplaceAll(EndOfLine, "\n") + """" + _
		  "}]}"
		  
		  ' Create URLConnection for synchronous HTTP request
		  Var socket As New URLConnection

		  ' Add Basic Authentication header
		  Var credentials As String = apiKey + ":" + apiSecret
		  Var credentialsEncoded As String = EncodeBase64(credentials)

		  ' Remove any line breaks that EncodeBase64 might add (CRITICAL for HTTP Basic Auth)
		  credentialsEncoded = credentialsEncoded.ReplaceAll(EndOfLine, "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(Chr(13), "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(Chr(10), "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(" ", "")

		  socket.RequestHeader("Authorization") = "Basic " + credentialsEncoded

		  ' Set request body (SetRequestContent sets Content-Type automatically)
		  socket.SetRequestContent(json, "application/json")

		  ' Send POST request to MailJet API (30 second timeout)
		  ' Note: If you have a US-based account, change to: https://api.us.mailjet.com/v3.1/send
		  Try
		    Var response As String = socket.SendSync("POST", "https://api.mailjet.com/v3.1/send", 30)

		    ' Check response status
		    If socket.HTTPStatusCode = 200 Then
		      #If TargetWeb Then
		        If webSession <> Nil Then
		          webSession.ExecuteJavaScript("console.log('Email sent successfully via MailJet');")
		        End If
		      #EndIf
		    Else
		      #If TargetWeb Then
		        If webSession <> Nil Then
		          webSession.ExecuteJavaScript("console.error('MailJet API error: HTTP " + socket.HTTPStatusCode.ToString + "');")
		          webSession.ExecuteJavaScript("console.error('Response: " + response.ReplaceAll("'", "\\'").ReplaceAll("""", "\""") + "');")
		        End If
		      #EndIf
		      MessageBox("Failed to send email. HTTP Status: " + socket.HTTPStatusCode.ToString + EndOfLine + "Response: " + response)
		    End If
		    
		  Catch e As RuntimeException
		    #If TargetWeb Then
		      If webSession <> Nil Then
		        webSession.ExecuteJavaScript("console.error('Email send exception: " + e.Message + "');")
		      End If
		    #EndIf
		    MessageBox("Error sending email: " + e.Message)
		  End Try
		  
		  ' Release the semaphore
		  MailSemaphore.Release
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub submitChangeRequest(changeRequest as string, cUser as string)
		  var db as MySQLCommunityServer, sql as string
		  db = session.db
		  sql = "insert into changes  (changeRequest, cUser, cStatus) values (?, ?, 'New')"

		  try
		    db.ExecuteSQL(sql, changeRequest, cUser)
		  catch e as DatabaseException
		    MessageBox(e.Message)
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMailJetAuth(webSession As WebSession = Nil)
		  ' Test MailJet API credentials with a simple GET request
		  ' Replace these with your actual MailJet API credentials
		  Var apiKey As String = "aeb158a2ac1a32e526b124a2cb7aa3a7"
		  Var apiSecret As String = "384238973b036e63d5240aa0a3cfa65a"

		  #If TargetWeb Then
		    If webSession <> Nil Then
		      webSession.ExecuteJavaScript("console.log('Testing MailJet API authentication...');")
		    End If
		  #EndIf

		  ' Create URLConnection for synchronous HTTP request
		  Var socket As New URLConnection

		  ' Add Basic Authentication header
		  Var credentials As String = apiKey + ":" + apiSecret
		  Var credentialsEncoded As String = EncodeBase64(credentials)

		  ' Remove any line breaks that EncodeBase64 might add (CRITICAL for HTTP Basic Auth)
		  credentialsEncoded = credentialsEncoded.ReplaceAll(EndOfLine, "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(Chr(13), "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(Chr(10), "")
		  credentialsEncoded = credentialsEncoded.ReplaceAll(" ", "")

		  socket.RequestHeader("Authorization") = "Basic " + credentialsEncoded

		  ' Debug: Log what we're sending
		  #If TargetWeb Then
		    If webSession <> Nil Then
		      webSession.ExecuteJavaScript("console.log('API Key: " + apiKey + "');")
		      webSession.ExecuteJavaScript("console.log('Credentials (raw): " + credentials + "');")
		      webSession.ExecuteJavaScript("console.log('Credentials (base64): " + credentialsEncoded + "');")
		      webSession.ExecuteJavaScript("console.log('Authorization header: Basic " + credentialsEncoded + "');")
		    End If
		  #EndIf

		  ' Send GET request to MailJet API stats endpoint (10 second timeout)
		  Try
		    Var url As String = "https://api.mailjet.com/v3/REST/statcounters?CounterSource=APIKey&CounterTiming=Message&CounterResolution=Lifetime"
		    Var response As String = socket.SendSync("GET", url, 10)

		    ' Check response status
		    #If TargetWeb Then
		      If webSession <> Nil Then
		        webSession.ExecuteJavaScript("console.log('MailJet API Test - HTTP Status: " + socket.HTTPStatusCode.ToString + "');")
		        webSession.ExecuteJavaScript("console.log('Response: " + response.ReplaceAll("'", "\\'").ReplaceAll("""", "\""").ReplaceAll(EndOfLine, " ") + "');")
		      End If
		    #EndIf

		    If socket.HTTPStatusCode = 200 Then
		      MessageBox("MailJet API Test Success!" + EndOfLine + "HTTP Status: 200" + EndOfLine + "Response: " + response)
		    Else
		      MessageBox("MailJet API Test Failed" + EndOfLine + "HTTP Status: " + socket.HTTPStatusCode.ToString + EndOfLine + "Response: " + response)
		    End If

		  Catch e As RuntimeException
		    #If TargetWeb Then
		      If webSession <> Nil Then
		        webSession.ExecuteJavaScript("console.error('MailJet API test exception: " + e.Message + "');")
		      End If
		    #EndIf
		    MessageBox("Error testing MailJet API: " + e.Message)
		  End Try

		End Sub
	#tag EndMethod


	#tag Note, Name = Untitled
		12/12/2025
		Changes - incomplete list:
		Webdialogs implemented for weblistboxes where inline editing is not an option (more fields than are shown in listbox) - for example indications, users, etc.
		Implemented a mailing system (primarily for password resets)
		Navigation manager class, instantiated in the session object
		Code reformatted, object naming change with appropraite prefixes
		Landing page added as primary page; webcontainers for logos and menu on landing page. Header webcontainer for all other webpages (remembering that some of the pages are now dialogs that don't)
		
		
		General notes:
		Methods that don 't take parameters do not have trailing `()` after the method name in Xojo.
		If producing code for an object, do not use .xojo_code format as can't be used in xojo and not human-readable. Instead just list properties, events and methods.
		objects should be prefixed appropriately: buttons: btn, labels: lbl, fields/textareas: txt, segmentedButtons: seg, checkboxes: chk, istboxes: lst, webpages: wp_, webcontainers: wc_, dialogs: dlg_, etc
		
		
		what works: 
		- Admin login - non-authenticated users can view indications, indication details and issues. Admin login required for all other functionality, which also means setting enabled/visible of controls
		- Password reset with OTP via Email
		- listing of all indications
		- double clicking the lstIndications opens a web dialog with all related fields and displays appropriately (save not yet implemented)
		- Users web page with listbox that shows users and double-clicking displays and edits or creates new.
		
		what is missing 
		- save in dlg_indications
		- right click an indication in lstIndications -> contextual menu -> request change for that indication
		- contexts was proposed as a many-to-many linked table via intermediary table - no functionality on this yet
		- issues webpage wp_issues (this is intended for bug or change requests that can be submitted from the landing page, and for change requests from right-clicking lstIndications
		- audit web page wp_audit - a log of all changes made, by who and when
		- a settings webpage wp_settings - predominantly for managing contexts and probably other settings such as the svg icon in the wc_WebPageHeader menu.
		The missing web pages need to be built from scratch, but in the same style as existing.
		
		
		
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		MailSemaphore As Semaphore
	#tag EndProperty

	#tag Property, Flags = &h0
		MailSocket As SMTPSecureSocket
	#tag EndProperty


	#tag Constant, Name = LightGrey, Type = Color, Dynamic = False, Default = \"&cD6D6D6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LightGrey1, Type = Color, Dynamic = False, Default = \"&cD6D6D6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NHSBlue, Type = Color, Dynamic = False, Default = \"&c006AB5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NHSBlue1, Type = Color, Dynamic = False, Default = \"&c006AB5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NHSBlueSemi, Type = Color, Dynamic = False, Default = \"&c0080DE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NHSBlueSemi1, Type = Color, Dynamic = False, Default = \"&c0080DE", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
