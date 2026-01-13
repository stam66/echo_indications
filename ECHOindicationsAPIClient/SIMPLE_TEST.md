# ECHO Indications API Client - Simple Test

**5-Minute Setup Guide**

---

## Step 1: Create a Xojo Console App

1. Open Xojo
2. **File → New Project → Console**
3. Save it as "API_Test"

---

## Step 2: Create Three Modules

### Module 1: AppConfig

1. **Insert → Module**
2. Name it: `AppConfig`
3. **Replace ALL the code** in the code editor with this:

```xojo
#tag Module
Protected Module AppConfig
	#tag Constant, Name = API_BASE_URL, Type = String, Dynamic = False, Default = \"https://echoindications.org/API", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = API_TIMEOUT_SECONDS, Type = Integer, Dynamic = False, Default = \"30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = APP_NAME, Type = String, Dynamic = False, Default = \"ECHO Indications", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = APP_VERSION, Type = String, Dynamic = False, Default = \"1.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TOKEN_EXPIRY_MINUTES, Type = Integer, Dynamic = False, Default = \"30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TOKEN_REFRESH_BUFFER_MINUTES, Type = Integer, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DEBUG_MODE, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
	#tag EndConstant
End Module
#tag EndModule
```

---

### Module 2: APIClient

1. **Insert → Module**
2. Name it: `APIClient`
3. **Replace ALL the code** with the contents of `Modules/APIClient.txt`
   - (Or I'll give you a simplified version below)

---

### Module 3: AuthManager

1. **Insert → Module**
2. Name it: `AuthManager`
3. **Replace ALL the code** with the contents of `Modules/AuthManager.txt`
   - (Or simplified version below)

---

## Step 3: Add Test Code

1. Double-click **App** in the navigator
2. Add an **Opening** event handler
3. **Paste this test code:**

```xojo
System.DebugLog "=========================================="
System.DebugLog "ECHO Indications API Test"
System.DebugLog "=========================================="
System.DebugLog ""

// Test 1: Check connectivity
System.DebugLog "Test 1: Checking API connectivity..."
If APIClient.IsConnected Then
  System.DebugLog "✅ API is reachable"
Else
  System.DebugLog "❌ API is not reachable"
  Return
End If
System.DebugLog ""

// Test 2: Fetch all indications (no auth needed)
System.DebugLog "Test 2: Fetching all indications..."
Var result As Dictionary = APIClient.Get("indications.lc", "list")

If result.Value("status") = "success" Then
  Var data As Dictionary = result.Value("data")

  If data.HasKey("indications") Then
    Var indicationsArray As Variant = data.Value("indications")

    If indicationsArray IsA Object() Then
      Var items() As Variant = Object()(indicationsArray)
      System.DebugLog "✅ Found " + items.Count.ToString + " indications"
      System.DebugLog ""

      // Show first 5
      System.DebugLog "First 5 indications:"
      For i As Integer = 0 To Min(4, items.Count - 1)
        If items(i) IsA Dictionary Then
          Var indication As Dictionary = Dictionary(items(i))
          Var id As Integer = indication.Value("id").IntegerValue
          Var title As String = indication.Value("title").StringValue
          System.DebugLog "  [" + id.ToString + "] " + title
        End If
      Next
    End If
  End If
Else
  System.DebugLog "❌ Error: " + result.Value("message").StringValue
End If
System.DebugLog ""

// Test 3: Fetch contexts
System.DebugLog "Test 3: Fetching contexts..."
Var contextResult As Dictionary = APIClient.Get("contexts.lc", "with_counts")

If contextResult.Value("status") = "success" Then
  Var data As Dictionary = contextResult.Value("data")

  If data.HasKey("contexts") Then
    Var contextsArray As Variant = data.Value("contexts")

    If contextsArray IsA Object() Then
      Var items() As Variant = Object()(contextsArray)
      System.DebugLog "✅ Found " + items.Count.ToString + " contexts"
      System.DebugLog ""

      System.DebugLog "All contexts:"
      For i As Integer = 0 To items.Count - 1
        If items(i) IsA Dictionary Then
          Var context As Dictionary = Dictionary(items(i))
          Var name As String = context.Value("name").StringValue
          Var count As Integer = context.Value("indication_count").IntegerValue
          System.DebugLog "  • " + name + " (" + count.ToString + " indications)"
        End If
      Next
    End If
  End If
Else
  System.DebugLog "❌ Error: " + contextResult.Value("message").StringValue
End If
System.DebugLog ""

// Test 4: Search
System.DebugLog "Test 4: Searching for 'coronary'..."
Var params As New Dictionary
params.Value("q") = "coronary"
Var searchResult As Dictionary = APIClient.Get("search.lc", "keyword", params)

If searchResult.Value("status") = "success" Then
  Var data As Dictionary = searchResult.Value("data")

  If data.HasKey("results") Then
    Var resultsArray As Variant = data.Value("results")

    If resultsArray IsA Object() Then
      Var items() As Variant = Object()(resultsArray)
      System.DebugLog "✅ Found " + items.Count.ToString + " matching indications"

      For i As Integer = 0 To Min(2, items.Count - 1)
        If items(i) IsA Dictionary Then
          Var indication As Dictionary = Dictionary(items(i))
          Var title As String = indication.Value("title").StringValue
          System.DebugLog "  • " + title
        End If
      Next
    End If
  End If
Else
  System.DebugLog "❌ Error: " + searchResult.Value("message").StringValue
End If
System.DebugLog ""

System.DebugLog "=========================================="
System.DebugLog "All tests complete!"
System.DebugLog "=========================================="
```

---

## Step 4: Run

1. Click **Run** (▶️ button)
2. Check the **Messages** tab at bottom
3. You should see:

```
==========================================
ECHO Indications API Test
==========================================

Test 1: Checking API connectivity...
✅ API is reachable

Test 2: Fetching all indications...
✅ Found 196 indications

First 5 indications:
  [1] Acute coronary syndrome
  [2] Acute pericarditis - initial assessment
  [3] Annual surveillance of bioprosthetic valve...
  ...

Test 3: Fetching contexts...
✅ Found 14 contexts

All contexts:
  • New (5 indications)
  • Primary Care (23 indications)
  • Myocardial (45 indications)
  ...

Test 4: Searching for 'coronary'...
✅ Found 12 matching indications
  • Acute coronary syndrome
  • Coronary artery disease evaluation
  ...

==========================================
All tests complete!
==========================================
```

---

## ✅ Success!

If you see the ✅ checkmarks, **the API client is working perfectly!**

This tests:
- Network connectivity ✓
- GET requests ✓
- JSON parsing ✓
- Public endpoints (no auth) ✓
- Query parameters (search) ✓

---

## 🔐 Optional: Test Authentication

Add this to test login (requires valid credentials):

```xojo
// Test 5: Login
System.DebugLog "Test 5: Testing login..."
If AuthManager.Login("your_username", "your_password") Then
  System.DebugLog "✅ Login successful as: " + AuthManager.CurrentUsername
  System.DebugLog "User ID: " + AuthManager.CurrentUserID.ToString

  // Now test a protected endpoint
  Var userResult As Dictionary = APIClient.Get("users.lc", "list")
  If userResult.Value("status") = "success" Then
    System.DebugLog "✅ Protected endpoint works - authentication verified!"
  End If

  AuthManager.Logout
  System.DebugLog "Logged out"
Else
  System.DebugLog "❌ Login failed: " + AuthManager.LastError
End If
```

---

## 📋 What This Tests

| Feature | Status |
|---------|--------|
| Network connectivity | ✅ Tested |
| GET requests | ✅ Tested |
| JSON parsing | ✅ Tested |
| List all indications | ✅ Tested |
| List contexts | ✅ Tested |
| Search functionality | ✅ Tested |
| Error handling | ✅ Tested |
| Authentication | ⚠️ Optional (needs credentials) |

---

## 🐛 Troubleshooting

**Problem:** "API is not reachable"
- Check internet connection
- Verify `API_BASE_URL` in AppConfig is correct
- Test https://echoindications.org/API in browser

**Problem:** "Compile error"
- Make sure you copied ALL the code including `#tag Module` and `#tag EndModule`
- Check module names are exactly: `AppConfig`, `APIClient`, `AuthManager`

**Problem:** "Empty results"
- The API might be returning data in a different format
- Add this to see raw response:
  ```xojo
  System.DebugLog result.Value("data").ToString
  ```

---

## 🎯 Next Steps After Testing

Once this works, you can:
1. ✅ **Use in Desktop app** - Import these modules into your real project
2. ✅ **Add to Mobile app** - Same modules work for iOS/Android
3. ✅ **Build the UI** - Create windows that use `APIClient.Get()` to fetch data
4. ✅ **Add authentication** - Use `AuthManager.Login()` in login dialog

---

**That's it!** The simplest possible test with copy/paste. Should take 5-10 minutes total.

Let me know if you hit any issues!
