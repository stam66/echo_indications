-- Add explicit British Heart Valve Society attribution support.
-- Run before importing content that sets indications.source_bhvs.

ALTER TABLE indications
  ADD COLUMN IF NOT EXISTS source_bhvs TINYINT(1) NOT NULL DEFAULT 0
  AFTER source_bse;

