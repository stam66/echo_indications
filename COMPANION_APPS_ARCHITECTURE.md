# ECHO Indications - Companion Apps Architecture
**Desktop and Mobile Applications Plan**

Date: 2026-01-13
Project: ECHO Indications Companion Apps (Desktop & Mobile)
API: ECHOindications-API (LiveCode Server RPC-style)

---

## Executive Summary

Creating native **Desktop** (Windows/macOS/Linux) and **Mobile** (iOS/Android) companion applications using **Xojo** that consume the ECHOindications-API to provide:

- **Desktop App:** Full-featured admin interface for managing indications, users, audit logs
- **Mobile App:** Lightweight browse/search interface for clinicians to look up indications on the go

Both apps will share:
- Common API client classes
- Consistent UI/UX matching the web app
- NHS Blue branding (#005EB8)
- Dark theme aesthetic
- Offline caching capabilities

---

## Design Philosophy

### Shared Principles
1. **API 2 Compliant** - All code uses `Var`, modern array/string methods, PreparedStatements
2. **Consistent Branding** - Match web app's NHS Blue theme and dark aesthetic
3. **Secure** - JWT authentication, HTTPS only, secure storage of tokens
4. **Offline-Capable** - Cache indications locally for offline browsing
5. **Clean Architecture** - Separation of concerns (UI, Business Logic, Data Access)

### Desktop App Focus
- **Full CRUD operations** for admin users
- **Multi-window interface** for power users
- **Keyboard shortcuts** for efficiency
- **Advanced filtering** and search
- **Audit trail viewing**
- **User management**

### Mobile App Focus
- **Read-only** for most users (browse/search)
- **Touch-optimized** UI with swipe gestures
- **Quick search** for point-of-care use
- **Offline mode** for unreliable connectivity
- **Simple, focused** interface
- **Context filtering** for relevant indications

---

## Technology Stack

### Development Platform
- **Framework:** Xojo 2025 Release 3 (API 2)
- **Language:** Xojo (Object-Oriented, strongly-typed)
- **API Style:** RPC with JSON responses

### Desktop App
- **Target Platforms:** Windows 10+, macOS 11+, Linux (Ubuntu/Debian)
- **UI Framework:** Xojo Desktop (native controls)
- **Database:** SQLite for local caching
- **Networking:** URLConnection with HTTPS

### Mobile App
- **Target Platforms:** iOS 14+, Android 8+
- **UI Framework:** Xojo iOS (native UIKit) / Xojo Android
- **Database:** SQLite for local caching
- **Networking:** URLConnection with HTTPS

---

## Architecture Overview

### Three-Tier Architecture

```
┌─────────────────────────────────────────────┐
│         PRESENTATION LAYER (UI)              │
│  - Windows/Dialogs                           │
│  - Controls (Lists, Forms, Buttons)          │
│  - User Input Handling                       │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────┴───────────────────────────┐
│      BUSINESS LOGIC LAYER                    │
│  - Business Objects (Indication, Context,    │
│    User, ChangeRequest)                      │
│  - Validation Rules                          │
│  - Data Transformation                       │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────┴───────────────────────────┐
│       DATA ACCESS LAYER                      │
│  - APIClient (HTTP communication)            │
│  - CacheManager (Local SQLite storage)       │
│  - AuthManager (JWT token management)        │
└─────────────────────────────────────────────┘
```

---

## Shared Components (Both Apps)

### 1. API Client Classes

**APIClient Module** - Base HTTP communication
```xojo
Module APIClient
  // Configuration
  Property BaseURL As String = "https://echoindications.org/API"
  Property Timeout As Integer = 30 // seconds

  // Methods
  Function Get(endpoint As String, action As String, params As Dictionary = Nil) As Dictionary
  Function Post(endpoint As String, action As String, data As Dictionary) As Dictionary
  Function IsConnected() As Boolean

  // Private
  Private Function BuildURL(endpoint As String, action As String, params As Dictionary) As String
  Private Function ParseResponse(json As String) As Dictionary
  Private Function HandleError(response As Dictionary) As Boolean
End Module
```

**AuthManager Module** - Authentication & token management
```xojo
Module AuthManager
  // Properties
  Property CurrentToken As String
  Property TokenExpiry As DateTime
  Property CurrentUser As User
  Property IsAuthenticated As Boolean

  // Methods
  Function Login(username As String, password As String) As Boolean
  Function Refresh() As Boolean
  Function Logout()
  Function GetAuthHeader() As String // Returns "Bearer {token}"

  // Storage
  Private Sub SaveToken(token As String)
  Private Function LoadToken() As String
  Private Sub ClearToken()
End Module
```

**CacheManager Module** - Offline data storage (SQLite)
```xojo
Module CacheManager
  // Properties
  Property DB As SQLiteDatabase

  // Methods
  Function Initialize() As Boolean
  Function CacheIndications(indications() As Indication) As Boolean
  Function GetCachedIndications() As Indication()
  Function CacheContexts(contexts() As Context) As Boolean
  Function GetCachedContexts() As Context()
  Function ClearCache() As Boolean
  Function GetLastSync() As DateTime

  // SQLite Schema
  /*
    indications_cache (id, title, keywords, comments, primary_care,
                       secondary_inpatient, secondary_outpatient,
                       source_ase, source_eacvi, source_bse, source_consensus,
                       urgency, cached_at)
    contexts_cache (id, name, description, sort_order, is_active, cached_at)
    indication_contexts_cache (indication_id, context_id)
  */
End Module
```

### 2. Business Object Classes

**Indication Class**
```xojo
Class Indication
  // Properties
  Property ID As Integer
  Property Title As String
  Property Keywords As String
  Property Comments As String
  Property PrimaryCare As String // "indicated", "not_indicated", "can_be_considered"
  Property SecondaryInpatient As String
  Property SecondaryOutpatient As String
  Property SourceASE As Boolean
  Property SourceEACVI As Boolean
  Property SourceBSE As Boolean
  Property SourceConsensus As Boolean
  Property Urgency As String // "urgent", "soon", "routine", etc.
  Property ContextIDs() As Integer
  Property ContextNames() As String
  Property CreatedAt As DateTime
  Property UpdatedAt As DateTime

  // API Methods
  Shared Function GetAll() As Indication()
  Shared Function Search(keyword As String) As Indication()
  Shared Function GetByID(id As Integer) As Indication
  Shared Function GetByContext(contextID As Integer) As Indication()

  // Instance Methods
  Function Save() As Boolean
  Function Delete() As Boolean
  Function LoadContexts() As Boolean
  Function ToJSON() As String
  Shared Function FromJSON(json As String) As Indication
End Class
```

**Context Class**
```xojo
Class Context
  // Properties
  Property ID As Integer
  Property Name As String
  Property Description As String
  Property SortOrder As Integer
  Property IsActive As Boolean
  Property IndicationCount As Integer // From "with_counts" action

  // API Methods
  Shared Function GetAll() As Context()
  Shared Function GetAllActive() As Context()
  Shared Function GetWithCounts() As Context()
  Shared Function GetByID(id As Integer) As Context

  // Instance Methods
  Function ToJSON() As String
  Shared Function FromJSON(json As String) As Context
End Class
```

**User Class** (Desktop only)
```xojo
Class User
  // Properties
  Property ID As Integer
  Property Username As String
  Property Email As String
  Property Name As String
  Property Title As String
  Property IsActive As Boolean
  Property CreatedAt As DateTime
  Property UpdatedAt As DateTime

  // API Methods (Protected - requires auth)
  Shared Function GetAll() As User()
  Shared Function GetByID(id As Integer) As User
  Function Save() As Boolean
  Function Delete() As Boolean

  // Instance Methods
  Function ToJSON() As String
  Shared Function FromJSON(json As String) As User
End Class
```

**ChangeRequest Class**
```xojo
Class ChangeRequest
  // Properties
  Property ID As Integer
  Property IndicationID As Integer
  Property ChangesRequest As String
  Property ChangesRequestor As String
  Property ChangesStatus As String // "New", "In progress", "Closed", "Rejected"
  Property ReasonForClose As String
  Property IndicationExisting As String
  Property IndicationNew As String
  Property ContextsExisting As String
  Property ContextsNew As String
  Property CreatedAt As DateTime

  // API Methods
  Shared Function GetAll() As ChangeRequest()
  Shared Function GetByStatus(status As String) As ChangeRequest()
  Shared Function GetByID(id As Integer) As ChangeRequest
  Shared Function CountNew() As Integer

  // Instance Methods
  Function Submit() As Boolean
  Function ToJSON() As String
  Shared Function FromJSON(json As String) As ChangeRequest
End Class
```

### 3. Utility Modules

**AppConfig Module** - Configuration constants
```xojo
Module AppConfig
  // API Configuration
  #tag Constant, Name = API_BASE_URL, Type = String, Dynamic = False, Default = \"https://echoindications.org/API", Scope = Protected
  #tag EndConstant

  #tag Constant, Name = API_TIMEOUT, Type = Integer, Dynamic = False, Default = \"30", Scope = Protected
  #tag EndConstant

  // App Info
  #tag Constant, Name = APP_NAME, Type = String, Dynamic = False, Default = \"ECHO Indications", Scope = Protected
  #tag EndConstant

  #tag Constant, Name = APP_VERSION, Type = String, Dynamic = False, Default = \"1.0", Scope = Protected
  #tag EndConstant

  // Colors (NHS Blue theme)
  #tag Constant, Name = COLOR_NHS_BLUE, Type = Color, Dynamic = False, Default = \"&c005EB8", Scope = Protected
  #tag EndConstant

  #tag Constant, Name = COLOR_DARK_BG, Type = Color, Dynamic = False, Default = \"&c1a1a1a", Scope = Protected
  #tag EndConstant

  #tag Constant, Name = COLOR_DARK_PANEL, Type = Color, Dynamic = False, Default = \"&c2d2d2d", Scope = Protected
  #tag EndConstant

  // Cache Settings
  #tag Constant, Name = CACHE_EXPIRY_HOURS, Type = Integer, Dynamic = False, Default = \"24", Scope = Protected
  #tag EndConstant
End Module
```

**NetworkMonitor Module** - Connectivity checking
```xojo
Module NetworkMonitor
  Property IsOnline As Boolean

  Function CheckConnectivity() As Boolean
  Event ConnectionStatusChanged(isOnline As Boolean)
End Module
```

---

## Desktop App Detailed Design

### Application Name
**ECHO Indications Desktop Admin**

### Main Window Layout

```
┌──────────────────────────────────────────────────────────┐
│  ECHO Indications                          [Username] ▼  │ ← Toolbar
│  🏠 Indications  👥 Users  📋 Issues  📊 Audit  ⚙️ Settings │
├──────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌──────────────────────────────┐  │
│  │   SIDEBAR       │  │     MAIN CONTENT AREA        │  │
│  │                 │  │                              │  │
│  │  Contexts:      │  │  [Search: ______________ 🔍] │  │
│  │  ☑ All (196)    │  │                              │  │
│  │  ☐ ACHD (12)    │  │  Indication List:            │  │
│  │  ☐ Arrhythmia   │  │  ┌────────────────────────┐  │  │
│  │  ☐ Arterial     │  │  │ Acute coronary synd... │  │  │
│  │  ☐ Cardio-Onc   │  │  ├────────────────────────┤  │  │
│  │  ☐ Coronary     │  │  │ Acute pericarditis ... │  │  │
│  │  ☐ General      │  │  ├────────────────────────┤  │  │
│  │  ☐ ICC          │  │  │ Annual surveillance... │  │  │
│  │  ☐ Myocardial   │  │  └────────────────────────┘  │  │
│  │  ...            │  │                              │  │
│  │                 │  │  [+ New]  [Edit]  [Delete]   │  │
│  └─────────────────┘  └──────────────────────────────┘  │
│                                                          │
│  Status: Connected | Last sync: 2 mins ago  [Sync Now] │ ← Status Bar
└──────────────────────────────────────────────────────────┘
```

### Windows & Dialogs

#### 1. **MainWindow** - Primary interface
- **Left Sidebar:** Context filter checkboxes with counts
- **Main Area:** Listbox showing indications
- **Toolbar:** Navigation buttons, user menu, sync button
- **Search:** Real-time filtering as user types
- **Actions:** New/Edit/Delete buttons

#### 2. **LoginDialog** - Authentication
- Username field (email)
- Password field (masked)
- "Remember me" checkbox
- "Reset password" link
- Cancel / Login buttons
- NHS Blue header with logo

#### 3. **IndicationEditorDialog** - Create/Edit indication
- **Layout:** Similar to web app
- **Left Panel:** Context checkboxes (scrolling)
- **Right Panel:**
  - Title TextField
  - Keywords/Synonyms TextArea
  - Comments TextArea
  - Attribution checkboxes (BSE, EACVI, ASE, Consensus)
  - Appropriate Use Criteria:
    - Primary Care PopupMenu
    - Secondary Care (OP) PopupMenu
    - Secondary Care (IP) PopupMenu
  - Priority/Urgency PopupMenu
- **Buttons:** Cancel, Save
- **Validation:** Required fields, duplicate title check

#### 4. **UsersWindow** - User management
- Listbox showing all users (name, username, email, title, status)
- Add/Edit/Deactivate buttons
- Search/filter functionality

#### 5. **IssuesWindow** - Change requests
- Segmented button for status filter (All Open, New, In Progress, Closed, All)
- Listbox showing requests (title, status, date, requestor)
- Badge count for "New" items
- Double-click to open details

#### 6. **IssueDetailsDialog** - View/edit change request
- Status PopupMenu (New, In Progress, Closed, Rejected)
- Requestor field (read-only)
- Issue description (read-only or editable)
- Existing vs. Proposed (side-by-side comparison)
- Reason for close (if closed/rejected)
- Cancel / Save buttons

#### 7. **AuditWindow** - Audit trail viewer
- Date range filter
- Table/action filter (indications, users, contexts)
- User filter
- Listbox showing audit entries
- Double-click to view details (before/after values)

#### 8. **SettingsDialog** - App configuration
- API endpoint configuration
- Cache settings (expiry time, clear cache button)
- Theme settings (future: light/dark toggle)
- About section (version, credits)

### Desktop Features

**Core Functionality:**
- [x] Full CRUD for indications
- [x] Context management
- [x] User management (admin only)
- [x] Change request workflow
- [x] Audit log viewing
- [x] Search (keyword and advanced)
- [x] Offline mode with sync
- [x] Export to CSV/PDF (optional)

**User Experience:**
- Keyboard shortcuts (Cmd/Ctrl+N for new, Cmd/Ctrl+F for search, etc.)
- Right-click context menus
- Drag-and-drop for reordering
- Auto-save drafts
- Undo/Redo support
- Multi-window for power users

---

## Mobile App Detailed Design

### Application Name
**ECHO Indications Mobile**

### Screen Flow

```
Landing Screen → Login (if admin) → Indications List → Indication Detail
                                  ↓
                              Context Filter → Filtered List
```

### Screens

#### 1. **LandingScreen** - Splash/Home
- Large ECHO logo
- "View Indications" button (primary action)
- "Admin Login" button (secondary)
- NHS logos footer
- Version info

#### 2. **LoginScreen** - Admin authentication
- Username field
- Password field
- "Forgot password?" link
- Login button
- Back button

#### 3. **IndicationsListScreen** - Main browsing interface
```
┌──────────────────────────────────┐
│  🔍 Search indications...        │ ← Search bar (sticky)
├──────────────────────────────────┤
│  🏷️ Contexts: All (196) ▼        │ ← Context filter (expandable)
├──────────────────────────────────┤
│  ┌────────────────────────────┐  │
│  │ Acute coronary syndrome    │  │ ← Card (tap to open)
│  │ Contexts: Coronary, Urgent │  │
│  │ Sources: ASE, BSE          │  │
│  └────────────────────────────┘  │
│  ┌────────────────────────────┐  │
│  │ Acute pericarditis         │  │
│  │ Contexts: Pericardial      │  │
│  │ Sources: EACVI, Consensus  │  │
│  └────────────────────────────┘  │
│  ...                             │
│                                  │
│  [Scroll to load more]           │
└──────────────────────────────────┘
```

**Features:**
- Pull-to-refresh (sync with server)
- Infinite scroll / pagination
- Search as-you-type
- Context filter chips
- Offline mode indicator
- Swipe-to-favorite (bookmark for quick access)

#### 4. **IndicationDetailScreen** - Full details
```
┌──────────────────────────────────┐
│  ← Back                    Share │ ← Navigation bar
├──────────────────────────────────┤
│  Acute coronary syndrome         │ ← Title (large, bold)
│                                  │
│  🏷️ Contexts                     │
│  Coronary, Urgent                │
│                                  │
│  📚 Sources                      │
│  ☑ ASE  ☑ BSE                    │
│  ☐ EACVI  ☐ Consensus            │
│                                  │
│  🔑 Keywords                     │
│  ACS, MI, chest pain, STEMI,    │
│  NSTEMI                          │
│                                  │
│  💬 Comments                     │
│  Urgent echocardiography...      │
│                                  │
│  ✅ Appropriate Use Criteria     │
│  ┌──────────────────────────┐   │
│  │ Primary Care             │   │
│  │ 🟢 Indicated              │   │
│  ├──────────────────────────┤   │
│  │ Secondary Care (OP)      │   │
│  │ 🟢 Indicated              │   │
│  ├──────────────────────────┤   │
│  │ Secondary Care (IP)      │   │
│  │ 🟢 Indicated              │   │
│  ├──────────────────────────┤   │
│  │ Priority                 │   │
│  │ 🔴 Urgent                 │   │
│  └──────────────────────────┘   │
│                                  │
│  [Request Change]                │ ← Action button
└──────────────────────────────────┘
```

**Features:**
- Swipe left/right to navigate between indications
- Share button (export as text/PDF)
- Bookmark/favorite button
- "Request Change" opens submission form
- Color-coded urgency (🔴 Urgent, 🟡 Soon, 🟢 Routine)

#### 5. **ContextFilterScreen** - Filter by context
- List of all contexts with counts
- Multi-select checkboxes
- "Apply" button
- "Clear All" button

#### 6. **ChangeRequestScreen** - Submit change request
- Indication selector (if not from detail screen)
- Description TextArea (large)
- Requestor name/email fields
- Submit button
- Success confirmation

#### 7. **SettingsScreen** (Admin only)
- Account info (name, email)
- Logout button
- Cache management (clear cache, last sync time)
- About (version, licenses)

### Mobile Features

**Core Functionality:**
- [x] Browse all indications
- [x] Search (keyword)
- [x] Filter by context
- [x] View full indication details
- [x] Submit change requests
- [x] Offline mode (cached data)
- [x] Pull-to-refresh sync
- [x] Bookmark favorites (local storage)

**User Experience:**
- Touch-optimized (44pt minimum tap targets)
- Swipe gestures (back, navigate between records)
- Pull-to-refresh
- Haptic feedback
- Dark mode support
- Responsive design (tablet support)
- Fast launch with cached data

---

## Data Flow

### Authentication Flow

```
1. User launches app
2. App checks for saved token (AuthManager.LoadToken())
3. If token exists and not expired:
   → Auto-login (silent)
4. If token expired:
   → Show login screen
5. User enters credentials
6. App calls APIClient.Post("auth.lc", "login", {username, password})
7. API returns JWT token + user info
8. AuthManager saves token and user info
9. App navigates to main screen
```

### Data Sync Flow (Desktop/Mobile)

```
1. User triggers sync (manual or auto on launch)
2. NetworkMonitor.CheckConnectivity()
3. If offline:
   → Load from CacheManager (SQLite)
   → Show "Offline Mode" indicator
4. If online:
   → APIClient.Get("indications.lc", "list")
   → APIClient.Get("contexts.lc", "with_counts")
   → CacheManager.CacheIndications(indications)
   → CacheManager.CacheContexts(contexts)
   → Update UI with fresh data
   → Update "Last synced" timestamp
```

### Create/Edit Flow (Desktop)

```
1. User clicks "New" or "Edit" button
2. App opens IndicationEditorDialog
3. User fills form and clicks "Save"
4. App validates input (required fields, duplicates)
5. If invalid:
   → Show error message
   → Keep dialog open
6. If valid:
   → indication.ToJSON()
   → APIClient.Post("indications.lc", "create" or "update", json)
   → If success:
     → Close dialog
     → Refresh list
     → Show success message
   → If error:
     → Show API error message
     → Keep dialog open
```

### Search Flow

```
1. User types in search field
2. After 300ms delay (debounce):
   → If online:
     → APIClient.Get("search.lc", "keyword", {q: searchText})
     → Display results
   → If offline:
     → CacheManager.SearchLocal(searchText) // SQLite LIKE query
     → Display cached results with offline indicator
```

---

## Database Schema (Local Cache - SQLite)

### Table: indications_cache

```sql
CREATE TABLE indications_cache (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  keywords TEXT,
  comments TEXT,
  primary_care TEXT,
  secondary_inpatient TEXT,
  secondary_outpatient TEXT,
  source_ase INTEGER DEFAULT 0,
  source_eacvi INTEGER DEFAULT 0,
  source_bse INTEGER DEFAULT 0,
  source_consensus INTEGER DEFAULT 0,
  urgency TEXT,
  cached_at TEXT NOT NULL
);

CREATE INDEX idx_title ON indications_cache(title);
CREATE INDEX idx_keywords ON indications_cache(keywords);
CREATE INDEX idx_urgency ON indications_cache(urgency);
```

### Table: contexts_cache

```sql
CREATE TABLE contexts_cache (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER,
  is_active INTEGER DEFAULT 1,
  indication_count INTEGER DEFAULT 0,
  cached_at TEXT NOT NULL
);

CREATE INDEX idx_active ON contexts_cache(is_active);
CREATE INDEX idx_sort_order ON contexts_cache(sort_order);
```

### Table: indication_contexts_cache

```sql
CREATE TABLE indication_contexts_cache (
  indication_id INTEGER NOT NULL,
  context_id INTEGER NOT NULL,
  PRIMARY KEY (indication_id, context_id),
  FOREIGN KEY (indication_id) REFERENCES indications_cache(id),
  FOREIGN KEY (context_id) REFERENCES contexts_cache(id)
);
```

### Table: auth_tokens

```sql
CREATE TABLE auth_tokens (
  id INTEGER PRIMARY KEY,
  token TEXT NOT NULL,
  expiry TEXT NOT NULL,
  user_id INTEGER,
  username TEXT,
  user_email TEXT,
  created_at TEXT NOT NULL
);
```

### Table: favorites (Mobile only)

```sql
CREATE TABLE favorites (
  indication_id INTEGER PRIMARY KEY,
  added_at TEXT NOT NULL
);
```

---

## Security Considerations

### Authentication
- ✅ JWT tokens stored securely (Keychain on macOS/iOS, Credential Manager on Windows, Keyring on Linux)
- ✅ Tokens expire after 30 minutes (auto-refresh before expiry)
- ✅ Logout clears all tokens and cache
- ✅ Failed login attempts logged (API handles rate limiting)

### Network Security
- ✅ HTTPS only (TLS 1.2+)
- ✅ Certificate pinning (optional, for high security)
- ✅ No credentials stored in plaintext
- ✅ API key/secret not embedded in app (JWT-based auth)

### Data Security
- ✅ Local cache encrypted (optional, for sensitive deployments)
- ✅ SQLite database in app sandbox (not world-readable)
- ✅ Cache cleared on logout
- ✅ No PHI/PII stored locally (only indication data)

### Code Security
- ✅ API 2 compliant (no legacy code)
- ✅ Input validation on all user input
- ✅ SQL injection prevention (PreparedStatements)
- ✅ XSS prevention (no HTML rendering of user input)

---

## Error Handling

### Network Errors
- **Connection timeout:** Show "Connection timed out. Check your internet connection."
- **Server error (5xx):** Show "Server error. Please try again later."
- **Rate limited (429):** Show "Too many requests. Please wait and try again."
- **Unauthorized (401):** Force re-login

### Validation Errors
- **Required field empty:** Highlight field in red, show inline error
- **Duplicate title:** Show "An indication with this title already exists."
- **Invalid format:** Show specific format requirement

### Cache Errors
- **Database error:** Fall back to API-only mode, show warning
- **Corrupted cache:** Clear cache and re-sync

---

## Performance Optimization

### Desktop App
- Lazy load indication details (only fetch when dialog opens)
- Virtual scrolling for large lists (1000+ items)
- Background sync (don't block UI)
- Debounce search (300ms delay)
- Cache images/logos locally

### Mobile App
- Pagination (load 50 items at a time)
- Image lazy loading
- Aggressive caching (24 hour expiry)
- Background fetch (iOS: update cache while app suspended)
- Fast app launch (show cached data immediately, sync in background)

---

## Testing Strategy

### Unit Tests
- API client methods (mock HTTP responses)
- Business object validation
- Authentication logic
- Cache operations

### Integration Tests
- Full auth flow (login, refresh, logout)
- CRUD operations with real API
- Sync with error conditions
- Offline mode switching

### UI Tests (Manual)
- All windows/dialogs open correctly
- Navigation flows
- Form validation
- Error messages
- Responsive layouts (mobile: various screen sizes)

### User Acceptance Testing
- Clinician workflow (mobile: search → find → view)
- Admin workflow (desktop: manage indications → submit change)
- Offline scenario (disconnect network, verify cached data)

---

## Deployment

### Desktop App
**Build Targets:**
- Windows: .exe installer (64-bit)
- macOS: .app bundle in .dmg (Apple Silicon + Intel Universal)
- Linux: .deb package (Ubuntu/Debian)

**Distribution:**
- Direct download from echoindications.org
- Auto-update mechanism (check for updates on launch)
- Version checking against API

### Mobile App
**Build Targets:**
- iOS: .ipa (submitted to App Store)
- Android: .apk/.aab (submitted to Google Play)

**App Store Requirements:**
- Privacy policy URL
- Screenshots (various device sizes)
- Description, keywords
- Age rating (Medical app - 17+)
- Compliance statements

**Distribution:**
- iOS: App Store
- Android: Google Play Store
- Enterprise: Direct distribution (.ipa/.apk) for hospital deployment

---

## Development Roadmap

### Phase 1: Foundation (Week 1-2)
- [ ] Create Xojo projects (Desktop + Mobile)
- [ ] Implement API client classes (APIClient, AuthManager, CacheManager)
- [ ] Implement business object classes (Indication, Context, User, ChangeRequest)
- [ ] Set up SQLite schemas
- [ ] Test API connectivity

### Phase 2: Desktop App Core (Week 3-4)
- [ ] Create MainWindow with sidebar and list
- [ ] Implement LoginDialog
- [ ] Implement IndicationEditorDialog
- [ ] Implement search and filtering
- [ ] Implement CRUD operations
- [ ] Add offline mode with sync

### Phase 3: Desktop App Extended (Week 5)
- [ ] Create UsersWindow
- [ ] Create IssuesWindow with workflow
- [ ] Create AuditWindow
- [ ] Add keyboard shortcuts
- [ ] Polish UI/UX

### Phase 4: Mobile App Core (Week 6-7)
- [ ] Create IndicationsListScreen
- [ ] Implement IndicationDetailScreen
- [ ] Add search functionality
- [ ] Add context filtering
- [ ] Implement offline mode
- [ ] Add pull-to-refresh

### Phase 5: Mobile App Extended (Week 8)
- [ ] Add ChangeRequestScreen
- [ ] Add favorites/bookmarks
- [ ] Optimize for tablets
- [ ] Polish UI/UX (touch targets, animations)

### Phase 6: Testing & Refinement (Week 9)
- [ ] Unit tests
- [ ] Integration tests
- [ ] User acceptance testing
- [ ] Bug fixes
- [ ] Performance optimization

### Phase 7: Deployment (Week 10)
- [ ] Build desktop installers
- [ ] Submit mobile apps to stores
- [ ] Create documentation
- [ ] Deploy to production

---

## Future Enhancements (Post v1.0)

### Desktop App
- [ ] Export to CSV/PDF
- [ ] Advanced search with multiple filters
- [ ] Bulk edit capabilities
- [ ] Change request approval workflow
- [ ] Dashboard with statistics
- [ ] Dark/light theme toggle
- [ ] Multi-language support

### Mobile App
- [ ] Push notifications for change requests
- [ ] Offline editing (queue for sync)
- [ ] QR code sharing
- [ ] Voice search
- [ ] Apple Watch companion app
- [ ] Widget for quick search

### Both
- [ ] Two-factor authentication
- [ ] Biometric login (Face ID, Touch ID, Fingerprint)
- [ ] Analytics/usage tracking (anonymized)
- [ ] Accessibility improvements (screen reader support)

---

## Conclusion

This architecture provides a solid foundation for building professional, secure, and user-friendly companion applications for the ECHO Indications platform. The shared API client and business logic classes ensure consistency between desktop and mobile apps, while platform-specific UI optimizations provide the best experience on each device.

**Next Steps:**
1. Review and approve architecture
2. Set up Xojo projects
3. Begin Phase 1 implementation
4. Iterate based on user feedback

---

**Document Version:** 1.0
**Last Updated:** 2026-01-13
**Status:** Architecture Plan - Ready for Implementation
