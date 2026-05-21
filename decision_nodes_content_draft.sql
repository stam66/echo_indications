-- ============================================================================
-- Decision tree content - DRAFT, REQUIRES CLINICAL REVIEW
-- ============================================================================
-- Comprehensive seed for the clinical decision tool. Builds 26 root entry
-- points (symptom presentations, abnormal findings, known conditions and
-- clinical contexts) and routes every leaf to one of the 87 indications in
-- content/blended_echo_indications_seed.sql.
--
-- DESIGN PRINCIPLES (from prior design sessions):
--   * The ONLY contact point between the decision tree and the indications
--     table is the terminal (verdict) node. Each terminal node MUST link to
--     an existing indication via indication_id. The AUC verdicts and urgency
--     are read off the linked indication; decision_nodes carries no verdict
--     columns of its own.
--   * A node is terminal iff indication_id IS NOT NULL. Branch nodes have
--     indication_id NULL.
--   * Roots have parent_id NULL. There are no other constraints; the tree
--     depth and width is entirely shaped by clinical convenience.
--
-- PORTABILITY:
--   Indication IDs are NOT hardcoded. Every leaf names its target indication
--   by TITLE; the script resolves titles to IDs at insert time via the live
--   indications table. This means the seed runs correctly on any database
--   where blended_echo_indications_seed.sql has been applied, regardless of
--   AUTO_INCREMENT order.
--
-- CLINICAL VALIDATION REQUIRED:
--   This file is a structural draft. Before clinical use the author must
--   verify:
--     1. Root-level coverage matches local referral pathways.
--     2. Branch labels are unambiguous from a referrer's perspective.
--     3. Each leaf is routed to the most appropriate indication.
--     4. Indications appearing in multiple paths (e.g. "New murmur after MI"
--        under both Chest pain and Murmur) are intentional duplications.
--     5. No required clinical scenario is missing.
--
-- This REPLACES all existing decision_nodes content. Run deliberately.
--
-- ID scheme: authored nodes use ids 1-360. AUTO_INCREMENT is reset to 1000
-- afterwards, so any nodes you create later in the editor are clearly
-- numbered 1000+ and distinct from this authored set.
--
-- prompt and rationale are left NULL: the editor no longer exposes prompt,
-- and the viewer falls back to the linked indication's own comments when a
-- node has no tree-specific rationale.
--
-- Prerequisite:
--   content/blended_echo_indications_seed.sql must have been applied so the
--   referenced indications exist by title.
-- ============================================================================

START TRANSACTION;

-- ----------------------------------------------------------------------------
-- Stage all nodes in a temp table keyed by indication TITLE (not id).
-- ----------------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS `_decision_node_seed`;
CREATE TEMPORARY TABLE `_decision_node_seed` (
  `id`               INT  PRIMARY KEY,
  `parent_id`        INT  NULL,
  `option_label`     VARCHAR(255) NOT NULL,
  `sort_order`       INT  NOT NULL DEFAULT 0,
  `indication_title` TEXT NULL
);

INSERT INTO `_decision_node_seed` (`id`,`parent_id`,`option_label`,`sort_order`,`indication_title`) VALUES

