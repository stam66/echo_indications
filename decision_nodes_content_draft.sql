-- ============================================================================
-- Decision tree content - DRAFT, REQUIRES CLINICAL REVIEW
-- ============================================================================
-- Builds the five symptom-presentation decision trees (Chest pain, Dyspnoea,
-- Palpitations, Syncope, Murmur) and links every terminal node to an existing
-- indication in the `indications` table.
--
-- IMPORTANT - this is a structural draft authored by mapping indication TITLES
-- to plausible decision paths. It has NOT been clinically validated. Before any
-- use, the author must verify:
--   1. The branch structure and the ordering of options at each level.
--   2. That every leaf links to the correct indication_id.
--   3. Whether overlapping criteria (e.g. a patient with exertional chest pain
--      AND an abnormal ECG) are routed sensibly.
--
-- This REPLACES all existing decision_nodes content. Run deliberately.
--
-- ID scheme: authored nodes use ids 1-60. AUTO_INCREMENT is reset to 1000
-- afterwards, so any nodes you create later in the editor are clearly numbered
-- 1000+ and distinct from this authored set.
--
-- prompt and rationale are left NULL: the editor no longer exposes prompt, and
-- the viewer falls back to the linked indication's own comments when a node has
-- no tree-specific rationale.
-- ============================================================================

START TRANSACTION;

DELETE FROM `decision_nodes`;

-- --- Roots ------------------------------------------------------------------
INSERT INTO `decision_nodes` (`id`,`parent_id`,`option_label`,`prompt`,`sort_order`,`rationale`,`indication_id`) VALUES
( 1, NULL, 'Chest pain', NULL, 1, NULL, NULL ),
( 2, NULL, 'Dyspnoea', NULL, 2, NULL, NULL ),
( 3, NULL, 'Palpitations', NULL, 3, NULL, NULL ),
( 4, NULL, 'Syncope', NULL, 4, NULL, NULL ),
( 5, NULL, 'Murmur', NULL, 5, NULL, NULL );

-- --- Level 2: branches and direct leaves under each root --------------------
INSERT INTO `decision_nodes` (`id`,`parent_id`,`option_label`,`prompt`,`sort_order`,`rationale`,`indication_id`) VALUES
-- Chest pain (1)
( 10, 1, 'Acute / haemodynamically unstable presentation', NULL, 1, NULL, NULL ),
( 16, 1, 'Exertional chest pain', NULL, 2, NULL, 172 ),
( 17, 1, 'Chest pain with abnormal ECG', NULL, 3, NULL, 171 ),
( 18, 1, 'Chest pain, normal ECG, no other cardiac signs', NULL, 4, NULL, 170 ),
( 19, 1, 'Non-exertional, non-pleuritic chest pain', NULL, 5, NULL, 173 ),
( 20, 1, 'Clearly non-cardiac chest pain', NULL, 6, NULL, 243 ),
( 21, 1, 'Chest pain with family history of SCD or DCM', NULL, 7, NULL, 174 ),
( 22, 1, 'Chest pain with recent recreational drug use', NULL, 8, NULL, 175 ),
-- Dyspnoea (2)
( 23, 2, 'Suspected heart failure', NULL, 1, NULL, NULL ),
( 26, 2, 'Known LV dysfunction / heart failure', NULL, 2, NULL, NULL ),
( 31, 2, 'Dyspnoea with known lung disease', NULL, 3, NULL, NULL ),
( 34, 2, 'Suspected or established pulmonary hypertension', NULL, 4, NULL, 249 ),
( 35, 2, 'Suspected pulmonary embolism', NULL, 5, NULL, NULL ),
( 39, 2, 'Fatigue or breathlessness, otherwise well, normal ECG, benign FH', NULL, 6, NULL, 180 ),
-- Palpitations (3)
( 40, 3, 'Documented arrhythmia', NULL, 1, NULL, NULL ),
( 48, 3, 'No documented arrhythmia', NULL, 2, NULL, NULL ),
-- Syncope (4)
( 51, 4, 'Clinical suspicion of cardiac disease', NULL, 1, NULL, 167 ),
( 52, 4, 'Family history suggestive of inherited cardiac condition', NULL, 2, NULL, 168 ),
( 53, 4, 'Previous ECHO and no suspicion of cardiac disease', NULL, 3, NULL, 166 ),
( 54, 4, 'Probable neurocardiogenic (vasovagal) syncope', NULL, 4, NULL, 169 ),
-- Murmur (5)
( 55, 5, 'Pathological murmur', NULL, 1, NULL, 178 ),
( 56, 5, 'Murmur with clinical suspicion of cardiovascular disease', NULL, 2, NULL, 177 ),
( 57, 5, 'Murmur, no suspicion of CVD, benign FH, age under 50, no previous ECHO', NULL, 3, NULL, 176 ),
( 58, 5, 'Unchanged murmur, asymptomatic, previous normal echocardiogram', NULL, 4, NULL, 238 ),
( 59, 5, 'Asymptomatic, haemodynamically-insignificant lesion', NULL, 5, NULL, 239 ),
( 60, 5, 'New murmur following acute or recent myocardial infarction', NULL, 6, NULL, 241 );

