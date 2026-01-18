# SKButton - Custom Canvas Button

This is a custom button control built as a DesktopCanvas subclass from the [SKButton repository](https://github.com/stam66/SKButton).

## Why Use SKButton Instead of DesktopButton?

Standard Xojo buttons have limitations:
- Fixed height
- No icon support
- Limited styling
- No SVG support

SKButton provides:
- **Variable height** - Any size you want
- **SVG icons** - Crisp at any DPI/resolution
- **Flexible icon placement** - Left, Right, Above, Below text
- **Full styling control** - Colors, borders, corner radius
- **Hover/pressed states** - Professional interaction
- **Dark mode aware** - Automatic color adaptation

## Usage in Navigation Bar

For the top navigation bar in MainWindow, use SKButtons with:

```xojo
// Example: Indications button with icon
IndicationsButton.Text = "Indications"
IndicationsButton.BaseBackColor = &cF5F5F500   // Light gray
IndicationsButton.BaseHoverColor = &cE0E0E000  // Darker on hover
IndicationsButton.BaseTextColor = &c33333300   // Dark text
IndicationsButton.IconSVG = kIndicationsIconSVG // SVG icon
IndicationsButton.IconAlignment = 2             // Icon above text
IndicationsButton.ContentAlignment = 1          // Center content
IndicationsButton.CornerRadius = 8
IndicationsButton.BorderThickness = 0
```

## Action Event

Just like native buttons, SKButton has an Action event:

```xojo
// Double-click the SKButton instance in the IDE
// Add code in the Action event handler:
Sub IndicationsButton.Action()
  NavigationManager.NavigateToIndications()
End Sub
```

## Properties Reference

| Property | Description | Example |
|----------|-------------|---------|
| Text | Button caption | "Indications" |
| BaseBackColor | Background color (light mode) | &cF5F5F500 |
| BaseHoverColor | Hover state color | &cE0E0E000 |
| BasePressedColor | Pressed state color | &cD0D0D000 |
| BaseTextColor | Text color | &c33333300 |
| IconSVG | SVG icon string | "<svg>...</svg>" |
| IconAlignment | 0=Left, 1=Right, 2=Above, 3=Below | 2 (above) |
| ContentAlignment | 0=Left, 1=Center, 2=Right | 1 (center) |
| CornerRadius | Rounded corners | 8 |
| BorderThickness | Border width in pixels | 0 (no border) |
| BorderColor | Border color | &cCCCCCC00 |

## SVG Icons

Store SVG icons as constants in AppConfig or a separate IconConstants module:

```xojo
#tag Constant, Name = kIndicationsIconSVG, Type = String
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M12 2L2 7l10 5 10-5-10-5z"/>
  <path d="M2 17l10 5 10-5M2 12l10 5 10-5"/>
</svg>
#tag EndConstant
```

For a consistent navigation bar, all buttons should have the same:
- Height (e.g., 60px)
- IconAlignment (e.g., 2 = icon above text)
- ContentAlignment (e.g., 1 = centered)
- Corner radius
- Color scheme

This creates a professional, modern UI matching contemporary design patterns.