-- ============================================================================
-- ROOTS (parent_id NULL)
-- ============================================================================
(  1, NULL, 'Chest pain',                                                                    1, NULL),
(  2, NULL, 'Dyspnoea or breathlessness',                                                    2, NULL),
(  3, NULL, 'Peripheral oedema or suspected fluid overload',                                 3, NULL),
(  4, NULL, 'Palpitations or known arrhythmia',                                              4, NULL),
(  5, NULL, 'Syncope or presyncope',                                                         5, NULL),
(  6, NULL, 'Murmur',                                                                        6, NULL),
(  7, NULL, 'Abnormal ECG without symptoms',                                                 7, NULL),
(  8, NULL, 'Raised natriuretic peptide or cardiomegaly on chest X-ray',                     8, NULL),
(  9, NULL, 'Hypertension',                                                                  9, NULL),
( 10, NULL, 'Known lung disease or suspected pulmonary hypertension',                       10, NULL),
( 11, NULL, 'Suspected or confirmed pulmonary embolism',                                    11, NULL),
( 12, NULL, 'Pericardial disease (suspected or known)',                                     12, NULL),
( 13, NULL, 'Suspected or confirmed infective endocarditis',                                13, NULL),
( 14, NULL, 'Stroke, TIA or suspected cardiac source of embolism',                          14, NULL),
( 15, NULL, 'Known native valve disease - surveillance or change',                          15, NULL),
( 16, NULL, 'Known prosthetic valve - surveillance or dysfunction',                         16, NULL),
( 17, NULL, 'Known LV dysfunction, heart failure or cardiomyopathy',                        17, NULL),
( 18, NULL, 'Aortopathy or aortic root concerns',                                           18, NULL),
( 19, NULL, 'Congenital or inherited cardiac disease',                                      19, NULL),
( 20, NULL, 'Pre-operative assessment for non-cardiac surgery',                             20, NULL),
( 21, NULL, 'Post cardiac, thoracic or structural procedure',                               21, NULL),
( 22, NULL, 'Cardio-oncology (cardiotoxic cancer therapy)',                                 22, NULL),
( 23, NULL, 'Pregnancy or pre-pregnancy planning',                                          23, NULL),
( 24, NULL, 'Cardiac trauma',                                                               24, NULL),
( 25, NULL, 'Critical care: shock, fluid balance, ARDS',                                    25, NULL),
( 26, NULL, 'Echo unlikely to alter management (frailty, palliative, ceiling of care)',     26, NULL),

-- ============================================================================
-- ROOT 1 - Chest pain
-- ============================================================================
(100,  1, 'Acute or haemodynamically unstable presentation',                                 1, NULL),
(101,100, 'Haemodynamic instability or shock',                                               1, 'Chest pain with haemodynamic instability'),
(102,100, 'Confirmed acute MI - assess LV function, infarct size and complications',         2, 'Confirmed acute myocardial infarction to assess LV function and complications'),
(103,100, 'New murmur after recent myocardial infarction',                                   3, 'New murmur after recent myocardial infarction'),
(104,100, 'Suspected type A aortic dissection (TTE will not delay definitive imaging)',      4, 'Suspected type A aortic dissection when TTE will not delay definitive imaging'),
(105,  1, 'Atypical chest pain - normal ECG, negative biomarkers, no murmur',                2, 'Chest pain with normal ECG, negative biomarkers and no murmur'),
(106,  1, 'Asymptomatic - family history of ischaemic heart disease only',                   3, 'Family history of ischaemic heart disease in an asymptomatic individual'),

-- ============================================================================
-- ROOT 2 - Dyspnoea or breathlessness
-- ============================================================================
-- NOTE: Dyspnoea entry points stratified by NT-proBNP / CXR live under Root 8.
--       Dyspnoea on a background of known LV dysfunction lives under Root 17.
--       Dyspnoea with pulmonary disease lives under Root 10.
(110,  2, 'Suspected heart failure with clinical signs (raised JVP, oedema)',                1, 'Suspected heart failure with clinical signs'),
(111,  2, 'Unexplained dyspnoea with abnormal ECG or chest radiograph',                      2, 'Unexplained dyspnoea with abnormal ECG or chest radiograph'),
(112,  2, 'Unexplained dyspnoea - ambiguous cardiac versus pulmonary cause',                 3, 'Unexplained dyspnoea with ambiguous cardiac versus pulmonary cause'),

-- ============================================================================
-- ROOT 3 - Peripheral oedema or suspected fluid overload
-- ============================================================================
(120,  3, 'Peripheral oedema, normal JVP, normal ECG, no cardiac abnormality',               1, 'Peripheral oedema without cardiac signs, normal JVP and no cardiac abnormality'),

