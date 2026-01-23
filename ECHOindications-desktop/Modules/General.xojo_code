#tag Module
Protected Module General
	#tag Method, Flags = &h0
		Function AdjustColorBrightness(originalColor As Color, factor As Double) As Color
		  // Adjust brightness while preserving color identity
		  // factor > 1.0 makes brighter, < 1.0 makes darker, 1.0 = no change
		  
		  Var r As Integer = Min(255, originalColor.Red * factor)
		  Var g As Integer = Min(255, originalColor.Green * factor)
		  Var b As Integer = Min(255, originalColor.Blue * factor)
		  
		  Return Color.RGB(r, g, b)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContrastingTextColor(backgroundColor As Color) As Color
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
		Function GetLuminance(backgroundColor As Color) As Double
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
		Function GetReadableColorForBackground(textColor As Color, backgroundColor As Color, preserveHue As Boolean = True) As Color
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
		  
		  MailSemaphore.Release ' Release the Semaphore to make the socket available for use
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MailServerErrorHandler(m As SMTPSecureSocket, errorID As Integer, errorMessage As String, email As EmailMessage)
		  #Pragma Unused m
		  #Pragma Unused errorID
		  #Pragma Unused email
		  
		  MailSemaphore.Release ' Release the Semaphore to make the socket available for use
		  MessageBox(errorMessage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageHide(target as variant)
		  DesktopLabel(target).Text = ""
		  DesktopLabel(target).Visible = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageShow(target as DesktopLabel, message as String)
		  target.Text = message
		  target.Visible = true
		  Timer.CallLater(2000, AddressOf MessageHide, target)
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
		Sub SendMail(toAddress As String, subject As String, message As String)
		  
		  ' Try to acquire the semaphore (non-blocking)
		  ' If we can't acquire it, another email is being sent - wait briefly and retry
		  Var retryCount As Integer = 0
		  Var maxRetries As Integer = 30  ' Wait up to ~30 seconds
		  
		  While Not MailSemaphore.TrySignal And retryCount < maxRetries
		    retryCount = retryCount + 1
		    
		    ' Wait 1 second before retry
		    Var deadline As Double = System.Microseconds + 1000000
		    While System.Microseconds < deadline
		      ' Busy wait
		    Wend
		  Wend
		  
		  If retryCount >= maxRetries Then
		    ' Failed to acquire semaphore - another email is stuck
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
		  socket.RequestHeader("Content-Type") = "application/json"
		  
		  ' Add Basic Authentication header
		  Var credentials As String = apiKey + ":" + apiSecret
		  Var credentialsEncoded As String = EncodeBase64(credentials)
		  socket.RequestHeader("Authorization") = "Basic " + credentialsEncoded

		  ' Set request body
		  socket.SetRequestContent(json, "application/json")

		  ' Send POST request to MailJet API
		  Try
		    socket.Send("POST", "https://api.mailjet.com/v3.1/send")

		    ' Check response status
		    If socket.HTTPStatusCode = 200 Then
		      ' Email sent successfully
		    Else
		      Var response As String = socket.ResponseContent
		      MessageBox("Failed to send email. HTTP Status: " + socket.HTTPStatusCode.ToString)
		    End If

		  Catch e As RuntimeException
		    MessageBox("Error sending email: " + e.Message)
		  End Try

		  ' Release the semaphore
		  MailSemaphore.Release
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		MailSemaphore As Semaphore
	#tag EndProperty


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
