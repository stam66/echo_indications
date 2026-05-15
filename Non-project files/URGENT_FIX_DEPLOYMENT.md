# URGENT FIX: LiveCode bitShift/bitAnd Syntax Error

## Problem

After deploying db-functions.lc to your server, you encountered this error:

```
row 364, col 20: Expression: missing ')' before factor (bitShift)
```

## Root Cause

The pbkdf2 function was trying to call custom functions named `bitShift` and `bitAnd`, but LiveCode recognizes these as **built-in operators** (in some versions), causing a "double binary operator" syntax error.

The solution is to use **inline arithmetic operations** instead of function calls:
```livecode
put numToChar((tBlockIndex div 16777216) mod 256) into tBlockBytes
```

This uses simple division and modulo operations that work in all LiveCode versions.

## What Was Fixed

Changed lines 364-368 in the pbkdf2 function to use inline arithmetic instead of custom function calls:

**Before (INCORRECT - causes "double binary operator" error):**
```livecode
put numToChar((tBlockIndex bitShift 24) bitAnd 255) into tBlockBytes
put numToChar((tBlockIndex bitShift 16) bitAnd 255) after tBlockBytes
put numToChar((tBlockIndex bitShift 8) bitAnd 255) after tBlockBytes
put numToChar(tBlockIndex bitAnd 255) after tBlockBytes
```

**After (CORRECT - uses arithmetic operations):**
```livecode
put numToChar((tBlockIndex div 16777216) mod 256) into tBlockBytes  -- Byte 1 (bits 24-31)
put numToChar((tBlockIndex div 65536) mod 256) after tBlockBytes     -- Byte 2 (bits 16-23)
put numToChar((tBlockIndex div 256) mod 256) after tBlockBytes       -- Byte 3 (bits 8-15)
put numToChar(tBlockIndex mod 256) after tBlockBytes                 -- Byte 4 (bits 0-7)
```

**How it works:**
- `div 16777216` = divide by 2^24 (equivalent to right shift by 24 bits)
- `div 65536` = divide by 2^16 (equivalent to right shift by 16 bits)
- `div 256` = divide by 2^8 (equivalent to right shift by 8 bits)
- `mod 256` = extract lowest 8 bits (equivalent to bitwise AND with 255)

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

### Big-Endian Conversion Using Arithmetic

For a 32-bit integer to 4-byte big-endian conversion:

**Block index = 1 (0x00000001):**
- Byte 1 (MSB): `(1 div 16777216) mod 256` = 0
- Byte 2: `(1 div 65536) mod 256` = 0
- Byte 3: `(1 div 256) mod 256` = 0
- Byte 4 (LSB): `1 mod 256` = 1
- Result: `[0x00, 0x00, 0x00, 0x01]`

**Block index = 258 (0x00000102):**
- Byte 1 (MSB): `(258 div 16777216) mod 256` = 0
- Byte 2: `(258 div 65536) mod 256` = 0
- Byte 3: `(258 div 256) mod 256` = 1
- Byte 4 (LSB): `258 mod 256` = 2
- Result: `[0x00, 0x00, 0x01, 0x02]`

This arithmetic approach works identically to bit shifting and masking, but avoids any function calls or operator naming conflicts.

## Next Steps After Successful Deployment

1. ✅ Verify no syntax errors with test_simple.lc
2. ✅ Verify hash computation matches database with test_hash_stam.lc
3. ✅ Test desktop app login
4. ✅ Test web app login
5. ✅ Confirm both apps can authenticate the same users

If all tests pass, the PBKDF2 implementation is working correctly and your password hashing is now fully compatible between the Xojo web app and the LiveCode API backend!
