#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFiles1
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vR3JhcGhpY3MvaGVhcnRfbmV3LnN2Zw==
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				  macOSEntitlements={"App Sandbox":"False","Hardened Runtime":"False","Notarize":"False","UserEntitlements":""}
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFiles2
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vR3JhcGhpY3MvaGVhcnRfbmV3LnN2Zw==
				End
			End
#tag EndBuildAutomation
