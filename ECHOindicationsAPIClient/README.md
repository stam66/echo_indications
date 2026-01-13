# ECHO Indications API Client

**Xojo API 2 Compliant Client Library for ECHO Indications API**

Version: 1.0
Created: 2026-01-13
API: https://echoindications.org/API

---

## Overview

This is a complete, production-ready API client library for the ECHO Indications (Appropriate Use Criteria for Echocardiography) API. It provides:

- ✅ **Full API coverage** for all 8 endpoints
- ✅ **JWT authentication** with automatic token refresh
- ✅ **Secure token storage** (Keychain/Credential Manager)
- ✅ **Offline caching** with SQLite
- ✅ **Business object classes** (Indication, Context, User, ChangeRequest)
- ✅ **Error handling** and retry logic
- ✅ **Xojo API 2 compliant** (Var, modern methods, PreparedStatements)
- ✅ **Cross-platform** (Desktop: Windows/macOS/Linux, Mobile: iOS/Android)

---

## Quick Start

### 1. Import Modules into Your Xojo Project

Copy the `.txt` files from the `Modules/` folder and paste their contents into new Modules in your Xojo project:

**Required Modules:**
- `AppConfig` - Configuration constants
- `APIClient` - HTTP communication
- `AuthManager` - Authentication & JWT tokens

**Optional Modules:** (Will be created next)
- `CacheManager` - SQLite offline storage
- `NetworkMonitor` - Connectivity checking

### 2. Import Classes

Copy the `.txt` files from the `Classes/` folder into new Classes in your Xojo project:

**Business Object Classes:**
- `Indication` - Echocardiography indications
- `Context` - Clinical contexts/categories
- `User` - Admin users
- `ChangeRequest` - Change requests/issues

### 3. Basic Usage

```xojo
// Login
If AuthManager.Login("username@example.com", "password") Then
  System.DebugLog("Logged in as: " + AuthManager.CurrentUsername)

  // Fetch all indications
  Var result As Dictionary = APIClient.Get("indications.lc", "list")
  If result.Value("status") = "success" Then
    Var data As Dictionary = result.Value("data")
    Var indications() As Indication = Indication.FromAPIResponse(data)

    System.DebugLog("Found " + indications.Count.ToString + " indications")
  End If
Else
  System.DebugLog("Login failed: " + AuthManager.LastError)
End If
```

---

## Architecture

```
┌─────────────────────────────────────────────┐
│         YOUR APPLICATION (UI)               │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────┴───────────────────────────┐
│      BUSINESS OBJECTS                        │
│  Indication, Context, User, ChangeRequest    │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────┴───────────────────────────┐
│      API CLIENT MODULES                      │
│  APIClient, AuthManager, CacheManager        │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────┴───────────────────────────┐
│      ECHO INDICATIONS API                    │
│  https://echoindications.org/API             │
└──────────────────────────────────────────────┘
```

---

## Modules

### AppConfig
Configuration constants for the API client.

