# URGENT FIX: LiveCode bitShift/bitAnd Syntax Error

## Problem

After deploying db-functions.lc to your server, you encountered this error:

```
row 364, col 20: Expression: missing ')' before factor (bitShift)
```

## Root Cause

The pbkdf2 function was using `bitShift` and `bitAnd` as **operators**:
```livecode
put numToChar((tBlockIndex bitShift 24) bitAnd 255) into tBlockBytes
```

But LiveCode requires them to be called as **functions**:
```livecode
put numToChar(bitAnd(bitShift(tBlockIndex, -24), 255)) into tBlockBytes
```

## What Was Fixed

Changed lines 364-367 in the pbkdf2 function from operator syntax to function call syntax:

**Before (INCORRECT):**
```livecode
put numToChar((tBlockIndex bitShift 24) bitAnd 255) into tBlockBytes
put numToChar((tBlockIndex bitShift 16) bitAnd 255) after tBlockBytes
put numToChar((tBlockIndex bitShift 8) bitAnd 255) after tBlockBytes
put numToChar(tBlockIndex bitAnd 255) after tBlockBytes
```

**After (CORRECT):**
```livecode
put numToChar(bitAnd(bitShift(tBlockIndex, -24), 255)) into tBlockBytes
put numToChar(bitAnd(bitShift(tBlockIndex, -16), 255)) after tBlockBytes
put numToChar(bitAnd(bitShift(tBlockIndex, -8), 255)) after tBlockBytes
put numToChar(bitAnd(tBlockIndex, 255)) after tBlockBytes
```

**Note:** The bitShift function uses **negative values for left shift** and positive values for right shift.

## Deployment Instructions

### Step 1: Upload the Fixed File

Upload the corrected file to your server:

**File location:** `/home/user/echo_indications/db-functions-FIXED.lc`

**Upload to:** `https://api.echoindications.org/API/lib/db-functions.lc`

Using SCP:
```bash
scp /home/user/echo_indications/db-functions-FIXED.lc user@yourserver:/var/www/api/API/lib/db-functions.lc
```

### Step 2: Verify the Fix

Test that the syntax error is resolved:

```bash
curl -s "https://api.echoindications.org/test_simple.lc"
```

You should now see a valid PBKDF2 hash output instead of syntax errors.

### Step 3: Test Hash Computation

If you've updated test_hash_stam.lc with the actual password, test it:

```bash
curl -s "https://api.echoindications.org/test_hash_stam.lc"
```

Expected output:
```
Salt: 5LsiOTd6xiSXOZUCm9RAyPcrYK4wtFcA
Password: [your password]

Computed hash: [64-character hex string]
Stored hash:   67773741fd29b900ac545de1cc22ad34cbe9de944a622f4339e2525e87823f1d

Match (case-insensitive): true
Match (case-sensitive):   true
```

### Step 4: Test Desktop App Login

Try logging in with the desktop app using the 'stam' account (or any account that was reset using the web app).

Login should now work correctly!

## What This Fix Does

The bitShift and bitAnd functions are already defined in db-functions.lc (lines 248-287), but they were being called incorrectly using operator syntax instead of function syntax.

The fix converts the block index to a 4-byte big-endian representation, which is required by the PBKDF2 standard (RFC 2898). This is a critical part of the PBKDF2 algorithm - without the correct syntax, the function couldn't run at all.

## Technical Details

### The bitShift Function
```livecode
function bitShift pValue, pShift
  -- Negative shift means left shift
  if pShift < 0 then
    put pValue * (2 ^ (-pShift)) into tResult
    return tResult
  end if

  -- Positive shift means right shift
  put pValue div (2 ^ pShift) into tResult
  return tResult
end bitShift
```

For a 32-bit big-endian conversion:
- `bitShift(value, -24)` = shift left 24 bits (most significant byte)
- `bitShift(value, -16)` = shift left 16 bits
- `bitShift(value, -8)` = shift left 8 bits
- No shift needed for least significant byte

Then `bitAnd(result, 255)` extracts just the byte value (0-255).

## Next Steps After Successful Deployment

1. ✅ Verify no syntax errors with test_simple.lc
2. ✅ Verify hash computation matches database with test_hash_stam.lc
3. ✅ Test desktop app login
4. ✅ Test web app login
5. ✅ Confirm both apps can authenticate the same users

If all tests pass, the PBKDF2 implementation is working correctly and your password hashing is now fully compatible between the Xojo web app and the LiveCode API backend!
