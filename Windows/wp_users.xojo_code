#tag WebPage
Begin WebPage wp_users
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   688
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
   Title           =   "User management"
   Top             =   0
   Visible         =   True
   Width           =   1068
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
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
      Scope           =   2
      ScrollDirection =   0
      SectionTitle    =   "Manage admin access"
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1068
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebListBox lstUsers
      AllowRowReordering=   False
      ColumnCount     =   4
      ColumnWidths    =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   49
      Enabled         =   True
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   456
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "Full Name	Username	Email	Title"
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
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   213
      Visible         =   True
      Width           =   1028
      _mPanelIndex    =   -1
   End
   Begin WebSearchField txtSearch
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Hint            =   "Search Users..."
      Index           =   -2147483648
      Indicator       =   0
      Left            =   303
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   2
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   97
      Visible         =   True
      Width           =   400
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
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   97
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
      Indicator       =   4
      Left            =   128
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   97
      Visible         =   True
      Width           =   100
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
      Scope           =   0
      TabIndex        =   5
      TabStop         =   True
      Text            =   "Found count"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   174
      Underline       =   False
      Visible         =   True
      Width           =   275
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  populateUsers
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleDeleteUserConfirm(sender As WebMessageDialog, button As WebMessageDialogButton)
		  If button = sender.ActionButton Then
		    Try
		      // Load user first for audit
		      Var user As User = User.GetByID(Session.DB, SelectedUserID)
		      If user <> Nil Then
		        If user.DeleteWithAudit(Session.DB, Session.CurrentUsername) Then
		          // Refresh the list
		          If txtSearch.Value.Trim = "" Then
		            populateUsers
		          Else
		            SearchUsers
		          End If
		          MessageBox("User deleted successfully")
		        Else
		          MessageBox("Error deleting user")
		        End If
		      Else
		        MessageBox("User not found")
		      End If
		    Catch err As DatabaseException
		      MessageBox("Error deleting user: " + err.Message)
		    End Try
		  End If
		  
		  SelectedUserID = 0
		  
		  ' If button = sender.ActionButton Then
		  ' Try
		  ' Var sql As String = "DELETE FROM users WHERE id = ?"
		  ' Var ps As MySQLPreparedStatement = Session.db.Prepare(sql)
		  ' ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		  ' ps.Bind(0, SelectedUserID)
		  ' ps.ExecuteSQL
		  ' 
		  ' // Refresh the list
		  ' If txtSearch.Value.Trim = "" Then
		  ' populateUsers
		  ' Else
		  ' SearchUsers
		  ' End If
		  ' 
		  ' MessageBox("User deleted successfully")
		  ' 
		  ' Catch err As DatabaseException
		  ' MessageBox("Error deleting user: " + err.Message)
		  ' End Try
		  ' End If
		  ' 
		  ' SelectedUserID = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleUserSaved(sender as WebDialog)
		  Var dlg As dlg_user = dlg_user(sender)
		  If dlg.WasSaved Then
		    If txtSearch.Value.Trim = "" Then
		      populateUsers
		    Else
		      SearchUsers
		    End If
		    dlg.WasSaved = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub populateUsers()
		  Var sql As String = "SELECT * FROM users ORDER BY name"
		  Var rs As RowSet = Session.db.SelectSQL(sql)
		  
		  lstUsers.RemoveAllRows
		  
		  // Define styles
		  Var darkMode As Boolean = Session.IsDarkMode
		  Var activeStyle As New WebStyle
		  Var inactiveStyle As New WebStyle
		  
		  activeStyle.ForegroundColor = If(darkMode, Color.White, Color.Black)
		  inactiveStyle.ForegroundColor = Color.LightGray
		  inactiveStyle.Italic = True
		  
		  While Not rs.AfterLastRow
		    // Add empty row first
		    lstUsers.AddRow()
		    Var rowIdx As Integer = lstUsers.LastAddedRowIndex
		    
		    // Read data
		    Var fullName As String = rs.Column("name").StringValue
		    Var username As String = rs.Column("username").StringValue
		    Var email As String = rs.Column("email").StringValue
		    Var title As String = rs.Column("title").StringValue
		    Var isActive As Boolean = rs.Column("is_active").BooleanValue
		    Var userId As Integer = rs.Column("id").IntegerValue
		    
		    // Store primary key
		    lstUsers.RowTagAt(rowIdx) = userId
		    
		    // Choose style
		    Var cellStyle As WebStyle = If(isActive, activeStyle, inactiveStyle)
		    
		    // Apply styled text to every column
		    lstUsers.CellValueAt(rowIdx, 0) = New WebListBoxStyleRenderer(cellStyle, fullName)
		    lstUsers.CellValueAt(rowIdx, 1) = New WebListBoxStyleRenderer(cellStyle, username)
		    lstUsers.CellValueAt(rowIdx, 2) = New WebListBoxStyleRenderer(cellStyle, email)
		    lstUsers.CellValueAt(rowIdx, 3) = New WebListBoxStyleRenderer(cellStyle, title)
		    
		    rs.MoveToNextRow
		  Wend
		  
		  UpdateFoundCount
		  
		  
		  
		  
		  ' Var sql As String = "SELECT * FROM users ORDER BY name"
		  ' Var rs As RowSet = Session.db.SelectSQL(sql)
		  ' 
		  ' lstUsers.RemoveAllRows
		  ' While Not rs.AfterLastRow
		  ' lstUsers.AddRow(rs.Column("name").StringValue)
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 1) = rs.Column("username").StringValue
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 2) = rs.Column("email").StringValue
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 3) = rs.Column("title").StringValue
		  ' lstUsers.RowTagAt(lstUsers.LastAddedRowIndex) = rs.Column("id").IntegerValue
		  ' 
		  ' // Style inactive users
		  ' If Not rs.Column("is_active").BooleanValue Then
		  ' For col As Integer = 0 To 3
		  ' lstUsers.CellStyleAt(lstUsers.LastAddedRowIndex, col) = InactiveUserStyle
		  ' Next
		  ' End If
		  ' 
		  ' rs.MoveToNextRow
		  ' Wend
		  ' 
		  ' UpdateFoundCount
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SearchUsers()
		  Var searchTerm As String = txtSearch.Value.Trim.Lowercase
		  
		  If searchTerm = "" Then
		    populateUsers
		    Return
		  End If
		  
		  // Build SQL with LIKE clauses for all searchable fields
		  Var sql As String = "SELECT * FROM users WHERE " + _
		  "LOWER(name) LIKE ? OR " + _
		  "LOWER(username) LIKE ? OR " + _
		  "LOWER(email) LIKE ? OR " + _
		  "LOWER(title) LIKE ? " + _
		  "ORDER BY name"
		  
		  Var ps As MySQLPreparedStatement = Session.db.Prepare(sql)
		  
		  // Bind the search term with wildcards for each parameter
		  Var wildcard As String = "%" + searchTerm + "%"
		  For i As Integer = 0 To 3
		    ps.BindType(i, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.Bind(i, wildcard)
		  Next
		  
		  Var rs As RowSet = ps.SelectSQL
		  
		  lstUsers.RemoveAllRows
		  
		  // Define styles
		  Var darkMode As Boolean = Session.IsDarkMode
		  Var activeStyle As New WebStyle
		  Var inactiveStyle As New WebStyle
		  
		  activeStyle.ForegroundColor = If(darkMode, Color.White, Color.Black)
		  inactiveStyle.ForegroundColor = Color.LightGray
		  inactiveStyle.Italic = True
		  
		  While Not rs.AfterLastRow
		    // Add empty row first
		    lstUsers.AddRow()
		    Var rowIdx As Integer = lstUsers.LastAddedRowIndex
		    
		    // Read data
		    Var fullName As String = rs.Column("name").StringValue
		    Var username As String = rs.Column("username").StringValue
		    Var email As String = rs.Column("email").StringValue
		    Var title As String = rs.Column("title").StringValue
		    Var isActive As Boolean = rs.Column("is_active").BooleanValue
		    Var userId As Integer = rs.Column("id").IntegerValue
		    
		    // Store primary key
		    lstUsers.RowTagAt(rowIdx) = userId
		    
		    // Choose style
		    Var cellStyle As WebStyle = If(isActive, activeStyle, inactiveStyle)
		    
		    // Apply styled text to every column
		    lstUsers.CellValueAt(rowIdx, 0) = New WebListBoxStyleRenderer(cellStyle, fullName)
		    lstUsers.CellValueAt(rowIdx, 1) = New WebListBoxStyleRenderer(cellStyle, username)
		    lstUsers.CellValueAt(rowIdx, 2) = New WebListBoxStyleRenderer(cellStyle, email)
		    lstUsers.CellValueAt(rowIdx, 3) = New WebListBoxStyleRenderer(cellStyle, title)
		    
		    rs.MoveToNextRow
		  Wend
		  
		  UpdateFoundCount
		  
		  
		  ' Var searchTerm As String = txtSearch.Value.Trim.Lowercase
		  ' 
		  ' If searchTerm = "" Then
		  ' populateUsers
		  ' Return
		  ' End If
		  ' 
		  ' // Build SQL with LIKE clauses for all searchable fields
		  ' Var sql As String = "SELECT * FROM users WHERE " + _
		  ' "LOWER(name) LIKE ? OR " + _
		  ' "LOWER(username) LIKE ? OR " + _
		  ' "LOWER(email) LIKE ? OR " + _
		  ' "LOWER(title) LIKE ? " + _
		  ' "ORDER BY name"
		  ' 
		  ' Var ps As MySQLPreparedStatement = Session.db.Prepare(sql)
		  ' 
		  ' // Bind the search term with wildcards for each parameter
		  ' Var wildcard As String = "%" + searchTerm + "%"
		  ' For i As Integer = 0 To 3
		  ' ps.BindType(i, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		  ' ps.Bind(i, wildcard)
		  ' Next
		  ' 
		  ' Var rs As RowSet = ps.ExecuteSQL
		  ' 
		  ' lstUsers.RemoveAllRows
		  ' While Not rs.AfterLastRow
		  ' lstUsers.AddRow(rs.Column("name").StringValue)
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 1) = rs.Column("username").StringValue
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 2) = rs.Column("email").StringValue
		  ' lstUsers.CellTextAt(lstUsers.LastAddedRowIndex, 3) = rs.Column("title").StringValue
		  ' lstUsers.RowTagAt(lstUsers.LastAddedRowIndex) = rs.Column("id").IntegerValue
		  ' 
		  ' // Style inactive users
		  ' If Not rs.Column("is_active").BooleanValue Then
		  ' For col As Integer = 0 To 3
		  ' lstUsers.CellTextColorAt(lstUsers.LastAddedRowIndex, col) = Color.RGB(128, 128, 128)
		  ' lstUsers.CellItalicAt(lstUsers.LastAddedRowIndex, col) = True
		  ' Next
		  ' End If
		  ' 
		  ' rs.MoveToNextRow
		  ' Wend
		  ' 
		  ' UpdateFoundCount
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFoundCount()
		  Var count As Integer = lstUsers.RowCount
		  If count = 1 Then
		    lblFoundCount.Text = "1 user"
		  Else
		    lblFoundCount.Text = count.ToString + " users"
		  End If
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var style As New WebStyle
			  style.ForegroundColor = Color.RGB(128, 128, 128)
			  style.Italic = True
			  Return style
			End Get
		#tag EndGetter
		InactiveUserStyle As WebStyle
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		SearchText As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectdRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedUserID As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events lstUsers
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  #Pragma Unused column
		  
		  Var id As Integer = me.RowTagAt(row)
		  Var dlg As New dlg_user
		  AddHandler dlg.UserSaved, AddressOf HandleUserSaved
		  dlg.UserID = id
		  dlg.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtSearch
	#tag Event
		Sub TextChanged()
		  SearchUsers
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnNew
	#tag Event
		Sub Pressed()
		  Var dlg As New dlg_user
		  dlg.UserID = 0
		  AddHandler dlg.UserSaved, AddressOf HandleUserSaved 
		  dlg.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnDelete
	#tag Event
		Sub Pressed()
		  If lstUsers.SelectedRowIndex < 0 Then
		    MessageBox("Please select a user to delete")
		    Return
		  End If
		  
		  // Store selected user ID
		  SelectedUserID = lstUsers.RowTagAt(lstUsers.SelectedRowIndex)
		  
		  // Get user name for confirmation message
		  Var userName As String = lstUsers.CellTextAt(lstUsers.SelectedRowIndex, 0)
		  
		  Var dlg As New WebMessageDialog
		  dlg.Message = "Delete user: " + userName + "?"
		  dlg.Explanation = "This will permanently delete this user. This action cannot be undone."
		  dlg.ActionButton.Caption = "Delete"
		  dlg.CancelButton.Caption = "Cancel"
		  dlg.CancelButton.Visible = True
		  dlg.ActionButton.Indicator = WebUIControl.Indicators.Danger
		  
		  AddHandler dlg.ButtonPressed, AddressOf HandleDeleteUserConfirm
		  dlg.Show
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
#tag EndViewBehavior
