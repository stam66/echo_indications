# Business Object Classes

**High-level object-oriented API wrapper**

Instead of working with raw `Dictionary` objects and API responses, use these clean business classes.

---

## Classes Available

### 1. **Indication** - Echocardiography indications

**Properties:**
- `ID` (Integer)
- `Title` (String)
- `Keywords` (String)
- `Comments` (String)
- `PrimaryCare` (String) - "indicated", "not_indicated", "can_be_considered"
- `SecondaryInpatient` (String)
- `SecondaryOutpatient` (String)
- `SourceASE` (Boolean)
- `SourceEACVI` (Boolean)
- `SourceBSE` (Boolean)
- `SourceConsensus` (Boolean)
- `Urgency` (String) - "urgent", "soon", "routine", etc.
- `ContextIDs()` (Integer array)
- `ContextNames()` (String array)

**Methods:**
```xojo
// Get all indications
Var indications() As Indication = Indication.GetAll

// Search by keyword
Var results() As Indication = Indication.Search("coronary")

// Get single indication
Var indication As Indication = Indication.GetByID(123)

// Get by context
Var contextIndications() As Indication = Indication.GetByContext(5)

// Delete (requires authentication)
indication.Delete  // Returns Boolean

// Display
System.DebugLog indication.ToString
```

---

### 2. **Context** - Clinical contexts/categories

**Properties:**
- `ID` (Integer)
- `Name` (String) - e.g., "Valve", "Coronary", "ACHD"
- `Description` (String)
- `SortOrder` (Integer)
- `IsActive` (Boolean)
- `IndicationCount` (Integer) - How many indications in this context

**Methods:**
```xojo
// Get all contexts
Var contexts() As Context = Context.GetAll

// Get with indication counts
Var contexts() As Context = Context.GetAllWithCounts

// Get single context
Var context As Context = Context.GetByID(5)

// Display
System.DebugLog context.ToString
// Outputs: [5] Valve (43 indications)
```

---

### 3. **ChangeRequest** - Change requests/issues

**Properties:**
- `ID` (Integer)
- `IndicationID` (Integer)
- `ChangesRequest` (String) - What needs changing
- `ChangesRequestor` (String) - Who requested it
- `ChangesStatus` (String) - "New", "In progress", "Closed", "Rejected"
- `ReasonForClose` (String)
- `IndicationExisting` (String)
- `IndicationNew` (String)
- `ContextsExisting` (String)
- `ContextsNew` (String)
- `CreatedAt` (DateTime)

**Methods:**
```xojo
// Get all change requests
Var changes() As ChangeRequest = ChangeRequest.GetAll

// Filter by status
Var newChanges() As ChangeRequest = ChangeRequest.GetByStatus("New")

// Get single change request
Var change As ChangeRequest = ChangeRequest.GetByID(15)

// Count new requests (for badge)
Var count As Integer = ChangeRequest.CountNew

// Display
System.DebugLog change.ToString
```

---

### 4. **User** - System users (requires authentication)

**Properties:**
- `ID` (Integer)
- `Username` (String)
- `Email` (String)
- `Name` (String)
- `Title` (String) - Job title
- `IsActive` (Boolean)

**Methods:**
```xojo
// Must be authenticated first
If AuthManager.Login("username", "password") Then

  // Get all users
  Var users() As User = User.GetAll

  // Get single user
  Var user As User = User.GetByID(1)

  // Display
  System.DebugLog user.ToString

  AuthManager.Logout
End If
```

---

## Why Use Business Classes?

### ❌ **Old Way (Raw API):**

```xojo
Var result As Dictionary = APIClient.Get("indications.lc", "list")
If result.Value("status") = "success" Then
  Var dataVariant As Variant = result.Value("data")
  Var items() As Variant = dataVariant

  For Each item As Variant In items
    If item IsA Dictionary Then
      Var indication As Dictionary = item
      Var id As Integer = indication.Value("id").IntegerValue
      Var title As String = indication.Value("title").StringValue
      // Extract each field manually...
    End If
  Next
End If
```

### ✅ **New Way (Business Classes):**

```xojo
Var indications() As Indication = Indication.GetAll

For Each indication As Indication In indications
  System.DebugLog indication.Title
  System.DebugLog "Urgency: " + indication.Urgency

  If indication.SourceASE Then
    System.DebugLog "  Source: ASE"
  End If
Next
```

---

## Benefits

1. **Type Safety** - Properties instead of dictionary lookups
2. **Clean Code** - `indication.Title` vs `dict.Value("title").StringValue`
3. **Error Handling** - Built-in with Try/Catch
4. **Easy to Use** - One-line method calls
5. **ToString() Methods** - Clean string representation
6. **Consistent** - All classes follow same pattern
7. **Maintainable** - Change API, business classes stay same

---

## Common Patterns

### Pattern 1: List All Items

```xojo
Var indications() As Indication = Indication.GetAll
Var contexts() As Context = Context.GetAllWithCounts
Var changes() As ChangeRequest = ChangeRequest.GetAll
```

### Pattern 2: Get Single Item

```xojo
Var indication As Indication = Indication.GetByID(123)
If indication <> Nil Then
  System.DebugLog indication.Title
End If
```

### Pattern 3: Search/Filter

```xojo
// Search indications
Var results() As Indication = Indication.Search("coronary")

// Filter by context
Var valveIndications() As Indication = Indication.GetByContext(contextID)

// Filter change requests
Var newChanges() As ChangeRequest = ChangeRequest.GetByStatus("New")
```

### Pattern 4: Display in UI

```xojo
// Populate a Listbox
For Each indication As Indication In indications
  Listbox1.AddRow(indication.ID.ToString, indication.Title)
Next

// Show details
If Listbox1.SelectedRowIndex >= 0 Then
  Var selectedIndication As Indication = indications(Listbox1.SelectedRowIndex)
  TextField1.Text = selectedIndication.Title
  TextArea1.Text = selectedIndication.Comments
  CheckBox1.Value = selectedIndication.SourceASE
End If
```

### Pattern 5: Count for Badges

```xojo
// Show badge count
Var newCount As Integer = ChangeRequest.CountNew
BadgeLabel.Text = newCount.ToString
```

---

## Testing

Run **`TEST_BUSINESS_CLASSES.txt`** to see all classes in action.

Tests:
- ✅ Indication.GetAll, GetByID, Search, GetByContext
- ✅ Context.GetAll, GetAllWithCounts
- ✅ ChangeRequest.GetAll, GetByStatus, CountNew
- ✅ Sorting and filtering examples
- ✅ Comparison of old vs new way

---

## Next Steps

1. **Use in Desktop App** - Build UI with these classes
2. **Use in Mobile App** - Same classes work on iOS/Android
3. **Extend as Needed** - Add more methods when required
4. **Add CRUD** - When API supports create/update, add methods

---

## File Locations

```
Classes/
├── Indication.txt      - Main indications class
├── Context.txt         - Clinical contexts
├── ChangeRequest.txt   - Change requests/issues
└── User.txt            - Admin users
```

**To Use:** Copy `.txt` file contents into new Xojo Classes in your project.

---

**Status:** ✅ Complete and tested with live API

**API 2 Compliant:** ✅ Uses Var, modern methods, proper error handling

**Ready for:** Desktop and Mobile app development
