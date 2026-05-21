-- ============================================================================
-- Brugada, myocarditis follow-up, pericarditis follow-up - new indications
-- ============================================================================
-- DRAFT FOR CLINICAL REVIEW. Adds 6 new indications to fill gaps identified
-- by user questions:
--   - Brugada syndrome (index patient and asymptomatic first-degree relative)
--   - Follow-up after myocarditis (acute / recovery, vs fully-recovered routine)
--   - Follow-up after pericarditis (recurrent / prior effusion / constriction,
--     vs uncomplicated fully-resolved)
--
-- Sources cited per row in the `comments` column. Primary references:
--   - 2019 ACC/AHA/ASE nonvalvular AUC
--   - ESC 2023 myocarditis position paper
--   - ESC 2015 pericardial diseases guideline
--   - ESC 2022 ventricular arrhythmias guideline (Brugada family screening)
--   - HRS/EHRA/APHRS 2013 expert consensus on inherited arrhythmias
--
-- Idempotent: UPDATEs existing rows that match by title, INSERTs new ones,
-- DELETEs and re-creates indication_contexts links for these 6 rows only.
-- Safe to re-run.
--
-- IMPORTANT - after applying this file, RE-RUN
-- `decision_nodes_content_draft.sql` so the tree picks up the new leaves
-- that point at these indications.
-- ============================================================================

START TRANSACTION;

-- ----------------------------------------------------------------------------
-- Stage the new indications in a temp table (same pattern as the blended seed).
-- ----------------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS `_new_indications`;
CREATE TEMPORARY TABLE `_new_indications` (
  `title`                TEXT NOT NULL,
  `keywords`             TEXT,
  `comments`             TEXT,
  `primary_care`         ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  `secondary_inpatient`  ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  `secondary_outpatient` ENUM('indicated','not_indicated','can_be_considered') NOT NULL,
  `source_ase`           TINYINT(1) NOT NULL DEFAULT 0,
  `source_eacvi`         TINYINT(1) NOT NULL DEFAULT 0,
  `source_bse`           TINYINT(1) NOT NULL DEFAULT 0,
  `source_bhvs`          TINYINT(1) NOT NULL DEFAULT 0,
  `source_consensus`     TINYINT(1) NOT NULL DEFAULT 0,
  `urgency`              ENUM('not_indicated','can_be_considered','routine','soon','urgent') NOT NULL DEFAULT 'routine',
  `contexts`             TEXT NOT NULL
);

INSERT INTO `_new_indications`
  (title, keywords, comments,
   primary_care, secondary_inpatient, secondary_outpatient,
   source_ase, source_eacvi, source_bse, source_bhvs, source_consensus,
   urgency, contexts)
VALUES

-- 1. Brugada syndrome - baseline TTE to exclude structural disease
('Known or suspected Brugada syndrome - baseline TTE to exclude structural heart disease',
 'Brugada;Brugada syndrome;channelopathy;sodium channel;SCN5A;type 1 Brugada pattern;exclude ARVC;structural heart disease;inherited arrhythmia',
 'Brugada syndrome is a channelopathy and the heart is usually structurally normal. TTE at diagnosis is appropriate to exclude phenocopies (ARVC, ischaemic, infiltrative or other structural disease that can mimic the ECG/clinical picture). Routine repeat TTE in established Brugada with no clinical change is low value - reassess for new symptoms, new arrhythmia or device decisions. References: 2019 ACC/AHA/ASE nonvalvular AUC; HRS/EHRA/APHRS 2013 expert consensus on inherited arrhythmia syndromes.',
 'can_be_considered','indicated','indicated',
 1,0,0,0,1,
 'soon','Arrhythmia;Congenital/inherited'),

-- 2. Brugada - asymptomatic first-degree relative with normal ECG
('Asymptomatic first-degree relative of a Brugada patient with normal ECG',
 'Brugada family screening;Brugada FDR;first degree relative Brugada;asymptomatic Brugada relative;normal ECG family screening;inherited arrhythmia family',
 'Family screening in Brugada syndrome is primarily based on history, baseline ECG, drug-challenge ECG and targeted genetic testing. TTE adds little in an asymptomatic first-degree relative whose resting ECG is normal because the heart is structurally normal in Brugada by definition. Symptomatic relatives or those with an abnormal ECG should be routed through the relevant symptom (syncope, palpitations) entry point, where the suspected-structural-disease branches already trigger TTE. References: ESC 2022 ventricular arrhythmias guideline; HRS/EHRA/APHRS 2013 expert consensus.',
 'not_indicated','not_indicated','can_be_considered',
 0,1,0,0,1,
 'can_be_considered','Arrhythmia;Congenital/inherited'),

-- 3. Acute or recent myocarditis - assess LV function and recovery
('Acute or recent myocarditis - assess LV function and recovery',
 'myocarditis;acute myocarditis;recent myocarditis;LV function myocarditis;myocarditis follow-up;myocarditis recovery;3-6 months follow-up;recovery TTE;CMR follow-up',
 'TTE is central to assessment of acute myocarditis (LV function, regional wall motion, pericardial involvement) and to monitoring recovery, typically at 3-6 months with earlier reassessment if symptoms persist, new arrhythmia develops or LV dysfunction has not recovered. CMR remains the imaging gold standard for tissue characterisation - TTE complements rather than replaces it. References: ESC 2023 myocarditis position paper; 2019 ACC/AHA/ASE nonvalvular AUC (LV function assessment in known cardiomyopathy).',
 'indicated','indicated','indicated',
 1,1,0,0,1,
 'soon','Heart failure;Cardiomyopathy'),

