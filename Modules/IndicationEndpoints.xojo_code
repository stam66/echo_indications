#tag Module
Protected Module IndicationEndpoints
	#tag Method, Flags = &h0
		Sub HandleCreate(request As WebRequest, response As WebResponse)
		  // POST /api/v1/indications   Authorization: Bearer <token>
		  // body: { ...indication fields... }
		  // -> 201 with the created indication (including server-assigned id)
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var user As User = APIAuth.RequireUser(request, response, db)
		    If user Is Nil Then Return

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    Var ind As New Indication
		    ind.LoadFromJSON(body)

		    If ind.Title.Trim = "" Then
		      APIResponse.WriteError(response, 400, "title is required")
		      Return
		    End If

		    If Not ind.SaveWithAudit(db, user.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save indication")
		      Return
		    End If

		    // Reload so context names are populated from the join table
		    Var saved As Indication = Indication.GetByID(db, ind.ID)
		    If saved <> Nil Then
		      APIResponse.WriteJSON(response, saved.ToJSONItem, 201)
		    Else
		      APIResponse.WriteJSON(response, ind.ToJSONItem, 201)
		    End If
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  // DELETE /api/v1/indications/:id   Authorization: Bearer <token>
		  // -> 204 on success, 404 if not found
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var user As User = APIAuth.RequireUser(request, response, db)
		    If user Is Nil Then Return

		    Var ind As Indication = Indication.GetByID(db, id)
		    If ind Is Nil Then
		      APIResponse.WriteError(response, 404, "Indication not found")
		      Return
		    End If

		    If Not ind.DeleteWithAudit(db, user.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to delete indication")
		      Return
		    End If

		    response.Status = 204
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
		    Var ind As Indication = Indication.GetByID(db, id)
		    If ind Is Nil Then
		      APIResponse.WriteError(response, 404, "Indication not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, ind.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var indications() As Indication = Indication.GetAll(db)
		    Var json As New JSONItem
		    json.Load("[]")
		    For Each ind As Indication In indications
		      json.Add(ind.ToJSONItem)
		    Next
		    APIResponse.WriteJSON(response, json, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleUpdate(request As WebRequest, response As WebResponse, id As Integer)
		  // PUT /api/v1/indications/:id   Authorization: Bearer <token>
		  // body: { ...indication fields to update... }
		  // -> 200 with the updated indication
		  // Missing keys in the body keep their existing values (PATCH-style).
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var user As User = APIAuth.RequireUser(request, response, db)
		    If user Is Nil Then Return

		    Var ind As Indication = Indication.GetByID(db, id)
		    If ind Is Nil Then
		      APIResponse.WriteError(response, 404, "Indication not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    ind.LoadFromJSON(body)

		    If ind.Title.Trim = "" Then
		      APIResponse.WriteError(response, 400, "title is required")
		      Return
		    End If

		    If Not ind.SaveWithAudit(db, user.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save indication")
		      Return
		    End If

		    Var saved As Indication = Indication.GetByID(db, ind.ID)
		    APIResponse.WriteJSON(response, saved.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod


End Module
#tag EndModule
