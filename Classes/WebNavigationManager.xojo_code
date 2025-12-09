#tag Class
Protected Class WebNavigationManager
	#tag Method, Flags = &h0
		Sub Constructor(session as WebSession)
		  mSession = session
		  mNavigationHistory.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogNavigation(action As String, pageName As String)
		  
		  Var logEntry As String = DateTime.Now.ToString + " - " + action + ": " + pageName
		  System.DebugLog(logEntry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateBack()
		  If mCurrentPageIndex > 0 Then // can go back
		    mCurrentPageIndex = mCurrentPageIndex - 1 
		    Var previousPage As WebPage = mNavigationHistory(mCurrentPageIndex)
		    LogNavigation("Back", previousPage.Name)
		    NavigateToPage(previousPage)
		  else
		    LogNavigation("Error", "No previous page")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateForward()
		  If mCurrentPageIndex < UBound(mNavigationHistory) Then // can go forward
		    mCurrentPageIndex = mCurrentPageIndex + 1
		    Var nextPage As WebPage = mNavigationHistory(mCurrentPageIndex)
		    LogNavigation("Forward", nextPage.Name)
		    NavigateToPage(nextPage)
		  else
		    LogNavigation("Error", "No next page")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateToPage(page as WebDialog)
		  LogNavigation("Navigate", page.Name)
		  page.show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NavigateToPage(page as WebPage)
		  ' Add to history if it's different from current page
		  If mCurrentPageIndex = -1 Or (mCurrentPageIndex <= UBound(mNavigationHistory) And mNavigationHistory(mCurrentPageIndex) <> page) Then
		    If mCurrentPageIndex < UBound(mNavigationHistory) Then  ' Remove any forward history if we're navigating from middle of history
		      mNavigationHistory.ResizeTo(mCurrentPageIndex)
		    End If
		    mNavigationHistory.Add(page)  ' Add new page to history
		    mCurrentPageIndex = UBound(mNavigationHistory)
		    LogNavigation("Navigate", page.Name)
		  End If
		  page.show
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Read me
		# Stam Kapetanakis - 15 September 2025
		## Simple page navigation system for web apps.
		
		## How to implement into the web project
		
		1. Add property "NavigationManager" of type "WebNavigationManager" and intantiate in session.opening:
		NavigationManager = New WebNavigationManager(Self)               // instatiates class and pass the current session to it
		
		2. Start the navigation history by navigating to the homepage/landingpage
		Var w as new homepage
		session.NavigationManager.NavigateToPage(w)        
		
		
		
		## Use the below to handle all web page navigation:
		
		session.NavigationManager.NavigateBack, 
		session.NavigationManager.NavigateForward, 
		session.NavigationManager.NavigateToPage(pageName) 
		
		
		## WebNavigationManager outputs messages and errors to console. TODO: Currently the page names are not logging...
	#tag EndNote


	#tag Property, Flags = &h21
		Private mCurrentPageIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNavigationHistory() As WebPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSession As WebSession
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
End Class
#tag EndClass
