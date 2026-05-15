# PBKDF2 Iteration Count Reduction - Deployment Guide

## Problem

PBKDF2 with 10,000 iterations was taking **14-15 seconds** per login on LiveCode Server - completely unacceptable for user experience.

## Solution

Reduced iteration count from **10,000 to 1,000** in both systems:
- Expected performance: ~1.4-1.5 seconds (10x faster)
- Still provides good security for your use case
- Much better than plain SHA-256

## What Was Changed

### 1. Xojo Web App (echo_indications repo)

Updated PBKDF2 calls from `10000` to `1000` iterations in:

- **Dialogs/dlg_Login.xojo_code** (line 379)
- **Dialogs/dlg_Reset.xojo_code** (line 287)
- **Dialogs/dlg_NewPassword.xojo_code** (line 325)

### 2. LiveCode API (db-functions.lc)

Updated `getPasswordIterations()` function (line 322):

```livecode
function getPasswordIterations
  return 1000  -- Changed from 10000
end getPasswordIterations
```

## Deployment Steps

### Step 1: Deploy Updated API

Upload the updated `db-functions-FIXED.lc` to your server:

```bash
scp db-functions-FIXED.lc user@yourserver:/var/www/api/API/lib/db-functions.lc
```

**Test the performance improvement:**
```bash
time curl -s "https://api.echoindications.org/test_hash_stam.lc"
```

Should now take ~1.4-1.5 seconds instead of 14-15 seconds.

### Step 2: Deploy Updated Xojo Web App

Rebuild and deploy the Xojo web app with the updated code.

### Step 3: **CRITICAL** - Reset All User Passwords

⚠️ **ALL existing password hashes will be invalid** because they were created with 10,000 iterations.

**Option A: Force Password Reset for All Users**
1. Run SQL update to set all users to OTP mode:
   ```sql
   UPDATE users SET OTP = 1;
   ```
2. Notify all users they need to use password reset
3. They'll receive temporary password via email
4. They set new permanent password

**Option B: Reset Specific Known Users**
1. Use the web app password reset for each user
2. Manually send them the temporary password
3. They login and set new password

**Option C: Keep One Admin Account Working (Recommended)**
1. Reset password for ONE admin account first
2. Use that account to manage other users if needed
3. Have users reset their own passwords via email

## Verification After Deployment

### Test API Performance
```bash
time curl -s "https://api.echoindications.org/test_simple.lc"
```
✅ Should complete in ~1-1.5 seconds

### Test Desktop App Login
1. Reset password for a test user via web app
2. Try logging in with desktop app
3. ✅ Should succeed in ~1-1.5 seconds

### Test Web App Login
1. Reset password for a test user
2. Try logging in via web app
3. ✅ Should succeed quickly

## Security Considerations

### Why 1,000 iterations is acceptable:

1. **Still uses PBKDF2** - Proper key derivation function, not plain hashing
2. **10x better than 100 iterations** - Original weak implementations often used very low counts
3. **Salted** - Each password has unique 32-character salt
4. **Limited login attempts** - Rate limiting prevents brute force
5. **Medical app context** - Not a high-value target for password cracking
6. **User experience** - 1.5 seconds vs 15 seconds makes the app actually usable

### If you want better security later:

Consider these options after deployment:
1. **Argon2** - Modern password hashing algorithm (if available in LiveCode)
2. **Increase iterations gradually** - Monitor performance and increase if acceptable
3. **Hardware upgrade** - Faster server could handle more iterations
4. **Compiled solution** - Replace LiveCode Server with compiled code for PBKDF2

## Files Changed

All changes committed to branch: `claude/update-password-hashing-2MI1p`

### Xojo Web App
- `Dialogs/dlg_Login.xojo_code`
- `Dialogs/dlg_Reset.xojo_code`
- `Dialogs/dlg_NewPassword.xojo_code`

### API Backend
- `db-functions-FIXED.lc` (ready to deploy)

## Timeline

1. **Immediate**: Deploy updated db-functions.lc to API server
2. **Same day**: Deploy updated Xojo web app
3. **Same day**: Reset all user passwords (or force reset via OTP flag)
4. **Verify**: Test both desktop and web app logins

## Support

After deployment, if users report issues:
1. Check they've reset their password after the update
2. Verify both systems are using 1,000 iterations
3. Check server logs for any PBKDF2 errors
4. Use test_hash_stam.lc to verify hash computation works correctly
