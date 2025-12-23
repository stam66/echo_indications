#tag Module
Protected Module PubSub
	#tag Method, Flags = &h0
		Sub Broadcast(eventName As String, data As Variant = Nil)
		  'Broadcast an event to all subscribers
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Check if this event has any subscribers
		  If Not mSubscriptions.HasKey(eventName) Then Return
		  
		  Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		  
		  // Loop through all subscribed targets
		  For Each target As Object In eventDict.Keys
		    // Get callbacks for this target
		    Dim callbacks() As EventCallback = eventDict.Value(target)
		    
		    // Call each callback - simple and fast!
		    For Each callback As EventCallback In callbacks
		      callback.Invoke(data)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0, Description = 416C6C2063616C6C6261636B206D6574686F6473206D7573742074616B65203120706172616D657465722061732076617269616E74
		Delegate Sub EventCallback(data As Variant)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub RemoveAllSubscriptions()
		  '  Remove all subscriptions
		  
		  mSubscriptions = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Subscribe(eventName As String, callback As EventCallback, target As Object)
		  ' Subscribe to an event
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Get or create the event dictionary
		  Dim eventDict As Dictionary
		  If mSubscriptions.HasKey(eventName) Then
		    eventDict = mSubscriptions.Value(eventName)
		  Else
		    eventDict = New Dictionary
		    mSubscriptions.Value(eventName) = eventDict
		  End If
		  
		  // Get or create the target's callback array
		  Dim callbacks() As EventCallback
		  
		  If eventDict.HasKey(target) Then
		    callbacks = eventDict.Value(target)
		  End If
		  
		  // Add callback
		  callbacks.Add(callback)
		  
		  eventDict.Value(target) = callbacks
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unsubscribe(eventName As String, callback As EventCallback, target As Object)
		  '   Unsubscribe from an event
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Check if event exists
		  If Not mSubscriptions.HasKey(eventName) Then Return
		  
		  Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		  
		  // Check if target exists for this event
		  If Not eventDict.HasKey(target) Then Return
		  
		  // Get callbacks for this target
		  Dim callbacks() As EventCallback = eventDict.Value(target)
		  Dim newCallbacks() As EventCallback
		  
		  // Remove the specific callback
		  For Each cb As EventCallback In callbacks
		    // Compare delegate references (this works in Xojo)
		    If Not (cb = callback) Then
		      newCallbacks.Add(cb)
		    End If
		  Next
		  
		  // If no callbacks left, remove the target entirely
		  If newCallbacks.Count = 0 Then
		    eventDict.Remove(target)
		  Else
		    eventDict.Value(target) = newCallbacks
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnsubscribeAll(eventName As String, target As Object)
		  ' Unsubscribe all callbacks for a target from an event
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Check if event exists
		  If Not mSubscriptions.HasKey(eventName) Then Return
		  
		  Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		  
		  // Remove target if it exists
		  If eventDict.HasKey(target) Then
		    eventDict.Remove(target)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnsubscribeTarget(target As Object)
		  ' Remove all subscriptions for a target across all events
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Loop through all events
		  For Each eventName As String In mSubscriptions.Keys
		    Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		    
		    If eventDict.HasKey(target) Then
		      eventDict.Remove(target)
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		#tag Note
			
			// Structure: Dictionary[EventName:String] -> Dictionary[Target:Object] -> EventCallback()
		#tag EndNote
		Private mSubscriptions As Dictionary
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