-- --- Level 3: leaves under the level-2 branches -----------------------------
INSERT INTO `decision_nodes` (`id`,`parent_id`,`option_label`,`prompt`,`sort_order`,`rationale`,`indication_id`) VALUES
-- Chest pain / Acute (10)
( 11, 10, 'Haemodynamic instability', NULL, 1, NULL, 240 ),
( 12, 10, 'STEMI - immediate assessment for complications', NULL, 2, NULL, 290 ),
( 13, 10, 'Post-PCI assessment of LV function', NULL, 3, NULL, 292 ),
( 14, 10, 'New murmur following recent myocardial infarction', NULL, 4, NULL, 241 ),
( 15, 10, 'Post-MI - infarct size, complications and baseline LV function', NULL, 5, NULL, 242 ),
-- Dyspnoea / Suspected heart failure (23)
( 24, 23, 'Elevated NT-proBNP', NULL, 1, NULL, 154 ),
( 25, 23, 'Normal NT-proBNP', NULL, 2, NULL, 271 ),
-- Dyspnoea / Known LV dysfunction (26)
( 27, 26, 'HFpEF - routine surveillance', NULL, 1, NULL, 162 ),
( 28, 26, 'HFrEF, maximally treated - routine surveillance', NULL, 2, NULL, 163 ),
( 29, 26, 'Monitoring effect of medical or device therapy', NULL, 3, NULL, 155 ),
( 30, 26, 'Change in clinical status', NULL, 4, NULL, 156 ),
-- Dyspnoea / Known lung disease (31)
( 32, 31, 'No clinical suspicion of cardiac involvement', NULL, 1, NULL, 247 ),
( 33, 31, 'Clinical suspicion of cor pulmonale', NULL, 2, NULL, 248 ),
-- Dyspnoea / Suspected pulmonary embolism (35)
( 36, 35, 'Suspected PE, not confirmed', NULL, 1, NULL, 199 ),
( 37, 35, 'Confirmed acute PE - thrombolysis or thrombectomy may be considered', NULL, 2, NULL, 200 ),
( 38, 35, 'Confirmed PE - intervention not being considered', NULL, 3, NULL, 201 ),
-- Palpitations / Documented arrhythmia (40)
( 41, 40, 'AF or atrial flutter - new onset or change in clinical status', NULL, 1, NULL, 141 ),
( 42, 40, 'AF or atrial flutter - no change in clinical status', NULL, 2, NULL, 253 ),
( 43, 40, 'SVT - new onset or change in clinical status', NULL, 3, NULL, 254 ),
( 44, 40, 'SVT - previous ECHO, no change in clinical status', NULL, 4, NULL, 142 ),
( 45, 40, 'Ventricular arrhythmia', NULL, 5, NULL, 143 ),
( 46, 40, 'High ventricular ectopic burden (over 10% on recent Holter)', NULL, 6, NULL, 139 ),
( 47, 40, 'Exercise-induced ventricular ectopy', NULL, 7, NULL, 140 ),
-- Palpitations / No documented arrhythmia (48)
( 49, 48, 'Palpitations without proof of arrhythmia', NULL, 1, NULL, 153 ),
( 50, 48, 'Infrequent ectopy, no clinical suspicion of heart disease', NULL, 2, NULL, 149 );

COMMIT;

-- Editor-created nodes will be numbered 1000+ so they stay distinct from this
-- authored set.
ALTER TABLE `decision_nodes` AUTO_INCREMENT = 1000;