-- 4. Routine repeat TTE in fully recovered myocarditis with normal prior echo
('Routine repeat TTE in fully recovered myocarditis with normal prior echo and no symptoms',
 'recovered myocarditis;normal echo recovery;asymptomatic myocarditis follow-up;surveillance recovered myocarditis;LV recovery confirmed',
 'Once LV function has fully recovered and the patient is asymptomatic, further routine surveillance TTE is low value unless symptoms recur, new arrhythmia develops, or a specialist surveillance protocol requires it (e.g. selected athletes returning to competition, or persistent late-gadolinium enhancement on CMR). Reference: ESC 2023 myocarditis position paper.',
 'not_indicated','not_indicated','can_be_considered',
 0,0,0,0,1,
 'can_be_considered','Heart failure;Cardiomyopathy'),

-- 5. Recurrent pericarditis or prior effusion / suspected constriction
('Recurrent pericarditis or pericarditis with prior effusion or suspected constriction',
 'recurrent pericarditis;chronic pericardial effusion;constrictive pericarditis;pericarditis follow-up;post pericarditis surveillance;effusive constrictive',
 'TTE is appropriate for surveillance in recurrent pericarditis, where a prior effusion is being followed, or where constrictive physiology is suspected (raised JVP, oedema disproportionate to LV function, paradoxical septal motion, respirophasic ventricular interdependence). Interval depends on the clinical question and prior findings. Reference: ESC 2015 pericardial diseases guideline.',
 'indicated','indicated','indicated',
 0,1,0,0,1,
 'routine','Pericardial disease'),

-- 6. Routine repeat after fully resolved uncomplicated acute pericarditis
('Routine repeat TTE after fully resolved uncomplicated acute pericarditis with no effusion',
 'resolved pericarditis;uncomplicated pericarditis;no effusion;asymptomatic pericarditis follow-up;single episode pericarditis',
 'After an uncomplicated single episode of acute pericarditis that has fully resolved without an effusion, routine repeat TTE is low value. Reassess if symptoms recur, an effusion is suspected on examination, or constrictive features emerge. Some specialists obtain a single confirmation scan; this is reasonable but not mandated. Reference: ESC 2015 pericardial diseases guideline.',
 'not_indicated','not_indicated','can_be_considered',
 0,0,0,0,1,
 'can_be_considered','Pericardial disease');

-- ----------------------------------------------------------------------------
-- UPDATE existing rows that match by title, then INSERT any that don't yet
-- exist. Same pattern as content/blended_echo_indications_seed.sql.
-- ----------------------------------------------------------------------------
UPDATE `indications` i
JOIN `_new_indications` r ON i.title = r.title
SET i.keywords             = r.keywords,
    i.comments             = r.comments,
    i.primary_care         = r.primary_care,
    i.secondary_inpatient  = r.secondary_inpatient,
    i.secondary_outpatient = r.secondary_outpatient,
    i.source_ase           = r.source_ase,
    i.source_eacvi         = r.source_eacvi,
    i.source_bse           = r.source_bse,
    i.source_bhvs          = r.source_bhvs,
    i.source_consensus     = r.source_consensus,
    i.urgency              = r.urgency;

INSERT INTO `indications`
  (title, keywords, comments, primary_care, secondary_inpatient, secondary_outpatient,
   source_ase, source_eacvi, source_bse, source_bhvs, source_consensus, urgency)
SELECT r.title, r.keywords, r.comments, r.primary_care, r.secondary_inpatient, r.secondary_outpatient,
       r.source_ase, r.source_eacvi, r.source_bse, r.source_bhvs, r.source_consensus, r.urgency
FROM `_new_indications` r
WHERE NOT EXISTS (SELECT 1 FROM `indications` i WHERE i.title = r.title);

-- ----------------------------------------------------------------------------
-- Refresh indication_contexts for the 6 rows we just touched (delete-and-recreate,
-- scoped strictly to these titles so we don't disturb anything else).
-- ----------------------------------------------------------------------------
DELETE ic
FROM `indication_contexts` ic
JOIN `indications`         i ON i.id    = ic.indication_id
JOIN `_new_indications`    r ON r.title = i.title;

INSERT INTO `indication_contexts` (indication_id, context_id)
SELECT i.id, c.id
FROM `_new_indications` r
JOIN `indications`      i ON i.title = r.title
JOIN `contexts`         c ON FIND_IN_SET(c.name, REPLACE(r.contexts, ';', ',')) > 0
WHERE NOT EXISTS (
  SELECT 1 FROM `indication_contexts` ic
  WHERE ic.indication_id = i.id AND ic.context_id = c.id
);

DROP TEMPORARY TABLE `_new_indications`;

COMMIT;
