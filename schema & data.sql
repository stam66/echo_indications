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


-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE `users`( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`username` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`password_hash` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`is_active` TinyInt( 1 ) NULL DEFAULT 1,
	`created_at` Timestamp NULL DEFAULT current_timestamp(),
	`updated_at` Timestamp NULL DEFAULT current_timestamp(),
	`title` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`OTP` TinyInt( 4 ) NOT NULL DEFAULT 0,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `username` UNIQUE( `username` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 6;
-- -------------------------------------------------------------


-- CREATE TABLE "contexts" -------------------------------------
CREATE TABLE `contexts`( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`description` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`sort_order` Int( 11 ) NULL DEFAULT NULL,
	`is_active` TinyInt( 4 ) NOT NULL DEFAULT 1,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `name` UNIQUE( `name` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 16;
-- -------------------------------------------------------------


-- CREATE TABLE "indication_contexts" --------------------------
CREATE TABLE `indication_contexts`( 
	`indication_id` Int( 11 ) NOT NULL,
	`context_id` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `indication_id`, `context_id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "audit" ----------------------------------------
CREATE TABLE `audit`( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`audit_timestamp` Timestamp NOT NULL DEFAULT current_timestamp(),
	`audit_user` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`audit_table` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`audit_primarykey` Int( 11 ) NOT NULL,
	`action` Enum( 'create', 'update', 'delete' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`changed_fields` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`old_values` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`new_values` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 128;
-- -------------------------------------------------------------


-- CREATE TABLE "indications" ----------------------------------
CREATE TABLE `indications`( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 500 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`keywords` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`comments` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`primary_care` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`secondary_inpatient` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`secondary_outpatient` Enum( 'indicated', 'not_indicated', 'can_be_considered' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	`source_ase` TinyInt( 1 ) NULL DEFAULT 0,
	`source_eacvi` TinyInt( 1 ) NULL DEFAULT 0,
	`source_bse` TinyInt( 1 ) NULL DEFAULT 0,
	`source_consensus` TinyInt( 1 ) NULL DEFAULT 0,
	`created_at` Timestamp NULL DEFAULT current_timestamp(),
	`updated_at` Timestamp NULL DEFAULT current_timestamp(),
	`urgency` Enum( 'urgent', 'soon', 'routine', 'can_be_considered', 'not_indicated' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'not_indicated',
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 334;
-- -------------------------------------------------------------


-- CREATE TABLE "changes" --------------------------------------
CREATE TABLE `changes`( 
	`changes_request` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`changes_requestor` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`changes_status` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`contexts_existing` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`contexts_new` MediumText CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`indication_existing` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`indication_new` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`Indication_id` Int( 11 ) NULL DEFAULT NULL,
	`reason_for_close` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`created_at` Timestamp NULL DEFAULT current_timestamp(),
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 35;
-- -------------------------------------------------------------


-- Dump data of "users" ------------------------------------
BEGIN;

INSERT INTO `users`(`id`,`username`,`password_hash`,`email`,`is_active`,`created_at`,`updated_at`,`title`,`OTP`,`name`) VALUES 
( '1', 'admin', '5e9293d879732c749b3542f5d0fa6b47c6b96c852ef8162723bfe36ad88557c6', 'stam66@mac.com', '1', '2025-11-29 01:22:57', '2025-12-10 04:37:08', 'System Admin', '0', 'Admin' ),
( '2', 'SKapetanakis', '5e9293d879732c749b3542f5d0fa6b47c6b96c852ef8162723bfe36ad88557c6', 'skapetanakis@nhs.net', '1', '2025-12-10 03:33:16', '2025-12-11 19:15:49', 'ECHO Lead GSTT', '0', 'Stam Kapetanakis' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "contexts" ---------------------------------
BEGIN;

INSERT INTO `contexts`(`id`,`name`,`description`,`sort_order`,`is_active`) VALUES 
( '1', 'ACHD', 'Adult Congenital Heart Disease', '3', '1' ),
( '2', 'Arrhythmia', 'Cardiac rhythm disorders', '4', '1' ),
( '3', 'Arterial', 'Arterial conditions, aortic disease & hypertension', '5', '1' ),
( '4', 'Cardio-Oncology', 'Oncology-related indications', '6', '1' ),
( '5', 'Coronary', 'Coronary artery disease', '7', '1' ),
( '6', 'General', 'General indications', '8', '1' ),
( '7', 'ICC', 'Inherited Cardiac Conditions (eg DCM)', '9', '1' ),
( '8', 'Myocardial', 'Myocardial disease, heart failure', '10', '1' ),
( '9', 'Pericardial', 'Pericardial disease', '11', '1' ),
( '10', 'Systemic', 'Systemic conditions (sarcoid, amyloid etc)', '12', '1' ),
( '11', 'Valve', 'Valvular heart disease & endocarditis', '13', '1' ),
( '12', 'PHTN & right heart', 'Pulmonary hypertension, right heart', '14', '1' ),
( '13', 'Primary Care', 'A context for locating indications relevant to primary care', '2', '1' ),
( '14', 'New', 'New indications for multi-hospital review', '1', '1' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indication_contexts" ----------------------
BEGIN;

INSERT INTO `indication_contexts`(`indication_id`,`context_id`) VALUES 
( '138', '6' ),
( '139', '2' ),
( '140', '2' ),
( '141', '2' ),
( '142', '2' ),
( '143', '2' ),
( '143', '5' ),
( '144', '2' ),
( '145', '2' ),
( '146', '2' ),
( '147', '7' ),
( '148', '2' ),
( '149', '2' ),
( '150', '2' ),
( '151', '6' ),
( '152', '2' ),
( '153', '2' ),
( '153', '5' ),
( '154', '8' ),
( '154', '12' ),
( '155', '8' ),
( '156', '8' ),
( '157', '5' ),
( '157', '7' ),
( '158', '3' ),
( '158', '12' ),
( '159', '4' ),
( '160', '4' ),
( '160', '8' ),
( '161', '5' ),
( '162', '8' ),
( '162', '12' ),
( '163', '8' ),
( '164', '3' ),
( '164', '12' ),
( '165', '2' ),
( '165', '5' ),
( '166', '12' ),
( '167', '12' ),
( '168', '5' ),
( '168', '7' ),
( '168', '12' ),
( '169', '12' ),
( '170', '5' ),
( '171', '5' ),
( '172', '5' ),
( '173', '5' ),
( '174', '5' ),
( '174', '7' ),
( '175', '5' ),
( '176', '5' ),
( '176', '7' ),
( '176', '11' ),
( '177', '11' ),
( '178', '11' ),
( '179', '5' ),
( '179', '12' ),
( '180', '5' ),
( '180', '7' ),
( '181', '11' ),
( '182', '6' ),
( '183', '6' ),
( '184', '12' ),
( '185', '7' ),
( '185', '12' ),
( '186', '12' ),
( '187', '1' ),
( '188', '1' ),
( '189', '4' ),
( '190', '7' ),
( '191', '10' ),
( '192', '6' ),
( '192', '10' ),
( '193', '10' ),
( '194', '5' ),
( '195', '2' ),
( '195', '12' ),
( '196', '12' ),
( '197', '6' ),
( '198', '5' ),
( '198', '10' ),
( '199', '12' ),
( '200', '5' ),
( '200', '12' ),
( '201', '12' ),
( '202', '12' ),
( '203', '5' ),
( '204', '6' ),
( '205', '5' ),
( '205', '11' ),
( '206', '5' ),
( '206', '11' ),
( '207', '11' ),
( '208', '11' ),
( '209', '11' ),
( '210', '5' ),
( '210', '11' ),
( '211', '5' ),
( '211', '11' ),
( '212', '11' ),
( '213', '11' ),
( '214', '11' ),
( '214', '12' ),
( '215', '2' ),
( '215', '11' ),
( '215', '12' ),
( '216', '2' ),
( '216', '11' ),
( '216', '12' ),
( '217', '11' ),
( '217', '12' ),
( '218', '11' ),
( '219', '12' ),
( '220', '9' ),
( '220', '12' ),
( '221', '3' ),
( '221', '12' ),
( '222', '3' ),
( '223', '3' ),
( '224', '3' ),
( '224', '11' ),
( '225', '3' ),
( '225', '5' ),
( '225', '12' ),
( '226', '3' ),
( '226', '12' ),
( '227', '5' ),
( '228', '5' ),
( '229', '8' ),
( '230', '8' ),
( '231', '6' ),
( '232', '7' ),
( '233', '1' ),
( '233', '12' ),
( '234', '1' ),
( '235', '1' ),
( '236', '1' ),
( '237', '1' ),
( '238', '11' ),
( '239', '5' ),
( '239', '11' ),
( '239', '12' ),
( '240', '5' ),
( '241', '5' ),
( '241', '11' ),
( '242', '5' ),
( '242', '8' ),
( '243', '5' ),
( '244', '5' ),
( '244', '8' ),
( '245', '6' ),
( '246', '9' ),
( '246', '12' ),
( '247', '12' ),
( '248', '12' ),
( '249', '3' ),
( '249', '12' ),
( '250', '3' ),
( '250', '12' ),
( '251', '3' ),
( '251', '12' ),
( '252', '3' ),
( '252', '12' ),
( '253', '2' ),
( '254', '2' ),
( '255', '6' ),
( '256', '11' ),
( '257', '11' ),
( '258', '11' ),
( '259', '3' ),
( '259', '5' ),
( '259', '11' ),
( '260', '3' ),
( '260', '5' ),
( '260', '11' ),
( '261', '3' ),
( '261', '5' ),
( '261', '11' ),
( '262', '3' ),
( '262', '5' ),
( '262', '11' ),
( '263', '11' ),
( '264', '11' ),
( '265', '11' ),
( '266', '11' ),
( '266', '12' ),
( '267', '11' ),
( '268', '2' ),
( '269', '2' ),
( '270', '5' ),
( '271', '8' ),
( '272', '6' ),
( '273', '11' ),
( '274', '2' ),
( '275', '4' ),
( '275', '14' ),
( '276', '4' ),
( '276', '14' ),
( '277', '4' ),
( '277', '8' ),
( '277', '14' ),
( '278', '4' ),
( '278', '14' ),
( '279', '4' ),
( '279', '11' ),
( '279', '14' ),
( '280', '4' ),
( '280', '14' ),
( '281', '4' ),
( '281', '14' ),
( '282', '12' ),
( '282', '14' ),
( '283', '11' ),
( '283', '12' ),
( '283', '14' ),
( '284', '12' ),
( '284', '14' ),
( '285', '11' ),
( '285', '14' ),
( '286', '11' ),
( '286', '14' ),
( '287', '11' ),
( '287', '14' ),
( '288', '11' ),
( '288', '14' ),
( '289', '6' ),
( '289', '11' ),
( '289', '14' ),
( '290', '5' ),
( '290', '14' ),
( '291', '5' ),
( '291', '14' ),
( '292', '5' ),
( '292', '14' ),
( '293', '7' ),
( '293', '14' ),
( '294', '7' ),
( '294', '14' ),
( '295', '7' ),
( '295', '14' ),
( '296', '10' ),
( '296', '14' ),
( '297', '10' ),
( '297', '14' ),
( '298', '10' ),
( '298', '14' ),
( '299', '7' ),
( '299', '14' ),
( '300', '7' ),
( '300', '14' );

INSERT INTO `indication_contexts`(`indication_id`,`context_id`) VALUES 
( '301', '8' ),
( '301', '14' ),
( '302', '8' ),
( '302', '14' ),
( '303', '9' ),
( '303', '14' ),
( '304', '9' ),
( '304', '14' ),
( '305', '9' ),
( '305', '14' ),
( '306', '9' ),
( '306', '14' ),
( '307', '4' ),
( '307', '9' ),
( '307', '14' ),
( '308', '3' ),
( '308', '14' ),
( '309', '3' ),
( '309', '14' ),
( '310', '3' ),
( '310', '14' ),
( '311', '3' ),
( '311', '11' ),
( '311', '14' ),
( '312', '1' ),
( '312', '3' ),
( '312', '14' ),
( '313', '3' ),
( '313', '14' ),
( '314', '3' ),
( '314', '14' ),
( '315', '2' ),
( '315', '14' ),
( '316', '5' ),
( '316', '14' ),
( '317', '6' ),
( '317', '14' ),
( '318', '10' ),
( '318', '14' ),
( '319', '10' ),
( '319', '14' ),
( '320', '10' ),
( '320', '14' ),
( '321', '10' ),
( '321', '14' ),
( '322', '10' ),
( '322', '14' ),
( '323', '10' ),
( '323', '14' ),
( '324', '10' ),
( '324', '14' ),
( '325', '1' ),
( '325', '14' ),
( '326', '1' ),
( '326', '14' ),
( '327', '1' ),
( '327', '14' ),
( '328', '1' ),
( '328', '14' ),
( '329', '6' ),
( '329', '14' ),
( '330', '6' ),
( '330', '14' ),
( '331', '8' ),
( '331', '14' ),
( '332', '6' ),
( '332', '14' ),
( '333', '6' ),
( '333', '14' );
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
( '67', '2025-12-17 13:39:25', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":1}', '{"is_active":0}' ),
( '68', '2025-12-18 18:47:48', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '69', '2025-12-18 18:47:53', 'skapetanakis', 'contexts', '14', 'create', NULL, NULL, '{"name":"New Context","description":"","sort_order":14,"is_active":1}' ),
( '70', '2025-12-18 18:48:01', 'skapetanakis', 'contexts', '14', 'update', 'name', '{"name":"New Context"}', '{"name":"New"}' ),
( '71', '2025-12-18 18:48:03', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":14}', '{"sort_order":13}' ),
( '72', '2025-12-18 18:48:03', 'skapetanakis', 'contexts', '12', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":14}' ),
( '73', '2025-12-18 18:48:03', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":12}' ),
( '74', '2025-12-18 18:48:03', 'skapetanakis', 'contexts', '11', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":13}' ),
( '75', '2025-12-18 18:48:04', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":11}' ),
( '76', '2025-12-18 18:48:04', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":12}' ),
( '77', '2025-12-18 18:48:04', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '78', '2025-12-18 18:48:04', 'skapetanakis', 'contexts', '9', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '79', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":9}' ),
( '80', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '8', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":10}' ),
( '81', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":8}' ),
( '82', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '7', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":9}' ),
( '83', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":7}' ),
( '84', '2025-12-18 18:48:05', 'skapetanakis', 'contexts', '6', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":8}' ),
( '85', '2025-12-18 18:48:06', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":6}' ),
( '86', '2025-12-18 18:48:06', 'skapetanakis', 'contexts', '5', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":7}' ),
( '87', '2025-12-18 18:48:06', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":5}' ),
( '88', '2025-12-18 18:48:06', 'skapetanakis', 'contexts', '4', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":6}' ),
( '89', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":4}' ),
( '90', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '3', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":5}' ),
( '91', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":3}' ),
( '92', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '2', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":4}' ),
( '93', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":2}' ),
( '94', '2025-12-18 18:48:07', 'skapetanakis', 'contexts', '1', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":3}' ),
( '95', '2025-12-18 18:48:08', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":1}' ),
( '96', '2025-12-18 18:48:08', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":1}', '{"sort_order":2}' ),
( '97', '2025-12-20 13:11:10', 'skapetanakis', 'indications', '173', 'update', 'keywords', '{"keywords":"angina, chest pain"}', '{"keywords":"atypical chest pain"}' ),
( '98', '2025-12-20 13:12:39', 'skapetanakis', 'indications', '229', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Transplant-related"}' ),
( '99', '2025-12-20 13:12:58', 'skapetanakis', 'indications', '229', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Transplant-related"}' ),
( '100', '2025-12-20 13:13:41', 'skapetanakis', 'indications', '230', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Transplant-related"}' ),
( '101', '2025-12-20 13:14:21', 'skapetanakis', 'indications', '230', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Transplant-related"}' ),
( '102', '2025-12-20 13:15:44', 'skapetanakis', 'indications', '255', 'update', 'keywords', '{"keywords":""}', '{"keywords":"ECH"}' ),
( '103', '2025-12-20 13:27:32', 'skapetanakis', 'indications', '139', 'update', 'title', '{"title":"High VE burden gt 10% on recent Holter"}', '{"title":"High VE burden gt 10% on recent Holters"}' ),
( '104', '2025-12-20 13:51:21', 'skapetanakis', 'indications', '302', 'update', 'title', '{"title":"Peripartum cardiomyopathy"}', '{"title":"Peripartum cardiomyopathys"}' ),
( '105', '2025-12-20 14:30:52', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instability"}', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}' ),
( '106', '2025-12-20 14:46:09', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instability"}', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}' ),
( '107', '2025-12-20 14:55:22', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instability"}', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}' ),
( '108', '2025-12-20 14:55:51', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}', '{"title":"Acute coronary syndrome with hemodynamic instability"}' ),
( '109', '2025-12-20 15:10:12', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instability"}', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}' ),
( '110', '2025-12-20 15:10:28', 'skapetanakis', 'indications', '291', 'update', 'title', '{"title":"Acute coronary syndrome with hemodynamic instabilitys"}', '{"title":"Acute coronary syndrome with hemodynamic instability"}' ),
( '111', '2025-12-20 19:13:15', 'skapetanakis', 'indications', '276', 'update', 'keywords', '{"keywords":"checkpoint inhibitor, immunotherapy, myocarditis"}', '{"keywords":"checkpoint inhibitor, immunotherapy, myocarditis, ICI"}' ),
( '112', '2025-12-20 19:21:47', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessment"}', '{"title":"Acute pericarditis - initial assessments"}' ),
( '113', '2025-12-20 19:22:00', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessments"}', '{"title":"Acute pericarditis - initial assessment"}' ),
( '114', '2025-12-20 19:34:50', 'skapetanakis', 'indications', '148', 'update', 'keywords', '{"keywords":""}', '{"keywords":"CIED"}' ),
( '115', '2025-12-20 19:38:03', 'skapetanakis', 'indications', '242', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Post-MI, LV function, ischaemic cardiomyopathy"}' ),
( '116', '2025-12-20 19:38:40', 'skapetanakis', 'indications', '159', 'update', 'keywords', '{"keywords":""}', '{"keywords":"COS"}' ),
( '117', '2025-12-20 19:38:48', 'skapetanakis', 'indications', '276', 'update', 'keywords', '{"keywords":"checkpoint inhibitor, immunotherapy, myocarditis, ICI"}', '{"keywords":"checkpoint inhibitor, immunotherapy, myocarditis, ICI, COS"}' ),
( '118', '2025-12-20 19:39:25', 'skapetanakis', 'indications', '273', 'update', 'keywords', '{"keywords":"mitral, MV, narrowing, stenosis"}', '{"keywords":"mitral, MV, narrowing, stenosis, ECG"}' ),
( '119', '2025-12-20 19:40:22', 'skapetanakis', 'indications', '231', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Donor"}' ),
( '120', '2025-12-20 20:52:31', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessment"}', '{"title":"Acute pericarditis - initial assessments"}' ),
( '121', '2025-12-20 21:19:05', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessments"}', '{"title":"Acute pericarditis - initial assessment"}' ),
( '122', '2025-12-20 21:19:27', 'skapetanakis', 'indications', '255', 'update', 'title', '{"title":"Any indication where echocardiography will not change management"}', '{"title":"Any indication where echocardiography will not change managements"}' ),
( '123', '2025-12-20 21:19:40', 'skapetanakis', 'indications', '255', 'update', 'title', '{"title":"Any indication where echocardiography will not change managements"}', '{"title":"Any indication where echocardiography will not change management"}' ),
( '124', '2025-12-20 21:29:45', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessment"}', '{"title":"Acute pericarditis - initial assessments"}' ),
( '125', '2025-12-20 21:29:53', 'skapetanakis', 'indications', '303', 'update', 'title', '{"title":"Acute pericarditis - initial assessments"}', '{"title":"Acute pericarditis - initial assessment"}' ),
( '126', '2025-12-20 21:57:30', 'skapetanakis', 'indications', '278', 'update', 'keywords', '{"keywords":""}', '{"keywords":"EOT"}' ),
( '127', '2025-12-20 21:58:08', 'skapetanakis', 'indications', '245', 'update', 'keywords', '{"keywords":""}', '{"keywords":"Suspected HF"}' ),
( '128', '2025-12-21 00:50:13', 'skapetanakis', 'contexts', '15', 'create', NULL, NULL, '{"name":"New Context","description":"","sort_order":1,"is_active":1}' ),
( '129', '2025-12-21 00:52:40', 'skapetanakis', 'contexts', '13', 'update', 'is_active', '{"is_active":0}', '{"is_active":1}' ),
( '130', '2025-12-21 00:52:43', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":14}', '{"sort_order":13}' ),
( '131', '2025-12-21 00:52:43', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":14}' ),
( '132', '2025-12-21 00:52:44', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":12}' ),
( '133', '2025-12-21 00:52:44', 'skapetanakis', 'contexts', '12', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":13}' ),
( '134', '2025-12-21 00:52:44', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":11}' ),
( '135', '2025-12-21 00:52:44', 'skapetanakis', 'contexts', '11', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":12}' ),
( '136', '2025-12-21 00:52:45', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '137', '2025-12-21 00:52:45', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '138', '2025-12-21 00:52:45', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":9}' ),
( '139', '2025-12-21 00:52:45', 'skapetanakis', 'contexts', '9', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":10}' ),
( '140', '2025-12-21 00:52:46', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":8}' ),
( '141', '2025-12-21 00:52:46', 'skapetanakis', 'contexts', '8', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":9}' ),
( '142', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":7}' ),
( '143', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '7', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":8}' ),
( '144', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":6}' ),
( '145', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '6', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":7}' ),
( '146', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":5}' ),
( '147', '2025-12-21 00:52:47', 'skapetanakis', 'contexts', '5', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":6}' ),
( '148', '2025-12-21 00:52:48', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":4}' ),
( '149', '2025-12-21 00:52:48', 'skapetanakis', 'contexts', '4', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":5}' ),
( '150', '2025-12-21 00:52:48', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":3}' ),
( '151', '2025-12-21 00:52:48', 'skapetanakis', 'contexts', '3', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":4}' ),
( '152', '2025-12-21 00:52:49', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":2}' ),
( '153', '2025-12-21 00:52:49', 'skapetanakis', 'contexts', '2', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":3}' ),
( '154', '2025-12-21 00:52:49', 'skapetanakis', 'contexts', '14', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":1}' ),
( '155', '2025-12-21 00:52:49', 'skapetanakis', 'contexts', '1', 'update', 'sort_order', '{"sort_order":1}', '{"sort_order":2}' ),
( '156', '2025-12-21 00:52:53', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":14}', '{"sort_order":13}' ),
( '157', '2025-12-21 00:52:53', 'skapetanakis', 'contexts', '12', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":14}' ),
( '158', '2025-12-21 00:52:54', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":13}', '{"sort_order":12}' ),
( '159', '2025-12-21 00:52:54', 'skapetanakis', 'contexts', '11', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":13}' ),
( '160', '2025-12-21 00:52:55', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":12}', '{"sort_order":11}' ),
( '161', '2025-12-21 00:52:55', 'skapetanakis', 'contexts', '10', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":12}' ),
( '162', '2025-12-21 00:52:56', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":11}', '{"sort_order":10}' ),
( '163', '2025-12-21 00:52:56', 'skapetanakis', 'contexts', '9', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":11}' ),
( '164', '2025-12-21 00:52:56', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":10}', '{"sort_order":9}' ),
( '165', '2025-12-21 00:52:56', 'skapetanakis', 'contexts', '8', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":10}' ),
( '166', '2025-12-21 00:52:57', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":9}', '{"sort_order":8}' ),
( '167', '2025-12-21 00:52:57', 'skapetanakis', 'contexts', '7', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":9}' ),
( '168', '2025-12-21 00:52:58', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":8}', '{"sort_order":7}' ),
( '169', '2025-12-21 00:52:58', 'skapetanakis', 'contexts', '6', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":8}' ),
( '170', '2025-12-21 00:52:59', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":7}', '{"sort_order":6}' ),
( '171', '2025-12-21 00:52:59', 'skapetanakis', 'contexts', '5', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":7}' ),
( '172', '2025-12-21 00:53:00', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":6}', '{"sort_order":5}' ),
( '173', '2025-12-21 00:53:00', 'skapetanakis', 'contexts', '4', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":6}' ),
( '174', '2025-12-21 00:53:00', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":5}', '{"sort_order":4}' ),
( '175', '2025-12-21 00:53:00', 'skapetanakis', 'contexts', '3', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":5}' ),
( '176', '2025-12-21 00:53:01', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":4}', '{"sort_order":3}' ),
( '177', '2025-12-21 00:53:01', 'skapetanakis', 'contexts', '2', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":4}' ),
( '178', '2025-12-21 00:53:02', 'skapetanakis', 'contexts', '13', 'update', 'sort_order', '{"sort_order":3}', '{"sort_order":2}' ),
( '179', '2025-12-21 00:53:02', 'skapetanakis', 'contexts', '1', 'update', 'sort_order', '{"sort_order":2}', '{"sort_order":3}' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indications" ------------------------------
BEGIN;

INSERT INTO `indications`(`id`,`title`,`keywords`,`comments`,`primary_care`,`secondary_inpatient`,`secondary_outpatient`,`source_ase`,`source_eacvi`,`source_bse`,`source_consensus`,`created_at`,`updated_at`,`urgency`) VALUES 
( '138', 'Any indication where the patients clinical status/prognosis precludes intervention', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '139', 'High VE burden gt 10% on recent Holter', 'ectopy, PVCs, VE burden', 'Refer to electrophyisiology for review', 'not_indicated', 'indicated', 'indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '140', 'Exercise-induced VE burden', 'ectopy, PVCs, VE burden', 'Refer to electrophysiology instead', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '141', 'Sustained or paroxysmal AF or atrial flutter with new onset or change in clinical status', 'AFL, atrial flutter', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '142', 'Sustained or paroxysmal SVT with previous ECHO and no change in clinical status', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '143', 'Ventricular arrhythmia', NULL, 'Refer to electrophysiology', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '144', 'LBBB with no previous echocardiogram', 'LBBB', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '145', 'RBBB with clinical suspicion of heart disease', 'RBBB', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '146', 'RBBB without clinical suspicion of heart disease', 'RBBB', 'Primary care should refer to cardiology for review', 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '147', 'Inherited channelopathy (e.g. Long QT)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '148', 'Pre device implant', 'CIED', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 19:34:50', 'soon' ),
( '149', 'Infrequent supraventricular or ventricular ectopy with no clinical suspicion of heart disease', 'ectopy, PVCs, VE, VE burden', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '150', 'Sinus bradycardia', NULL, 'Referral after discussion with specialist cardiology team. For discussion - consider not_indicated in all groups.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '151', 'Tented T-waves in absence of history suggesting cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '152', 'LAFB in absence of history suggesting cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '153', 'Palpitations without proof of arrhythmia', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '154', 'Suspected heart failure and elevated NT-proBNP *', 'cardiac failure, heart failure, HF', '"""Refer to 1-stop HF clinic where available. Where not available, reasonable for primary care to refer direct for ECHO. Timing of referral as per NICE Guidance 2018"""', 'can_be_considered', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '155', 'Surveillance of known LV dysfunction to monitor effect of medical or device therapy', 'follow-up, monitoring, surveillance', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '156', 'Surveillance of known LV dysfunction with change in clinical status', 'follow-up, monitoring, surveillance', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '157', 'Family screening in subjects with 1st degree relative with inherited cardiac disease, inherited valvulopathy or inherited aortopathy.', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '158', 'Initial investigation in patient with suspected hypertensive heart disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '159', 'Baseline and serial re-evaluations in patients undergoing therapy with cardiotoxic agents', 'COS', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 19:38:40', 'soon' ),
( '160', 'Reassessment  in patients on cancer therapies with significant (gt x2 ULN) rise in cardiac biomarkers [Troponin, NT-proBNP].', 'cancer, malignancy, oncology', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '161', 'Hypotension in the absence of shock, clinical evidence of significant valvular disease or evidence of acute cardiac pathology such as AMI.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '162', 'Routine surveillance in patients with HFPEF', 'follow-up, monitoring, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '163', 'Routine surveillance of maximally treated patients with HFREF in whom no further intervention is being contemplated and whose clinical status remains satisfactory', 'follow-up, monitoring, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '164', 'Routine re-evaluation in hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '165', 'Sinus arrhythmia', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '166', 'Syncope with previous ECHO and no clinical suspicion of heart disease and/or history of possible ICC', 'blackout, syncope', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '167', 'Syncope with clinical suspicion of cardiac disease', 'blackout, syncope', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '168', 'Syncope with family history suggestve of ICC', 'blackout, family history, syncope', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '169', 'Probable neurocardiogenic syncope', 'blackout, syncope', NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '170', 'Chest pain with no other symptoms and no signs of cardiac disease and normal ECG', 'angina, chest pain', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '171', 'Chest pain with abnormal ECG', 'angina, chest pain', '"""ECG abnormalties do not include: sinus bradycardia, sinus arrhythmia or other changes not linked to coronary disease"""', 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '172', 'Exertional chest pain', 'angina, chest pain', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '173', 'Non-exertional, non-pleuritic chest pain.', 'angina, chest pain', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '174', 'Chest pain with FH of SCD or DCM', 'angina, chest pain, family history', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '175', 'Chest pain with recent recreational drug use', 'angina, chest pain', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '176', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', 'family history, heart murmur, murmur', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '177', 'Murmur with clinical suspicion of cardiovascular disease', 'heart murmur, murmur', 'Removed the word innocent for semantic reasons.', 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '178', 'Pathological murmur', 'heart murmur, murmur', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '179', 'Chest wall deformities and scoliosis pre-operatively', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '180', 'Fatigue with no other signs and symptoms of cardiovascular disease, a normal ECG, and a benign family history.', 'family history', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '181', 'History suggestive of endocarditis with other findings that would fulfill Duke\'s criteria with or without ECHO', 'endocarditis, IE, infective endocarditis', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '182', 'Fever screen or CRP screen without findings to fulfil Duke\'s Criterial for Endocarditis with or without ECHO', 'endocarditis, IE, infective endocarditis', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '183', 'Central cyanosis', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '184', 'Isolated peripheral cyanosis', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '185', 'Genotype positive screen for ICC', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '186', 'Desaturation on pulse oximetry with no signs of cardiac decompensation', NULL, 'indicated if suspicion of platypnoea orthodeoxia', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '187', 'Chromosomal abnormality known to be associated with cardiovascular disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '188', 'Chromosomal abnormality with undefined risk for cardiovascular disease', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '189', 'Cancer with suspicion of cardiac involvment on axial imaging', 'cancer, malignancy, oncology', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '190', 'Muscular dystrophy', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '1', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '191', 'CKD IV or V with clinical suspicion of cardiovascular disease', NULL, 'Referral via secondary care', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '192', 'Obstructive sleep apnoea', '', '', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 19:33:59', 'can_be_considered' ),
( '193', 'Diabetes with no clinical suspicion of cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '194', 'Dyslipidaemia with no clnical suspicion of cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '195', 'Suspected thromboembolic CVA, with no previous ECHO at, or after, event.', NULL, 'For guideline review', 'not_indicated', 'can_be_considered', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '196', 'Peripheral arterial embolus with no obvious cause', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '197', 'Seizures, other neurologic disorders, or psychiatric disorders with no clnical suspicion of cardiac disese.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '198', 'Storage diseases, mitochondrial and metabolic disorders.', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '199', 'Suspected PE, not confirmed.', NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '200', 'Confirmed acute PE where thrombolysis or thrombectomy may be considered (severe hypoxaemia, haemodynamic instability)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '201', 'Confirmed PE where thombecomy or thrombolysis will not be considered regardless of ECHO findings', NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '202', 'Severe deceleration injury or chest trauma where cardiac injury is possible or suspected', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '203', 'Routine evaluation in the setting of mild chest trauma with no electrocardiographic changes or biomarker elevation', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '204', 'Initial evaluation when there is a reasonable suspicion of valvular or structural heart disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '205', 'Routine surveillance (lessThan 5 year) of mild valvular stenosis without a change in clinical status or cardiac exam', 'follow-up, monitoring, narrowing, stenosis, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '206', 'Routine surveillance (gtorequal 5 y) of mild valvular stenosis without a change in clinical status or cardiac exam', 'follow-up, monitoring, narrowing, stenosis, surveillance', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '207', 'Routine surveillance (lessThan1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', 'follow-up, monitoring, narrowing, stenosis, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '208', 'Routine surveillance (gtorequal 1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', 'follow-up, monitoring, narrowing, stenosis, surveillance', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '209', 'Routine surveillance of trace valvular regurgitation with structurally normal valves', 'follow-up, insufficiency, monitoring, regurgitation, surveillance, valve, valvular', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '210', 'Routine surveillance (lessThan 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', 'follow-up, insufficiency, monitoring, regurgitation, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '211', 'Routine surveillance (gtorequal 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', 'follow-up, insufficiency, monitoring, regurgitation, surveillance', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '212', 'Routine surveillance (lessThan 1 y) of moderate  valvular regurgitation without a change in clinical status or cardiac exam', 'follow-up, insufficiency, monitoring, regurgitation, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '213', 'Routine surveillance (gtorequal 1 y) of moderate  valvular regurgitation without change in clinical status or cardiac exam', 'follow-up, insufficiency, monitoring, regurgitation, surveillance', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '214', 'Initial postoperative evaluation of prosthetic valve for establishment of baseline', 'valve, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '215', 'Routine surveillance (lessThan 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', 'follow-up, monitoring, surveillance, TAVI, valve, valve intervention, valvular', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '216', 'Routine surveillance (gtorequal 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', 'follow-up, monitoring, surveillance, TAVI, valve, valve intervention, valvular', NULL, 'indicated', 'indicated', 'indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '217', 'Evaluation of prosthetic valve with suspected dysfunction or a change in clinical status or cardiac exam', 'valve, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '218', 'Re-evaluation of known prosthetic valve dysfunction when it would change management or guide therapy', 'valve, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '219', 'Suspected cardiac mass', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '220', 'Suspected pericardial disease', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '221', 'Evaluation of the ascending aorta in the setting of a known or suspected connective tissue disease or genetic condition that predisposes to aortic aneurysm or dissection (e.g., Marfan syndrome).', 'aorta, aortic, Marfan, Marfan syndrome', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '222', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection to establish a baseline rate of expansion or when the rate of expansion is excessive', 'aorta, aortic', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '223', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection with a change in clinical status or cardiac exam or when findings may alter management or therapy', 'aorta, aortic', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '224', 'Routine re-evaluation for surveillance of known ascending aortic dilation or history of aortic dissection without a change in clinical status or cardiac exam when findings would not change management or therapy (excludes bicuspid aortic valve related disease)', 'aorta, aortic, follow-up, monitoring, surveillance, valve, valvular', NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '225', 'Routine re-evaluation of systemic hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '226', 'Re-evaluation of known hypertensive heart disease without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '227', 'To determine candidacy for ventricular assist device', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '228', 'Optimization of ventricular assist device settings', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '229', 'Re-evaluation for signs/symptoms suggestive of ventricular assist device-related complications', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '230', 'Monitoring for rejection in a cardiac transplant recipient', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '231', 'Cardiac structure and function evaluation in a potential heart donor', 'Donor', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 19:40:22', 'routine' ),
( '232', 'Routine surveillance (lessThan1 y) of known cardiomyopathy without a change in clinical status or cardiac exam or change in therapy', 'cardiomyopathy, CM, follow-up, monitoring, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '233', 'Initial evaluation of known or suspected adult congenital heart disease', 'ACHD, CHD, congenital', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '234', 'Known adult congenital heart disease with a change in clinical status or cardiac exam', 'ACHD, CHD, congenital', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '235', 'Re-evaluation to guide therapy in known adult congenital heart disease', 'ACHD, CHD, congenital', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '236', 'Routine surveillance (lessThan2 y) of adult congenital heart disease following complete repair with no residual significant defect and no change in clinical status', 'ACHD, CHD, congenital, follow-up, monitoring, surveillance', NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '237', 'Routine surveillance (gtorequal 1y) of adult congenital heart disease following complete repair with residual signficant defect or change in clinical status', 'ACHD, CHD, congenital, follow-up, monitoring, surveillance', NULL, 'not_indicated', 'indicated', 'indicated', '0', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '238', 'Unchanged murmur in an asymptomatic individual with previous normal echocardiogram', 'heart murmur, murmur', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '239', 'Periodic repeat assessment of asymptomatic individual with haemodynamically-insignificant lesions, eg mitral annular calcification.', 'mitral, MV', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '240', 'Chest pain with haemodynamic instability', 'angina, chest pain', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '241', 'New murmur following acute or recent myocardial infarction', 'heart attack, heart murmur, MI, murmur, myocardial infarction', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '242', 'Assessment of infarct size, presence of complications and baseline LV function following MI.', 'Post-MI, LV function, ischaemic cardiomyopathy', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 19:38:03', 'soon' ),
( '243', 'Evaluation of non-cardiac chest pain', 'angina, chest pain', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '244', 'Minor radiographic cardiomegaly in the absence of symptoms or signs of heart failure', 'cardiac failure, heart failure, HF', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '245', 'Assessment of patients with oedema, normal venous pressure and no evidence of cardiac disease.', 'Suspected HF', 'Referral based on BNP pathway', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 21:58:08', 'not_indicated' ),
( '246', 'Repeat assessment of small pericardial effusion without clinical change.', 'effusion, pericardial effusion', 'Consider changing to trivial rather than small.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '247', 'Lung disease with no clinical suspicion of cardiac involvement', NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '248', 'Lung disease with clinical suspicion of cardiac involvement (cor pulmonale)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '249', 'Suspected or established pulmonary hypertension', 'PA, PH, PHTN, pulmonary, pulmonary hypertension', NULL, 'not_indicated', 'indicated', 'indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '250', 'Evaluation of clinically suspected aortic coarctation', 'aorta, aortic', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '251', 'Routine assessment in hypertension', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '252', 'Repeat assessment for LV mass regression with treated HTN', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '253', 'Sustained or paroxysmal AF or atrial flutter without change in clinical status', 'AFL, atrial flutter', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '254', 'Sustained or paroxysmal SVT - new onset or change in clinical status', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '255', 'Any indication where echocardiography will not change management', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 21:19:40', 'not_indicated' ),
( '256', 'Routine surveillance (lessThan 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', 'angina, blackout, cardiac failure, chest pain, follow-up, heart failure, HF, insufficiency, monitoring, narrowing, regurgitation, stenosis, surveillance, syncope', '"""RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review. Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"""', 'not_indicated', 'not_indicated', 'not_indicated', '1', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '257', 'Routine surveillance (gtorequal 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', 'angina, blackout, cardiac failure, chest pain, follow-up, heart failure, HF, insufficiency, monitoring, narrowing, regurgitation, stenosis, surveillance, syncope', '"""RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"""', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '258', 'Re-evaluation of severe valvular stenosis or regurgitation (lessThan 6 months) where red flag symptoms are present', 'angina, blackout, cardiac failure, chest pain, heart failure, HF, insufficiency, narrowing, regurgitation, stenosis, syncope', '"""RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"""', 'can_be_considered', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '259', 'Surveillance (lessThan 3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', 'aorta, aortic, follow-up, insufficiency, monitoring, narrowing, regurgitation, stenosis, surveillance, valve, valvular', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '260', 'Surveillance (gtorequal3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', 'aorta, aortic, follow-up, insufficiency, monitoring, narrowing, regurgitation, stenosis, surveillance, valve, valvular', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '261', 'Surveillance (lessThan 2 years) of bicuspid aortic valve with valve thickening and mild stenosis', 'aorta, aortic, follow-up, monitoring, narrowing, stenosis, surveillance, valve, valvular', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '262', 'Surveillance (gtorequal 2 years) of bicuspid aortic valve with early degenerative and mild stenosis', 'aorta, aortic, follow-up, monitoring, narrowing, stenosis, surveillance, valve, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '263', 'Bicuspid valve with signficant stenosis or regurgitation (lessThan 6 months) and no red flag signs', 'insufficiency, narrowing, regurgitation, stenosis, valve, valvular', NULL, 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '264', 'Bisucpid valve with aortopathy (gtorequal 12 months)', 'valve, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '265', 'Annual surveillance of bioprosthetic valve replacement from year 5 onwards (excludes TAVI)', 'follow-up, monitoring, surveillance, TAVI, valve, valve intervention, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '1', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '266', 'Routine surveillance of mechanical valve replacement, normal postoperative scan and no change in clinical status lessThan 10 years since implant.', 'follow-up, monitoring, surveillance, valve, valvular', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '267', 'Annual surveillance of TAVI valve if clinically appropriate', 'follow-up, monitoring, surveillance, TAVI, valve, valve intervention, valvular', NULL, 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '268', 'LBBB with previous satisfactory ECHO and no change in clinical status or where device therapy is not being considered.', 'LBBB', NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'can_be_considered' ),
( '269', 'LBBB with previous ECHO and change in clinical status or where device therapy is being considered', 'LBBB', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '270', 'Routine surveillance in patient-prosthesis mismatch and no change in clinical status lessThan 1 year', 'follow-up, monitoring, surveillance', NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '271', 'Shortness of breath with normal NT-proBNP', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'not_indicated' ),
( '272', 'P-wave abnormalities excepting bifid p-waves', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 19:34:11', 'not_indicated' ),
( '273', 'Bifid p-wave suggestive of mitral stenosis', 'mitral, MV, narrowing, stenosis, ECG', '', 'indicated', 'indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 19:39:25', 'routine' ),
( '274', 'Left atrial thrombus', 'clot, LA, left atrium, thrombus', NULL, 'not_indicated', 'not_indicated', 'indicated', '0', '0', '1', '1', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '275', 'Surveillance echocardiography during anthracycline therapy', 'anthracycline, cardiotoxicity, doxorubicin, follow-up, monitoring, surveillance', 'BSE/British Cardio-Oncology Society guideline - typically 3-6 monthly during therapy', 'not_indicated', 'indicated', 'indicated', NULL, '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '276', 'Baseline assessment before immune checkpoint inhibitor therapy', 'checkpoint inhibitor, immunotherapy, myocarditis, ICI, COS', 'Especially if pre-existing cardiac disease', 'not_indicated', 'indicated', 'indicated', '0', '0', '1', '0', '2025-12-20 12:47:07', '2025-12-20 19:38:48', 'routine' ),
( '277', 'Suspected checkpoint inhibitor myocarditis', 'checkpoint inhibitor, immunotherapy, myocarditis', 'Urgent assessment - high mortality if untreated', 'not_indicated', 'indicated', 'indicated', NULL, NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '278', 'Assessment after completion of potentially cardiotoxic therapy', 'EOT', 'BSE guidance - typically 6-12 months post-therapy', 'not_indicated', 'indicated', 'indicated', '0', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 21:57:30', 'routine' ),
( '279', 'Radiotherapy-related heart disease', NULL, 'Particularly after mediastinal/chest radiation', 'not_indicated', 'indicated', 'indicated', NULL, NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '280', 'HER2-targeted therapy (trastuzumab, pertuzumab)', NULL, '3-monthly assessment typical', 'not_indicated', 'indicated', 'indicated', NULL, '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '281', 'Tyrosine kinase inhibitor therapy monitoring', NULL, 'Variable schedule based on agent', 'not_indicated', 'indicated', 'indicated', NULL, NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '282', 'Right heart assessment for prognostication in known pulmonary hypertension', 'PA, PH, PHTN, pulmonary, pulmonary hypertension', '2025 ASE guidelines - prognostic markers', 'not_indicated', 'indicated', 'indicated', NULL, NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '283', 'Assessment of tricuspid regurgitation severity pre-intervention', 'insufficiency, regurgitation, TR, tricuspid, TV', 'Pre-TTVR/TEER assessment', 'not_indicated', 'indicated', 'indicated', NULL, NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '284', 'Chronic thromboembolic pulmonary hypertension (CTEPH)', 'PA, PH, PHTN, pulmonary, pulmonary hypertension', 'May show RV dysfunction, TR, raised pressures', 'not_indicated', 'indicated', 'indicated', NULL, '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '285', 'Native valve endocarditis - baseline assessment', 'endocarditis, IE, infective endocarditis, valve, valvular', 'First-line imaging per Duke criteria', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '286', 'Prosthetic valve endocarditis suspicion', 'endocarditis, IE, infective endocarditis, valve, valvular', 'TEE often required - TTE first line', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '287', 'Endocarditis - repeat assessment for complications', 'endocarditis, IE, infective endocarditis', 'Repeat if clinical deterioration', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '288', 'Endocarditis - pre-operative surgical planning', 'endocarditis, IE, infective endocarditis', 'Often requires TEE', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '289', 'Staphylococcus aureus bacteremia', NULL, 'High prevalence of undiagnosed IE', 'not_indicated', 'indicated', 'indicated', '1', '1', NULL, '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '290', 'STEMI - immediate assessment for complications', NULL, 'Urgent if hemodynamic instability', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '291', 'Acute coronary syndrome with hemodynamic instability', 'ACS, acute coronary syndrome', 'Life-threatening complications', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 15:10:28', 'urgent' ),
( '292', 'Post-PCI assessment of LV function', 'PCI', 'Not routine - selective use', 'not_indicated', 'can_be_considered', 'can_be_considered', '1', NULL, '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '293', 'Hypertrophic cardiomyopathy - initial diagnosis', 'cardiomyopathy, CM, HCM, hypertrophic', 'Includes stress if obstruction suspected', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '294', 'HCM - annual surveillance', 'follow-up, monitoring, surveillance', 'Annual unless clinical change', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '295', 'Dilated cardiomyopathy - first presentation', 'cardiomyopathy, CM, DCM, dilated', 'Include strain imaging', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '296', 'Suspected cardiac amyloidosis', 'amyloid, amyloidosis', 'Specific echo features - apical sparing', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '297', 'Confirmed cardiac amyloidosis - surveillance', 'amyloid, amyloidosis, follow-up, monitoring, surveillance', 'Variable frequency based on treatment', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '298', 'Cardiac sarcoidosis evaluation', 'cardiac sarcoid, sarcoid, sarcoidosis', 'Often requires CMR', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '299', 'Arrhythmogenic right ventricular cardiomyopathy (ARVC)', 'cardiomyopathy, CM, right ventricle, RV', 'Requires careful RV assessment', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '300', 'Left ventricular non-compaction', 'left ventricle, LV', 'Diagnostic criteria assessment', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '301', 'Takotsubo cardiomyopathy', 'cardiomyopathy, CM', 'Characteristic pattern - recovery expected', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '302', 'Peripartum cardiomyopathy', 'cardiomyopathy, CM, obstetric, pregnancy, pregnant', 'Late pregnancy/early post-partum presentation', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '303', 'Acute pericarditis - initial assessment', 'cardiac tamponade, tamponade', 'Mainly to exclude effusion/tamponade', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 21:29:53', 'soon' ),
( '304', 'Suspected tamponade', 'cardiac tamponade, tamponade', 'Life-threatening - urgent assessment', 'not_indicated', 'indicated', 'indicated', '1', '1', NULL, '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '305', 'Post-pericardiocentesis assessment', NULL, 'Check for re-accumulation', 'not_indicated', 'indicated', 'indicated', '1', '1', NULL, '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '306', 'Constrictive pericarditis evaluation', NULL, 'Requires comprehensive assessment', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '307', 'Pericardial effusion - malignant', 'effusion, pericardial effusion', 'Often requires drainage', 'not_indicated', 'indicated', 'indicated', '1', '1', NULL, '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '308', 'Suspected acute aortic syndrome', 'aorta, aortic', 'TTE limited - CT/TEE usually required', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '309', 'Marfan syndrome - baseline assessment', 'Marfan, Marfan syndrome', 'Establish baseline dimensions', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '310', 'Marfan syndrome - annual surveillance', 'follow-up, Marfan, Marfan syndrome, monitoring, surveillance', 'Annual unless rapid progression', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '311', 'Bicuspid aortic valve with aortopathy - annual surveillance', 'aorta, aortic, follow-up, monitoring, surveillance, valve, valvular', 'Annual if aorta ≥40mm', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '312', 'Turner syndrome', NULL, 'High prevalence cardiac abnormalities', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '313', 'Loeys-Dietz syndrome', 'Marfan, Marfan syndrome', 'More aggressive than Marfan', 'indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '314', 'Ehlers-Danlos syndrome (vascular type)', NULL, 'Screen for cardiovascular involvement', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '315', 'Left atrial appendage thrombus suspicion', 'clot, LA, left atrium, thrombus', 'TEE gold standard', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '316', 'Left ventricular thrombus post-MI', 'clot, left ventricle, LV, thrombus', 'Particularly anterior/apical MI', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '317', 'Stroke in young patient (<55y)', 'cerebrovascular, CVA, stroke', 'Contrast study for PFO', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '318', 'Systemic lupus erythematosus with cardiac symptoms', NULL, 'Multiple manifestations possible', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '319', 'Rheumatoid arthritis with suspected cardiac involvement', NULL, 'Pericarditis most common', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '320', 'Systemic sclerosis (scleroderma)', NULL, 'PHTN common complication', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '321', 'Fabry disease', NULL, 'Concentric LVH with unique features', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '322', 'Hemochromatosis', NULL, 'Variable presentations', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '323', 'HIV with cardiac symptoms', NULL, 'Multiple potential manifestations', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '324', 'Chronic kidney disease stage 4-5', NULL, 'High CV risk population', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '325', 'Congenital heart disease - transition to adult services', 'ACHD, CHD, congenital', 'Establish adult baseline', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '326', 'Fontan circulation surveillance', 'follow-up, monitoring, surveillance', 'Annual or biennial', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '327', 'Tetralogy of Fallot post-repair surveillance', 'follow-up, monitoring, surveillance', 'Variable frequency based on lesions', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '328', 'Transposition of great arteries post-switch', NULL, 'Different considerations per operation', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '329', 'Pre-pregnancy assessment in known heart disease', 'obstetric, pregnancy, pregnant', 'Risk assessment per WHO classification', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '330', 'Pregnancy with new cardiac symptoms', 'obstetric, pregnancy, pregnant', 'Physiological changes vs pathology', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'soon' ),
( '331', 'Pre-eclampsia with cardiac symptoms', NULL, 'Can cause acute LV dysfunction', 'not_indicated', 'indicated', 'indicated', '1', '1', NULL, '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' ),
( '332', 'Post-cardiac surgery - routine surveillance', 'follow-up, monitoring, surveillance', 'Variable based on procedure', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'routine' ),
( '333', 'Post-cardiac surgery with new symptoms', NULL, 'Any new symptoms post-cardiac surgery', 'not_indicated', 'indicated', 'indicated', '1', '1', '1', '0', '2025-12-20 12:47:07', '2025-12-20 12:47:07', 'urgent' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "changes" ----------------------------------
BEGIN;

INSERT INTO `changes`(`changes_request`,`changes_requestor`,`changes_status`,`contexts_existing`,`contexts_new`,`id`,`indication_existing`,`indication_new`,`Indication_id`,`reason_for_close`,`created_at`) VALUES 
( 'test issue', 'SK', 'Closed', NULL, NULL, '1', NULL, NULL, NULL, 'Resolved', '2025-12-16 13:58:32' ),
( 'another request', 'SK', 'Closed', NULL, NULL, '2', NULL, NULL, NULL, '', '2025-12-18 02:16:12' ),
( 'Add indication for suspicion of inherited myocardial or valve disease', 'SK', 'In progress', NULL, NULL, '6', NULL, NULL, NULL, NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 228', NULL, 'New', 'Arrhythmia', NULL, '7', 'Syncope with clinical suspicion of cardiac disease', 'Can you add Loss of consciousness? So that search is easy. Often GPs don\'t put syncope', '228', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 228', NULL, 'New', 'Arrhythmia', NULL, '8', 'Syncope with clinical suspicion of cardiac disease', 'Can you add Loss of consciousness? So that search is easy. Often GPs don\'t put syncope', '228', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 334', NULL, 'New', 'Myocardial', NULL, '9', 'Shortness of breath with normal NT-proBNP', 'Could you put SOB and dyspnoea? Difficult to find this indication.

Please add The 2nd and 3rd options with the level of BNP with SR and in AF', '334', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 225', NULL, 'New', 'Systemic', NULL, '10', 'Routine re-evaluation in hypertension without symptoms or signs of hypertensive heart disease', 'Please make separate entry for LVH on ECG (frequent GP request) and cardiomegaly on CXR. Can the proposed 14 GP pathologies be in the \'general\' pool', '225', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 334', NULL, 'New', 'Myocardial', NULL, '11', 'Shortness of breath with normal NT-proBNP', 'what if BNP is raised ? plus ankle oedema ?', '334', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 334', NULL, 'New', 'Myocardial', NULL, '12', 'Shortness of breath with normal NT-proBNP', 'what if BNP is raised ? plus ankle oedema ?', '334', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 205', NULL, 'New', 'Arrhythmia', NULL, '13', 'LBBB with no previous echocardiogram', 'can we have abbreviations. ?
it only came up with Bundle branch block in full.', '205', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 205', NULL, 'New', 'Arrhythmia', NULL, '14', 'LBBB with no previous echocardiogram', 'can we have abbreviations. ?
it only came up with Bundle branch block in full.', '205', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 291', NULL, 'New', 'Myocardial', NULL, '15', 'Monitoring for rejection in a cardiac transplant recipient', 'Rejection in Transplant patient', '291', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 291', NULL, 'New', 'Myocardial', NULL, '16', 'Monitoring for rejection in a cardiac transplant recipient', 'Rejection in Transplant patient', '291', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 305', NULL, 'New', 'Myocardial', NULL, '17', 'Minor radiographic cardiomegaly in the absence of symptoms or signs of heart failure', 'Cardiomegaly in absence of symptoms or signs of heart failure', '305', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 334', NULL, 'New', 'Myocardial', NULL, '18', 'Shortness of breath with normal NT-proBNP', 'SOB ', '334', NULL, '2025-12-22 02:10:04' ),
( 'Change request for indication id 314', NULL, 'New', 'Arrhythmia', NULL, '19', 'Sustained or paroxysmal AF or atrial flutter without change in clinical status', 'AF/atrial flutter', '314', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 314', NULL, 'New', 'Arrhythmia', NULL, '20', 'Sustained or paroxysmal AF or atrial flutter without change in clinical status', 'AF/atrial flutter', '314', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 283', NULL, 'New', 'Arterial', NULL, '21', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection to establish a baseline rate of expansion or when the rate of expansion is excessive', 'Dilated ascending aorta', '283', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 313', NULL, 'New', 'Arterial ; Myocardial', NULL, '22', 'Repeat assessment for LV mass regression with treated HTN', 'Please, make separate entry for LVH/cardiomegaly as many GPs come with this request', '313', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 227', NULL, 'New', 'Arrhythmia', NULL, '23', 'Syncope with previous ECHO and no clinical suspicion of heart disease and/or history of possible ICC', 'Please could we add an indication for just \'Syncope\' as this is often requested, also maybe \'Syncope with no previous TTE\'', '227', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 227', NULL, 'New', 'Arrhythmia', NULL, '24', 'Syncope with previous ECHO and no clinical suspicion of heart disease and/or history of possible ICC', 'Please could we add an indication for just \'Syncope\' as this is often requested, also maybe \'Syncope with no previous TTE\'', '227', NULL, '2025-12-22 02:10:05' ),
( 'Please could you include criteria for post pericarditis/myocarditis scans', 'KCH ', 'New', NULL, NULL, '25', NULL, NULL, NULL, NULL, '2025-12-22 02:10:05' ),
( 'Please could you add in ones for more simple requests such as: SOB; chest pain; breathlessness; enlarged heart on CXR; syncope; murmur; hypertension. Thank you. ', 'KCH', 'New', NULL, NULL, '26', NULL, NULL, NULL, NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 237', NULL, 'New', 'Valve', NULL, '27', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', '? is this needed for an inpatient if there are no symptoms ', '237', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 237', NULL, 'New', 'Valve', NULL, '28', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', '? is this needed for an inpatient if there are no symptoms ', '237', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 257', NULL, 'New', 'Systemic', NULL, '29', 'Peripheral arterial embolus with no obvious cause', 'Does this include stroke? I can\'t find the term stroke used anywhere else but it is one of our most common indications', '257', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 257', NULL, 'New', 'Systemic', NULL, '30', 'Peripheral arterial embolus with no obvious cause', 'Does this include stroke? I can\'t find the term stroke used anywhere else but it is one of our most common indications', '257', NULL, '2025-12-22 02:10:05' ),
( 'Abnormal ECG with no symptoms ', 'KCH', 'New', NULL, NULL, '31', NULL, NULL, NULL, NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 237', NULL, 'New', 'Valve', NULL, '32', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', '? should not be indicated', '237', NULL, '2025-12-22 02:10:05' ),
( 'Change request for indication id 237', NULL, 'New', 'Valve', NULL, '33', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', '? should not be indicated', '237', NULL, '2025-12-22 02:10:06' ),
( 'Does Brugada with no symptoms/FH of Brugada warrant a TTE?', 'KCH ', 'New', NULL, NULL, '34', NULL, NULL, NULL, NULL, '2025-12-22 02:10:06' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "idx_contexts_sort" ----------------------------
CREATE INDEX `idx_contexts_sort` USING BTREE ON `contexts`( `sort_order` );
-- -------------------------------------------------------------


-- CREATE INDEX "context_id" -----------------------------------
CREATE INDEX `context_id` USING BTREE ON `indication_contexts`( `context_id` );
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


-- CREATE INDEX "idx_indications_primary_care" -----------------
CREATE INDEX `idx_indications_primary_care` USING BTREE ON `indications`( `primary_care` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_secondary_in" -----------------
CREATE INDEX `idx_indications_secondary_in` USING BTREE ON `indications`( `secondary_inpatient` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_secondary_out" ----------------
CREATE INDEX `idx_indications_secondary_out` USING BTREE ON `indications`( `secondary_outpatient` );
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


