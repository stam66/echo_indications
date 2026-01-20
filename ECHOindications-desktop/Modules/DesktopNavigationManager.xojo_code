#tag Module
Protected Module DesktopNavigationManager
	#tag Method, Flags = &h0
		Function CanGoBack() As Boolean
		  Return mCurrentIndex > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanGoForward() As Boolean
		  Return mCurrentIndex < UBound(mNavigationHistory)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateContainerInstance(containerName As String) As DesktopContainer
		  ' Create appropriate container instance based on name
		  Select Case containerName.Lowercase
		  Case "indications"
		    Return New IndicationsContainer
		  Case "issues"
		    Return New IssuesContainer
		  Case "audit"
		    Return New AuditContainer
		  Case "settings"
		    Return New SettingsContainer
		  Case "users"
		    Return New UsersContainer
		  Else
		    Return Nil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCurrentRoute() As String
		  If mCurrentIndex >= 0 And mCurrentIndex <= UBound(mNavigationHistory) Then
		    Return mNavigationHistory(mCurrentIndex)
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize(masterWindow as wMaster)
		  mMasterWindow = masterWindow
		  mNavigationHistory.ResizeTo(-1)
		  mCurrentIndex = -1
		  
		  LogNavigation("Initialized", "DesktopNavigationManager ready")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsValidContainer(containerName As String) As Boolean
		  ' Validate that the container name is recognized
		  Var validNames() As String = Array("Indications", "Issues", "Audit", "Settings", "Users")
		  
		  For Each validName As String In validNames
		    If containerName.Lowercase = validName.Lowercase Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadContainer(containerName As String)
		  ' Call the master window's container loading logic
		  If mMasterWindow <> Nil Then
		    Var newContainer As DesktopContainer = CreateContainerInstance(containerName)
		    
		    If newContainer <> Nil Then
		      ' Remove current container
		      If mMasterWindow.CurrentContainer <> Nil Then
		        mMasterWindow.Placeholder.RemoveControl(mMasterWindow.CurrentContainer)
		      End If
		      
		      ' Embed new container
		      mMasterWindow.CurrentContainer = newContainer
		      newContainer.EmbedWithin(mMasterWindow.Placeholder, 0, 0, _
		      mMasterWindow.Placeholder.Width, mMasterWindow.Placeholder.Height)
		      
		      ' Update section title if available
		      UpdateSectionTitle(containerName)
		    Else
		      LogNavigation("Error", "Failed to create container: " + containerName)
		    End If
		  Else
		    LogNavigation("Error", "Master window reference is nil")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogNavigation(action As String, details As String)
		  If AppConfig.DEBUG_MODE Then
		    Var logEntry As String = DateTime.Now.ToString + " [NAV] " + action + ": " + details
		    System.DebugLog(logEntry)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateBack()
		  If Not CanGoBack() Then
		    LogNavigation("Error", "Cannot go back - at beginning of history")
		    Return
		  End If
		  
		  mCurrentIndex = mCurrentIndex - 1
		  Var previousRoute As String = mNavigationHistory(mCurrentIndex)
		  
		  LogNavigation("Back", "Navigating back to: " + previousRoute)
		  LoadContainer(previousRoute)
		  
		  ' Broadcast navigation event
		  PubSub.Broadcast(Events.NAVIGATION_CHANGED, previousRoute)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateForward()
		  If Not CanGoForward() Then
		    LogNavigation("Error", "Cannot go forward - at end of history")
		    Return
		  End If
		  
		  mCurrentIndex = mCurrentIndex + 1
		  Var nextRoute As String = mNavigationHistory(mCurrentIndex)
		  
		  LogNavigation("Forward", "Navigating forward to: " + nextRoute)
		  LoadContainer(nextRoute)
		  
		  ' Broadcast navigation event
		  PubSub.Broadcast(Events.NAVIGATION_CHANGED, nextRoute)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateTo(containerName As String)
		  ' Validate container name
		  If Not IsValidContainer(containerName) Then
		    LogNavigation("Error", "Invalid container name: " + containerName)
		    Return
		  End If
		  
		  ' Don't re-navigate to the same container
		  If mCurrentIndex >= 0 And mCurrentIndex <= UBound(mNavigationHistory) And _
		    mNavigationHistory(mCurrentIndex) = containerName Then
		    LogNavigation("Skip", "Already on: " + containerName)
		    Return
		  End If
		  
		  ' Truncate forward history if navigating from middle
		  If mCurrentIndex < UBound(mNavigationHistory) Then
		    mNavigationHistory.ResizeTo(mCurrentIndex)
		  End If
		  
		  ' Add to history
		  mNavigationHistory.Add(containerName)
		  mCurrentIndex = UBound(mNavigationHistory)
		  
		  LogNavigation("Navigate", containerName + " (history index: " + mCurrentIndex.ToString + ")")
		  LoadContainer(containerName)
		  
		  ' Broadcast navigation event
		  PubSub.Broadcast(Events.NAVIGATION_CHANGED, containerName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateSectionTitle(containerName As String)
		  ' Update the header section title based on current container
		  If mMasterWindow <> Nil And mMasterWindow.Header <> Nil Then
		    Select Case containerName.Lowercase
		    Case "indications"
		      mMasterWindow.Header.lblSectionTitle.Text = "Echocardiography Indications"
		    Case "issues"
		      mMasterWindow.Header.lblSectionTitle.Text = "Change Requests & Issues"
		    Case "audit"
		      mMasterWindow.Header.lblSectionTitle.Text = "Audit Trail"
		    Case "settings"
		      mMasterWindow.Header.lblSectionTitle.Text = "Settings & Contexts"
		    Case "users"
		      mMasterWindow.Header.lblSectionTitle.Text = "User Management"
		    End Select
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mCurrentIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		mMasterWindow As wMaster
	#tag EndProperty

	#tag Property, Flags = &h0
		mNavigationHistory() As String
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
