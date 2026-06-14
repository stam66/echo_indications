#tag Module
Protected Module APIRouter
	#tag Method, Flags = &h0
		Function Route(request As WebRequest, response As WebResponse) As Boolean
		  // Dispatch /api/v1/* to endpoint handlers. Returns True if handled.
		  Var segments() As String = APIHelpers.PathSegments(request.Path)

		  // Expect: ["api", "v1", <resource>, <id?>, <subresource?>, ...]
		  If segments.LastIndex < 2 Or segments(0) <> "api" Then
		    APIResponse.WriteError(response, 404, "Not found")
		    Return True
		  End If

		  If segments(1) <> "v1" Then
		    APIResponse.WriteError(response, 404, "Unsupported API version: " + segments(1))
		    Return True
		  End If

		  Var resource As String = segments(2)

		  Select Case resource
		  Case "login"
		    AuthEndpoints.HandleLogin(request, response)

		  Case "logout"
		    AuthEndpoints.HandleLogout(request, response)

		  Case "me"
		    AuthEndpoints.HandleMe(request, response)

		  Case "indications"
		    RouteIndications(request, response, segments)

		  Case "users"
		    RouteSimple(request, response, segments, "users")

		  Case "contexts"
		    RouteSimple(request, response, segments, "contexts")

		  Case "issues"
		    RouteSimple(request, response, segments, "issues")

		  Case "decision-nodes"
		    RouteSimple(request, response, segments, "decision-nodes")

		  Case "audit"
		    RouteSimple(request, response, segments, "audit")

		  Case "changelog"
		    RouteSimple(request, response, segments, "changelog")

		  Else
		    APIResponse.WriteError(response, 404, "Unknown resource: " + resource)
		  End Select

		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RouteIndications(request As WebRequest, response As WebResponse, segments() As String)
		  // /api/v1/indications                          GET, POST
		  // /api/v1/indications/:id                      GET, PUT, DELETE
		  // /api/v1/indications/:id/decision-nodes       GET (nested)
		  If segments.LastIndex = 2 Then
		    Select Case request.Method
		    Case "GET"
		      IndicationEndpoints.HandleList(request, response)
		    Case "POST"
		      IndicationEndpoints.HandleCreate(request, response)
		    Else
		      APIResponse.WriteError(response, 405, "Method not allowed")
		    End Select
		    Return
		  End If

		  Var id As Integer = Integer.FromString(segments(3))
		  If id <= 0 Then
		    APIResponse.WriteError(response, 400, "Invalid id")
		    Return
		  End If

		  If segments.LastIndex = 3 Then
		    Select Case request.Method
		    Case "GET"
		      IndicationEndpoints.HandleGet(request, response, id)
		    Case "PUT"
		      IndicationEndpoints.HandleUpdate(request, response, id)
		    Case "DELETE"
		      IndicationEndpoints.HandleDelete(request, response, id)
		    Else
		      APIResponse.WriteError(response, 405, "Method not allowed")
		    End Select
		    Return
		  End If

		  // Nested resource: /api/v1/indications/:id/decision-nodes
		  If segments.LastIndex = 4 And segments(4) = "decision-nodes" Then
		    If request.Method = "GET" Then
		      DecisionNodeEndpoints.HandleListByIndication(request, response, id)
		    Else
		      APIResponse.WriteError(response, 405, "Method not allowed")
		    End If
		    Return
		  End If

		  APIResponse.WriteError(response, 404, "Not found")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RouteSimple(request As WebRequest, response As WebResponse, segments() As String, resource As String)
		  // Shared collection/item dispatch for resources with the standard
		  // CRUD shape. resource is the URL segment (e.g. "users", "contexts",
		  // "issues", "decision-nodes") used to pick the right handler.
		  If segments.LastIndex = 2 Then
		    // Collection: /api/v1/<resource>
		    Select Case resource
		    Case "users"
		      If request.Method = "GET" Then
		        UserEndpoints.HandleList(request, response)
		      ElseIf request.Method = "POST" Then
		        UserEndpoints.HandleCreate(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "contexts"
		      If request.Method = "GET" Then
		        ContextEndpoints.HandleList(request, response)
		      ElseIf request.Method = "POST" Then
		        ContextEndpoints.HandleCreate(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "issues"
		      If request.Method = "GET" Then
		        IssueEndpoints.HandleList(request, response)
		      ElseIf request.Method = "POST" Then
		        IssueEndpoints.HandleCreate(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "decision-nodes"
		      If request.Method = "GET" Then
		        DecisionNodeEndpoints.HandleList(request, response)
		      ElseIf request.Method = "POST" Then
		        DecisionNodeEndpoints.HandleCreate(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "audit"
		      If request.Method = "GET" Then
		        AuditEndpoints.HandleList(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "changelog"
		      If request.Method = "GET" Then
		        ChangelogEndpoints.HandleList(request, response)
		      ElseIf request.Method = "POST" Then
		        ChangelogEndpoints.HandleCreate(request, response)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    End Select
		    Return
		  End If

		  If segments.LastIndex = 3 Then
		    // Item: /api/v1/<resource>/:id
		    Var id As Integer = Integer.FromString(segments(3))
		    If id <= 0 Then
		      APIResponse.WriteError(response, 400, "Invalid id")
		      Return
		    End If

		    Select Case resource
		    Case "users"
		      Select Case request.Method
		      Case "GET"
		        UserEndpoints.HandleGet(request, response, id)
		      Case "PUT"
		        UserEndpoints.HandleUpdate(request, response, id)
		      Case "DELETE"
		        UserEndpoints.HandleDelete(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End Select
		    Case "contexts"
		      Select Case request.Method
		      Case "GET"
		        ContextEndpoints.HandleGet(request, response, id)
		      Case "PUT"
		        ContextEndpoints.HandleUpdate(request, response, id)
		      Case "DELETE"
		        ContextEndpoints.HandleDelete(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End Select
		    Case "issues"
		      Select Case request.Method
		      Case "GET"
		        IssueEndpoints.HandleGet(request, response, id)
		      Case "PUT"
		        IssueEndpoints.HandleUpdate(request, response, id)
		      Case "DELETE"
		        IssueEndpoints.HandleDelete(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End Select
		    Case "decision-nodes"
		      Select Case request.Method
		      Case "GET"
		        DecisionNodeEndpoints.HandleGet(request, response, id)
		      Case "PUT"
		        DecisionNodeEndpoints.HandleUpdate(request, response, id)
		      Case "DELETE"
		        DecisionNodeEndpoints.HandleDelete(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End Select
		    Case "audit"
		      If request.Method = "GET" Then
		        AuditEndpoints.HandleGet(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End If
		    Case "changelog"
		      Select Case request.Method
		      Case "GET"
		        ChangelogEndpoints.HandleGet(request, response, id)
		      Case "PUT"
		        ChangelogEndpoints.HandleUpdate(request, response, id)
		      Case "DELETE"
		        ChangelogEndpoints.HandleDelete(request, response, id)
		      Else
		        APIResponse.WriteError(response, 405, "Method not allowed")
		      End Select
		    End Select
		    Return
		  End If

		  APIResponse.WriteError(response, 404, "Not found")
		End Sub
	#tag EndMethod


End Module
#tag EndModule
