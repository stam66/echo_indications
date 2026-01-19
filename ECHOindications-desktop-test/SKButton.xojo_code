#tag Class
Protected Class SKButton
Inherits desktopcanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If Self.Enabled Then
		    mIsArmed = True
		    mIsPressed = True  // Visual pressed state
		    Self.Refresh
		    Return True  // Capture mouse
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  If mIsArmed And Self.Enabled Then
		    Var wasPressed As Boolean = mIsPressed
		    mIsPressed = (x >= 0 And x <= Self.Width And y >= 0 And y <= Self.Height)
		    If mIsPressed <> wasPressed Then
		      Self.Refresh
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Self.Enabled Then
		    mIsHovered = True
		    Self.Refresh
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.Enabled Then
		    mIsHovered = False
		    Self.Refresh  // Will show pressed if armed, else normal
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If mIsArmed Then
		    Var wasPressed As Boolean = mIsPressed
		    mIsPressed = False
		    mIsArmed = False
		    
		    If wasPressed Then  // Only refresh if visual state changed
		      Self.Refresh
		    End If
		    
		    // Fire Action only if released inside
		    If x >= 0 And x <= Self.Width And y >= 0 And y <= Self.Height Then
		      RaiseEvent Action
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  // Colors with dark-mode adaptation
		  Var back As Color = AdaptedColor(BaseBackColor)
		  Var hover As Color = AdaptedColor(BaseHoverColor)
		  Var pressed As Color = AdaptedColor(BasePressedColor)
		  Var txt As Color = AdaptedTextColor(BaseTextColor)
		  Var border As Color = BorderColor
		  
		  If mIsArmed And mIsPressed Then
		    back = pressed
		  ElseIf mIsHovered Then
		    back = hover
		  End If
		  
		  // Disabled overlay
		  If Not Self.Enabled Then
		    back = Color.RGB((back.Red + 200)/2, (back.Green + 200)/2, (back.Blue + 200)/2)
		    txt = &c88888800
		    border = &cAAAAAA00
		  End If
		  
		  // Background & border
		  g.DrawingColor = back
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, CornerRadius, CornerRadius)
		  
		  If BorderThickness > 0 Then
		    g.DrawingColor = border
		    g.PenWidth = BorderThickness
		    g.PenHeight = BorderThickness
		    g.DrawRoundRectangle(0, 0, g.Width, g.Height, CornerRadius, CornerRadius)
		  End If
		  
		  // Text setup
		  g.FontName = TextFontName
		  g.FontSize = TextSize
		  g.Bold = TextBold
		  g.Italic = TextItalic
		  g.Underline = TextUnderline
		  g.DrawingColor = txt
		  
		  Var textW As Double = g.TextWidth(Text)
		  Var textH As Double = g.TextHeight(Text, g.Width)
		  
		  // Smart padding
		  Var pad As Double = If(IconPadding > 0, IconPadding, Max(8, g.Height * 0.15))
		  
		  Var pic As Picture = RenderedIcon
		  Var iconX, iconY, textX, textY As Double
		  
		  If pic <> Nil And pic.Width > 0 Then
		    Var srcW As Double = pic.Width
		    Var srcH As Double = pic.Height
		    
		    Var destH As Double = Min(g.Height * 0.5, srcH)
		    If destH < 16 Then destH = 16
		    Var destW As Double = destH * (srcW / srcH)
		    
		    Var groupW, groupH As Double = Max(destH, textH)
		    
		    Var isHorizontal As Boolean = (IconAlignment = 0 Or IconAlignment = 1)
		    If isHorizontal Then
		      groupW = destW + pad + textW
		    Else
		      groupW = Max(destW, textW)
		      groupH = destH + pad + textH
		    End If
		    
		    // Group horizontal alignment
		    Var groupX As Double
		    Select Case ContentAlignment
		    Case 0 // Left
		      groupX = pad
		    Case 1 // Center
		      groupX = (g.Width - groupW) / 2
		    Case 2 // Right
		      groupX = g.Width - groupW - pad
		    End Select
		    
		    // Position icon & text
		    Select Case IconAlignment
		    Case 0 // Left
		      iconX = groupX
		      iconY = (g.Height - destH) / 2
		      textX = groupX + destW + pad
		      textY = (g.Height - textH) / 2 + g.FontAscent
		      
		    Case 1 // Right
		      textX = groupX
		      textY = (g.Height - textH) / 2 + g.FontAscent
		      iconX = groupX + textW + pad
		      iconY = (g.Height - destH) / 2
		      
		    Case 2 // Above
		      iconX = groupX + (groupW - destW) / 2
		      iconY = (g.Height - groupH) / 2
		      textX = groupX + (groupW - textW) / 2
		      textY = iconY + destH + pad + g.FontAscent
		      
		    Case 3 // Below
		      textX = groupX + (groupW - textW) / 2
		      textY = (g.Height - groupH) / 2 + g.FontAscent
		      iconX = groupX + (groupW - destW) / 2
		      iconY = textY + textH - g.FontAscent + pad
		    End Select
		    
		    If Not Self.Enabled Then g.Transparency = 60.0
		    g.DrawPicture(pic, iconX, iconY, destW, destH, 0, 0, srcW, srcH)
		    g.Transparency = 0.0
		    
		  Else
		    // Text only — fixed Select Case (no commas)
		    Select Case ContentAlignment
		    Case 0 // Left
		      textX = pad
		    Case 1 // Center
		      textX = (g.Width - textW) / 2
		    Case 2 // Right
		      textX = g.Width - textW - pad
		    End Select
		    textY = (g.Height - textH) / 2 + g.FontAscent
		  End If
		  
		  If Text <> "" Then
		    g.DrawText(Text, textX, textY, g.Width, False)
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function AdaptedColor(base As Color) As Color
		  If Color.IsDarkMode Then
		    // Invert for dark mode background (simple complementary)
		    Var r As Integer = 255 - base.Red
		    Var g As Integer = 255 - base.Green
		    Var b As Integer = 255 - base.Blue
		    Return Color.RGB(r, g, b)
		  Else
		    Return base
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AdaptedTextColor(base As Color) As Color
		  // Text: use system text color when possible, fallback to inverted base
		  If Color.IsDarkMode Then
		    Return Color.TextColor  // System white/gray in dark mode
		  Else
		    Return base
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  Self.Transparent = False
		  Self.InvalidateIcon  // Ensures icon renders on first draw if SVG assigned
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InvalidateIcon()
		  
		  mRenderedIcon = Nil
		  Self.Refresh
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 48616E646C65204D6F7573655570202D2073696D756C6174657320627574746F6E204D6F7573655570
		Event Action()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 42617365206261636B67726F756E6420636F6C6F7220286C69676874206D6F6465292E20496E206461726B206D6F64652C2069742077696C6C20626520696E76657274656420666F7220636F6E74726173742E
		#tag Note
			// Base background color (light mode). In dark mode, it will be inverted for contrast.
		#tag EndNote
		BaseBackColor As Color = &c0077FF00
	#tag EndProperty

	#tag Property, Flags = &h0
		BaseHoverColor As Color = &c0055CC00
	#tag EndProperty

	#tag Property, Flags = &h0
		BasePressedColor As Color = &c00339900
	#tag EndProperty

	#tag Property, Flags = &h0
		BaseTextColor As Color = &cFFFFFF00
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			border color, default black
		#tag EndNote
		BorderColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			border width in pixels
		#tag EndNote
		BorderThickness As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			0=Left, 1=Center, 2=Right
		#tag EndNote
		ContentAlignment As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			for rounded corners
		#tag EndNote
		CornerRadius As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			0 = Left of text, 1 = Right, 2 = Above, 3 = Below
		#tag EndNote
		IconAlignment As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Space between icon and text in pixels.
			Set to 0 for automatic scaling based on button height (recommended).
			Set to positive value for fixed pixel spacing.
		#tag EndNote
		IconPadding As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			For traditional raster images (PNG, JPEG, etc.)
		#tag EndNote
		IconPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			For SVG: assign the raw SVG XML string (e.g., from a file, constant, or embedded resource)
		#tag EndNote
		IconSVG As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsArmed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			tracks hover state
		#tag EndNote
		Private mIsHovered As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			tracks press state
		#tag EndNote
		Private mIsPressed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRenderedIcon As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If mRenderedIcon <> Nil Then Return mRenderedIcon
			  
			  If IconSVG <> "" Then
			    Try
			      mRenderedIcon = Picture.FromData(IconSVG)
			      If mRenderedIcon = Nil Or mRenderedIcon.Width = 0 Then
			        // Debug: check console if SVG failed
			        System.DebugLog("SVG rasterization failed or empty")
			      End If
			    Catch e As IOException
			      System.DebugLog("SVG IOException: " + e.Message)
			      mRenderedIcon = Nil
			    End Try
			  ElseIf IconPicture <> Nil Then
			    mRenderedIcon = IconPicture
			  End If
			  
			  Return mRenderedIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRenderedIcon = value
			  IconPicture = value
			  IconSVG = ""
			  Self.Refresh
			End Set
		#tag EndSetter
		Private RenderedIcon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			caption text
		#tag EndNote
		Text As String = "Button"
	#tag EndProperty

	#tag Property, Flags = &h0
		TextBold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Font family
		#tag EndNote
		TextFontName As String = "System"
	#tag EndProperty

	#tag Property, Flags = &h0
		TextItalic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Font size
		#tag EndNote
		TextSize As Integer = 14
	#tag EndProperty

	#tag Property, Flags = &h0
		TextUnderline As Boolean = False
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
			InitialValue=""
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
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			InitialValue="True"
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
			InitialValue="False"
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
			Name="BorderColor"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BaseBackColor"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="&c0077FF00"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BaseTextColor"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="&cFFFFFF00"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BaseHoverColor"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="&c0055CC00"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BasePressedColor"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="&c00339900"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderThickness"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CornerRadius"
			Visible=true
			Group="SKButton - Appearance"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="SKButton - Text"
			InitialValue="Button"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFontName"
			Visible=true
			Group="SKButton - Text"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="SKButton - Text"
			InitialValue="14"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextBold"
			Visible=true
			Group="SKButton - Text"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextItalic"
			Visible=true
			Group="SKButton - Text"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextUnderline"
			Visible=true
			Group="SKButton - Text"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentAlignment"
			Visible=true
			Group="SKButton - Layout"
			InitialValue="1"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconAlignment"
			Visible=true
			Group="SKButton - Layout"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Right"
				"2 - Above"
				"3 - Below"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconPicture"
			Visible=true
			Group="SKButton - icon"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconPadding"
			Visible=true
			Group="SKButton - icon"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconSVG"
			Visible=true
			Group="SKButton - icon"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
