# numToChar vs binaryDecode - Different Purposes

## The Question

Why does the pbkdf2 function use `numToChar` for the block index conversion instead of `binaryDecode`?

## Answer: They Serve Different Purposes

### 1. numToChar - Converting INTEGER to BYTES

**Used in:** pbkdf2 function to convert block index to 4-byte big-endian format

**What it does:**
```livecode
-- Convert integer block index (e.g., 1) to 4 bytes in big-endian format
put numToChar(bitAnd(bitShift(tBlockIndex, -24), 255)) into tBlockBytes  -- Byte 1 (MSB)
put numToChar(bitAnd(bitShift(tBlockIndex, -16), 255)) after tBlockBytes -- Byte 2
put numToChar(bitAnd(bitShift(tBlockIndex, -8), 255)) after tBlockBytes  -- Byte 3
put numToChar(bitAnd(tBlockIndex, 255)) after tBlockBytes                -- Byte 4 (LSB)
```

**Example:** Block index = 1
- Byte 1 (MSB): 0x00 → numToChar(0) → character with ASCII value 0
- Byte 2: 0x00 → numToChar(0) → character with ASCII value 0
- Byte 3: 0x00 → numToChar(0) → character with ASCII value 0
- Byte 4 (LSB): 0x01 → numToChar(1) → character with ASCII value 1

Result: 4-byte binary string representing the integer 1 in big-endian format

**Purpose:** PBKDF2 specification (RFC 2898) requires the block index to be encoded as a 4-byte big-endian integer and appended to the salt. This is part of the input to the HMAC function.

### 2. binaryDecode - Converting BINARY DATA to HEX STRING

**Used in:** binaryToHex function to convert hash output to hexadecimal

**What it does:**
```livecode
function binaryToHex pBinary
  put binaryDecode("H*", pBinary, tHex) into tResult
  return toLower(tHex)
end binaryToHex
```

**Example:** Binary hash = (32 bytes of binary data)
```
Input:  Binary string with byte values like: 0x67, 0x77, 0x37, 0x41, ...
Output: "67773741fd29b900ac545de1cc22ad34cbe9de944a622f4339e2525e87823f1d"
```

**Purpose:** Convert the final PBKDF2 hash (which is binary data) into a hexadecimal string for storage in the database.

## Key Differences

| Operation | Input Type | Output Type | Purpose |
|-----------|------------|-------------|---------|
| **numToChar** | Integer (0-255) | Single character | Convert byte value to character |
| **binaryDecode** | Binary string | Hex string | Convert binary data to hex representation |

## In PBKDF2 Context

### The Full Flow:

1. **Start with:** Password + Salt + Block Index (integer)

2. **Block Index Encoding:** (using numToChar)
   ```livecode
   -- Convert block index 1 to 4-byte big-endian: [0x00, 0x00, 0x00, 0x01]
   put numToChar(0) & numToChar(0) & numToChar(0) & numToChar(1) into tBlockBytes
   ```

3. **First HMAC Iteration:**
   ```livecode
   put hmacSHA256(pSalt & tBlockBytes, pPassword) into tU  -- Returns HEX string
   put hexToBinary(tU) into tUBinary  -- Convert to binary for XOR operations
   ```

4. **Subsequent Iterations:** XOR operations on binary data

5. **Final Output:** (using binaryDecode via binaryToHex)
   ```livecode
   put binaryToHex(tDerivedKey) into tHash  -- Convert final binary to hex string
   return pSalt & ":" & tHash
   ```

## Why Not Use binaryEncode/binaryDecode for Block Index?

You COULD use `binaryEncode` for the block index:

```livecode
-- Alternative approach using binaryEncode
put binaryEncode("I", tBlockIndex) into tBlockBytes
```

However:
1. `binaryEncode("I", ...)` uses platform-specific endianness (little-endian on most systems)
2. PBKDF2 RFC 2898 specifically requires **big-endian** format
3. Manual bit shifting with numToChar ensures consistent big-endian encoding across all platforms
4. The manual approach is more explicit and easier to verify against the RFC spec

## Summary

- **numToChar:** Converts individual byte values (0-255) to characters - used for building binary strings from integers
- **binaryDecode:** Converts existing binary data to hex string representation - used for displaying/storing hash results

Both are essential for PBKDF2, but they serve completely different purposes in different parts of the algorithm.
