-- Migration: split decision_nodes.verdict into three setting-specific columns.
--
-- Custom-verdict leaves now carry separate verdicts for Primary care,
-- Secondary inpatient, and Secondary outpatient — mirroring the indications
-- table's three-cell model. Urgency stays single (one value applies to all
-- settings, same as in the indications table).
--
-- Strategy: rename existing `verdict` to `verdict_primary` (preserves seeded
-- data — those values become the primary-care verdict), then add the two new
-- columns as NULL.
--
-- Re-running this migration is idempotent against a partially-applied state:
-- the two ADD COLUMN statements use IF NOT EXISTS; the rename only happens
-- when the old column still exists.

-- Rename verdict → verdict_primary (only if not already renamed).
SET @col_exists := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'decision_nodes'
    AND COLUMN_NAME = 'verdict'
);
SET @sql := IF(@col_exists > 0,
  'ALTER TABLE decision_nodes CHANGE COLUMN verdict verdict_primary ENUM(''indicated'',''not_indicated'',''can_be_considered'') NULL DEFAULT NULL',
  'SELECT ''verdict already renamed'' AS note'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add the two new setting-specific verdicts.
ALTER TABLE decision_nodes
  ADD COLUMN IF NOT EXISTS verdict_secondary_inpatient
    ENUM('indicated','not_indicated','can_be_considered') NULL DEFAULT NULL
    AFTER verdict_primary,
  ADD COLUMN IF NOT EXISTS verdict_secondary_outpatient
    ENUM('indicated','not_indicated','can_be_considered') NULL DEFAULT NULL
    AFTER verdict_secondary_inpatient;
