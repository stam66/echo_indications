#tag WebPage
Begin WebPage wp_indications
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   689
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   PanelIndex      =   0
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "Appropriate Use Criteria for Echocardiography"
   Top             =   0
   Visible         =   True
   Width           =   996
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebSearchField txtSearch
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Hint            =   "Search by title or keywords..."
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   185
      Visible         =   True
      Width           =   400
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu popContext
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "All Contexts"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   693
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   0
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   185
      Visible         =   True
      Width           =   283
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblFoundCount
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   4
      TabStop         =   True
      Text            =   "Found count"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   251
      Underline       =   False
      Visible         =   True
      Width           =   275
      _mPanelIndex    =   -1
   End
   Begin WebListBox lstIndications
      AllowRowReordering=   False
      ColumnCount     =   3
      ColumnWidths    =   "70%, 15%, 15%"
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   380
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Indication	Contexts	Keywords"
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   ""
      PanelIndex      =   0
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   0
      SearchCriteria  =   ""
      SelectedRowColor=   &c0d6efd
      SelectedRowIndex=   0
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   289
      Visible         =   True
      Width           =   956
      _mPanelIndex    =   -1
   End
   Begin wc_WebPageHeader wc_header
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   74
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      ScrollDirection =   0
      SectionTitle    =   "Indications"
      TabIndex        =   6
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   996
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebButton btnNew
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "New"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   7
      TabStop         =   True
      Tooltip         =   ""
      Top             =   111
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton btnDelete
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Delete"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   128
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   8
      TabStop         =   True
      Tooltip         =   ""
      Top             =   111
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  LoadContexts
		  LoadIndications
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  MessageBox(Session.IsAuthenticated.ToString)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Initialise()
		  btnNew.Enabled = session.IsAuthenticated
		  btnDelete.Enabled = session.IsAuthenticated
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadContexts()
		  popContext.RemoveAllRows()
		  
		  // Row 0: Display text "All Contexts", store value 0 in RowTag
		  popContext.AddRow("All Contexts")
		  popContext.RowTagAt(0) = 0
		  
		  If Session.IsConnected Then
		    Var contexts() As Context = Context.GetAll(Session.DB)
		    For Each ctx As Context In contexts
		      // Add context name as display text, store database ID in RowTag
		      popContext.AddRow(ctx.Name)
		      popContext.RowTagAt(popContext.LastAddedRowIndex) = ctx.ID
		    Next
		  End If
		  
		  // Select "All Contexts" by default
		  popContext.SelectedRowIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadIndications()
		  lstIndications.RemoveAllRows
		  
		  If Not Session.IsConnected Then
		    MessageBox("Database connection error. Please refresh the page.")
		    Return
		  End If
		  
		  Try
		    Var sql As String = "SELECT DISTINCT i.* FROM indications i "
		    Var params() As Variant
		    
		    If FilterContextID > 0 Then
		      sql = sql + "INNER JOIN indication_contexts ic ON i.id = ic.indication_id "
		    End If
		    
		    sql = sql + "WHERE i.is_active = TRUE "
		    
		    If FilterContextID > 0 Then
		      sql = sql + "AND ic.context_id = ? "
		      params.Add(FilterContextID)
		    End If
		    
		    If SearchText.Trim <> "" Then
		      Var searchTerm As String = "%" + SearchText.Trim + "%"
		      sql = sql + "AND (i.title LIKE ? OR i.keywords LIKE ?) "
		      params.Add(searchTerm)
		      params.Add(searchTerm)
		    End If
		    
		    sql = sql + "ORDER BY i.title"
		    
		    Var rs As RowSet
		    
		    If params.Count > 0 Then
		      Var ps As PreparedSQLStatement = Session.DB.Prepare(sql)
		      
		      For i As Integer = 0 To params.LastIndex
		        ps.BindType(i, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		        ps.Bind(i, params(i))
		      Next
		      
		      rs = ps.SelectSQL
		    Else
		      rs = Session.DB.SelectSQL(sql)
		    End If
		    
		    Var count As Integer = 0
		    
		    While Not rs.AfterLastRow
		      Var ind As New Indication
		      ind.ID = rs.Column("id").IntegerValue
		      ind.Title = rs.Column("title").StringValue
		      ind.Keywords = rs.Column("keywords").StringValue
		      ind.LoadContexts Session.DB
		      
		      // Add row: Indication | Contexts | Keywords
		      lstIndications.AddRow ind.Title
		      Var lastRow As Integer = lstIndications.LastAddedRowIndex
		      
		      // Contexts column
		      Var contextList As String = String.FromArray(ind.ContextNames, ", ")
		      lstIndications.CellValueAt(lastRow, 1) = contextList
		      
		      // Keywords column
		      lstIndications.CellValueAt(lastRow, 2) = ind.Keywords
		      
		      // Store ID in RowTag
		      lstIndications.RowTagAt(lastRow) = ind.ID
		      
		      count = count + 1
		      rs.MoveToNextRow
		    Wend
		    
		    lblFoundCount.text = str(count) + " indication(s) found"
		    
		  Catch err As DatabaseException
		    MessageBox("Error loading indications: " + err.Message)
		    System.DebugLog("Error in LoadIndications: " + err.Message)
		  End Try
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FilterContextID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		IndicationID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SearchText As String
	#tag EndProperty


#tag EndWindowCode

#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  SearchText = txtSearch.Value.Trim
		  LoadIndications
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popContext
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  
		  If popContext.SelectedRowIndex >= 0 Then
		    FilterContextID = Val(popContext.RowValueAt(popContext.SelectedRowIndex))
		    LoadIndications()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstIndications
	#tag Event
		Sub SelectionChanged(rows() As Integer)
		  #Pragma Unused rows
		  
		  If me.SelectedRowIndex >= 0 Then
		    IndicationID = me.RowTagAt(me.SelectedRowIndex)
		  else
		    IndicationID = 0
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  #Pragma Unused row
		  #Pragma Unused column
		  
		  var dlg as new dlg_Indication
		  dlg.IndicationID = IndicationID
		  session.NavigationManager.NavigateToPage(dlg)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnNew
	#tag Event
		Sub Opening()
		  me.Enabled = session.IsAuthenticated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnDelete
	#tag Event
		Sub Opening()
		  me.Enabled = session.IsAuthenticated
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FilterContextID"
		Visible=false
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="SearchText"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