-- ============================================================================
-- ROOT 4 - Palpitations or known arrhythmia
-- ============================================================================
(130,  4, 'Documented arrhythmia',                                                           1, NULL),
(131,130, 'AF or atrial flutter - no clinical change since recent echocardiogram',           1, 'Atrial fibrillation or flutter with no clinical change after recent echocardiogram'),
(132,130, 'Proven arrhythmia with suspected structural heart disease',                       2, 'Proven arrhythmia with suspected structural heart disease'),
(133,130, 'High-burden (>10%) or exertional ventricular ectopy',                             3, 'High-burden ventricular ectopy or exertional ventricular ectopy'),
(134,130, 'Ventricular tachycardia or ventricular fibrillation',                             4, 'Ventricular tachycardia or ventricular fibrillation'),
(135,130, 'Arrhythmia with hypotension or haemodynamic compromise',                          5, 'Arrhythmia with hypotension or haemodynamic compromise'),
(136,130, 'Pre-cardioversion AF - no recent TTE or clinical status changed',                 6, 'Pre-cardioversion AF when recent TTE is absent or clinical status has changed'),
(137,130, 'Emergency cardioversion required - do not delay for routine TTE',                 7, 'Emergency cardioversion requiring immediate treatment'),
(138,  4, 'Palpitations without ECG proof of arrhythmia and no structural suspicion',        2, 'Palpitations without ECG proof of arrhythmia and no suspicion of structural disease'),

-- ============================================================================
-- ROOT 5 - Syncope or presyncope
-- ============================================================================
(140,  5, 'Classic vasovagal or situational syncope, no cardiac features',                   1, 'Classic vasovagal or situational syncope with no cardiac features'),
(141,  5, 'Syncope with suspected structural or functional heart disease',                   2, 'Syncope with suspected structural or functional heart disease'),
(142,  5, 'Exertional syncope',                                                              3, 'Exertional syncope'),
(143,  5, 'Syncope in high-risk occupation (pilot, HGV, safety-critical)',                   4, 'Syncope in high-risk occupation'),

-- ============================================================================
-- ROOT 6 - Murmur
-- ============================================================================
(150,  6, 'Innocent murmur confidently diagnosed by a physician',                            1, 'Innocent murmur confidently diagnosed by a physician'),
(151,  6, 'Unchanged murmur, previous normal echocardiogram, asymptomatic',                  2, 'Unchanged murmur with previous normal echocardiogram and no symptoms'),
(152,  6, 'Murmur with cardiac or respiratory symptoms',                                     3, 'Murmur with cardiac or respiratory symptoms'),
(153,  6, 'Murmur with syncope or advanced (NYHA III-IV) heart failure',                     4, 'Murmur with syncope or advanced heart failure symptoms'),
(154,  6, 'Asymptomatic murmur with features of structural disease (thrill, radiation)',     5, 'Asymptomatic murmur with clinical features suggesting structural heart disease'),
(155,  6, 'New murmur after recent myocardial infarction',                                   6, 'New murmur after recent myocardial infarction'),

-- ============================================================================
-- ROOT 7 - Abnormal ECG without symptoms
-- ============================================================================
(160,  7, 'Newly diagnosed left bundle branch block',                                        1, 'Newly diagnosed left bundle branch block'),
(161,  7, 'Newly diagnosed right bundle branch block (otherwise well)',                      2, 'Newly diagnosed right bundle branch block in an otherwise well patient'),
(162,  7, 'Asymptomatic isolated sinus bradycardia',                                         3, 'Asymptomatic isolated sinus bradycardia'),

-- ============================================================================
-- ROOT 8 - Raised natriuretic peptide or cardiomegaly on CXR
-- ============================================================================
(170,  8, 'Suspected heart failure - triaged by NT-proBNP (NICE NG106)',                     1, NULL),
(171,170, 'NT-proBNP above 2000 ng/L - TTE within 2 weeks',                                  1, 'Suspected heart failure with NT-proBNP above 2000 ng per litre'),
(172,170, 'NT-proBNP 400 to 2000 ng/L - TTE within 6 weeks',                                 2, 'Suspected heart failure with NT-proBNP 400 to 2000 ng per litre'),
(173,170, 'NT-proBNP below 400 ng/L - heart failure unlikely',                               3, 'Suspected heart failure with NT-proBNP below 400 ng per litre'),
(174,  8, 'Raised natriuretic peptide, specific band not specified',                         2, 'Suspected heart failure with high natriuretic peptide'),
(175,  8, 'Incidental cardiomegaly on CXR - normal ECG, normal exam, normal BNP',            3, 'Radiographic cardiomegaly without heart failure symptoms or supporting clinical information'),

