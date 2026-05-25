#tag Module
Protected Module DecisionNodeEndpoints
	#tag Method, Flags = &h0
		Sub HandleList(request As WebRequest, response As WebResponse)
		  // GET /api/v1/decision-nodes              -> all nodes (flat)
		  // GET /api/v1/decision-nodes?roots=1      -> only root nodes (parent_id IS NULL)
		  // GET /api/v1/decision-nodes?parent=N     -> children of node N
		  // Public — the decision tree is read-only metadata for clients.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var qs As String = request.QueryString
		    Var nodes() As DecisionNode

		    If qs.IndexOf("roots=1") >= 0 Then
		      nodes = DecisionNode.GetRoots(db)
		    ElseIf qs.IndexOf("parent=") >= 0 Then
		      Var parentID As Integer = APIHelpers.QueryInt(qs, "parent")
		      nodes = DecisionNode.GetChildren(db, parentID)
		    Else
		      nodes = DecisionNode.GetAll(db)
		    End If

		    Var json As New JSONItem
		    json.Load("[]")
		    For Each n As DecisionNode In nodes
		      json.Add(n.ToJSONItem)
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
		    Var n As DecisionNode = DecisionNode.GetByID(db, id)
		    If n Is Nil Then
		      APIResponse.WriteError(response, 404, "Decision node not found")
		      Return
		    End If
		    APIResponse.WriteJSON(response, n.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleListByIndication(request As WebRequest, response As WebResponse, indicationID As Integer)
		  // GET /api/v1/indications/:id/decision-nodes
		  // Returns leaf nodes whose verdict is this indication.
		  #Pragma Unused request
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var nodes() As DecisionNode = DecisionNode.GetByIndicationID(db, indicationID)
		    Var json As New JSONItem
		    json.Load("[]")
		    For Each n As DecisionNode In nodes
		      json.Add(n.ToJSONItem)
		    Next
		    APIResponse.WriteJSON(response, json, 200)
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

		    Var n As New DecisionNode
		    n.LoadFromJSON(body)

		    If n.OptionLabel.Trim = "" Then
		      APIResponse.WriteError(response, 400, "option_label is required")
		      Return
		    End If

		    If Not n.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save decision node")
		      Return
		    End If

		    Var saved As DecisionNode = DecisionNode.GetByID(db, n.ID)
		    APIResponse.WriteJSON(response, If(saved <> Nil, saved.ToJSONItem, n.ToJSONItem), 201)
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

		    Var n As DecisionNode = DecisionNode.GetByID(db, id)
		    If n Is Nil Then
		      APIResponse.WriteError(response, 404, "Decision node not found")
		      Return
		    End If

		    Var body As JSONItem
		    Try
		      body = New JSONItem(request.Body)
		    Catch
		      APIResponse.WriteError(response, 400, "Invalid JSON body")
		      Return
		    End Try

		    n.LoadFromJSON(body)

		    If n.OptionLabel.Trim = "" Then
		      APIResponse.WriteError(response, 400, "option_label is required")
		      Return
		    End If

		    If Not n.SaveWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to save decision node")
		      Return
		    End If

		    Var saved As DecisionNode = DecisionNode.GetByID(db, n.ID)
		    APIResponse.WriteJSON(response, saved.ToJSONItem, 200)
		  Finally
		    db.Close
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleDelete(request As WebRequest, response As WebResponse, id As Integer)
		  // ON DELETE CASCADE in the schema removes the whole subtree.
		  Var db As MySQLCommunityServer = APIHelpers.GetDB
		  If db Is Nil Or Not db.IsConnected Then
		    APIResponse.WriteError(response, 503, "Database unavailable")
		    Return
		  End If

		  Try
		    Var caller As User = APIAuth.RequireUser(request, response, db)
		    If caller Is Nil Then Return

		    Var n As DecisionNode = DecisionNode.GetByID(db, id)
		    If n Is Nil Then
		      APIResponse.WriteError(response, 404, "Decision node not found")
		      Return
		    End If

		    If Not n.DeleteWithAudit(db, caller.Username) Then
		      APIResponse.WriteError(response, 500, "Failed to delete decision node")
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
