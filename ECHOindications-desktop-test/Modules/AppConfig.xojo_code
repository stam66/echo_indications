#tag Module
Protected Module AppConfig
	#tag Note, Name = Description
		Application configuration constants for ECHO Indications API client
		
		This module contains all configuration values used by the API client.
		Modify these constants to match your deployment environment.
		
		Created: 2026-01-13
		API Version: 1.0
	#tag EndNote


	#tag Constant, Name = API_BASE_URL, Type = String, Dynamic = False, Default = \"https://api.echoindications.org", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"https://api.echoindications.org"
	#tag EndConstant

	#tag Constant, Name = API_TIMEOUT_SECONDS, Type = Integer, Dynamic = False, Default = \"30", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"30"
	#tag EndConstant

	#tag Constant, Name = APP_NAME, Type = String, Dynamic = False, Default = \"ECHO Indications", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"ECHO Indications"
	#tag EndConstant

	#tag Constant, Name = APP_VERSION, Type = String, Dynamic = False, Default = \"1.0", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"1.0"
	#tag EndConstant

	#tag Constant, Name = CACHE_EXPIRY_HOURS, Type = Integer, Dynamic = False, Default = \"24", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"24"
	#tag EndConstant

	#tag Constant, Name = COLOR_DARK_BG, Type = Color, Dynamic = False, Default = \"&c1a1a1a", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"&c1a1a1a"
	#tag EndConstant

	#tag Constant, Name = COLOR_DARK_PANEL, Type = Color, Dynamic = False, Default = \"&c2d2d2d", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"&c2d2d2d"
	#tag EndConstant

	#tag Constant, Name = COLOR_NHS_BLUE, Type = Color, Dynamic = False, Default = \"&c005EB8", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"&c005EB8"
	#tag EndConstant

	#tag Constant, Name = DEBUG_MODE, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"True"
	#tag EndConstant

	#tag Constant, Name = TOKEN_EXPIRY_MINUTES, Type = Integer, Dynamic = False, Default = \"30", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"30"
	#tag EndConstant

	#tag Constant, Name = TOKEN_REFRESH_BUFFER_MINUTES, Type = Integer, Dynamic = False, Default = \"5", Scope = Protected
		#Tag Instance, Platform = Any, Language = Default, Definition  = \"5"
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
