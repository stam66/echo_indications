-- Changelog table — run once against the echo_indications database.
-- Stores release-note entries displayed by dlg_ChangeLogViewer
-- and edited by dlg_ChangeLogEditor (admins only).

CREATE TABLE `changelog` (
  `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
  `entry_date` DATE NOT NULL,
  `body` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  INDEX `idx_changelog_date` (`entry_date` DESC)
) CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
  ENGINE = InnoDB;
