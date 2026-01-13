=================================================================
STUB CLASSES - HOW TO FIX COMPILATION ERRORS
=================================================================

If you created empty classes/modules from the architecture document
and are getting "unused parameter" or "missing implementation" errors,
use these stub implementations.

=================================================================
WHAT ARE STUBS?
=================================================================

Stubs are placeholder implementations that:
- Let your project compile without errors
- Return empty/default values
- Will be replaced with real implementations later

For now, we're ONLY testing the APIClient, not the business classes!

=================================================================
OPTION 1: Delete Empty Classes (Recommended for Testing)
=================================================================

If you haven't used these classes yet in your test code:

1. **Delete these classes/modules from your project:**
   - Indication class
   - Context class
   - User class
   - ChangeRequest class
   - CacheManager module

2. **Keep only the 3 working modules:**
   - AppConfig
   - APIClient
   - AuthManager

3. **Run your test** - it should work!

=================================================================
OPTION 2: Use Stub Implementations
=================================================================

If you want to keep the class structure:

1. **For Indication class:**
   - Copy ALL code from `Classes/Indication_STUB.txt`
   - Paste into your Indication class

2. **For Context class:**
   - Copy ALL code from `Classes/Context_STUB.txt`
   - Paste into your Context class

3. **For CacheManager module:**
   - Copy ALL code from `Modules/CacheManager_STUB.txt`
   - Paste into your CacheManager module

These stubs use `#Pragma Unused` to suppress parameter warnings.

=================================================================
QUICK FIX CHECKLIST
=================================================================

✅ AuthManager ViewBehavior fixed (CurrentUserFullName)
✅ APIClient URLConnection API fixed (Timeout, SetRequestContent)
✅ Test code array syntax fixed (IsA Variant())
✅ Stub classes created

TO COMPILE YOUR PROJECT:

□ Update AuthManager module (ViewBehavior fix)
□ Update test code (use CORRECTED_TEST_CODE.txt)
□ Either:
  □ Delete unused classes/modules, OR
  □ Use stub implementations from *_STUB.txt files

=================================================================
TESTING - WHAT YOU NEED
=================================================================

For the basic API test to work, you ONLY need:

✓ AppConfig module
✓ APIClient module
✓ AuthManager module
✓ App.Opening event with test code

That's it! No classes needed for basic testing.

=================================================================
NEXT STEPS AFTER TESTING WORKS
=================================================================

Once you see "✅ API is reachable" and "✅ Found 196 indications":

1. API client is working!
2. We can implement real business classes
3. We can build the actual Desktop/Mobile apps
4. We can add CacheManager for offline mode

But first - let's get the basic test working!

=================================================================
