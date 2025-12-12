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

	#tag Method, Flags = &h0
		Sub submitChangeRequest(indicaitonExisting as string, indicationNew as string, contextExisting as string, contextNew as string, primaryKey as string, cUser as string)
		  
		End Sub
	#tag EndMethod


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