-- ============================================================================
-- ROOT 9 - Hypertension
-- ============================================================================
(180,  9, 'Essential hypertension alone, no suspected target-organ damage',                  1, 'Essential hypertension alone with no suspected cardiac target-organ disease'),
(181,  9, 'Hypertension with suspected LV dysfunction, coarctation or end-organ damage',     2, 'Hypertension with suspected LV dysfunction, coarctation or end-organ cardiac damage'),
(182,  9, 'Accelerated hypertension - breathlessness or suspected acute LV dysfunction',     3, 'Accelerated hypertension with breathlessness or suspected acute LV dysfunction'),

-- ============================================================================
-- ROOT 10 - Known lung disease or suspected pulmonary hypertension
-- ============================================================================
(190, 10, 'Lung disease, no clinical suspicion of cardiac involvement or PHT',               1, 'Lung disease without suspicion of cardiac involvement or pulmonary hypertension'),
(191, 10, 'Lung disease with suspected right heart failure or cor pulmonale',                2, 'Lung disease with suspected right heart failure or pulmonary hypertension'),
(192, 10, 'Suspected or established pulmonary hypertension',                                 3, 'Suspected or established pulmonary hypertension'),
(193, 10, 'Unexplained persistent or positional oxygen desaturation (shunt assessment)',     4, 'Unexplained persistent or positional oxygen desaturation'),

-- ============================================================================
-- ROOT 11 - Suspected or confirmed pulmonary embolism
-- ============================================================================
(200, 11, 'Confirmed PE with clinical concern for RV impairment',                            1, 'Confirmed pulmonary embolism with clinical concern for RV impairment'),
(201, 11, 'Unstable PE - thrombolysis or thrombectomy being considered',                     2, 'Clinically unstable pulmonary embolism where thrombolysis or thrombectomy is being considered'),
(202, 11, 'Asymptomatic post-treatment PE with planned outpatient follow-up',                3, 'Asymptomatic post-treatment pulmonary embolism with planned outpatient follow-up'),

-- ============================================================================
-- ROOT 12 - Pericardial disease (suspected or known)
-- ============================================================================
(210, 12, 'Suspected pericarditis, effusion or constriction',                                1, 'Clinically suspected pericarditis, effusion or constriction'),
(211, 12, 'Suspected tamponade or pericardial fluid causing compromise',                     2, 'Suspected cardiac tamponade or pericardial fluid causing haemodynamic compromise'),
(212, 12, 'Small stable pericardial effusion - no compromise, no clinical change',           3, 'Small stable pericardial effusion without haemodynamic effect or clinical change'),

-- ============================================================================
-- ROOT 13 - Suspected or confirmed infective endocarditis
-- ============================================================================
(220, 13, 'Positive Duke criteria or strong clinical suspicion of IE',                       1, 'Positive Duke criteria or strong clinical suspicion of infective endocarditis'),
(221, 13, 'Suspected IE with acute HF, valve decompensation or abscess concern',             2, 'Suspected endocarditis with acute heart failure, valve decompensation or abscess concern'),
(222, 13, 'Fever alone, no other endocarditis criteria',                                     3, 'Fever alone without other endocarditis criteria'),

-- ============================================================================
-- ROOT 14 - Stroke, TIA or suspected cardiac source of embolism
-- ============================================================================
(230, 14, 'Stroke/TIA/systemic embolism with suspected cardiac source',                      1, 'Systemic embolism, stroke or TIA with suspected cardiac source'),
(231, 14, 'Stroke in known AF, no structural suspicion (echo will not alter anticoag)',      2, 'Stroke in atrial fibrillation without suspicion of structural heart disease where management will not change'),
(232, 14, 'Suspected or known cardiac mass',                                                 3, 'Suspected or known cardiac mass'),

