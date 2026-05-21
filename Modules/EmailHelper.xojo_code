#tag Module
Protected Module EmailHelper
	#tag Method, Flags = &h0
		Function GenerateOTP() As String
		  ' so an unused OTP is valid until the user changes their password.
		  ' Implement properly by:
		  '   1. ALTER TABLE users ADD COLUMN password_reset_at TIMESTAMP NULL;
		  '   2. Set password_reset_at = NOW() whenever password_is_otp is set to 1
		  '      (DoResetPassword on wp_Landing AND wd_EditUser).
		  '   3. In wp_Landing.DoLogin, when password_is_otp = 1, reject if
		  '      (NOW() - password_reset_at) > 30 minutes; force admin/user to re-issue.
		  '   4. Restore the "expires in 30 minutes" copy in the email templates.
		  
		  
		  ' *******************************************************************************
		  ' Add Method: GenerateOTP
		  '   Return Type: String
		  '   Purpose: Generates a secure 6-digit OTP
		  ' *******************************************************************************
		  
		  Var randomData As MemoryBlock = Crypto.GenerateRandomBytes(4)
		  
		  Var number As Integer = Abs(randomData.UInt8Value(0) * 16777216 + randomData.UInt8Value(1) * 65536 + randomData.UInt8Value(2) * 256 + randomData.UInt8Value(3))
		  Var otp As String = Format(number Mod 1000000, "000000")
		  
		  Return otp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GeneratePasswordResetEmailHTML(userName As String, otp As String) As String
		  ' *******************************************************************************
		  ' Add Method: GeneratePasswordResetEmailHTML
		  '   Parameters: userName As String, otp As String
		  '   Return Type: String
		  '   Scope: Private
		  '   Purpose: Creates styled HTML email content
		  ' *******************************************************************************
		  
		  Var html As String = "<!DOCTYPE html><html><head><meta charset='UTF-8'><style>"
		  html = html + "body{font-family:Arial,sans-serif;line-height:1.6;color:#333;max-width:600px;margin:0 auto;padding:20px;}"
		  html = html + ".container{background:#f9f9f9;border-radius:10px;padding:30px;}"
		  html = html + ".header{background:#2c3e50;color:white;padding:20px;border-radius:10px 10px 0 0;text-align:center;}"
		  html = html + ".content{background:white;padding:30px;border-radius:0 0 10px 10px;}"
		  html = html + ".otp-box{background:#3498db;color:white;font-size:32px;font-weight:bold;padding:20px;text-align:center;border-radius:5px;margin:20px 0;letter-spacing:8px;}"
		  html = html + ".warning{background:#fff3cd;border-left:4px solid #ffc107;padding:15px;margin:20px 0;}"
		  html = html + ".footer{text-align:center;color:#666;font-size:12px;margin-top:30px;}"
		  html = html + "</style></head><body><div class='container'><div class='header'>"
		  html = html + "<h1>ECHOindications</h1><p>Password Reset Request</p></div><div class='content'>"
		  html = html + "<p>Hello <strong>" + userName + "</strong>,</p>"
		  html = html + "<p>You have requested to reset your password. Use the one-time password (OTP) below to proceed:</p>"
		  html = html + "<div class='otp-box'>" + otp + "</div>"
		  html = html + "<div class='warning'><strong>⚠️ Security Notice:</strong> If you didn't request this password reset, please ignore this email and ensure your account is secure.</div>"
		  html = html + "<p>After entering your OTP, you'll be able to create a new password.</p>"
		  html = html + "<p>Best regards,<br>The ECHOindications Team</p></div>"
		  html = html + "<div class='footer'><p>This is an automated message. Please do not reply to this email.</p></div>"
		  html = html + "</div></body></html>"
		  
		  Return html
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateSecureToken() As String
		  ' *******************************************************************************
		  ' Add Method: GenerateSecureToken
		  '   Return Type: String
		  '   Purpose: Generates a secure 64-character token
		  ' *******************************************************************************
		  Var randomData As MemoryBlock = Crypto.GenerateRandomBytes(32)
		  
		  Var token As String = ""
		  For i As Integer = 0 To randomData.Size - 1
		    token = token + randomData.UInt8Value(i).ToHex(2)
		  Next
		  
		  Return token
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendAccessRequestNotification(toEmail as String, toName as String, applicantName as String, applicantEmail as String, db as MySQLCommunityServer) As Boolean
		  ' *******************************************************************************
		  ' Add Method: SendAccessRequestNotification
		  '   Parameters: toEmail (admin), toName (admin), applicantName, applicantEmail
		  '   Return Type: Boolean
		  '   Purpose: Notifies admins when a new access request is submitted
		  ' *******************************************************************************
		  
		  #Pragma Unused db
		  Var subject As String = "AI Audit - New Access Request"
		  
		  Try
		    ' Generate HTML body
		    Var html As String = "<!DOCTYPE html><html><head><meta charset='UTF-8'><style>"
		    html = html + "body{font-family:Arial,sans-serif;line-height:1.6;color:#333;max-width:600px;margin:0 auto;padding:20px;}"
		    html = html + ".container{background:#f9f9f9;border-radius:10px;padding:30px;}"
		    html = html + ".header{background:#2c3e50;color:white;padding:20px;border-radius:10px 10px 0 0;text-align:center;}"
		    html = html + ".content{background:white;padding:30px;border-radius:0 0 10px 10px;}"
		    html = html + ".info-box{background:#e8f4f8;border-left:4px solid #3498db;padding:15px;margin:20px 0;}"
		    html = html + ".info-row{margin:10px 0;}"
		    html = html + ".label{font-weight:bold;color:#2c3e50;}"
		    html = html + ".button{display:inline-block;background:#3498db;color:white;padding:12px 30px;text-decoration:none;border-radius:5px;margin-top:20px;}"
		    html = html + ".footer{text-align:center;color:#666;font-size:12px;margin-top:30px;}"
		    html = html + "</style></head><body><div class='container'><div class='header'>"
		    html = html + "<h1>AI Audit</h1><p>New Access Request</p></div><div class='content'>"
		    html = html + "<p>Hello <strong>" + toName + "</strong>,</p>"
		    html = html + "<p>A new user has requested access to AI Audit:</p>"
		    html = html + "<div class='info-box'>"
		    html = html + "<div class='info-row'><span class='label'>Name:</span> " + applicantName + "</div>"
		    html = html + "<div class='info-row'><span class='label'>Email:</span> " + applicantEmail + "</div>"
		    html = html + "<div class='info-row'><span class='label'>Requested:</span> " + DateTime.Now.ToString + "</div>"
		    html = html + "</div>"
		    html = html + "<p>Please review this request in the admin panel and approve or reject it.</p>"
		    html = html + "<p>Best regards,<br>The AI Audit team</p></div>"
		    html = html + "<div class='footer'><p>This is an automated notification. Please do not reply to this email.</p></div>"
		    html = html + "</div></body></html>"
		    
		    ' Generate plain text body
		    Var textBody As String = "Hello " + toName + "," + EndOfLine + EndOfLine
		    textBody = textBody + "A new user has requested access to AI Audit:" + EndOfLine + EndOfLine
		    textBody = textBody + "Name: " + applicantName + EndOfLine
		    textBody = textBody + "Email: " + applicantEmail + EndOfLine
		    textBody = textBody + "Requested: " + DateTime.Now.ToString + EndOfLine + EndOfLine
		    textBody = textBody + "Please review this request in the admin panel." + EndOfLine + EndOfLine
		    textBody = textBody + "Best regards," + EndOfLine
		    textBody = textBody + "AI Audit team"
		    
		    Return SendViaMailJet(toEmail, subject, html, textBody)
		    
		  Catch e As RuntimeException
		    LastError = "Email send error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendNewAccountEmail(toEmail As String, toName As String, username As String, otp As String) As Boolean
		  ' *******************************************************************************
		  ' Add Method: SendNewAccountEmail
		  '   Parameters: toEmail, toName, username, otp
		  '   Return Type: Boolean
		  '   Purpose: Sends welcome email with OTP so new user can set their own password
		  ' *******************************************************************************
		  
		  Var subject As String = "Welcome to AI Audit - Set Your Password"
		  
		  Try
		    ' Generate HTML body
		    Var html As String = "<!DOCTYPE html><html><head><meta charset='UTF-8'><style>"
		    html = html + "body{font-family:Arial,sans-serif;line-height:1.6;color:#333;max-width:600px;margin:0 auto;padding:20px;}"
		    html = html + ".container{background:#f9f9f9;border-radius:10px;padding:30px;}"
		    html = html + ".header{background:#27ae60;color:white;padding:20px;border-radius:10px 10px 0 0;text-align:center;}"
		    html = html + ".content{background:white;padding:30px;border-radius:0 0 10px 10px;}"
		    html = html + ".credentials-box{background:#e8f8f5;border-left:4px solid #27ae60;padding:20px;margin:20px 0;}"
		    html = html + ".credential-item{margin:15px 0;font-size:16px;}"
		    html = html + ".label{font-weight:bold;color:#2c3e50;display:inline-block;width:120px;}"
		    html = html + ".value{font-family:monospace;background:#fff;padding:8px 12px;border-radius:3px;border:1px solid #ddd;}"
		    html = html + ".otp-box{background:#3498db;color:white;font-size:32px;font-weight:bold;padding:20px;text-align:center;border-radius:5px;margin:20px 0;letter-spacing:8px;}"
		    html = html + ".warning{background:#fff3cd;border-left:4px solid #ffc107;padding:15px;margin:20px 0;}"
		    html = html + ".footer{text-align:center;color:#666;font-size:12px;margin-top:30px;}"
		    html = html + "</style></head><body><div class='container'><div class='header'>"
		    html = html + "<h1>Welcome to AI Audit</h1><p>An account has been created for you</p></div><div class='content'>"
		    html = html + "<p>Hello <strong>" + toName + "</strong>,</p>"
		    html = html + "<p>An AI Audit account has been created for you by an administrator. Your username is:</p>"
		    html = html + "<div class='credentials-box'>"
		    html = html + "<div class='credential-item'><span class='label'>Username:</span> <span class='value'>" + username + "</span></div>"
		    html = html + "</div>"
		    html = html + "<p>Use the one-time password (OTP) below to log in and set your password:</p>"
		    html = html + "<div class='otp-box'>" + otp + "</div>"
		    html = html + "<div class='warning'><strong>Note:</strong> This OTP can only be used once. After logging in you will be prompted to set a new password.</div>"
		    html = html + "<p>If you have any questions or need assistance, please contact your administrator.</p>"
		    html = html + "<p>Best regards,<br>The AI Audit Team</p></div>"
		    html = html + "<div class='footer'><p>This is an automated message. Please do not reply to this email.</p></div>"
		    html = html + "</div></body></html>"
		    
		    ' Generate plain text body
		    Var textBody As String = "Welcome to AI Audit" + EndOfLine + EndOfLine
		    textBody = textBody + "Hello " + toName + "," + EndOfLine + EndOfLine
		    textBody = textBody + "An AI Audit account has been created for you by an administrator." + EndOfLine + EndOfLine
		    textBody = textBody + "Username: " + username + EndOfLine + EndOfLine
		    textBody = textBody + "Use the following one-time password (OTP) to log in and set your password:" + EndOfLine
		    textBody = textBody + otp + EndOfLine + EndOfLine
		    textBody = textBody + "Best regards," + EndOfLine
		    textBody = textBody + "AI Audit Team"
		    
		    Return SendViaMailJet(toEmail, subject, html, textBody)
		    
		  Catch e As RuntimeException
		    LastError = "Email send error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendPasswordResetEmail(toEmail As String, toName As String, otp As String, resetLink As String) As Boolean
		  ' *******************************************************************************
		  ' Add Method: SendPasswordResetEmail
		  '   Parameters: toEmail As String, toName As String, otp As String, resetLink As String
		  '   Return Type: Boolean
		  ' *******************************************************************************
		  
		  #Pragma Unused resetLink
		  
		  Var subject As String = "ECHOindications - Password Reset Request"
		  
		  Try
		    ' Generate HTML body
		    Var htmlBody As String = GeneratePasswordResetEmailHTML(toName, otp)
		    
		    ' Generate plain text body
		    Var textBody As String = "Hello " + toName + "," + EndOfLine + EndOfLine
		    textBody = textBody + "You have requested to reset your ECHOindications password." + EndOfLine + EndOfLine
		    textBody = textBody + "Your one-time password (OTP) is: " + otp + EndOfLine + EndOfLine
		    textBody = textBody + "If you didn't request this, please ignore this email." + EndOfLine + EndOfLine
		    textBody = textBody + "Best regards," + EndOfLine
		    textBody = textBody + "ECHOindications Team"
		    
		    Return SendViaMailJet(toEmail, subject, htmlBody, textBody)
		    
		  Catch e As RuntimeException
		    LastError = "Email send error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendTestEmail(toEmail As String, toName As String) As Boolean
		  // Plain "smoke test" email used by dlg_EmailTest's "Send Test
		  // Email" button. Verifies the MailJet send path end-to-end without
		  // pretending to be a password reset or account-creation message —
		  // those have their own flows.
		  Var subject As String = "ECHOindications — email test message"
		  
		  Try
		    Var sentAt As String = DateTime.Now.SQLDateTime
		    
		    Var html As String = "<!DOCTYPE html><html><head><meta charset='UTF-8'><style>" _
		    + "body{font-family:Arial,sans-serif;line-height:1.5;color:#333;max-width:600px;margin:0 auto;padding:20px;}" _
		    + ".badge{display:inline-block;background:#0d6efd;color:white;padding:4px 10px;border-radius:4px;font-size:12px;letter-spacing:0.5px;}" _
		    + ".meta{background:#f4f6f8;border-left:4px solid #0d6efd;padding:14px 18px;margin:18px 0;font-family:monospace;font-size:13px;}" _
		    + ".meta div{margin:4px 0;}" _
		    + ".muted{color:#666;font-size:12px;margin-top:24px;}" _
		    + "</style></head><body>" _
		    + "<p><span class='badge'>TEST</span></p>" _
		    + "<p>Hello <strong>" + toName + "</strong>,</p>" _
		    + "<p>This is a test message sent from the ECHOindications application's email test screen. " _
		    + "If you've received it, outgoing email is configured correctly and reaching this inbox.</p>" _
		    + "<div class='meta'>" _
		    + "<div><strong>Sent at:</strong> " + sentAt + "</div>" _
		    + "<div><strong>Transport:</strong> MailJet API v3.1</div>" _
		    + "</div>" _
		    + "<p>No action is required. You can safely ignore or delete this message.</p>" _
		    + "<p class='muted'>ECHOindications · automated test message</p>" _
		    + "</body></html>"
		    
		    Var textBody As String = "[TEST] ECHOindications — email test message" + EndOfLine + EndOfLine _
		    + "Hello " + toName + "," + EndOfLine + EndOfLine _
		    + "This is a test message sent from the ECHOindications application's" + EndOfLine _
		    + "email test screen. If you've received it, outgoing email is" + EndOfLine _
		    + "configured correctly." + EndOfLine + EndOfLine _
		    + "Sent at:    " + sentAt + EndOfLine _
		    + "Transport:  MailJet API v3.1" + EndOfLine + EndOfLine _
		    + "No action is required." + EndOfLine
		    Return SendViaMailJet(toEmail, subject, html, textBody)
		    
		  Catch e As RuntimeException
		    LastError = "Test email send error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendViaMailJet(toEmail As String, subject As String, htmlBody As String, textBody As String) As Boolean
		  // Sends one email through the MailJet v3.1 REST API.
		  // API credentials come from the out-of-repo secrets file (see Modules/Secrets).
		  Const kFromEmail As String = "info@echoindications.org"
		  Const kFromName As String = "ECHOindications"
		  
		  // JSON-escape: backslash first, then double-quote, then newlines.
		  Var jsSubject As String = subject.ReplaceAll("\", "\\").ReplaceAll("""", "\""")
		  Var jsText As String = textBody.ReplaceAll("\", "\\").ReplaceAll("""", "\""").ReplaceAll(EndOfLine, "\n")
		  Var jsHtml As String = htmlBody.ReplaceAll("\", "\\").ReplaceAll("""", "\""").ReplaceAll(EndOfLine, "\n")
		  
		  Var json As String = "{""Messages"":[{" _
		  + """From"":{""Email"":""" + kFromEmail + """,""Name"":""" + kFromName + """}," _
		  + """To"":[{""Email"":""" + toEmail + """}]," _
		  + """Subject"":""" + jsSubject + """," _
		  + """TextPart"":""" + jsText + """," _
		  + """HTMLPart"":""" + jsHtml + """}]}"
		  
		  Try
		    Var socket As New URLConnection
		    Var creds As String = EncodeBase64(Secrets.MAILJET_API_KEY + ":" + Secrets.MAILJET_SECRET_KEY, 0)
		    creds = creds.ReplaceAll(EndOfLine, "").ReplaceAll(Chr(13), "").ReplaceAll(Chr(10), "")
		    socket.RequestHeader("Authorization") = "Basic " + creds
		    socket.SetRequestContent(json, "application/json")
		    
		    Var response As String = socket.SendSync("POST", "https://api.mailjet.com/v3.1/send", 30)
		    LastResponse = response
		    
		    If socket.HTTPStatusCode = 200 Then
		      LastError = ""
		      Return True
		    Else
		      LastError = "MailJet HTTP " + socket.HTTPStatusCode.ToString + ": " + response
		      Return False
		    End If
		  Catch e As RuntimeException
		    LastError = "Email send error: " + e.Message
		    LastResponse = ""
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendWelcomeEmail(toEmail as String, toName as String, username as String, tempPassword as String) As Boolean
		  ' *******************************************************************************
		  ' Add Method: SendWelcomeEmail
		  '   Parameters: toEmail, toName, username, tempPassword
		  '   Return Type: Boolean
		  '   Purpose: Sends welcome email with login credentials to new users
		  ' *******************************************************************************
		  
		  Var subject As String = "Welcome to AI Audit - Your Account is Ready"
		  
		  Try
		    ' Generate HTML body
		    Var html As String = "<!DOCTYPE html><html><head><meta charset='UTF-8'><style>"
		    html = html + "body{font-family:Arial,sans-serif;line-height:1.6;color:#333;max-width:600px;margin:0 auto;padding:20px;}"
		    html = html + ".container{background:#f9f9f9;border-radius:10px;padding:30px;}"
		    html = html + ".header{background:#27ae60;color:white;padding:20px;border-radius:10px 10px 0 0;text-align:center;}"
		    html = html + ".content{background:white;padding:30px;border-radius:0 0 10px 10px;}"
		    html = html + ".credentials-box{background:#e8f8f5;border-left:4px solid #27ae60;padding:20px;margin:20px 0;}"
		    html = html + ".credential-item{margin:15px 0;font-size:16px;}"
		    html = html + ".label{font-weight:bold;color:#2c3e50;display:inline-block;width:120px;}"
		    html = html + ".value{font-family:monospace;background:#fff;padding:8px 12px;border-radius:3px;border:1px solid #ddd;}"
		    html = html + ".warning{background:#fff3cd;border-left:4px solid #ffc107;padding:15px;margin:20px 0;}"
		    html = html + ".footer{text-align:center;color:#666;font-size:12px;margin-top:30px;}"
		    html = html + "</style></head><body><div class='container'><div class='header'>"
		    html = html + "<h1>Welcome to AI Audit</h1><p>Your account has been approved</p></div><div class='content'>"
		    html = html + "<p>Hello <strong>" + toName + "</strong>,</p>"
		    html = html + "<p>Great news! Your access request has been approved. You can now log in to AI Audit using the credentials below:</p>"
		    html = html + "<div class='credentials-box'>"
		    html = html + "<div class='credential-item'><span class='label'>Username:</span> <span class='value'>" + username + "</span></div>"
		    html = html + "<div class='credential-item'><span class='label'>Password:</span> <span class='value'>" + tempPassword + "</span></div>"
		    html = html + "</div>"
		    html = html + "<div class='warning'><strong>🔒 Important Security Notice:</strong><br>"
		    html = html + "This is a temporary password. Please change it immediately after your first login for security reasons.</div>"
		    html = html + "<p>You can access AI Audit by visiting the login page and entering your credentials.</p>"
		    html = html + "<p>If you have any questions or need assistance, please contact your administrator.</p>"
		    html = html + "<p>Best regards,<br>The AI Audit Team</p></div>"
		    html = html + "<div class='footer'><p>This is an automated message. Please do not reply to this email.</p></div>"
		    html = html + "</div></body></html>"
		    
		    ' Generate plain text body
		    Var textBody As String = "Welcome to AI Audit" + EndOfLine + EndOfLine
		    textBody = textBody + "Hello " + toName + "," + EndOfLine + EndOfLine
		    textBody = textBody + "Your access request has been approved. You can now log in using:" + EndOfLine + EndOfLine
		    textBody = textBody + "Username: " + username + EndOfLine
		    textBody = textBody + "Password: " + tempPassword + EndOfLine + EndOfLine
		    textBody = textBody + "IMPORTANT: This is a temporary password. Please change it after your first login." + EndOfLine + EndOfLine
		    textBody = textBody + "Best regards," + EndOfLine
		    textBody = textBody + "AI Audit Team"
		    
		    Return SendViaMailJet(toEmail, subject, html, textBody)
		    
		  Catch e As RuntimeException
		    LastError = "Email send error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		LastError As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponse As String
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
		#tag ViewProperty
			Name="LastError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastResponse"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
