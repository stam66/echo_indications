# PBKDF2 Password Hashing Deployment Guide

## Current Status

### ✅ Completed
- **Xojo Web App**: Updated to use PBKDF2 with proper implementation
  - Salt generation: 32 alphanumeric characters
  - Iterations: 10,000
  - Algorithm: PBKDF2-HMAC-SHA256
  - Output: 32 bytes (64-character hex)

- **API Repository**: Confirmed to have correct db-functions.lc with proper PBKDF2 implementation

### ❌ Pending
- **API Server Deployment**: The deployed db-functions.lc on the production server still has the OLD iterative hashing code instead of proper PBKDF2

## The Problem

The deployed API server has this INCORRECT code:
```livecode
function hashPassword pPassword, pSalt
  put getPasswordIterations() into tIterations
  put pPassword into tHash

  repeat tIterations times
    put pSalt & tHash into tData
    put messageDigest(tData, "SHA-256") into tBinary
    put binaryToHex(tBinary) into tHash
  end repeat

  return pSalt & ":" & tHash
end hashPassword
```

This is simple iterative SHA-256 hashing, NOT PBKDF2.

## Deployment Steps

### 1. Deploy Correct db-functions.lc to API Server

The correct version is in your local repository at:
`/home/user/ECHOindications-API/API/lib/db-functions.lc`

Upload this file to your production server at:
`https://api.echoindications.org/API/lib/db-functions.lc`

**Using SCP (recommended):**
```bash
scp /home/user/ECHOindications-API/API/lib/db-functions.lc user@api.echoindications.org:/path/to/api/API/lib/
```

**Or using SFTP/FTP client like FileZilla**

### 2. Verify Deployment

After uploading, test the hash computation:

```bash
curl -s "https://api.echoindications.org/test_simple.lc"
```

The output should show a valid PBKDF2 hash. You can verify by running the same test locally.

### 3. Test with Known User

Update test_hash_stam.lc with the actual password, then test:

```bash
curl -s "https://api.echoindications.org/test_hash_stam.lc"
```

This should show:
- Match (case-insensitive): true
- Match (case-sensitive): true

### 4. Reset Affected User Passwords

Any users whose passwords were created or reset AFTER the Xojo web app was updated but BEFORE deploying the correct API code will need to have their passwords reset again.

**Steps:**
1. Identify affected users (those with 32-character alphanumeric salts created during the problem period)
2. Have them use the password reset feature in the web app
3. This will generate a new temporary password
4. They should log in with the temporary password and set a new one
5. Test both web app login AND desktop app login

## Verification Checklist

- [ ] db-functions.lc deployed to production API server
- [ ] test_simple.lc returns valid PBKDF2 hash
- [ ] test_hash_stam.lc shows hash match (if password provided)
- [ ] Desktop app login works with newly reset password
- [ ] Web app login works with newly reset password
- [ ] Both apps can authenticate the same user

## Technical Details

### PBKDF2 Parameters (Both Systems)
- **Iterations**: 10,000
- **Key Length**: 32 bytes (256 bits)
- **Hash Algorithm**: SHA-256
- **Output Format**: 64-character lowercase hexadecimal
- **Salt Format**: 32 alphanumeric characters (A-Z, a-z, 0-9)

### Database Schema
```sql
users table:
- password_hash VARCHAR(64)  -- Hexadecimal PBKDF2 output
- password_salt VARCHAR(32)  -- Alphanumeric salt
```

### Xojo Implementation
```xojo
Dim salt As String = app.GenerateRandomSalt(32)
Dim passwordData As New MemoryBlock(password.LenB)
passwordData.StringValue(0, password.LenB) = password
Dim hash As MemoryBlock = Crypto.PBKDF2(salt, passwordData, 10000, 32, Crypto.HashAlgorithms.SHA2_256)
Dim hashHex As String = app.EncodeHex(hash)
```

### LiveCode Implementation
```livecode
put pbkdf2(pPassword, pSalt, 10000, 32) into tBinary
put binaryToHex(tBinary) into tHash
return pSalt & ":" & tHash
```

## Troubleshooting

### Desktop App Still Can't Log In After Deployment

1. Verify the API is using the new code:
   ```bash
   curl -s "https://api.echoindications.org/test_simple.lc"
   ```

2. Check the user's password hash in database:
   ```sql
   SELECT username, LENGTH(password_salt) as salt_len, LENGTH(password_hash) as hash_len
   FROM users WHERE username = 'testuser';
   ```
   Should show: salt_len=32, hash_len=64

3. Reset the password again using the web app

4. Check API server logs for authentication errors

### Hash Mismatch During Testing

If test_hash_stam.lc shows hashes don't match:
- Ensure you've entered the correct password in the test file
- Verify the salt and stored hash are copied correctly from database
- Check that the deployed db-functions.lc has the correct pbkdf2() function

## Support Files

The following test files are available in the API repository:
- `test_simple.lc` - Basic PBKDF2 test with known values
- `test_hash_stam.lc` - Test specific user hash computation
- `test_binarytohex.lc` - Test binary-to-hex conversion methods
- `test_api_hashing.sh` - Shell script to run API tests
