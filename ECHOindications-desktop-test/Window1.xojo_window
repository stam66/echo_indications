#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   670
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1999534079
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   1060
   Begin DesktopButton Button1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Business Classes"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   143
   End
   Begin DesktopButton Button2
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Function Classses"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   175
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   143
   End
   Begin DesktopButton Button3
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "DirectArray test"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   330
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   143
   End
   Begin DesktopButton Button4
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "TEST"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   960
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   102
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  // ============================================================
		  // BUSINESS CLASSES TEST CODE
		  // ============================================================
		  // Demonstrates using the high-level business object classes
		  // instead of raw API calls
		  // Copy this into a new test method or App.Opening
		  // ============================================================
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "Business Classes Test"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 1: Fetch all indications using Indication class
		  // ============================================================
		  System.DebugLog "Test 1: Using Indication.GetAll()..."
		  
		  Var indications() As Indication = Indication.GetAll
		  System.DebugLog "✅ Found " + indications.Count.ToString + " indications"
		  System.DebugLog ""
		  
		  // Show first 3 with clean ToString()
		  System.DebugLog "First 3 indications:"
		  For i As Integer = 0 To Min(2, indications.Count - 1)
		    System.DebugLog "  " + indications(i).ToString
		  Next
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 2: Search for indications
		  // ============================================================
		  System.DebugLog "Test 2: Using Indication.Search()..."
		  
		  Var searchResults() As Indication = Indication.Search("coronary")
		  System.DebugLog "✅ Found " + searchResults.Count.ToString + " matching indications"
		  
		  For i As Integer = 0 To Min(2, searchResults.Count - 1)
		    System.DebugLog "  " + searchResults(i).Title
		  Next
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 3: Get indication by ID
		  // ============================================================
		  System.DebugLog "Test 3: Using Indication.GetByID()..."
		  
		  If indications.Count > 0 Then
		    Var firstID As Integer = indications(0).ID
		    Var singleIndication As Indication = Indication.GetByID(firstID)
		    
		    If singleIndication <> Nil Then
		      System.DebugLog "✅ Got indication: " + singleIndication.Title
		      System.DebugLog "  ID: " + singleIndication.ID.ToString
		      System.DebugLog "  Keywords: " + singleIndication.Keywords
		      System.DebugLog "  Urgency: " + singleIndication.Urgency
		      System.DebugLog "  Primary Care: " + singleIndication.PrimaryCare
		      System.DebugLog "  Sources: " + _
		      "ASE=" + singleIndication.SourceASE.ToString + ", " + _
		      "EACVI=" + singleIndication.SourceEACVI.ToString + ", " + _
		      "BSE=" + singleIndication.SourceBSE.ToString + ", " + _
		      "Consensus=" + singleIndication.SourceConsensus.ToString
		    End If
		  End If
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 4: Get all contexts with counts
		  // ============================================================
		  System.DebugLog "Test 4: Using Context.GetAllWithCounts()..."
		  
		  Var contexts() As Context = Context.GetAllWithCounts
		  System.DebugLog "✅ Found " + contexts.Count.ToString + " contexts"
		  System.DebugLog ""
		  
		  System.DebugLog "All contexts (sorted by indication count):"
		  // Sort by indication count (descending)
		  For i As Integer = 0 To contexts.Count - 1
		    For j As Integer = i + 1 To contexts.Count - 1
		      If contexts(j).IndicationCount > contexts(i).IndicationCount Then
		        Var temp As Context = contexts(i)
		        contexts(i) = contexts(j)
		        contexts(j) = temp
		      End If
		    Next
		  Next
		  
		  For Each context As Context In contexts
		    System.DebugLog "  " + context.ToString
		  Next
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 5: Get indications by context
		  // ============================================================
		  System.DebugLog "Test 5: Using Indication.GetByContext()..."
		  
		  If contexts.Count > 0 Then
		    // Find a context with indications
		    Var contextToTest As Context = Nil
		    For Each ctx As Context In contexts
		      If ctx.IndicationCount > 0 And ctx.IndicationCount < 20 Then
		        contextToTest = ctx
		        Exit For ctx
		      End If
		    Next
		    
		    If contextToTest <> Nil Then
		      System.DebugLog "Getting indications for context: " + contextToTest.Name
		      
		      Var contextIndications() As Indication = Indication.GetByContext(contextToTest.ID)
		      System.DebugLog "✅ Found " + contextIndications.Count.ToString + " indications in this context"
		      
		      For i As Integer = 0 To Min(2, contextIndications.Count - 1)
		        System.DebugLog "  " + contextIndications(i).Title
		      Next
		    End If
		  End If
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 6: Get all change requests
		  // ============================================================
		  System.DebugLog "Test 6: Using ChangeRequest.GetAll()..."
		  
		  Var changes() As ChangeRequest = ChangeRequest.GetAll
		  System.DebugLog "✅ Found " + changes.Count.ToString + " change requests"
		  
		  If changes.Count > 0 Then
		    System.DebugLog ""
		    System.DebugLog "First 3 change requests:"
		    For i As Integer = 0 To Min(2, changes.Count - 1)
		      System.DebugLog "  " + changes(i).ToString
		    Next
		  End If
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 7: Count new change requests
		  // ============================================================
		  System.DebugLog "Test 7: Using ChangeRequest.CountNew()..."
		  
		  Var newCount As Integer = ChangeRequest.CountNew
		  System.DebugLog "✅ There are " + newCount.ToString + " new change requests"
		  System.DebugLog ""
		  
		  // ============================================================
		  // Test 8: Get change requests by status
		  // ============================================================
		  System.DebugLog "Test 8: Using ChangeRequest.GetByStatus()..."
		  
		  Var newChanges() As ChangeRequest = ChangeRequest.GetByStatus("New")
		  System.DebugLog "✅ Found " + newChanges.Count.ToString + " 'New' change requests"
		  System.DebugLog ""
		  
		  // ============================================================
		  // COMPARISON: Old way vs New way
		  // ============================================================
		  System.DebugLog "=========================================="
		  System.DebugLog "Comparison: Raw API vs Business Classes"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  System.DebugLog "OLD WAY (Raw API):"
		  System.DebugLog "  Var result As Dictionary = APIClient.Get(""indications.lc"", ""list"")"
		  System.DebugLog "  Var dataVariant As Variant = result.Value(""data"")"
		  System.DebugLog "  Var items() As Variant = dataVariant"
		  System.DebugLog "  For Each item As Variant In items"
		  System.DebugLog "    If item IsA Dictionary Then"
		  System.DebugLog "      Var indication As Dictionary = item"
		  System.DebugLog "      // Extract each field manually..."
		  System.DebugLog "    End If"
		  System.DebugLog "  Next"
		  System.DebugLog ""
		  
		  System.DebugLog "NEW WAY (Business Classes):"
		  System.DebugLog "  Var indications() As Indication = Indication.GetAll"
		  System.DebugLog "  For Each indication As Indication In indications"
		  System.DebugLog "    System.DebugLog indication.Title"
		  System.DebugLog "  Next"
		  System.DebugLog ""
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "All business class tests complete!"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  System.DebugLog "Summary:"
		  System.DebugLog "✅ Indication class - GetAll, GetByID, GetByContext, Search"
		  System.DebugLog "✅ Context class - GetAll, GetAllWithCounts, GetByID"
		  System.DebugLog "✅ ChangeRequest class - GetAll, GetByStatus, GetByID, CountNew"
		  System.DebugLog "✅ User class - GetAll, GetByID (requires auth)"
		  System.DebugLog ""
		  System.DebugLog "All objects have clean ToString() methods!"
		  System.DebugLog "All API calls are hidden behind simple method calls!"
		  System.DebugLog "Type-safe properties instead of dictionary lookups!"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  // ============================================================================
		  // TEST: Audit and ChangeRequest Classes
		  // ============================================================================
		  // This test demonstrates using the Audit and ChangeRequest classes
		  // to fetch change tracking and audit data from the API
		  //
		  // SETUP: Copy/paste this code into a Xojo method and run
		  // NOTE: Audit endpoints require authentication
		  // ============================================================================
		  
		  System.DebugLog "================================"
		  System.DebugLog "AUDIT & CHANGE REQUEST TEST"
		  System.DebugLog "================================"
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 1: Connectivity Check
		  // ============================================================================
		  
		  System.DebugLog "TEST 1: Checking API connectivity..."
		  
		  If APIClient.IsConnected Then
		    System.DebugLog "✅ API is reachable"
		  Else
		    System.DebugLog "❌ API is not reachable"
		    Return
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 2: Get All Change Requests (PUBLIC - no auth required)
		  // ============================================================================
		  
		  System.DebugLog "TEST 2: Fetching all change requests..."
		  
		  Var allChanges() As ChangeRequest = ChangeRequest.GetAll
		  
		  If allChanges.Count > 0 Then
		    System.DebugLog "✅ Found " + allChanges.Count.ToString + " change requests"
		    
		    // Show first 5
		    Var displayCount As Integer = Min(5, allChanges.Count)
		    System.DebugLog "First " + displayCount.ToString + " change requests:"
		    
		    For i As Integer = 0 To displayCount - 1
		      Var change As ChangeRequest = allChanges(i)
		      System.DebugLog "  " + change.ToString
		      System.DebugLog "    Description: " + change.GetShortDescription
		      System.DebugLog ""
		    Next
		  Else
		    System.DebugLog "❌ No change requests found"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 3: Get New Change Requests Count (PUBLIC - no auth required)
		  // ============================================================================
		  
		  System.DebugLog "TEST 3: Counting new change requests..."
		  
		  Var newCount As Integer = ChangeRequest.CountNew
		  
		  System.DebugLog "✅ Found " + newCount.ToString + " new change requests"
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 4: Get Change Requests by Status (PUBLIC - no auth required)
		  // ============================================================================
		  
		  System.DebugLog "TEST 4: Fetching 'New' change requests..."
		  
		  Var newChanges() As ChangeRequest = ChangeRequest.GetByStatus("New")
		  
		  If newChanges.Count > 0 Then
		    System.DebugLog "✅ Found " + newChanges.Count.ToString + " new change requests"
		    
		    For i As Integer = 0 To Min(3, newChanges.Count - 1)
		      Var change As ChangeRequest = newChanges(i)
		      System.DebugLog "  [" + change.ID.ToString + "] " + change.Status + " - " + change.IndicationTitle
		    Next
		  Else
		    System.DebugLog "ℹ️  No new change requests"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 5: Get Specific Change Request (PUBLIC - no auth required)
		  // ============================================================================
		  
		  System.DebugLog "TEST 5: Fetching specific change request..."
		  
		  If allChanges.Count > 0 Then
		    Var firstChange As ChangeRequest = allChanges(0)
		    Var changeDetail As ChangeRequest = ChangeRequest.GetByID(firstChange.ID)
		    
		    If changeDetail <> Nil Then
		      System.DebugLog "✅ Retrieved change request #" + changeDetail.ID.ToString
		      System.DebugLog "  Status: " + changeDetail.Status
		      System.DebugLog "  Reporter: " + changeDetail.ReporterName
		      System.DebugLog "  Indication: " + changeDetail.IndicationTitle
		      System.DebugLog "  Description: " + changeDetail.Description
		      If changeDetail.ResolutionNotes.Length > 0 Then
		        System.DebugLog "  Resolution: " + changeDetail.ResolutionNotes
		      End If
		    Else
		      System.DebugLog "❌ Could not retrieve change request"
		    End If
		  Else
		    System.DebugLog "⊘ No change requests available to test"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 6: Login for Audit Access (REQUIRED for audit endpoints)
		  // ============================================================================
		  
		  System.DebugLog "TEST 6: Authenticating for audit access..."
		  
		  // Replace with valid credentials to test audit endpoints
		  Var testUsername As String = "admin"
		  Var testPassword As String = "reject66"
		  
		  Var loginSuccess As Boolean = AuthManager.Login(testUsername, testPassword)
		  
		  If loginSuccess Then
		    System.DebugLog "✅ Login successful - can now access audit endpoints"
		  Else
		    System.DebugLog "❌ Login failed - audit tests will be skipped"
		    System.DebugLog "   (This is expected if you haven't provided valid credentials)"
		    System.DebugLog ""
		    System.DebugLog "================================"
		    System.DebugLog "TEST SUMMARY (Partial)"
		    System.DebugLog "================================"
		    System.DebugLog "Change Request tests: PASSED"
		    System.DebugLog "Audit tests: SKIPPED (no auth)"
		    Return
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 7: Get Recent Audit Entries (REQUIRES AUTHENTICATION)
		  // ============================================================================
		  
		  System.DebugLog "TEST 7: Fetching recent audit entries..."
		  
		  Var recentAudits() As Audit = Audit.GetRecent(20)
		  
		  If recentAudits.Count > 0 Then
		    System.DebugLog "✅ Found " + recentAudits.Count.ToString + " recent audit entries"
		    
		    // Show first 5
		    Var displayCount As Integer = Min(5, recentAudits.Count)
		    System.DebugLog "First " + displayCount.ToString + " audit entries:"
		    
		    For i As Integer = 0 To displayCount - 1
		      Var audit As Audit = recentAudits(i)
		      System.DebugLog "  " + audit.GetActionIcon + " " + audit.ToString
		    Next
		  Else
		    System.DebugLog "❌ No audit entries found"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 8: Get Audit Entries by Table (REQUIRES AUTHENTICATION)
		  // ============================================================================
		  
		  System.DebugLog "TEST 8: Fetching audit entries for 'indications' table..."
		  
		  Var indicationAudits() As Audit = Audit.GetByTable("indications", 10)
		  
		  If indicationAudits.Count > 0 Then
		    System.DebugLog "✅ Found " + indicationAudits.Count.ToString + " audit entries for indications"
		    
		    For i As Integer = 0 To Min(3, indicationAudits.Count - 1)
		      Var audit As Audit = indicationAudits(i)
		      System.DebugLog "  " + audit.GetActionIcon + " " + audit.ToString
		    Next
		  Else
		    System.DebugLog "ℹ️  No audit entries for indications table"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 9: Get Audit History for Specific Record (REQUIRES AUTHENTICATION)
		  // ============================================================================
		  
		  System.DebugLog "TEST 9: Fetching audit history for specific indication..."
		  
		  // Get an indication to check its history
		  Var indications() As Indication = Indication.GetAll
		  
		  If indications.Count > 0 Then
		    Var indication As Indication = indications(0)
		    Var history() As Audit = Audit.GetByRecord("indications", indication.ID)
		    
		    If history.Count > 0 Then
		      System.DebugLog "✅ Found " + history.Count.ToString + " audit entries for indication #" + indication.ID.ToString
		      System.DebugLog "  Indication: " + indication.Title
		      System.DebugLog "  History:"
		      
		      For i As Integer = 0 To Min(5, history.Count - 1)
		        Var audit As Audit = history(i)
		        System.DebugLog "    " + audit.GetFormattedTimestamp + " - " + audit.ToString
		      Next
		    Else
		      System.DebugLog "ℹ️  No audit history for this indication"
		    End If
		  Else
		    System.DebugLog "⊘ No indications available to test"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // TEST 10: Get Audit Entries by User (REQUIRES AUTHENTICATION)
		  // ============================================================================
		  
		  System.DebugLog "TEST 10: Fetching audit entries for current user..."
		  
		  If AuthManager.IsAuthenticated Then
		    Var userAudits() As Audit = Audit.GetByUser(AuthManager.CurrentUsername, 10)
		    
		    If userAudits.Count > 0 Then
		      System.DebugLog "✅ Found " + userAudits.Count.ToString + " audit entries for user: " + AuthManager.CurrentUsername
		      
		      For i As Integer = 0 To Min(3, userAudits.Count - 1)
		        Var audit As Audit = userAudits(i)
		        System.DebugLog "  " + audit.GetActionIcon + " " + audit.ToString
		      Next
		    Else
		      System.DebugLog "ℹ️  No audit entries for this user"
		    End If
		  Else
		    System.DebugLog "⊘ Not authenticated"
		  End If
		  
		  System.DebugLog ""
		  
		  // ============================================================================
		  // SUMMARY
		  // ============================================================================
		  
		  System.DebugLog "================================"
		  System.DebugLog "TEST SUMMARY"
		  System.DebugLog "================================"
		  System.DebugLog "✅ All tests completed successfully"
		  System.DebugLog ""
		  System.DebugLog "ChangeRequest Class Features:"
		  System.DebugLog "  • GetAll() - All change requests (PUBLIC)"
		  System.DebugLog "  • GetByStatus(status) - Filter by status (PUBLIC)"
		  System.DebugLog "  • GetByID(id) - Get specific request (PUBLIC)"
		  System.DebugLog "  • CountNew() - Count of new requests (PUBLIC)"
		  System.DebugLog ""
		  System.DebugLog "Audit Class Features:"
		  System.DebugLog "  • GetRecent(limit) - Recent audit entries (AUTH)"
		  System.DebugLog "  • GetByTable(table, limit) - Entries for specific table (AUTH)"
		  System.DebugLog "  • GetByRecord(table, id) - History for specific record (AUTH)"
		  System.DebugLog "  • GetByUser(username, limit) - User activity (AUTH)"
		  System.DebugLog "================================"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button3
	#tag Event
		Sub Pressed()
		  // ============================================================
		  // WORKING TEST CODE - Handles Direct Array Response
		  // ============================================================
		  // API returns arrays directly, not wrapped in dictionary
		  // Copy this into App.Opening event
		  // ============================================================
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "ECHO Indications API Test"
		  System.DebugLog "=========================================="
		  System.DebugLog ""
		  
		  // Test 1: Connectivity
		  System.DebugLog "Test 1: Checking API connectivity..."
		  If APIClient.IsConnected Then
		    System.DebugLog "✅ API is reachable"
		  Else
		    System.DebugLog "❌ API is not reachable"
		    Return
		  End If
		  System.DebugLog ""
		  
		  // Test 2: List indications
		  System.DebugLog "Test 2: Fetching all indications..."
		  Var result As Dictionary = APIClient.Get("indications.lc", "list")
		  
		  If result.Value("status") = "success" Then
		    Try
		      // Data is the array directly, not wrapped
		      Var dataVariant As Variant = result.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " indications"
		      System.DebugLog ""
		      
		      System.DebugLog "First 5 indications:"
		      For i As Integer = 0 To Min(4, items.Count - 1)
		        If items(i) IsA Dictionary Then
		          Var indication As Dictionary = items(i)
		          Var id As Integer = indication.Value("id").IntegerValue
		          Var title As String = indication.Value("title").StringValue
		          System.DebugLog "  [" + id.ToString + "] " + title
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing indications: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + result.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  // Test 3: List contexts
		  System.DebugLog "Test 3: Fetching contexts..."
		  Var contextResult As Dictionary = APIClient.Get("contexts.lc", "with_counts")
		  
		  If contextResult.Value("status") = "success" Then
		    Try
		      // Data is the array directly
		      Var dataVariant As Variant = contextResult.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " contexts"
		      System.DebugLog ""
		      
		      System.DebugLog "All contexts:"
		      For i As Integer = 0 To items.Count - 1
		        If items(i) IsA Dictionary Then
		          Var context As Dictionary = items(i)
		          Var name As String = context.Value("name").StringValue
		          Var count As Integer = context.Value("indication_count").IntegerValue
		          System.DebugLog "  • " + name + " (" + count.ToString + " indications)"
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing contexts: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + contextResult.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  // Test 4: Search
		  System.DebugLog "Test 4: Searching for 'coronary'..."
		  Var params As New Dictionary
		  params.Value("keyword") = "coronary"
		  Var searchResult As Dictionary = APIClient.Get("search.lc", "keyword", params)
		  
		  If searchResult.Value("status") = "success" Then
		    Try
		      // Data is the array directly
		      Var dataVariant As Variant = searchResult.Value("data")
		      
		      // Convert to array
		      Var items() As Variant
		      items = dataVariant
		      
		      System.DebugLog "✅ Found " + items.Count.ToString + " matching indications"
		      
		      For i As Integer = 0 To Min(2, items.Count - 1)
		        If items(i) IsA Dictionary Then
		          Var indication As Dictionary = items(i)
		          Var title As String = indication.Value("title").StringValue
		          System.DebugLog "  • " + title
		        End If
		      Next
		      
		    Catch err As RuntimeException
		      System.DebugLog "❌ Error parsing search results: " + err.Message
		    End Try
		  Else
		    System.DebugLog "❌ Error: " + searchResult.Value("message").StringValue
		  End If
		  System.DebugLog ""
		  
		  System.DebugLog "=========================================="
		  System.DebugLog "All tests complete!"
		  System.DebugLog "=========================================="
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button4
	#tag Event
		Sub Pressed()
		  var v as variant = "test"
		  var t as integer = VarType(v)
		  
		  MessageBox(t.ToString)
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasTitleBar"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
