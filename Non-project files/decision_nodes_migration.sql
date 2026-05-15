-- Clinical Decision Support — decision_nodes table.
-- Self-referential tree: each row is either a branch (prompt + options) or
-- a terminal verdict. Leaves carry a verdict + optional rationale + optional
-- linked indication.

CREATE TABLE `decision_nodes` (
  `id`            INT(11) AUTO_INCREMENT PRIMARY KEY,
  `parent_id`    INT(11) NULL,
  `option_label`  VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prompt`        VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort_order`    INT(11) NULL DEFAULT 0,
  `verdict`       ENUM('indicated','not_indicated','can_be_considered') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `urgency`       ENUM('routine','soon','urgent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `rationale`     TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `indication_id` INT(11) NULL,
  `created_at`    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_dn_parent`     FOREIGN KEY (`parent_id`)     REFERENCES `decision_nodes`(`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_dn_indication` FOREIGN KEY (`indication_id`) REFERENCES `indications`(`id`)   ON DELETE SET NULL,
  INDEX `idx_dn_parent` (`parent_id`, `sort_order`)
) CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ENGINE = InnoDB;


-- ---- Seed: a small "Chest pain" tree to prove the UI works ---------------

-- Roots (parent_id = NULL): the starting list of presenting complaints.
INSERT INTO decision_nodes (parent_id, option_label, prompt, sort_order) VALUES
  (NULL, 'Chest pain',   'Is the chest pain acute or chronic?',                1),
  (NULL, 'Dyspnoea',     'Is heart failure clinically suspected?',             2),
  (NULL, 'Palpitations', '(More options to be added — placeholder)',           3);

-- Children of "Chest pain"  (id = 1)
INSERT INTO decision_nodes (parent_id, option_label, prompt, sort_order) VALUES
  (1, 'Acute',                          'Has acute coronary syndrome been ruled out?', 1),
  (1, 'Chronic / on exertion',          'Are other cardiac symptoms present?',         2),
  (1, 'Recent recreational drug use',   NULL,                                          3);

-- Terminal: drug-related chest pain
UPDATE decision_nodes SET
  verdict   = 'indicated',
  urgency   = 'soon',
  rationale = 'Echo indicated to assess for cardiotoxicity and structural complications.'
WHERE parent_id = 1 AND option_label = 'Recent recreational drug use';

-- Children of "Acute" (under chest pain)
INSERT INTO decision_nodes (parent_id, option_label, prompt, sort_order, verdict, urgency, rationale) VALUES
  ((SELECT id FROM (SELECT id FROM decision_nodes WHERE parent_id = 1 AND option_label = 'Acute') t),
   'ACS suspected — ongoing concern',
   NULL, 1,
   'indicated', 'urgent',
   'Urgent echo to assess regional wall motion, LV function, and complications.'),
  ((SELECT id FROM (SELECT id FROM decision_nodes WHERE parent_id = 1 AND option_label = 'Acute') t),
   'ACS ruled out, no other signs',
   NULL, 2,
   'can_be_considered', 'routine',
   'May be considered if alternative cardiac cause is suspected after initial workup.');

-- Children of "Chronic / on exertion"
INSERT INTO decision_nodes (parent_id, option_label, prompt, sort_order, verdict, urgency, rationale) VALUES
  ((SELECT id FROM (SELECT id FROM decision_nodes WHERE parent_id = 1 AND option_label = 'Chronic / on exertion') t),
   'Yes — other cardiac symptoms',
   NULL, 1,
   'indicated', 'routine',
   'Routine echo to assess LV function and exclude structural cause for exertional symptoms.'),
  ((SELECT id FROM (SELECT id FROM decision_nodes WHERE parent_id = 1 AND option_label = 'Chronic / on exertion') t),
   'No — chest pain in isolation, normal ECG',
   NULL, 2,
   'not_indicated', NULL,
   'Echo not indicated in isolated chest pain with a normal ECG and no other cardiac findings.');

-- Children of "Dyspnoea" (id = 2)
INSERT INTO decision_nodes (parent_id, option_label, prompt, sort_order, verdict, urgency, rationale) VALUES
  (2, 'Suspected HF — clinical signs present',  NULL, 1,
   'indicated',         'soon',    'Echo indicated to confirm and characterise heart failure.'),
  (2, 'Suspected HF — raised BNP',               NULL, 2,
   'indicated',         'routine', 'Routine echo following raised BNP per NICE guidance.'),
  (2, 'No cardiac signs, normal BNP',            NULL, 3,
   'not_indicated',     NULL,      'Echo not indicated when there are no clinical features of HF and BNP is normal.');