-- ============================================================================
-- ROOT 15 - Known native valve disease - surveillance or change
-- ============================================================================
(240, 15, 'Surveillance by severity (asymptomatic, no clinical change)',                     1, NULL),
(241,240, 'Severe asymptomatic native valve disease',                                        1, 'Severe native valve disease surveillance while asymptomatic'),
(242,240, 'Moderate asymptomatic native valve disease',                                      2, 'Moderate native valve disease surveillance while asymptomatic'),
(243,240, 'Mild valve disease with anatomically abnormal valve',                             3, 'Mild native valve disease surveillance with anatomically abnormal valve'),
(244,240, 'Trivial or physiologic regurgitation, normal anatomy, no symptoms',               4, 'Trivial or haemodynamically insignificant valve lesion with normal anatomy and no symptoms'),
(245,240, 'Stage A surveillance - BAV or aortic sclerosis without progression',              5, 'Stage A surveillance of bicuspid aortic valve or aortic sclerosis without progression'),
(246,240, 'Mild AR, structurally normal valve, aortic root <40 mm (BSE PUE014)',             6, 'Mild aortic regurgitation with structurally normal valve and aortic root under 40 mm'),
(247, 15, 'New change in known valve disease (red flags)',                                   2, NULL),
(248,247, 'Valve disease with new symptoms',                                                 1, 'Valve disease with new symptoms'),
(249,247, 'Valve disease with new LV dilatation or systolic impairment',                     2, 'Valve disease with new LV dilatation or systolic impairment'),
(250,247, 'Valve disease with new AF or raised pulmonary pressure',                          3, 'Valve disease with new atrial fibrillation or raised pulmonary pressure'),

-- ============================================================================
-- ROOT 16 - Known prosthetic valve - surveillance or dysfunction
-- ============================================================================
(260, 16, 'Routine post-procedural surveillance',                                            1, NULL),
(261,260, 'Routine pre-discharge TTE after uncomplicated valve replacement (low value)',     1, 'Routine pre-discharge TTE after uncomplicated valve replacement'),
(262,260, 'Baseline TTE after valve replacement or valve repair (~6-8 weeks)',               2, 'Baseline TTE after valve replacement or valve repair'),
(263, 16, 'Concerns about prosthetic function',                                              2, NULL),
(264,263, 'Suspected prosthetic valve dysfunction or new/worsening regurgitation',           1, 'Suspected prosthetic valve dysfunction or new/worsening prosthetic regurgitation'),
(265,263, 'Mechanical valve with prolonged subtherapeutic anticoagulation',                  2, 'Mechanical prosthetic valve with prolonged subtherapeutic anticoagulation and concern for thrombosis'),

-- ============================================================================
-- ROOT 17 - Known LV dysfunction, heart failure or cardiomyopathy
-- ============================================================================
(270, 17, 'Change in clinical status (new symptoms, planned therapy change)',                1, 'Known LV dysfunction or cardiomyopathy with change in clinical status'),
(271, 17, 'Routine repeat in stable cardiomyopathy - no management impact',                  2, 'Routine repeat TTE in stable cardiomyopathy when management will not change'),
(272, 17, 'Suspected genetic or infiltrative cardiomyopathy or LVH phenotype',               3, 'Suspected genetic or infiltrative cardiomyopathy or LVH phenotype'),

-- ============================================================================
-- ROOT 18 - Aortopathy or aortic root concerns
-- ============================================================================
(280, 18, 'Aortic root dilatation or suspected inherited aortopathy (Marfan, BAV)',          1, 'Aortic root dilatation or suspected inherited aortopathy'),
(281, 18, 'Suspected acute aortic event (within emergency cross-sectional pathway)',         2, 'Suspected acute aortic event'),
(282, 18, 'Bicuspid aortic valve with ascending aortic dilatation',                          3, 'Bicuspid aortic valve with ascending aortic dilatation'),

-- ============================================================================
-- ROOT 19 - Congenital or inherited cardiac disease
-- ============================================================================
(290, 19, 'Known adult congenital heart disease (imaging will guide management)',            1, 'Known adult congenital heart disease when imaging will guide management'),
(291, 19, 'First-degree relative of a bicuspid aortic valve patient',                        2, 'First-degree relative of a patient with a bicuspid aortic valve'),
(292, 19, 'Suspected inherited cardiomyopathy or LVH phenotype (FH, exam, ECG)',             3, 'Suspected genetic or infiltrative cardiomyopathy or LVH phenotype'),

-- ============================================================================
-- ROOT 20 - Pre-operative assessment for non-cardiac surgery
-- ============================================================================
(300, 20, 'Routine pre-op TTE with no specific question (low value)',                        1, 'Routine pre-operative assessment before non-cardiac surgery'),
(301, 20, 'Surgery + suspected severe valve/ventricular disease - may alter anaesthetic',    2, 'Non-cardiac surgery with suspected severe valve or ventricular disease likely to alter anaesthetic plan'),
(302, 20, 'Routine repeat pre-op TTE - recent study, no clinical change',                    3, 'Routine repeat pre-operative TTE after recent study with no clinical change'),
(303, 20, 'Severe asymptomatic aortic stenosis prior to non-cardiac surgery',                4, 'Severe asymptomatic aortic stenosis prior to non-cardiac surgery or pregnancy'),