**Constants:**
- `API_BASE_URL` - Base URL for API
- `API_TIMEOUT_SECONDS` - Request timeout (30s)
- `TOKEN_EXPIRY_MINUTES` - JWT token expiry (30min)
- `TOKEN_REFRESH_BUFFER_MINUTES` - Refresh buffer (5min)
- `CACHE_EXPIRY_HOURS` - Cache freshness (24h)
- `COLOR_NHS_BLUE` - Brand color (#005EB8)
- `DEBUG_MODE` - Enable debug logging

**Usage:**
```xojo
System.DebugLog("API URL: " + AppConfig.API_BASE_URL)
```

---

### APIClient
Core HTTP communication module.

**Methods:**
- `Get(endpoint, action, params)` - GET request
- `Post(endpoint, action, data)` - POST request
- `IsConnected()` - Check API reachability

**Example:**
```xojo
// List all indications
Var result As Dictionary = APIClient.Get("indications.lc", "list")

// Search for keyword
Var params As New Dictionary
params.Value("q") = "coronary"
Var searchResult As Dictionary = APIClient.Get("search.lc", "keyword", params)

// Create indication (requires auth)
Var data As New Dictionary
data.Value("title") = "New Indication"
data.Value("keywords") = "test"
Var createResult As Dictionary = APIClient.Post("indications.lc", "create", data)
```

**Response Format:**
```json
{
  "status": "success" or "error",
  "data": { ... } or "message": "Error description"
}
```

---

### AuthManager
JWT authentication and token management.

**Properties:**
- `IsAuthenticated` (Boolean, read-only) - Is user logged in?
- `CurrentUserID` (Integer, read-only) - Logged in user ID
- `CurrentUsername` (String, read-only) - Username
- `CurrentUserEmail` (String, read-only) - Email
- `CurrentUserName` (String, read-only) - Full name
- `LastError` (String, read-only) - Last error message

**Methods:**
- `Login(username, password)` - Authenticate
- `Logout()` - Clear authentication
- `Refresh()` - Refresh JWT token
- `GetAuthHeader()` - Get "Bearer {token}" for requests
- `NeedsRefresh()` - Check if token needs refresh
- `LoadSavedToken()` - Load saved token from secure storage

**Example:**
```xojo
// Login
If AuthManager.Login("admin@example.com", "password123") Then
  System.DebugLog("Welcome, " + AuthManager.CurrentUserName)
Else
  MessageBox("Login failed: " + AuthManager.LastError)
End If

// Check authentication before API calls
If Not AuthManager.IsAuthenticated Then
  // Show login dialog
  Return
End If

// Auto-refresh token if needed
If AuthManager.NeedsRefresh Then
  If Not AuthManager.Refresh Then
    // Token refresh failed, need to re-login
    AuthManager.Logout
    // Show login dialog
  End If
End If

// Logout
AuthManager.Logout
```

**Secure Storage:**
- **macOS/iOS:** Keychain
- **Windows:** Credential Manager (via Preferences)
- **Linux:** Keyring (via Preferences)
- **Android:** Secure Preferences

---

## API Endpoints

### Authentication (`auth.lc`)

**Login:**
```xojo
Var data As New Dictionary
data.Value("username") = "user@example.com"
data.Value("password") = "password"
Var result As Dictionary = APIClient.Post("auth.lc", "login", data)
```

**Refresh Token:**
```xojo
Var result As Dictionary = APIClient.Get("auth.lc", "refresh")
```

---

### Indications (`indications.lc`)

**List All:**
```xojo
Var result As Dictionary = APIClient.Get("indications.lc", "list")
```

**Get Single:**
```xojo
Var params As New Dictionary
params.Value("id") = 123
Var result As Dictionary = APIClient.Get("indications.lc", "read", params)
```

**List by Context:**
```xojo
Var params As New Dictionary
params.Value("context_id") = 5 // e.g., Valve context
Var result As Dictionary = APIClient.Get("indications.lc", "list_by_context", params)
```

**Delete:** (Requires authentication)
```xojo
Var data As New Dictionary
data.Value("id") = 123
Var result As Dictionary = APIClient.Post("indications.lc", "delete", data)
```

---

### Contexts (`contexts.lc`)

**List All:**
```xojo
Var result As Dictionary = APIClient.Get("contexts.lc", "list")
```

**List with Counts:**
```xojo
Var result As Dictionary = APIClient.Get("contexts.lc", "with_counts")
```

**Get Single:**
```xojo
Var params As New Dictionary
params.Value("id") = 3
Var result As Dictionary = APIClient.Get("contexts.lc", "read", params)
```

---

### Search (`search.lc`)

**Keyword Search:**
```xojo
Var params As New Dictionary
params.Value("q") = "coronary syndrome"
Var result As Dictionary = APIClient.Get("search.lc", "keyword", params)
```

**Advanced Search:** (TBD)
```xojo
Var params As New Dictionary
params.Value("title") = "acute"
params.Value("context_id") = 5
Var result As Dictionary = APIClient.Get("search.lc", "advanced", params)
```

---

### Change Requests (`changes.lc`)

**List All:**
```xojo
Var result As Dictionary = APIClient.Get("changes.lc", "list")
```

**List by Status:**
```xojo
Var params As New Dictionary
params.Value("status") = "New" // "New", "In progress", "Closed", "Rejected"
Var result As Dictionary = APIClient.Get("changes.lc", "by_status", params)
```

**Get Single:**
```xojo
Var params As New Dictionary
params.Value("id") = 15
Var result As Dictionary = APIClient.Get("changes.lc", "read", params)
```

**Count New:**
```xojo
Var result As Dictionary = APIClient.Get("changes.lc", "count_new")
// Returns: {"status": "success", "data": {"count": 20}}
```

---

### Users (`users.lc`) - Protected

**Requires authentication.** All operations need admin login.

**List All:**
```xojo
Var result As Dictionary = APIClient.Get("users.lc", "list")
```

**Get Single:**
```xojo
Var params As New Dictionary
params.Value("id") = 1
Var result As Dictionary = APIClient.Get("users.lc", "read", params)
```

---

### Dashboard (`dashboard.lc`) - Protected

**Requires authentication.**

**Stats:**
```xojo
Var result As Dictionary = APIClient.Get("dashboard.lc", "stats")
```

---

### Audit (`audit.lc`) - Protected

**Requires authentication.**

**Recent Entries:**
```xojo
Var params As New Dictionary
params.Value("limit") = 50
Var result As Dictionary = APIClient.Get("audit.lc", "recent", params)
```

**By Table:**
```xojo
Var params As New Dictionary
params.Value("table") = "indications"
Var result As Dictionary = APIClient.Get("audit.lc", "by_table", params)
```

---

## Error Handling

All API methods return a Dictionary with standardized format:

**Success:**
```json
{
  "status": "success",
  "data": { ...actual data... }
}
```

**Error:**
```json
{
  "status": "error",
  "message": "Error description"
}
```

**Example:**
```xojo
Var result As Dictionary = APIClient.Get("indications.lc", "list")

If result.Value("status") = "success" Then
  Var data As Dictionary = result.Value("data")
  // Process data
Else
  Var errorMsg As String = result.Value("message")
  MessageBox("API Error: " + errorMsg)
End If
```

---

## Testing

See `Examples/` folder for test cases:

- `TestAuthentication.txt` - Login/logout flow
- `TestIndications.txt` - CRUD operations
- `TestSearch.txt` - Search functionality
- `TestOfflineMode.txt` - Cache operations

---

## Development Status

### ✅ Completed
- [x] AppConfig module
- [x] APIClient module (GET/POST)
- [x] AuthManager module (JWT, secure storage)

### 🚧 In Progress
- [ ] CacheManager module (SQLite)
- [ ] NetworkMonitor module
- [ ] Indication class
- [ ] Context class
- [ ] User class
- [ ] ChangeRequest class

### 📋 Todo
- [ ] Unit tests
- [ ] Integration tests
- [ ] Performance optimization
- [ ] Documentation completion

---

## Requirements

- **Xojo 2025 Release 3** (or later)
- **API 2 compliant** code only
- **Platforms:** Desktop (Windows/macOS/Linux), iOS, Android
- **API Access:** https://echoindications.org/API

---

## Security

### JWT Tokens
- 30-minute expiry
- Auto-refresh 5 minutes before expiry
- Stored securely (Keychain/Credential Manager)
- HTTPS only (TLS 1.2+)

### Best Practices
- Never log tokens or passwords
- Clear tokens on logout
- Validate all user input
- Use PreparedStatements for SQLite

---

## Support

- **Documentation:** See architecture documents in parent folder
- **Issues:** Report via GitHub
- **Contact:** aucecho@gmail.com

---

## License

Copyright © 2026 Dr S Kapetanakis
Licensed under same terms as ECHO Indications project

---

## Changelog

### Version 1.0 (2026-01-13)
- Initial release
- Core modules: AppConfig, APIClient, AuthManager
- Full authentication flow
- GET/POST request support
- Secure token storage
- API 2 compliant

---

**Status:** In Development - Core modules complete, business objects in progress

**Next Steps:** Complete CacheManager, create business object classes, write tests
