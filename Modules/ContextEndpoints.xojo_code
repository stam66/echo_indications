#tag Module
Protected Module ContextEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/contexts        ?active=1 to restrict to is_active rows
		  // Public — contexts are used as picklist values for indications.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var activeOnly As Boolean = request.QueryString.IndexOf("active=1") >= 0
		    Var contexts() As Context
		    If activeOnly Then
		      contexts = Context.GetAllActive(db)
		    Else
		      contexts = Context.GetAll(db)
		    End If

		    Var json As New JSONItem
		    json.Load("[]")
		    For Each c As Context In contexts
		      json.Add(c.ToJSONItem)
		    Next
		    APIResponse.WriteJSON(response, json, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleGet(request As WebRequest, response As WebResponse, id As Integer)
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var c As Context = Context.GetByID(db, id)
		    If c Is Nil Then
		      APIResponse.WriteError(response, 404, "Context not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, c.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleCreate(request As WebRequest, response As WebResponse)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    Var c As New Context
		    c.LoadFromJSON(body)
		    // is_active defaults to True when creating, unless caller explicitly set it
		    If Not body.HasName("is_active") Then c.IsActive = True

		    If c.Name.Trim = "" Then
		      APIResponse.WriteError(response, 400, "name is required")
		      Return
		    End If

		    If Not c.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save context (name may already exist)")
		      Return
		    End If

		    Var saved As Context = Context.GetByID(db, c.ID)
		    APIResponse.WriteJSON(response, If(saved <> Nil, saved.ToJSONItem, c.ToJSONItem), 201)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleUpdate(request As WebRequest, response As WebResponse, id As Integer)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var c As Context = Context.GetByID(db, id)
		    If c Is Nil Then
		      APIResponse.WriteError(response, 404, "Context not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    c.LoadFromJSON(body)

		    If c.Name.Trim = "" Then
		      APIResponse.WriteError(response, 400, "name is required")
		      Return
		    End If

		    If Not c.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save context")
		      Return
		    End If

		    Var saved As Context = Context.GetByID(db, c.ID)
		    APIResponse.WriteJSON(response, saved.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var c As Context = Context.GetByID(db, id)
		    If c Is Nil Then
		      APIResponse.WriteError(response, 404, "Context not found")
		      Return
		    End If

		    If Not c.DeleteWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to delete context")
		      Return
		    End If

		    response.Status = 204
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod


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
