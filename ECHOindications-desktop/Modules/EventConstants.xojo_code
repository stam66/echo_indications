#tag Module
Protected Module EventConstants
	#tag Note, Name = Usage
		# Events Module - PubSub Event Constants
		
		This module defines all PubSub event names used throughout the application.
		Using constants ensures consistency and helps prevent typos.
		
		## Usage Pattern:
		
		### Subscribe to events:
		```xojo
		Sub Opening()
		  PubSub.Subscribe(EventConstants.INDICATION_UPDATED, AddressOf HandleIndicationUpdated, Self)
		  PubSub.Subscribe(EventConstants.AUTH_LOGIN, AddressOf HandleLogin, Self)
		End Sub
		
		Sub HandleIndicationUpdated(data As Variant)
		  ' Refresh the list
		  LoadData()
		End Sub
		
		Sub Closing()
		  PubSub.UnsubscribeTarget(Self)  ' Clean up all subscriptions for this object
		End Sub
		```
		
		### Broadcast events:
		```xojo
		' After saving an indication
		PubSub.Broadcast(EventConstants.INDICATION_CREATED, indicationObject)

		' After deleting
		PubSub.Broadcast(EventConstants.INDICATION_DELETED, indicationID)

		' Generic data refresh
		PubSub.Broadcast(EventConstants.DATA_REFRESH, nil)
		```
		
		## Event Data Conventions:
		
		- **_CREATED**: Pass the new object (Indication, User, etc.)
		- **_UPDATED**: Pass the updated object
		- **_DELETED**: Pass the deleted object's ID (Integer)
		- **AUTH_LOGIN**: Pass user data Dictionary
		- **AUTH_LOGOUT**: Pass nil
		- **DATA_REFRESH**: Pass nil or optional table name String
		- **NAVIGATION_CHANGED**: Pass container name String
	#tag EndNote


	#tag Constant, Name = AUDIT_CREATED, Type = String, Dynamic = False, Default = \"audit.created", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"audit.created"
	#tag EndConstant

	#tag Constant, Name = AUTH_LOGIN, Type = String, Dynamic = False, Default = \"auth.login", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"auth.login"
	#tag EndConstant

	#tag Constant, Name = AUTH_LOGOUT, Type = String, Dynamic = False, Default = \"auth.logout", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"auth.logout"
	#tag EndConstant

	#tag Constant, Name = CHANGEREQUEST_CREATED, Type = String, Dynamic = False, Default = \"changerequest.created", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"changerequest.created"
	#tag EndConstant

	#tag Constant, Name = CHANGEREQUEST_DELETED, Type = String, Dynamic = False, Default = \"changerequest.deleted", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"changerequest.deleted"
	#tag EndConstant

	#tag Constant, Name = CHANGEREQUEST_UPDATED, Type = String, Dynamic = False, Default = \"changerequest.updated", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"changerequest.updated"
	#tag EndConstant

	#tag Constant, Name = CONTEXT_CREATED, Type = String, Dynamic = False, Default = \"context.created", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"context.created"
	#tag EndConstant

	#tag Constant, Name = CONTEXT_DELETED, Type = String, Dynamic = False, Default = \"context.deleted", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"context.deleted"
	#tag EndConstant

	#tag Constant, Name = CONTEXT_UPDATED, Type = String, Dynamic = False, Default = \"context.updated", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"context.updated"
	#tag EndConstant

	#tag Constant, Name = DATA_REFRESH, Type = String, Dynamic = False, Default = \"data.refresh", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"data.refresh"
	#tag EndConstant

	#tag Constant, Name = INDICATION_CREATED, Type = String, Dynamic = False, Default = \"indication.created", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"indication.created"
	#tag EndConstant

	#tag Constant, Name = INDICATION_DELETED, Type = String, Dynamic = False, Default = \"indication.deleted", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"indication.deleted"
	#tag EndConstant

	#tag Constant, Name = INDICATION_UPDATED, Type = String, Dynamic = False, Default = \"indication.updated", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"indication.updated"
	#tag EndConstant

	#tag Constant, Name = NAVIGATION_CHANGED, Type = String, Dynamic = False, Default = \"navigation.changed", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"navigation.changed"
	#tag EndConstant

	#tag Constant, Name = USER_CREATED, Type = String, Dynamic = False, Default = \"user.created", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"user.created"
	#tag EndConstant

	#tag Constant, Name = USER_DELETED, Type = String, Dynamic = False, Default = \"user.deleted", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"user.deleted"
	#tag EndConstant

	#tag Constant, Name = USER_UPDATED, Type = String, Dynamic = False, Default = \"user.updated", Scope = Public
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"user.updated"
	#tag EndConstant


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