-- ============================================================================
-- ROOT 21 - Post cardiac, thoracic or structural procedure
-- ============================================================================
-- Most prosthetic-valve post-op follow-up lives under Root 16. This root
-- captures the cross-procedure tamponade question.
(310, 21, 'Concern for tamponade after cardiac, thoracic or structural procedure',           1, 'Concern for tamponade after cardiac, thoracic or structural procedure'),

-- ============================================================================
-- ROOT 22 - Cardio-oncology
-- ============================================================================
(320, 22, 'Baseline or serial assessment during cardiotoxic cancer therapy',                 1, 'Baseline or serial assessment during potentially cardiotoxic cancer therapy'),

-- ============================================================================
-- ROOT 23 - Pregnancy or pre-pregnancy planning
-- ============================================================================
(330, 23, 'Pre-pregnancy evaluation in prosthetic valve patient (no recent echo)',           1, 'Pre-pregnancy evaluation in prosthetic valve patient without recent echocardiogram'),
(331, 23, 'Severe asymptomatic aortic stenosis prior to pregnancy',                          2, 'Severe asymptomatic aortic stenosis prior to non-cardiac surgery or pregnancy'),

-- ============================================================================
-- ROOT 24 - Cardiac trauma
-- ============================================================================
(340, 24, 'Severe blunt cardiac trauma or deceleration injury',                              1, 'Severe blunt cardiac trauma or deceleration injury'),

-- ============================================================================
-- ROOT 25 - Critical care: shock, fluid balance, ARDS
-- ============================================================================
(350, 25, 'Shock after senior clinical assessment - TTE will guide treatment',               1, 'Shock after senior clinical assessment when TTE will guide treatment'),
(351, 25, 'Complex fluid balance or anuric state - filling status will guide therapy',       2, 'Complex fluid balance or anuric state where filling status will guide therapy'),
(352, 25, 'Differentiate ARDS or pneumonitis from cardiogenic pulmonary oedema',             3, 'Differentiate ARDS or pneumonitis from cardiogenic pulmonary oedema'),

-- ============================================================================
-- ROOT 26 - Echo unlikely to alter management
-- ============================================================================
(360, 26, 'Advanced frailty, palliative care, or documented ceiling of care',                1, 'Echocardiography unlikely to alter management, including advanced frailty');

-- ============================================================================
-- VALIDATION CHECKPOINT - inspect the result of this query.
-- If it returns ANY rows, run:  ROLLBACK;
-- ... fix the indication titles in this file, then re-run.
-- If it returns no rows, the seed is safe to commit.
-- ============================================================================
SELECT
  s.id                AS node_id,
  s.option_label,
  s.indication_title  AS UNRESOLVED_TITLE
FROM `_decision_node_seed` s
WHERE s.indication_title IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `indications` i WHERE i.title = s.indication_title
  );

-- ----------------------------------------------------------------------------
-- Apply the seed: clear existing decision_nodes, then insert resolving titles
-- to ids. FK checks disabled briefly so parents/children can be inserted in
-- a single statement regardless of order.
-- ----------------------------------------------------------------------------
SET @prev_fk_checks := @@SESSION.FOREIGN_KEY_CHECKS;
SET SESSION FOREIGN_KEY_CHECKS = 0;

DELETE FROM `decision_nodes`;

INSERT INTO `decision_nodes`
  (`id`, `parent_id`, `option_label`, `prompt`, `sort_order`, `rationale`, `indication_id`)
SELECT
  s.id,
  s.parent_id,
  s.option_label,
  NULL,
  s.sort_order,
  NULL,
  (SELECT i.id FROM `indications` i WHERE i.title = s.indication_title)
FROM `_decision_node_seed` s
ORDER BY s.id;

SET SESSION FOREIGN_KEY_CHECKS = @prev_fk_checks;

DROP TEMPORARY TABLE `_decision_node_seed`;

COMMIT;

-- Editor-created nodes will be numbered 1000+ so they stay distinct from this
-- authored set.
ALTER TABLE `decision_nodes` AUTO_INCREMENT = 1000;
