# ECHO Indications - Companion Apps Next Steps

Date: 2026-01-13
Status: Planning Complete - Ready for Implementation

---

## ✅ Completed Tasks

### 1. Web App Code Review
- **Status:** COMPLETE
- **Files Created:**
  - `CLAUDE_CODE_REVIEW.md` - Comprehensive 20+ page analysis
  - `PROPOSED_CHANGES.md` - Optional improvements with examples
  - `REVIEW_SUMMARY.txt` - Quick reference
- **Findings:** 98% API 2 compliant, production-ready, excellent architecture

### 2. API Analysis
- **Status:** COMPLETE
- **Repository:** ECHOindications-API analyzed
- **API Type:** RPC-style with LiveCode Server
- **Authentication:** JWT-based (HMAC-SHA256, 30-min expiry)
- **Key Endpoints:** auth, indications, contexts, search, changes, users, dashboard, audit

### 3. UI/UX Review
- **Status:** COMPLETE
- **Screenshots Analyzed:** 10+ screens
- **Design System Identified:**
  - **Theme:** Light/Dark mode flexible
  - **Primary Color:** NHS Blue (#005EB8)
  - **Dark BG:** #1a1a1a, #2d2d2d
  - **Components:** Modal dialogs, segmented buttons, tables, badges
  - **Layout:** Sidebar + main content, top navigation

### 4. Architecture Planning
- **Status:** COMPLETE
- **File Created:** `COMPANION_APPS_ARCHITECTURE.md` (50+ pages)
- **Applications Designed:**
  1. **Desktop App** - Full admin interface (Windows/macOS/Linux)
  2. **Mobile App** - Browse/search for clinicians (iOS/Android)
- **Key Decisions:**
  - Three-tier architecture (Presentation, Business Logic, Data Access)
  - Shared API client modules
  - SQLite caching for offline mode
  - JWT authentication with secure storage
  - Light/Dark theme support

---

## 📋 What We're Building

### Desktop App: "ECHO Indications Desktop Admin"

**Target Users:** Hospital administrators, data managers

**Key Features:**
- ✅ Full CRUD for indications (create, read, update, delete)
- ✅ Context management (14 clinical categories)
- ✅ User administration
- ✅ Change request workflow management
- ✅ Comprehensive audit log viewing
- ✅ Advanced search and filtering
- ✅ Offline mode with sync
- ✅ Multi-window support
- ✅ Keyboard shortcuts

**Windows:**
1. MainWindow - Indications list with sidebar
2. LoginDialog - Authentication
3. IndicationEditorDialog - Create/edit with contexts
4. UsersWindow - User management
5. IssuesWindow - Change requests
6. AuditWindow - Audit trail viewer
7. SettingsDialog - App configuration

**Platforms:**
- Windows 10+ (64-bit .exe)
- macOS 11+ (Universal .app)
- Linux (Ubuntu/Debian .deb)

---

### Mobile App: "ECHO Indications Mobile"

**Target Users:** Clinicians, nurses, point-of-care staff

**Key Features:**
- ✅ Browse all 196+ indications
- ✅ Keyword search (real-time)
- ✅ Filter by context (ACHD, Arrhythmia, etc.)
- ✅ View full indication details
- ✅ Submit change requests
- ✅ Offline mode (cached data)
- ✅ Favorites/bookmarks
- ✅ Pull-to-refresh sync
- ✅ Touch-optimized UI

**Screens:**
1. LandingScreen - Splash with NHS branding
2. LoginScreen - Admin auth (optional)
3. IndicationsListScreen - Main browse with search
4. IndicationDetailScreen - Full details with swipe navigation
5. ContextFilterScreen - Multi-select contexts
6. ChangeRequestScreen - Submit feedback
7. SettingsScreen - Account and cache management

**Platforms:**
- iOS 14+ (App Store)
- Android 8+ (Google Play)

---

## 🏗️ Shared Architecture

### Core Modules (Both Apps)

```
Modules/
├── APIClient.xojo_code          # HTTP communication with API
├── AuthManager.xojo_code        # JWT token management
├── CacheManager.xojo_code       # SQLite offline storage
├── AppConfig.xojo_code          # Configuration constants
└── NetworkMonitor.xojo_code     # Connectivity checking
```

### Business Objects (Both Apps)

```
Classes/
├── Indication.xojo_code         # Indication CRUD + API methods
├── Context.xojo_code            # Context management
├── User.xojo_code               # User management (Desktop only)
├── ChangeRequest.xojo_code      # Change request submission
└── (Future: AuditEntry, etc.)
```

### Local Database (SQLite)

```sql
-- Offline caching
indications_cache (id, title, keywords, comments, ...)
contexts_cache (id, name, description, sort_order, ...)
indication_contexts_cache (indication_id, context_id)

-- Auth tokens (secure storage)
auth_tokens (id, token, expiry, user_id, username, ...)

-- Mobile only
favorites (indication_id, added_at)
```

---

## 🎨 Design System

### Colors

| Element | Light Mode | Dark Mode |
|---------|------------|-----------|
| **Primary (NHS Blue)** | #005EB8 | #005EB8 |
| **Background** | #FFFFFF | #1a1a1a |
| **Panel** | #F5F5F5 | #2d2d2d |
| **Text** | #000000 | #FFFFFF |
| **Secondary Text** | #666666 | #AAAAAA |
| **Border** | #CCCCCC | #444444 |

### Typography
- **Headers:** 24pt bold
- **Subheaders:** 18pt semi-bold
- **Body:** 14pt regular
- **Caption:** 12pt regular

### Components
- **Buttons:** Rounded 8px, 44pt min height (mobile)
- **Dialogs:** Blue header (#005EB8), white/dark content
- **Lists:** Alternating row colors, hover highlight
- **Badges:** Red circle with white text (notifications)
- **Segmented Buttons:** Blue highlight for active

---

## 📅 Development Roadmap

### Phase 1: Foundation (Week 1-2)
**Goal:** Set up projects and core infrastructure

- [ ] Create Xojo Desktop project (3 platforms)
- [ ] Create Xojo iOS project
- [ ] Create Xojo Android project
- [ ] Implement APIClient module
  - HTTP GET/POST methods
  - URL building
  - JSON parsing
  - Error handling
- [ ] Implement AuthManager module
  - Login flow
  - Token storage (Keychain/Credential Manager)
  - Token refresh
  - Logout
- [ ] Implement CacheManager module
  - SQLite database setup
  - Cache indications/contexts
  - Retrieve cached data
  - Sync timestamps
- [ ] Create AppConfig module (constants)
- [ ] Implement NetworkMonitor
- [ ] Test API connectivity

**Deliverable:** Working API client with authentication

---

### Phase 2: Desktop App Core (Week 3-4)
**Goal:** Main browsing and editing functionality

- [ ] Create MainWindow
  - Context sidebar with checkboxes
  - Indications listbox
  - Search field with live filtering
  - New/Edit/Delete buttons
  - Status bar with sync indicator
- [ ] Create LoginDialog
  - Username/password fields
  - Remember me checkbox
  - Error messages
- [ ] Create IndicationEditorDialog
  - All fields from API (title, keywords, comments, etc.)
  - Context checkboxes (scrolling panel)
  - Attribution checkboxes (BSE, EACVI, ASE, Consensus)
  - Appropriate use criteria dropdowns
  - Priority/urgency dropdown
  - Save/Cancel buttons
  - Validation
- [ ] Implement CRUD operations
  - Create new indication
  - Edit existing
  - Delete with confirmation
  - Save to API
- [ ] Implement search functionality
  - Keyword search (API or cached)
  - Context filtering
  - Combined filters
- [ ] Add offline mode
  - Auto-detect connectivity
  - Use cached data when offline
  - Queue changes for sync
  - Sync on reconnect

**Deliverable:** Functional indications management app

---

### Phase 3: Desktop App Extended (Week 5)
**Goal:** Admin features and polish

- [ ] Create UsersWindow
  - User list with search
  - Add/Edit/Delete users
  - Active/inactive toggle
- [ ] Create IssuesWindow
  - Change request list
  - Segmented filter buttons (All Open, New, In Progress, Closed, All)
  - Badge count for new items
  - Double-click to open details
- [ ] Create IssueDetailsDialog
  - Status dropdown
  - Requestor info
  - Existing vs. proposed comparison
  - Reason for close
  - Save changes
- [ ] Create AuditWindow
  - Audit log table (timestamp, action, user, table)
  - Date range filter
  - Table filter
  - User filter
  - Double-click for before/after details
- [ ] Create SettingsDialog
  - API endpoint config
  - Cache settings (expiry, clear button)
  - Theme toggle (light/dark)
  - About section
- [ ] Add keyboard shortcuts
  - Cmd/Ctrl+N for New
  - Cmd/Ctrl+F for Search
  - Cmd/Ctrl+S for Save
  - Cmd/Ctrl+W for Close Window
- [ ] Polish UI
  - Theme switching
  - Loading indicators
  - Progress bars for sync
  - Tooltips

**Deliverable:** Complete desktop admin application

---

### Phase 4: Mobile App Core (Week 6-7)
**Goal:** Browse and search functionality

- [ ] Create LandingScreen
  - ECHO logo
  - NHS branding
  - "View Indications" button
  - "Admin Login" button (optional)
- [ ] Create LoginScreen
  - Username/password fields
  - Back button
- [ ] Create IndicationsListScreen
  - Search bar (sticky at top)
  - Context filter dropdown
  - Indication cards (title, contexts, sources)
  - Infinite scroll / pagination
  - Pull-to-refresh
  - Offline indicator
- [ ] Create IndicationDetailScreen
  - Full indication details
  - Contexts section
  - Sources (checkboxes, read-only)
  - Keywords section
  - Comments section
  - Appropriate use criteria panel
  - Share button
  - Swipe left/right for navigation
- [ ] Implement search
  - Real-time filtering
  - Works offline with cached data
  - Debounce (300ms)
- [ ] Implement context filtering
  - Multi-select checkboxes
  - Apply/Clear buttons
  - Show filtered count
- [ ] Add offline mode
  - Cache on first launch
  - Use cached data when offline
  - Pull-to-refresh syncs
  - Offline indicator banner

**Deliverable:** Functional mobile browse app

---

### Phase 5: Mobile App Extended (Week 8)
**Goal:** Additional features and polish

- [ ] Create ContextFilterScreen
  - List all 14 contexts
  - Multi-select checkboxes
  - Show indication counts
  - Apply/Clear buttons
- [ ] Create ChangeRequestScreen
  - Indication selector (if not from detail)
  - Description text area (large)
  - Requestor name field
  - Requestor email field
  - Submit button
  - Success confirmation
- [ ] Add SettingsScreen
  - Account info (if logged in)
  - Logout button
  - Cache management
    - Last sync time
    - Clear cache button
  - About section
    - Version
    - License
- [ ] Implement favorites/bookmarks
  - Star button on detail screen
  - Store in local SQLite
  - "Favorites" filter on list screen
- [ ] Optimize for tablets
  - Master-detail split view (iPad/Android tablets)
  - Larger touch targets
  - Better use of screen space
- [ ] Polish UI
  - Theme switching (follow system preference)
  - Loading spinners
  - Empty state messages
  - Error states
  - Haptic feedback

**Deliverable:** Complete mobile app

---

### Phase 6: Testing & Refinement (Week 9)
**Goal:** Ensure quality and fix bugs

**Unit Tests:**
- [ ] APIClient methods (mock responses)
- [ ] AuthManager (token handling)
- [ ] CacheManager (SQLite operations)
- [ ] Business object validation
- [ ] JSON parsing/serialization

**Integration Tests:**
- [ ] Full authentication flow
- [ ] CRUD operations with real API
- [ ] Sync with various network conditions
- [ ] Offline mode switching

**UI Tests (Manual):**
- [ ] All windows/dialogs open correctly
- [ ] Navigation flows work
- [ ] Form validation shows errors
- [ ] Theme switching works
- [ ] Responsive layouts (various screen sizes)

**User Acceptance Testing:**
- [ ] Desktop: Admin workflow (manage indications, review changes, check audit)
- [ ] Mobile: Clinician workflow (search, find, view indication)
- [ ] Offline scenario (disconnect network, verify cached data works)
- [ ] Sync scenario (make offline changes, reconnect, verify sync)

**Performance Testing:**
- [ ] Large dataset (1000+ indications)
- [ ] Slow network conditions
- [ ] Memory usage
- [ ] Battery usage (mobile)

**Bug Fixes:**
- [ ] Fix any crashes
- [ ] Fix UI issues
- [ ] Fix data sync issues
- [ ] Optimize performance bottlenecks

**Deliverable:** Stable, tested applications

---

### Phase 7: Deployment (Week 10)
**Goal:** Release to production

**Desktop:**
- [ ] Build installers
  - Windows: .exe (Inno Setup or similar)
  - macOS: .dmg with signed .app bundle
  - Linux: .deb package
- [ ] Code signing
  - macOS: Apple Developer certificate
  - Windows: Authenticode certificate
- [ ] Create download page
- [ ] Write user documentation
- [ ] Deploy to echoindications.org/downloads

**Mobile:**
- [ ] Build release versions
  - iOS: Archive and export .ipa
  - Android: Build signed .aab
- [ ] App Store assets
  - Screenshots (various device sizes)
  - App description
  - Keywords
  - Privacy policy URL
  - Support URL
- [ ] Submit to stores
  - iOS: App Store Connect
  - Android: Google Play Console
- [ ] Review and approval process
- [ ] Release to production

**Documentation:**
- [ ] User guide (PDF)
- [ ] Admin guide (PDF)
- [ ] API documentation (for future developers)
- [ ] Deployment guide
- [ ] Troubleshooting guide

**Deliverable:** Released applications in production

---

## 🛠️ Technical Requirements

### Development Environment
- **Xojo 2025 Release 3** (or later)
- **macOS** (for iOS builds) or **Windows** (for Android/Windows builds)
- **Xojo licenses:**
  - Desktop license (Windows, macOS, Linux)
  - iOS license
  - Android license (if available, otherwise web builds)

### API Access
- **Base URL:** https://echoindications.org/API
- **Credentials:** Database and JWT secret (from settings.lc)
- **Test account:** Admin credentials for testing

### Design Assets
- **ECHO logo** (SVG or high-res PNG)
- **NHS logos** (GSTT, KCH, LGT)
- **Icons** (if any custom icons needed)

### Code Repository
- **Main repo:** stam66/echo_indications (web app)
- **API repo:** stam66/ECHOindications-API
- **New repos:**
  - stam66/echo_indications_desktop (Desktop app)
  - stam66/echo_indications_mobile (Mobile app)

---

## 📝 API Implementation Checklist

### Endpoints to Implement

**auth.lc:**
- [x] Login (POST)
- [ ] Refresh token (GET)

**indications.lc:**
- [x] List all (GET)
- [x] Read single (GET)
- [ ] List by context (GET)
- [ ] Create (POST) - API returns "not yet implemented"
- [ ] Update (POST) - API returns "not yet implemented"
- [x] Delete (POST)

**contexts.lc:**
- [x] List all (GET)
- [x] List with counts (GET)
- [x] Read single (GET)

**search.lc:**
- [x] Keyword search (GET)
- [ ] Advanced search (GET)

**changes.lc:**
- [x] List all (GET)
- [x] List by status (GET)
- [x] Read single (GET)
- [x] Count new (GET)

**users.lc:** (Protected - Desktop only)
- [ ] List all (GET)
- [ ] Read single (GET)
- [ ] Create (POST)
- [ ] Update (POST)
- [ ] Delete (POST)

**dashboard.lc:** (Protected - Desktop only)
- [ ] Stats (GET)
- [ ] User activity (GET)
- [ ] Recent changes (GET)

**audit.lc:** (Protected - Desktop only)
- [ ] Recent (GET)
- [ ] By table (GET)
- [ ] By record (GET)
- [ ] By user (GET)

---

## 🔐 Security Checklist

### Authentication
- [ ] JWT tokens stored in secure storage
  - macOS/iOS: Keychain
  - Windows: Credential Manager
  - Linux: libsecret
  - Android: KeyStore
- [ ] Tokens expire after 30 minutes
- [ ] Auto-refresh before expiry
- [ ] Logout clears all tokens
- [ ] Failed login shows clear error messages

### Network Security
- [ ] HTTPS only (no HTTP fallback)
- [ ] TLS 1.2 minimum
- [ ] Certificate validation enabled
- [ ] Optional: Certificate pinning for high security

### Data Security
- [ ] SQLite cache in app sandbox
- [ ] Optional: Encrypt SQLite database
- [ ] No PHI/PII stored (only indication data)
- [ ] Cache cleared on logout

### Input Validation
- [ ] All user input validated
- [ ] SQL injection prevention (PreparedStatements)
- [ ] No HTML rendering of user content

---

## 🧪 Testing Scenarios

### Authentication
1. ✅ Login with valid credentials → Success
2. ✅ Login with invalid credentials → Error message
3. ✅ Token expires after 30 min → Auto-refresh
4. ✅ Logout → Clears token, redirects to login

### CRUD Operations (Desktop)
1. ✅ Create indication → Saves to API, appears in list
2. ✅ Edit indication → Updates API, reflects changes
3. ✅ Delete indication → Removes from API, confirms deletion
4. ✅ Validation errors → Shows inline error messages

### Search & Filter
1. ✅ Keyword search → Returns matching indications
2. ✅ Context filter → Shows only indications in selected contexts
3. ✅ Combined filters → Works correctly
4. ✅ Clear filters → Shows all indications

### Offline Mode
1. ✅ Launch app offline → Shows cached data
2. ✅ Browse offline → Works with cached data
3. ✅ Search offline → Searches cached data
4. ✅ Make changes offline → Queues for sync
5. ✅ Go online → Syncs queued changes
6. ✅ Pull to refresh → Updates cache

### Mobile Specific
1. ✅ Pull to refresh → Syncs data
2. ✅ Swipe between indications → Navigates correctly
3. ✅ Bookmark indication → Saves to favorites
4. ✅ Submit change request → Submits successfully
5. ✅ Share indication → Opens share sheet

---

## 📦 Deliverables

### Phase 1-2 (Foundation + Desktop Core)
- [ ] Xojo Desktop project (working)
- [ ] API client modules (tested)
- [ ] Main indication management UI (functional)

### Phase 3 (Desktop Extended)
- [ ] Complete desktop app (all features)
- [ ] Installer builds for all platforms
- [ ] User documentation

### Phase 4-5 (Mobile)
- [ ] Xojo iOS project (working)
- [ ] Xojo Android project (working)
- [ ] Complete mobile app (all features)

### Phase 6 (Testing)
- [ ] Test reports
- [ ] Bug fixes completed
- [ ] Performance optimizations

### Phase 7 (Deployment)
- [ ] Desktop installers (Windows .exe, macOS .dmg, Linux .deb)
- [ ] Mobile app store submissions (iOS .ipa, Android .aab)
- [ ] Documentation (user guides, API docs)
- [ ] Release notes

---

## 🎯 Success Criteria

### Desktop App
- ✅ Full CRUD operations work
- ✅ Offline mode functions correctly
- ✅ Sync resolves conflicts properly
- ✅ Admin features (users, audit) accessible
- ✅ Runs on Windows 10+, macOS 11+, Linux (Ubuntu 20.04+)
- ✅ Performance: Lists 1000+ indications smoothly

### Mobile App
- ✅ Browse and search work offline
- ✅ UI is touch-optimized (44pt tap targets)
- ✅ Loads quickly (<2 seconds with cached data)
- ✅ Submits change requests successfully
- ✅ Passes App Store review (iOS)
- ✅ Passes Google Play review (Android)

### Both Apps
- ✅ API 2 compliant (Var, modern methods)
- ✅ Light/Dark theme works correctly
- ✅ NHS Blue branding consistent
- ✅ No crashes in testing
- ✅ Memory usage acceptable
- ✅ Battery usage acceptable (mobile)

---

## 💡 Future Enhancements (Post-v1.0)

### Desktop
- [ ] Export to CSV/PDF
- [ ] Bulk edit capabilities
- [ ] Dashboard with charts
- [ ] Multi-language support
- [ ] Keyboard maestro for power users

### Mobile
- [ ] Push notifications for change requests
- [ ] QR code sharing
- [ ] Voice search
- [ ] Apple Watch app
- [ ] Home screen widget

### Both
- [ ] Two-factor authentication
- [ ] Biometric login
- [ ] Analytics (anonymized usage)
- [ ] Accessibility improvements

---

## 📞 Support & Resources

### Documentation
- **Architecture:** COMPANION_APPS_ARCHITECTURE.md
- **Web App Review:** CLAUDE_CODE_REVIEW.md
- **API Repo:** https://github.com/stam66/ECHOindications-API

### Contact
- **Project Lead:** Dr S Kapetanakis
- **Email:** aucecho@gmail.com
- **Web:** https://echoindications.org

### External Resources
- **Xojo Documentation:** https://documentation.xojo.com
- **Xojo API 2:** https://documentation.xojo.com/topics/api_2.html
- **Xojo Forum:** https://forum.xojo.com

---

## ✅ Ready to Start!

**Current Status:** Planning complete, architecture designed, API analyzed

**Next Action:** Begin Phase 1 - Foundation (create projects, implement API client)

**Estimated Timeline:** 10 weeks from start to App Store submission

**Blockers:** None - all dependencies identified and available

---

**Document Version:** 1.0
**Last Updated:** 2026-01-13
**Status:** Ready for Implementation
**Approved By:** Pending review
