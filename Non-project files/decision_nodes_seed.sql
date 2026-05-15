-- Decision-tree seed data for clinical decision support (dlg_cds).
-- Run after decision_nodes_migration.sql has created the table.
-- Safe to re-run: clears the table first. ASCII only; one INSERT per row to
-- avoid multi-line / non-ASCII parsing quirks seen in some clients.

DELETE FROM decision_nodes;
ALTER TABLE decision_nodes AUTO_INCREMENT = 1;


-- ROOTS (parent_id = NULL) -------------------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (1, NULL, 'Chest pain',   'Is the chest pain acute or chronic?',          1);
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (2, NULL, 'Dyspnoea',     'Best description of the dyspnoea picture?',    2);
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (3, NULL, 'Palpitations', 'What is the palpitation pattern?',             3);
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (4, NULL, 'Syncope',      'Does the syncope have concerning features?',   4);
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (5, NULL, 'Murmur',       'Is the murmur new, symptomatic, or innocent?', 5);


-- CHEST PAIN branch (parent = 1) -------------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (10, 1, 'Acute',                 'Acute coronary syndrome - workup status?',         1);
INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (11, 1, 'Chronic / on exertion', 'Are there other cardiac symptoms or findings?',    2);

INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (12, 1, 'Recent recreational drug use', 3, 'indicated', 'soon', 'Echo indicated to assess for cardiotoxicity, regional wall-motion abnormalities, and structural complications.');

-- Acute chest pain (parent = 10)
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (100, 10, 'ACS suspected - ongoing concern',                  1, 'indicated', 'urgent', 'Urgent echo to assess regional wall-motion abnormality, LV function, and mechanical complications.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (101, 10, 'ACS ruled out, no other signs',                    2, 'can_be_considered', 'routine', 'May be considered if alternative cardiac cause suspected after initial workup. Not first-line if ACS excluded and exam otherwise normal.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (102, 10, 'Suspected pericarditis with tamponade features',   3, 'indicated', 'urgent', 'Urgent echo to confirm/exclude pericardial effusion and assess haemodynamic significance.');

-- Chronic chest pain (parent = 11)
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (110, 11, 'Other cardiac symptoms or abnormal findings',           1, 'indicated', 'routine', 'Routine echo to assess LV function and exclude structural cause for exertional symptoms.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (111, 11, 'Isolated chest pain, normal ECG, no other findings',     2, 'not_indicated', NULL, 'Echo not indicated in isolated chest pain with a normal ECG and no other cardiac features.');


-- DYSPNOEA branch (parent = 2) ---------------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (20, 2, 'Suspected HF - clinical signs present',      1, 'indicated', 'soon',    'Echo to confirm and characterise heart failure; defines phenotype (HFrEF / HFpEF) and underlying pathology.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (21, 2, 'Suspected HF - raised BNP / NT-proBNP',      2, 'indicated', 'routine', 'Routine echo following raised natriuretic peptide, per NICE / ESC guidance.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (22, 2, 'No cardiac signs, normal BNP',              3, 'not_indicated', NULL, 'Echo not indicated when clinical features and BNP are both unremarkable.');

INSERT INTO decision_nodes (id, parent_id, option_label, prompt, sort_order) VALUES (23, 2, 'Exertional dyspnoea, otherwise well', 'Murmur or other abnormality on examination?', 4);

-- Exertional dyspnoea sub-branch (parent = 23)
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (230, 23, 'Yes - murmur or abnormal findings',     1, 'indicated', 'routine', 'Routine echo to clarify structural cause of exertional dyspnoea where exam is abnormal.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (231, 23, 'No - normal examination',               2, 'can_be_considered', 'routine', 'May be considered if symptoms persist and an alternative explanation is not found; not first-line if exam and basic workup are normal.');


-- PALPITATIONS branch (parent = 3) -----------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (30, 3, 'Sustained / documented arrhythmia',                1, 'indicated', 'routine', 'Echo to assess for underlying structural heart disease and quantify ventricular function.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (31, 3, 'Awareness only, no ECG changes, normal exam',      2, 'can_be_considered', 'routine', 'May be considered if symptoms persist or risk features develop; not first-line otherwise.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (32, 3, 'Palpitations associated with syncope',             3, 'indicated', 'soon', 'Echo indicated to look for structural / functional substrate that may explain syncopal episodes.');


-- SYNCOPE branch (parent = 4) ----------------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (40, 4, 'Exertional syncope',                          1, 'indicated', 'urgent', 'Urgent echo to assess for structural cause (HCM, aortic stenosis, anomalous coronary, pulmonary hypertension).');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (41, 4, 'Family history of sudden cardiac death',      2, 'indicated', 'soon',   'Echo to screen for inherited cardiac conditions (HCM, ARVC, dilated cardiomyopathy).');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (42, 4, 'Vasovagal pattern, otherwise well',           3, 'not_indicated', NULL, 'Echo not indicated for classic vasovagal syncope with normal ECG and exam.');


-- MURMUR branch (parent = 5) -----------------------------------------------
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (50, 5, 'New murmur, symptomatic',                       1, 'indicated', 'routine', 'Echo to characterise the lesion, assess severity, and guide management.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (51, 5, 'Innocent characteristics, asymptomatic',        2, 'not_indicated', NULL, 'Innocent-sounding murmur in an asymptomatic patient with no other findings does not require echo.');
INSERT INTO decision_nodes (id, parent_id, option_label, sort_order, verdict, urgency, rationale) VALUES (52, 5, 'Diastolic or harsh systolic murmur',            3, 'indicated', 'soon', 'Diastolic and harsh systolic murmurs are always pathological and warrant echo.');
