#tag Module
Protected Module APIhelpers
	#tag Method, Flags = &h0
		Function GetDB() As MySQLCommunityServer
		  // Opens a fresh DB connection for an API request.
		  // API requests have no WebSession to hang DB on, so we mint a
		  // per-request connection. Caller is responsible for closing it
		  // (typically via `Try ... Finally db.Close`).
		  Try
		    Secrets.Load   // idempotent
		  Catch err As RuntimeException
		    System.DebugLog("Secrets.Load failed in API: " + err.Message)
		  End Try
		  
		  Var db As New MySQLCommunityServer
		  db.Host = "127.0.0.1"
		  db.Port = 3306
		  db.DatabaseName = "echo_indications"
		  db.UserName = Secrets.DB_USERNAME
		  db.Password = Secrets.DB_PASSWORD
		  
		  db.Connect
		  Return db
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PathSegments(path As String) As String()
		  // "/api/v1/indications/42" -> ["api", "v1", "indications", "42"]
		  Var trimmed As String = path
		  If trimmed.BeginsWith("/") Then trimmed = trimmed.Middle(1)
		  If trimmed.EndsWith("/") Then trimmed = trimmed.Left(trimmed.Length - 1)
		  Return trimmed.Split("/")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueryInt(queryString As String, key As String) As Integer
		  // Extracts an integer value for `key` from a URL-encoded query string.
		  // Returns 0 if the key is absent or the value isn't an integer.
		  Var pairs() As String = queryString.Split("&")
		  For Each pair As String In pairs
		    Var eq As Integer = pair.IndexOf("=")
		    If eq <= 0 Then Continue
		    Var k As String = pair.Left(eq)
		    If k = key Then
		      Var v As String = pair.Middle(eq + 1)
		      Return Integer.FromString(v)
		    End If
		  Next
		  Return 0
		End Function
	#tag EndMethod


End Module
#tag EndModule
