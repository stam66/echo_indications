#tag Module
Protected Module PubSubOld
	#tag Method, Flags = &h0
		Sub Broadcast(eventName As String, data As Variant = Nil)
		  ' Public Sub Broadcast(eventName As String, data As Variant = Nil)
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Check if this event has any subscribers
		  If Not mSubscriptions.HasKey(eventName) Then Return
		  
		  Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		  
		  // Loop through all subscribed targets
		  For Each target As Object In eventDict.Keys
		    // Get callbacks for this target
		    Dim callbacks() As String = eventDict.Value(target)
		    
		    // Call each callback method on the target
		    For Each callbackName As String In callbacks
		      Try
		        Dim ti As Introspection.TypeInfo = Introspection.GetType(target)
		        Dim methods() As Introspection.MethodInfo = ti.GetMethods
		        
		        For Each mi As Introspection.MethodInfo In methods
		          If mi.Name = callbackName Then
		            // Call with or without parameter depending on method signature
		            Dim params() As Introspection.ParameterInfo = mi.GetParameters
		            If params.Count = 0 Then
		              mi.Invoke(target)
		            Else
		              // Pass parameters as an array
		              Dim args() As Variant
		              args.Add(data)
		              mi.Invoke(target, args)
		            End If
		            Exit For mi
		          End If
		        Next
		        
		      Catch e As RuntimeException
		        // Silently ignore if method doesn't exist or can't be called
		      End Try
		    Next
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllSubscriptions()
		  mSubscriptions = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Subscribe(eventName As String, callbackMethod As String, target As Object)
		  ' Public Sub Subscribe(eventName As String, callbackMethod As String, target As Object)
		  
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
		  Dim callbacks() As String
		  
		  If eventDict.HasKey(target) Then
		    callbacks = eventDict.Value(target)
		  End If
		  
		  // Add callback if not already present
		  If callbacks.IndexOf(callbackMethod) = -1 Then
		    callbacks.Add(callbackMethod)
		  End If
		  
		  eventDict.Value(target) = callbacks
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unsubscribe(eventName As String, callbackMethod As String = "", target As Object)
		  ' Public Sub Unsubscribe(eventName As String, callbackMethod As String = "", target As Object)
		  
		  
		  // Initialize if needed
		  If mSubscriptions = Nil Then mSubscriptions = New Dictionary
		  
		  // Check if event exists
		  If Not mSubscriptions.HasKey(eventName) Then Return
		  
		  Dim eventDict As Dictionary = mSubscriptions.Value(eventName)
		  
		  // Check if target exists for this event
		  If Not eventDict.HasKey(target) Then Return
		  
		  // If no callback specified, remove all callbacks for this target
		  If callbackMethod = "" Then
		    eventDict.Remove(target)
		  Else
		    // Remove specific callback
		    Dim callbacks() As String = eventDict.Value(target)
		    Dim newCallbacks() As String
		    
		    For Each cb As String In callbacks
		      If cb <> callbackMethod Then
		        newCallbacks.Add(cb)
		      End If
		    Next
		    
		    // If no callbacks left, remove the target entirely
		    If newCallbacks.Count = 0 Then
		      eventDict.Remove(target)
		    Else
		      eventDict.Value(target) = newCallbacks
		    End If
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			// Structure: Dictionary[EventName:String] -> Dictionary[Target:WeakRef] -> String() of callback method names
		#tag EndNote
		mSubscriptions As Dictionary
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
