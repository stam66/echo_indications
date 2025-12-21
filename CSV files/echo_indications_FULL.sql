-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE DATABASE "echo_indications" ----------------------
CREATE DATABASE IF NOT EXISTS `echo_indications` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `echo_indications`;
-- ---------------------------------------------------------


-- CREATE TABLE "contexts" -------------------------------------
CREATE TABLE `contexts`( 
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`description` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`sort_order` Int( 0 ) NULL DEFAULT 0,
	`is_active` TinyInt( 0 ) NOT NULL DEFAULT 1,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `name` UNIQUE( `name` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 13;
-- -------------------------------------------------------------


-- CREATE TABLE "indication_contexts" --------------------------
CREATE TABLE `indication_contexts`( 
	`indication_id` Int( 0 ) NOT NULL,
	`context_id` Int( 0 ) NOT NULL,
	PRIMARY KEY ( `indication_id`, `context_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "indications" ----------------------------------
CREATE TABLE `indications`( 
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 500 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`description` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`keywords` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`comments` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`primary_care` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`secondary_inpatient` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`secondary_outpatient` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`source_ase` TinyInt( 1 ) NULL DEFAULT 0,
	`source_eacvi` TinyInt( 1 ) NULL DEFAULT 0,
	`source_bse` TinyInt( 1 ) NULL DEFAULT 0,
	`source_consensus` TinyInt( 1 ) NULL DEFAULT 0,
	`created_at` Timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` Timestamp NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 281;
-- -------------------------------------------------------------


-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE `users`( 
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`username` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`password_hash` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`is_active` TinyInt( 1 ) NULL DEFAULT 1,
	`created_at` Timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` Timestamp NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`title` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`OTP` TinyInt( 0 ) NOT NULL DEFAULT 0,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `username` UNIQUE( `username` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 6;
-- -------------------------------------------------------------


-- CREATE TABLE "changes" --------------------------------------
CREATE TABLE `changes`( 
	`changes_request` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`changes_requestor` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`changes_status` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`contexts_existing` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`contexts_new` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`indication_existing` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`indication_new` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`Indication_id` Int( 0 ) NULL DEFAULT NULL,
	`reason_for_close` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`created_at` Timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- -------------------------------------------------------------


-- CREATE TABLE "audit" ----------------------------------------
CREATE TABLE `audit`( 
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`audit_timestamp` Timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`audit_user` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`audit_table` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`audit_primarykey` Int( 0 ) NOT NULL,
	`action` Enum( 'create', 'update', 'delete' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`changed_fields` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`old_values` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`new_values` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- Dump data of "contexts" ---------------------------------
BEGIN;

INSERT INTO `contexts`(`id`,`name`,`description`,`sort_order`,`is_active`) VALUES 
( '1', 'ACHD', 'Adult Congenital Heart Disease', '2', '1' ),
( '2', 'Arrhythmia', 'Cardiac rhythm disorders', '3', '1' ),
( '3', 'Arterial', 'Arterial conditions, aortic disease & hypertension', '4', '1' ),
( '4', 'Cardio-Oncology', 'Oncology-related indications', '5', '1' ),
( '5', 'Coronary', 'Coronary artery disease', '6', '1' ),
( '6', 'General', 'General indications', '7', '1' ),
( '7', 'ICC', 'Inherited Cardiac Conditions (eg DCM)', '8', '1' ),
( '8', 'Myocardial', 'Myocardial disease, heart failure', '9', '1' ),
( '9', 'Pericardial', 'Pericardial disease', '10', '1' ),
( '10', 'Systemic', 'Systemic conditions (sarcoid, amyloid etc)', '11', '1' ),
( '11', 'Valve', 'Valvular heart disease & endocarditis', '12', '1' ),
( '12', 'PHTN & right heart', 'Pulmonary hypertension, right heart', '13', '1' ),
( '13', 'Primary Care', 'A context for locating indications relevant to primary care', '1', '0' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indication_contexts" ----------------------
BEGIN;

INSERT INTO `indication_contexts`(`indication_id`,`context_id`) VALUES 
( '242', '5' ),
( '138', '6' ),
( '255', '6' ),
( '242', '8' ),
( '245', '8' ),
( '263', '11' ),
( '265', '11' ),
( '267', '11' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indications" ------------------------------
BEGIN;

INSERT INTO `indications`(`id`,`title`,`description`,`keywords`,`comments`,`primary_care`,`secondary_inpatient`,`secondary_outpatient`,`source_ase`,`source_eacvi`,`source_bse`,`source_consensus`,`created_at`,`updated_at`) VALUES 
( '138', 'Any indication where the patients clinical status/prognosis precludes intervention', '', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-14 22:21:50' ),
( '139', 'High VE burden gt 10% on recent Holter', NULL, NULL, 'Refer to electrophyisiology for review', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '140', 'Exercise-induced VE burden', NULL, NULL, 'Refer to electrophysiology instead', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '141', 'Sustained or paroxysmal AF or atrial flutter with new onset or change in clinical status', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '142', 'Sustained or paroxysmal SVT with previous ECHO and no change in clinical status', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '143', 'Ventricular arrhythmia', NULL, NULL, 'Refer to electrophysiology', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '144', 'LBBB with no previous echocardiogram', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '145', 'RBBB with clinical suspicion of heart disease', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '146', 'RBBB without clinical suspicion of heart disease', NULL, NULL, 'Primary care should refer to cardiology for review', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '147', 'Inherited channelopathy (e.g. Long QT)', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '148', 'Pre device implant', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '149', 'Infrequent supraventricular or ventricular ectopy with no clinical suspicion of heart disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '150', 'Sinus bradycardia', NULL, NULL, 'Referral after discussion with specialist cardiology team. For discussion - consider not_indicated in all groups.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '151', 'Tented T-waves in absence of history suggesting cardiac disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '152', 'LAFB in absence of history suggesting cardiac disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '153', 'Palpitations without proof of arrhythmia', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '154', 'Suspected heart failure and elevated NT-proBNP *', NULL, NULL, '"Refer to 1-stop HF clinic where available. Where not available, reasonable for primary care to refer direct for ECHO. Timing of referral as per NICE Guidance 2018"', 'can_be_considered', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '155', 'Surveillance of known LV dysfunction to monitor effect of medical or device therapy', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '156', 'Surveillance of known LV dysfunction with change in clinical status', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '157', 'Family screening in subjects with 1st degree relative with inherited cardiac disease, inherited valvulopathy or inherited aortopathy.', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:33' ),
( '158', 'Initial investigation in patient with suspected hypertensive heart disease', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '159', 'Baseline and serial re-evaluations in patients undergoing therapy with cardiotoxic agents', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '160', 'Reassessment  in patients on cancer therapies with significant (gt x2 ULN) rise in cardiac biomarkers [Troponin, NT-proBNP].', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:07' ),
( '161', 'Hypotension in the absence of shock, clinical evidence of significant valvular disease or evidence of acute cardiac pathology such as AMI.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:50' ),
( '162', 'Routine surveillance in patients with HFPEF', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '163', 'Routine surveillance of maximally treated patients with HFREF in whom no further intervention is being contemplated and whose clinical status remains satisfactory', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '164', 'Routine re-evaluation in hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '165', 'Sinus arrhythmia', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '166', 'Syncope with previous ECHO and no clinical suspicion of heart disease and/or history of possible ICC', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '167', 'Syncope with clinical suspicion of cardiac disease', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '168', 'Syncope with family history suggestve of ICC', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '169', 'Probable neurocardiogenic syncope', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '170', 'Chest pain with no other symptoms and no signs of cardiac disease and normal ECG', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '171', 'Chest pain with abnormal ECG', NULL, NULL, '"ECG abnormalties do not include: sinus bradycardia, sinus arrhythmia or other changes not linked to coronary disease"', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '172', 'Exertional chest pain', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '173', 'Non-exertional, non-pleuritic chest pain.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:58' ),
( '174', 'Chest pain with FH of SCD or DCM', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '175', 'Chest pain with recent recreational drug use', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '176', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '177', 'Murmur with clinical suspicion of cardiovascular disease', NULL, NULL, 'Removed the word innocent for semantic reasons.', 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '178', 'Pathological murmur', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '179', 'Chest wall deformities and scoliosis pre-operatively', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '180', 'Fatigue with no other signs and symptoms of cardiovascular disease, a normal ECG, and a benign family history.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:40' ),
( '181', 'History suggestive of endocarditis with other findings that would fulfill Duke\'s criteria with or without ECHO', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '182', 'Fever screen or CRP screen without findings to fulfil Duke\'s Criterial for Endocarditis with or without ECHO', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '183', 'Central cyanosis', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '184', 'Isolated peripheral cyanosis', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '185', 'Genotype positive screen for ICC', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '186', 'Desaturation on pulse oximetry with no signs of cardiac decompensation', NULL, NULL, 'indicated if suspicion of platypnoea orthodeoxia', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '187', 'Chromosomal abnormality known to be associated with cardiovascular disease', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '188', 'Chromosomal abnormality with undefined risk for cardiovascular disease', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '189', 'Cancer with suspicion of cardiac involvment on axial imaging', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '190', 'Muscular dystrophy', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '191', 'CKD IV or V with clinical suspicion of cardiovascular disease', NULL, NULL, 'Referral via secondary care', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '192', 'Obstructive sleep apnoea', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '193', 'Diabetes with no clinical suspicion of cardiac disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '194', 'Dyslipidaemia with no clnical suspicion of cardiac disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '195', 'Suspected thromboembolic CVA, with no previous ECHO at, or after, event.', NULL, NULL, 'For guideline review', 'not_indicated', 'can_be_considered', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:33' ),
( '196', 'Peripheral arterial embolus with no obvious cause', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '197', 'Seizures, other neurologic disorders, or psychiatric disorders with no clnical suspicion of cardiac disese.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:11' ),
( '198', 'Storage diseases, mitochondrial and metabolic disorders.', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:19' ),
( '199', 'Suspected PE, not confirmed.', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:27' ),
( '200', 'Confirmed acute PE where thrombolysis or thrombectomy may be considered (severe hypoxaemia, haemodynamic instability)', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:23' ),
( '201', 'Confirmed PE where thombecomy or thrombolysis will not be considered regardless of ECHO findings', NULL, NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '202', 'Severe deceleration injury or chest trauma where cardiac injury is possible or suspected', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '203', 'Routine evaluation in the setting of mild chest trauma with no electrocardiographic changes or biomarker elevation', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '204', 'Initial evaluation when there is a reasonable suspicion of valvular or structural heart disease', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '205', 'Routine surveillance (lessThan 5 year) of mild valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '206', 'Routine surveillance (gtorequal 5 y) of mild valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '207', 'Routine surveillance (lessThan1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '208', 'Routine surveillance (gtorequal 1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '209', 'Routine surveillance of trace valvular regurgitation with structurally normal valves', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '210', 'Routine surveillance (lessThan 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '211', 'Routine surveillance (gtorequal 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '212', 'Routine surveillance (lessThan 1 y) of moderate  valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '213', 'Routine surveillance (gtorequal 1 y) of moderate  valvular regurgitation without change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '214', 'Initial postoperative evaluation of prosthetic valve for establishment of baseline', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '215', 'Routine surveillance (lessThan 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '216', 'Routine surveillance (gtorequal 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '217', 'Evaluation of prosthetic valve with suspected dysfunction or a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '218', 'Re-evaluation of known prosthetic valve dysfunction when it would change management or guide therapy', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '219', 'Suspected cardiac mass', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '220', 'Suspected pericardial disease', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '221', 'Evaluation of the ascending aorta in the setting of a known or suspected connective tissue disease or genetic condition that predisposes to aortic aneurysm or dissection (e.g., Marfan syndrome).', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:12' ),
( '222', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection to establish a baseline rate of expansion or when the rate of expansion is excessive', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '223', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection with a change in clinical status or cardiac exam or when findings may alter management or therapy', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '224', 'Routine re-evaluation for surveillance of known ascending aortic dilation or history of aortic dissection without a change in clinical status or cardiac exam when findings would not change management or therapy (excludes bicuspid aortic valve related disease)', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '225', 'Routine re-evaluation of systemic hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '226', 'Re-evaluation of known hypertensive heart disease without a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '227', 'To determine candidacy for ventricular assist device', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '228', 'Optimization of ventricular assist device settings', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '229', 'Re-evaluation for signs/symptoms suggestive of ventricular assist device-related complications', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '230', 'Monitoring for rejection in a cardiac transplant recipient', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '231', 'Cardiac structure and function evaluation in a potential heart donor', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '232', 'Routine surveillance (lessThan1 y) of known cardiomyopathy without a change in clinical status or cardiac exam or change in therapy', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '233', 'Initial evaluation of known or suspected adult congenital heart disease', NULL, 'ACHD', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '234', 'Known adult congenital heart disease with a change in clinical status or cardiac exam', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '235', 'Re-evaluation to guide therapy in known adult congenital heart disease', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '236', 'Routine surveillance (lessThan2 y) of adult congenital heart disease following complete repair with no residual significant defect and no change in clinical status', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '237', 'Routine surveillance (gtorequal 1y) of adult congenital heart disease following complete repair with residual signficant defect or change in clinical status', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '238', 'Unchanged murmur in an asymptomatic individual with previous normal echocardiogram', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '239', 'Periodic repeat assessment of asymptomatic individual with haemodynamically-insignificant lesions, eg mitral annular calcification.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:03' ),
( '240', 'Chest pain with haemodynamic instability', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '241', 'New murmur following acute or recent myocardial infarction', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '242', 'Assessment of infarct size, presence of complications and baseline LV function following MI.', '', 'Post MI', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-14 23:56:14' ),
( '243', 'Evaluation of non-cardiac chest pain', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '244', 'Minor radiographic cardiomegaly in the absence of symptoms or signs of heart failure', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '245', 'Assessment of patients with oedema, normal venous pressure and no evidence of cardiac disease.', NULL, NULL, 'Referral based on BNP pathway', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:11:14' ),
( '246', 'Repeat assessment of small pericardial effusion without clinical change.', NULL, NULL, 'Consider changing to trivial rather than small.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '247', 'Lung disease with no clinical suspicion of cardiac involvement', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '248', 'Lung disease with clinical suspicion of cardiac involvement (cor pulmonale)', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '249', 'Suspected or established pulmonary hypertension', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '250', 'Evaluation of clinically suspected aortic coarctation', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '251', 'Routine assessment in hypertension', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '252', 'Repeat assessment for LV mass regression with treated HTN', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '253', 'Sustained or paroxysmal AF or atrial flutter without change in clinical status', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '254', 'Sustained or paroxysmal SVT - new onset or change in clinical status', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '255', 'Any indication where echocardiography will not change management', '', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:26' ),
( '256', 'Routine surveillance (lessThan 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', NULL, NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review. Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '257', 'Routine surveillance (gtorequal 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', NULL, NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '258', 'Re-evaluation of severe valvular stenosis or regurgitation (lessThan 6 months) where red flag symptoms are present', NULL, NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'can_be_considered', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '259', 'Surveillance (lessThan 3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '260', 'Surveillance (gtorequal3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '261', 'Surveillance (lessThan 2 years) of bicuspid aortic valve with valve thickening and mild stenosis', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '262', 'Surveillance (gtorequal 2 years) of bicuspid aortic valve with early degenerative and mild stenosis', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '263', 'Bicuspid valve with signficant stenosis or regurgitation (lessThan 6 months) and no red flag signs', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '264', 'Bisucpid valve with aortopathy (gtorequal 12 months)', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '265', 'Annual surveillance of bioprosthetic valve replacement from year 5 onwards (excludes TAVI)', '', '', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:02' ),
( '266', 'Routine surveillance of mechanical valve replacement, normal postoperative scan and no change in clinical status lessThan 10 years since implant.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-12 00:11:02' ),
( '267', 'Annual surveillance of TAVI valve if clinically appropriate', '', '', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:14' ),
( '268', 'LBBB with previous satisfactory ECHO and no change in clinical status or where device therapy is not being considered.', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '269', 'LBBB with previous ECHO and change in clinical status or where device therapy is being considered', NULL, NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '270', 'Routine surveillance in patient-prosthesis mismatch and no change in clinical status lessThan 1 year', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '271', 'Shortness of breath with normal NT-proBNP', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '272', 'P-wave abnormalities excepting bifid p-waves', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '273', 'Bifid p-wave suggestive of mitral stenosis', NULL, NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06' ),
( '274', 'Left atrial thrombus', NULL, NULL, NULL, 'not_indicated', 'not_indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "users" ------------------------------------
BEGIN;

INSERT INTO `users`(`id`,`username`,`password_hash`,`email`,`is_active`,`created_at`,`updated_at`,`title`,`OTP`,`name`) VALUES 
( '1', 'admin', '5e9293d879732c749b3542f5d0fa6b47c6b96c852ef8162723bfe36ad88557c6', 'stam66@mac.com', '1', '2025-11-29 01:22:57', '2025-12-10 04:37:08', 'System Admin', '0', 'Admin' ),
( '2', 'SKapetanakis', '5e9293d879732c749b3542f5d0fa6b47c6b96c852ef8162723bfe36ad88557c6', 'skapetanakis@nhs.net', '1', '2025-12-10 03:33:16', '2025-12-11 19:15:49', 'ECHO Lead GSTT', '0', 'Stam Kapetanakis' ),
( '5', 'TUser', NULL, 'tuser@somewhere.com', '1', '2025-12-16 12:09:39', '2025-12-16 12:09:51', 'Test', '0', 'Test User' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "changes" ----------------------------------
BEGIN;

INSERT INTO `changes`(`changes_request`,`changes_requestor`,`changes_status`,`contexts_existing`,`contexts_new`,`id`,`indication_existing`,`indication_new`,`Indication_id`,`reason_for_close`,`created_at`) VALUES 
( 'test issue', 'SK', 'Closed', NULL, NULL, '1', NULL, NULL, NULL, 'Resolved', '2025-12-16 13:58:32' ),
( 'another request', 'SK', 'Open', NULL, NULL, '2', NULL, NULL, NULL, NULL, '2025-12-18 02:16:12' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "audit" ------------------------------------
BEGIN;

INSERT INTO `audit`(`id`,`audit_timestamp`,`audit_user`,`audit_table`,`audit_primarykey`,`action`,`changed_fields`,`old_values`,`new_values`) VALUES 
( '1', '2025-12-16 16:49:49', 'skapetanakis', 'indications', '0', 'create', NULL, NULL, '{"title":"test indication","description":"","keywords":"","comments":"","primary_care":"","secondary_inpatient":"","secondary_outpatient":"","source_ase":"0","source_eacvi":"0","source_bse":"0","source_consensus":"0","contexts":""}' ),
( '2', '2025-12-16 16:56:01', 'skapetanakis', 'indications', '281', 'create', NULL, NULL, '{"title":"test indication","description":"","keywords":"","comments":"","primary_care":"not_indicated","secondary_inpatient":"not_indicated","secondary_outpatient":"not_indicated","source_ase":"0","source_eacvi":"0","source_bse":"0","source_consensus":"0","contexts":""}' ),
( '3', '2025-12-16 16:56:18', 'skapetanakis', 'indications', '281', 'update', 'secondary_inpatient,source_consensus', '{"secondary_inpatient":"not_indicated","source_consensus":"0"}', '{"secondary_inpatient":"indicated","source_consensus":"1"}' ),
( '4', '2025-12-16 16:56:27', 'skapetanakis', 'indications', '281', 'delete', NULL, '{"title":"test indication","description":"","keywords":"","comments":"","primary_care":"not_indicated","secondary_inpatient":"indicated","secondary_outpatient":"not_indicated","source_ase":"0","source_eacvi":"0","source_bse":"0","source_consensus":"1","contexts":"General"}', NULL ),
( '5', '2025-12-16 16:57:39', 'skapetanakis', 'users', '6', 'create', NULL, NULL, '{"name":"dummy","username":"dummy","email":"d@m.com","title":"dummy","is_active":"1"}' ),
( '6', '2025-12-16 16:57:51', 'skapetanakis', 'users', '6', 'update', 'username', '{"username":"dummy"}', '{"username":"dUser"}' ),
( '7', '2025-12-16 16:57:55', 'skapetanakis', 'users', '6', 'delete', NULL, '{"name":"dummy","username":"dUser","email":"d@m.com","title":"dummy","is_active":"1"}', NULL ),
( '8', '2025-12-16 18:20:15', 'skapetanakis', 'contexts', '13', 'create', NULL, NULL, '{"name":"New Context","description":"","sort_order":13,"is_active":1}' ),
( '9', '2025-12-16 18:22:06', 'skapetanakis', 'contexts', '13', 'update', 'name', '{"name":"New Context"}', '{"name":"New Context 2"}' ),
( '10', '2025-12-16 18:23:01', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":12}' ),
( '11', '2025-12-16 18:23:01', 'skapetanakis', 'contexts', '12', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":13}' ),
( '12', '2025-12-16 18:23:02', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":11}' ),
( '13', '2025-12-16 18:23:02', 'skapetanakis', 'contexts', '11', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":12}' ),
( '14', '2025-12-16 18:23:03', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '15', '2025-12-16 18:23:03', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '16', '2025-12-16 18:23:04', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '17', '2025-12-16 18:23:04', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '18', '2025-12-16 18:23:06', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '19', '2025-12-16 18:23:06', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '20', '2025-12-16 18:23:06', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":9}' ),
( '21', '2025-12-16 18:23:06', 'skapetanakis', 'contexts', '9', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":10}' ),
( '22', '2025-12-16 18:23:07', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":8}' ),
( '23', '2025-12-16 18:23:07', 'skapetanakis', 'contexts', '8', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":9}' ),
( '24', '2025-12-16 18:23:08', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":7}' ),
( '25', '2025-12-16 18:23:08', 'skapetanakis', 'contexts', '7', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":8}' ),
( '26', '2025-12-16 18:23:08', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":6}' ),
( '27', '2025-12-16 18:23:09', 'skapetanakis', 'contexts', '6', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":7}' ),
( '28', '2025-12-16 18:23:11', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":5}' ),
( '29', '2025-12-16 18:23:11', 'skapetanakis', 'contexts', '5', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":6}' ),
( '30', '2025-12-16 18:23:15', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":4}' ),
( '31', '2025-12-16 18:23:15', 'skapetanakis', 'contexts', '4', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":5}' ),
( '32', '2025-12-16 18:23:16', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":3}' ),
( '33', '2025-12-16 18:23:16', 'skapetanakis', 'contexts', '3', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":4}' ),
( '34', '2025-12-16 18:23:17', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":2}' ),
( '35', '2025-12-16 18:23:17', 'skapetanakis', 'contexts', '2', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":3}' ),
( '36', '2025-12-16 18:23:18', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":1}' ),
( '37', '2025-12-16 18:23:18', 'skapetanakis', 'contexts', '1', 'update', 'sort_order', '{"sort_order":1}', '{"sort_order":2}' ),
( '38', '2025-12-16 18:23:31', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '39', '2025-12-16 18:23:35', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '40', '2025-12-16 18:23:42', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '41', '2025-12-16 18:23:49', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '42', '2025-12-16 18:23:53', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '43', '2025-12-16 18:23:56', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '44', '2025-12-16 18:24:12', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '45', '2025-12-16 18:24:17', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '46', '2025-12-16 18:24:23', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '47', '2025-12-16 18:24:28', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '48', '2025-12-16 18:25:07', 'skapetanakis', 'contexts', '13', 'update', 'name', '{"name":"New Context 2"}', '{"name":"Primary Care"}' ),
( '49', '2025-12-16 18:33:35', 'skapetanakis', 'contexts', '13', 'update', 'name', '{"name":"Primary Care"}', '{"name":"Primary Cares"}' ),
( '50', '2025-12-16 18:37:27', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '51', '2025-12-16 18:37:32', 'skapetanakis', 'contexts', '13', 'update', 'name', '{"name":"Primary Cares"}', '{"name":"Primary Care"}' ),
( '52', '2025-12-16 18:37:36', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '53', '2025-12-16 18:37:42', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '54', '2025-12-16 18:37:44', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '55', '2025-12-16 18:40:50', 'skapetanakis', 'contexts', '3', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '56', '2025-12-16 18:40:52', 'skapetanakis', 'contexts', '3', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '57', '2025-12-16 18:41:25', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '58', '2025-12-16 18:41:27', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '59', '2025-12-16 18:45:12', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '60', '2025-12-16 18:45:13', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '61', '2025-12-16 18:45:15', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '62', '2025-12-16 18:45:15', 'skapetanakis', 'contexts', '1', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '63', '2025-12-16 18:45:59', 'skapetanakis', 'contexts', '2', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '64', '2025-12-16 18:46:00', 'skapetanakis', 'contexts', '2', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '65', '2025-12-16 18:51:05', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '66', '2025-12-17 13:37:23', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '67', '2025-12-17 13:39:25', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "idx_contexts_sort" ----------------------------
CREATE INDEX `idx_contexts_sort` USING BTREE ON `contexts`( `sort_order` );
-- -------------------------------------------------------------


-- CREATE INDEX "context_id" -----------------------------------
CREATE INDEX `context_id` USING BTREE ON `indication_contexts`( `context_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_primary_care" -----------------
CREATE INDEX `idx_indications_primary_care` USING BTREE ON `indications`( `primary_care` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_secondary_in" -----------------
CREATE INDEX `idx_indications_secondary_in` USING BTREE ON `indications`( `secondary_inpatient` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_secondary_out" ----------------
CREATE INDEX `idx_indications_secondary_out` USING BTREE ON `indications`( `secondary_outpatient` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_audit_pk" ---------------------------------
CREATE INDEX `idx_audit_pk` USING BTREE ON `audit`( `audit_primarykey` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_audit_table" ------------------------------
CREATE INDEX `idx_audit_table` USING BTREE ON `audit`( `audit_table` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_audit_timestamp" --------------------------
CREATE INDEX `idx_audit_timestamp` USING BTREE ON `audit`( `audit_timestamp` );
-- -------------------------------------------------------------


-- CREATE LINK "indication_contexts_ibfk_1" --------------------
ALTER TABLE `indication_contexts`
	ADD CONSTRAINT `indication_contexts_ibfk_1` FOREIGN KEY ( `indication_id` )
	REFERENCES `indications`( `id` )
	ON DELETE Cascade
	ON UPDATE No Action;
-- -------------------------------------------------------------


-- CREATE LINK "indication_contexts_ibfk_2" --------------------
ALTER TABLE `indication_contexts`
	ADD CONSTRAINT `indication_contexts_ibfk_2` FOREIGN KEY ( `context_id` )
	REFERENCES `contexts`( `id` )
	ON DELETE Cascade
	ON UPDATE No Action;
-- -------------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


