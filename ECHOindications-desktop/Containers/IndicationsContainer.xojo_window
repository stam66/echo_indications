#tag DesktopWindow
Begin DesktopContainer IndicationsContainer
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   600
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   False
   Visible         =   True
   Width           =   1100
   Begin DesktopSearchField txtSearch
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      Enabled         =   True
      Height          =   26
      Hint            =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   204
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   37
      Transparent     =   False
      Visible         =   True
      Width           =   663
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopButton btnNew
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "New"
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
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton btnDelete
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Delete"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   112
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopPopupMenu popContexts
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   879
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   -1
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   201
   End
   Begin DesktopLabel lblSearchInfo
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   10.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   True
      Left            =   208
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Separate search terms with a comma"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   213
   End
   Begin DesktopLabel lblFoundCount
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   14.0
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
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Found Count"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   198
   End
   Begin DesktopListBox lstIndications
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   "50%, 25%, 25%"
      DefaultRowHeight=   30
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   430
      Index           =   -2147483648
      InitialValue    =   "Indications	Contexts	Keywords"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   150
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   1060
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  ' Clean up PubSub subscriptions
		  PubSub.UnsubscribeTarget(Self)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  ' Subscribe to PubSub events
		  PubSub.Subscribe(EventConstants.INDICATION_CREATED, AddressOf HandleIndicationChanged, Self)
		  PubSub.Subscribe(EventConstants.INDICATION_UPDATED, AddressOf HandleIndicationChanged, Self)
		  PubSub.Subscribe(EventConstants.INDICATION_DELETED, AddressOf HandleIndicationChanged, Self)
		  PubSub.Subscribe(EventConstants.DATA_REFRESH, AddressOf HandleDataRefresh, Self)
		  
		  ' Load contexts for filter dropdown
		  LoadContexts()
		  
		  ' Load initial data
		  LoadIndications()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleDataRefresh(data As Variant)
		  #Pragma Unused data
		  
		  ' Generic refresh handler
		  LoadIndications()
		  LoadContexts()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleIndicationChanged(data As Variant)
		  #Pragma Unused  data
		  
		  ' Refresh the list when any indication changes
		  LoadIndications()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadContexts()
		  Try
		    ' Clear existing items
		    popContexts.RemoveAllRows()
		    
		    ' Add "All Contexts" option
		    popContexts.AddRow("All Contexts")
		    popContexts.RowTagAt(0) = 0
		    
		    ' Initialize context lookup dictionary
		    mContextLookup = New Dictionary
		    
		    ' Load contexts from API
		    Var contexts() As Context = Context.GetAllWithCounts()
		    
		    For Each ctx As Context In contexts
		      ' Add to lookup dictionary (maps ID to name)
		      mContextLookup.Value(ctx.ID) = ctx.Name
		      
		      If ctx.IsActive Then
		        Var displayText As String = ctx.Name
		        If ctx.IndicationCount > 0 Then
		          displayText = displayText + " (" + ctx.IndicationCount.ToString + ")"
		        End If
		        popContexts.AddRow(displayText)
		        popContexts.RowTagAt(popContexts.LastAddedRowIndex) = ctx.ID
		      End If
		    Next
		    
		    ' Select "All Contexts" by default
		    popContexts.SelectedRowIndex = 0
		    
		  Catch err As RuntimeException
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("IndicationsContainer: Error loading contexts - " + err.Message)
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadIndications()
		  Try
		    lstIndications.RemoveAllRows()
		    
		    Var indications() As Indication
		    Var searchText As String = txtSearch.Text.Trim
		    Var selectedContextID As Integer = 0
		    
		    ' Get selected context ID from popup
		    If popContexts.SelectedRowIndex >= 0 Then
		      selectedContextID = popContexts.RowTagAt(popContexts.SelectedRowIndex)
		    End If
		    
		    ' Determine which API call to make
		    If searchText.Length > 0 Then
		      ' Search by keywords
		      indications = Indication.Search(searchText)
		    ElseIf selectedContextID > 0 Then
		      ' Filter by context
		      indications = Indication.GetByContext(selectedContextID)
		    Else
		      ' Get all indications
		      indications = Indication.GetAll()
		    End If
		    
		    ' Filter by context if search was performed and context is selected
		    If searchText.Length > 0 And selectedContextID > 0 Then
		      Var filtered() As Indication
		      For Each ind As Indication In indications
		        If ind.ContextIDs.IndexOf(selectedContextID) >= 0 Then
		          filtered.Add(ind)
		        End If
		      Next
		      indications = filtered
		    End If
		    
		    ' Populate the listbox
		    For Each ind As Indication In indications
		      lstIndications.AddRow(ind.Title)
		      Var row As Integer = lstIndications.LastAddedRowIndex
		      
		      ' Store indication object in row tag for later retrieval
		      lstIndications.RowTagAt(row) = ind
		      
		      ' Add contexts - map IDs to names if ContextNames is empty
		      If ind.ContextNames.Count > 0 Then
		        lstIndications.CellTextAt(row, 1) = String.FromArray(ind.ContextNames, ", ")
		      ElseIf ind.ContextIDs.Count > 0 And mContextLookup <> Nil Then
		        ' Map context IDs to names using lookup
		        Var contextNames() As String
		        For Each contextID As Integer In ind.ContextIDs
		          If mContextLookup.HasKey(contextID) Then
		            contextNames.Add(mContextLookup.Value(contextID).StringValue)
		          End If
		        Next
		        If contextNames.Count > 0 Then
		          lstIndications.CellTextAt(row, 1) = String.FromArray(contextNames, ", ")
		        Else
		          lstIndications.CellTextAt(row, 1) = ""
		        End If
		      Else
		        lstIndications.CellTextAt(row, 1) = ""
		        If AppConfig.DEBUG_MODE Then
		          System.DebugLog("Indication " + ind.ID.ToString + " has no context names or IDs")
		        End If
		      End If
		      
		      ' Add keywords
		      lstIndications.CellTextAt(row, 2) = ind.Keywords
		    Next
		    
		    ' Update count label
		    UpdateCountLabel(indications.Count)
		    
		  Catch err As RuntimeException
		    If AppConfig.DEBUG_MODE Then
		      System.DebugLog("IndicationsContainer: Error loading indications - " + err.Message)
		    End If
		    MessageBox("Error loading indications: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCountLabel(count As Integer)
		  If count = 1 Then
		    lblFoundCount.Text = "1 indication found"
		  Else
		    lblFoundCount.Text = count.ToString + " indications found"
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContextLookup As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndications() As Indication
	#tag EndProperty


	#tag Constant, Name = kSectionTitle, Type = String, Dynamic = False, Default = \"Echocardiography Indications", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  ' Real-time search as user types
		  LoadIndications()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnNew
	#tag Event
		Sub Pressed()
		  ' Open dialog for creating new indication
		  Var dlg As New dlg_Indication
		  
		  ' Show dialog modally
		  dlg.ShowModal()
		  
		  ' No need to refresh manually - PubSub will handle it when dialog broadcasts event
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnDelete
	#tag Event
		Sub Pressed()
		  ' Delete selected indication
		  If lstIndications.SelectedRowIndex < 0 Then
		    MessageBox("Please select an indication to delete.")
		    Return
		  End If
		  
		  ' Get the indication from the row tag
		  Var ind As Indication = lstIndications.RowTagAt(lstIndications.SelectedRowIndex)
		  
		  If ind = Nil Then
		    MessageBox("Error: Could not retrieve indication data.")
		    Return
		  End If
		  
		  ' Confirm deletion
		  Var d As New MessageDialog
		  d.Message = "Are you sure you want to delete the indication:" + EndOfLine + EndOfLine + _
		  """" + ind.Title + """?"
		  d.Title = "Confirm Deletion"
		  d.ActionButton.Caption = "Delete"
		  d.CancelButton.Visible = True
		  d.CancelButton.Caption = "Cancel"
		  
		  If d.ShowModal = d.ActionButton Then
		    Try
		      If ind.Delete() Then
		        ' Broadcast deletion event
		        PubSub.Broadcast(EventConstants.INDICATION_DELETED, ind.ID)
		        MessageBox("Indication deleted successfully.")
		      Else
		        MessageBox("Failed to delete indication.")
		      End If
		    Catch err As RuntimeException
		      MessageBox("Error deleting indication: " + err.Message)
		    End Try
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popContexts
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  ' Filter by selected context
		  LoadIndications()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstIndications
	#tag Event
		Sub DoublePressed()
		  ' Open indication detail dialog on double-click
		  If Me.SelectedRowIndex < 0 Then Return
		  
		  ' Get the indication from the row tag
		  Var ind As Indication = Me.RowTagAt(Me.SelectedRowIndex)
		  
		  If ind <> Nil Then
		    Var dlg As New dlg_Indication
		    
		    ' Pass the indication to the dialog for editing
		    dlg.LoadIndication(ind)
		    
		    dlg.ShowModal()
		    
		    ' No need to refresh manually - PubSub will handle it
		  End If
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
		Name="Super"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
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
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
