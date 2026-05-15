#tag WebPage
Begin WebDialog dlg_select_indication
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   704
   Index           =   -2147483648
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   PanelIndex      =   0
   Position        =   1
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   828
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebListBox lstIndications
      AllowRowReordering=   False
      ColumnCount     =   4
      ColumnWidths    =   "*,75,75,75"
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   504
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Indication	GP	IP	OP"
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
      NoRowsMessage   =   "No indications found"
      PanelIndex      =   0
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   0
      SearchCriteria  =   ""
      SelectedRowColor=   &c006AB500
      SelectedRowIndex=   0
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   134
      Visible         =   True
      Width           =   788
      _mPanelIndex    =   -1
   End
   Begin WebRectangle rectHeader
      BorderColor     =   &c000000FF
      BorderThickness =   0
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   0
      CSSClasses      =   ""
      Enabled         =   True
      FillColor       =   &c006AB500
      HasFillColor    =   True
      Height          =   62
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
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   828
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebLabel lblDialogTitle
         Bold            =   True
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   "Bricolage Grotesque"
         FontSize        =   24.0
         Height          =   38
         HTMLElement     =   0
         Index           =   -2147483648
         Indicator       =   0
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
         Parent          =   "rectHeader"
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   -1
         TabStop         =   True
         Text            =   "Select an indication"
         TextAlignment   =   0
         TextColor       =   &cFAFAFA00
         Tooltip         =   ""
         Top             =   12
         Underline       =   False
         Visible         =   True
         Width           =   277
         _mPanelIndex    =   -1
      End
   End
   Begin WebButton Button1
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Select indication"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   637
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   646
      Visible         =   True
      Width           =   171
      _mPanelIndex    =   -1
   End
   Begin WebButton Button2
      AllowAutoDisable=   False
      Cancel          =   True
      Caption         =   "Close"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   529
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   646
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebSearchField txtSearch
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Hint            =   "e.g. dyspnoea, palpitations"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   5
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   79
      Visible         =   True
      Width           =   455
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
      Left            =   561
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
      TabIndex        =   6
      TabStop         =   True
      Tooltip         =   ""
      Top             =   79
      Visible         =   True
      Width           =   247
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  // Populate the context filter with "(All contexts)" + every active context.
		  // Tag 0 = no filter; positive tag = context ID.
		  // Using Opening (not Shown) so the listbox rows are fully wired by the
		  // time the user can click — populating from Shown leaves the rows briefly
		  // un-clickable on first open.
		  popContext.RemoveAllRows
		  popContext.AddRow("(All contexts)")
		  popContext.RowTagAt(0) = 0
		  For Each ctx As Context In Context.GetAllActive(Session.DB)
		    popContext.AddRow(ctx.Name)
		    popContext.RowTagAt(popContext.LastAddedRowIndex) = ctx.ID
		  Next
		  popContext.SelectedRowIndex = 0

		  FilterContextID = 0
		  SearchText = ""
		  txtSearch.Text = ""
		  LoadIndications
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddIndicationRow(id As Integer, title As String, gp As String, ip As String, op As String)
		  lstIndications.AddRow(title, "", "", "")
		  Var rowIdx As Integer = lstIndications.LastAddedRowIndex
		  lstIndications.RowTagAt(rowIdx) = id
		  lstIndications.CellValueAt(rowIdx, 1) = AucRenderer(gp)
		  lstIndications.CellValueAt(rowIdx, 2) = AucRenderer(ip)
		  lstIndications.CellValueAt(rowIdx, 3) = AucRenderer(op)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AucRenderer(value As String) As WebListBoxStyleRenderer
		  // RAG glyph centred in the cell. Matches wp_indications' style so the
		  // visual language is identical across pages.
		  Var s As New WebStyle
		  s.Bold = True
		  s.FontSize = 26
		  s.Value("text-align") = "center"
		  Var label As String = ""
		  Select Case value
		  Case "indicated"
		    label = "✔"
		    s.ForegroundColor = Color.RGB(46, 204, 113)
		  Case "not_indicated"
		    label = "✕"
		    s.ForegroundColor = Color.RGB(231, 76, 60)
		  Case "can_be_considered"
		    label = "?"
		    s.ForegroundColor = Color.RGB(243, 156, 18)
		  End Select
		  Return New WebListBoxStyleRenderer(s, label)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentSelectedID() As Integer
		  If lstIndications.SelectedRowIndex < 0 Then Return 0
		  Var tag As Variant = lstIndications.RowTagAt(lstIndications.SelectedRowIndex)
		  If tag Is Nil Then Return 0
		  Return tag.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadIndications()
		  // Rebuilds lstIndications from the current FilterContextID + SearchText.
		  // Single column query — RAG glyphs are rendered per-cell from the
		  // primary_care / secondary_inpatient / secondary_outpatient columns.
		  lstIndications.RemoveAllRows
		  
		  Try
		    Var sql As String
		    Var rs As RowSet
		    
		    If FilterContextID = 0 Then
		      sql = "SELECT i.id, i.title, i.keywords, " + _
		      "i.primary_care, i.secondary_inpatient, i.secondary_outpatient " + _
		      "FROM indications i ORDER BY i.title"
		      rs = Session.DB.SelectSQL(sql)
		    Else
		      sql = "SELECT i.id, i.title, i.keywords, " + _
		      "i.primary_care, i.secondary_inpatient, i.secondary_outpatient " + _
		      "FROM indications i " + _
		      "INNER JOIN indication_contexts ic ON i.id = ic.indication_id " + _
		      "WHERE ic.context_id = ? ORDER BY i.title"
		      Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		      ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		      ps.Bind(0, FilterContextID)
		      rs = ps.SelectSQL
		    End If
		    
		    Var needle As String = SearchText.Lowercase
		    While Not rs.AfterLastRow
		      Var title As String = rs.Column("title").StringValue
		      Var keywords As String = If(rs.Column("keywords").Value = Nil, "", rs.Column("keywords").StringValue)
		      
		      // Simple AND-of-comma-terms substring match against title+keywords.
		      Var matches As Boolean = True
		      If needle <> "" Then
		        Var combined As String = title + " " + keywords
		        Var hay As String = combined.Lowercase
		        Var terms() As String = needle.Split(",")
		        For Each rawTerm As String In terms
		          Var term As String = rawTerm.Trim
		          If term <> "" Then
		            If hay.IndexOf(term) = -1 Then
		              matches = False
		              Exit For
		            End If
		          End If
		        Next
		      End If
		      If matches Then
		        Var id As Integer = rs.Column("id").IntegerValue
		        Var gp As String = If(rs.Column("primary_care").Value = Nil, "", rs.Column("primary_care").StringValue)
		        Var ip As String = If(rs.Column("secondary_inpatient").Value = Nil, "", rs.Column("secondary_inpatient").StringValue)
		        Var op As String = If(rs.Column("secondary_outpatient").Value = Nil, "", rs.Column("secondary_outpatient").StringValue)
		        AddIndicationRow(id, title, gp, ip, op)
		      End If
		      rs.MoveToNextRow
		    Wend
		  Catch err As DatabaseException
		    System.DebugLog("dlg_select_indication.LoadIndications: " + err.Message)
		  End Try
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event IndicationPicked(indicationID As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private FilterContextID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SearchText As String = ""
	#tag EndProperty


#tag EndWindowCode

#tag Events lstIndications
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  #Pragma Unused column
		  If row < 0 Or row > lstIndications.LastRowIndex Then Return
		  Var id As Integer = lstIndications.RowTagAt(row).IntegerValue
		  RaiseEvent IndicationPicked(id)
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button1
	#tag Event
		Sub Pressed()
		  // "Select indication" — confirm the highlighted row and close.
		  Var id As Integer = CurrentSelectedID
		  If id = 0 Then
		    MessageBox("Highlight an indication first, or double-click a row to pick it directly.")
		    Return
		  End If
		  RaiseEvent IndicationPicked(id)
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  // "Close" — dismiss without picking. Raise IndicationPicked(0) so the
		  // caller can distinguish "user cancelled" (id = 0) from "user picked X"
		  // (id > 0) in a single event handler.
		  RaiseEvent IndicationPicked(0)
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  SearchText = txtSearch.Text.Trim
		  LoadIndications
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events popContext
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  #Pragma Unused item
		  If popContext.SelectedRowIndex < 0 Then Return
		  Var tag As Variant = popContext.RowTagAt(popContext.SelectedRowIndex)
		  FilterContextID = If(tag Is Nil, 0, tag.IntegerValue)
		  LoadIndications
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
		Name="Index"
		Visible=false
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
		Name="Position"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="WebDialog.Positions"
		EditorType="Enum"
		#tag EnumValues
			"0 - Top"
			"1 - Center"
		#tag EndEnumValues
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
#tag EndViewBehavior
