#tag Class
Protected Class EchoIndicationsApp
Inherits WebApplication
	#tag Event
		Sub Opening(args() As String)
		  #Pragma Unused args
		  
		  ' Semaphore is used to ensure that only one session at a time tries
		  ' to send an email.
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


	#tag Constant, Name = kInfoText, Type = String, Dynamic = False, Default = \"<div style\x3D\"margin: 0; padding: 0; font-family: Arial\x2C sans-serif; font-size: 14px; line-height: 1.2;\">\n<span style\x3D\"font-size: 24px; font-weight: bold;\">ECHOindications web app</span><br>\n<span style\x3D\"font-style: italic; font-size: 14px;\">Version 1.5</span><br><br>\nAppropriate Use Criteria for Echocardiography drawn from national and international guidelines and consensus across trusts in SE London.<br><br>\n<span style\x3D\"font-weight: bold;\">View Appropriate Use Criteria</span><br>\n- Indications for echocardiography with appropriate use criteria for primary care\x2C outpatient and inpatient secondary care\x2C and appropriate priority/urgency.<br>\n- Fuzzy search\x2C context filtering<br>\n- Double-click to view all details.<br>\n- Right-click to request changes for the specific context.<br><br>\n<span style\x3D\"font-weight: bold;\">Admin Login</span><br>\nAuthenticate to make changes.<br><br>\n<span style\x3D\"font-weight: bold;\">Request Changes</span><br>\nFeature requests or bug reports<br><br>\n<span style\x3D\"font-weight: bold;\">Issues</span><br>\nView all reported issues.\n</div>", Scope = Public
	#tag EndConstant

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
