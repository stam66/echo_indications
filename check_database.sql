-- Check password hashing format for all users
-- Run this to see what format each user's password is stored in

SELECT
    username,
    CHAR_LENGTH(password_salt) as salt_length,
    CASE
        WHEN password_salt IS NULL OR password_salt = '' THEN 'LEGACY (no salt)'
        WHEN CHAR_LENGTH(password_salt) = 32 AND password_salt REGEXP '^[A-Za-z0-9]+$' THEN 'PBKDF2 (correct format)'
        WHEN CHAR_LENGTH(password_salt) = 64 THEN 'OLD HEX SALT (needs reset)'
        ELSE 'UNKNOWN FORMAT'
    END as salt_format,
    CHAR_LENGTH(password_hash) as hash_length,
    CASE
        WHEN password_hash REGEXP '^[a-f0-9]+$' AND CHAR_LENGTH(password_hash) = 64 THEN 'Valid hex hash'
        ELSE 'Invalid or unknown hash format'
    END as hash_format,
    LEFT(password_salt, 10) as salt_preview,
    LEFT(password_hash, 10) as hash_preview,
    created_at,
    updated_at
FROM users
ORDER BY updated_at DESC;

-- For a specific user, run:
-- SELECT * FROM users WHERE username = 'YOUR_USERNAME';
