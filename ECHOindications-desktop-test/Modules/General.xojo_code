#tag Module
Protected Module General
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
		  
		  MailSemaphore.Signal
		  
		  ' Connect to Gmail
		  MailSocket.Address = "smtp.gmail.com"
		  MailSocket.Port = 465
		  MailSocket.SSLConnectionType = SSLSocket.SSLConnectionTypes.TLSv1
		  MailSocket.SMTPConnectionType = SMTPSecureSocket.SMTPConnectionTypes.SSLTLS
		  MailSocket.SSLEnabled = True
		  
		  MailSocket.Username = "aucecho@gmail.com"
		  MailSocket.Password = "asjc ccuv sgki kjbb"
		  
		  ' Create EmailMessage
		  Var mail As New EmailMessage
		  mail.FromAddress = "echoauc@gmail.com"
		  mail.AddRecipient(toAddress)
		  mail.Subject = subject
		  mail.BodyPlainText = message
		  mail.Headers.AddHeader("X-Mailer","SMTP Test")
		  
		  ' Send it
		  MailSocket.Messages.AddRow(mail)
		  MailSocket.SendMail
		  
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
