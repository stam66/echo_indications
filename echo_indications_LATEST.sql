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
	`sort_order` Int( 11 ) NULL DEFAULT 0,
	`is_active` TinyInt( 4 ) NOT NULL DEFAULT 1,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `name` UNIQUE( `name` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 15;
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
AUTO_INCREMENT = 97;
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
AUTO_INCREMENT = 282;
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
AUTO_INCREMENT = 3;
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
( '12', 'PHTN/RH', 'Pulmonary hypertension, right heart', '14', '1' ),
( '13', 'Primary Care', 'A context for locating indications relevant to primary care', '2', '1' ),
( '14', 'New', NULL, '1', '1' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indication_contexts" ----------------------
BEGIN;

INSERT INTO `indication_contexts`(`indication_id`,`context_id`) VALUES 
( '138', '6' ),
( '242', '5' ),
( '242', '8' ),
( '245', '8' ),
( '255', '6' ),
( '263', '11' ),
( '265', '11' ),
( '267', '11' );
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
( '97', '2025-12-19 14:21:39', 'skapetanakis', 'users', '5', 'delete', NULL, '{"name":"Test User","username":"TUser","email":"tuser@somewhere.com","title":"Test","is_active":"1"}', NULL );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "indications" ------------------------------
BEGIN;

INSERT INTO `indications`(`id`,`title`,`keywords`,`comments`,`primary_care`,`secondary_inpatient`,`secondary_outpatient`,`source_ase`,`source_eacvi`,`source_bse`,`source_consensus`,`created_at`,`updated_at`,`urgency`) VALUES 
( '138', 'Any indication where the patients clinical status/prognosis precludes intervention', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-14 22:21:50', 'not_indicated' ),
( '139', 'High VE burden gt 10% on recent Holter', NULL, 'Refer to electrophyisiology for review', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '140', 'Exercise-induced VE burden', NULL, 'Refer to electrophysiology instead', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '141', 'Sustained or paroxysmal AF or atrial flutter with new onset or change in clinical status', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '142', 'Sustained or paroxysmal SVT with previous ECHO and no change in clinical status', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '143', 'Ventricular arrhythmia', NULL, 'Refer to electrophysiology', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '144', 'LBBB with no previous echocardiogram', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '145', 'RBBB with clinical suspicion of heart disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '146', 'RBBB without clinical suspicion of heart disease', NULL, 'Primary care should refer to cardiology for review', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '147', 'Inherited channelopathy (e.g. Long QT)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '148', 'Pre device implant', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '149', 'Infrequent supraventricular or ventricular ectopy with no clinical suspicion of heart disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '150', 'Sinus bradycardia', NULL, 'Referral after discussion with specialist cardiology team. For discussion - consider not_indicated in all groups.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '151', 'Tented T-waves in absence of history suggesting cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '152', 'LAFB in absence of history suggesting cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '153', 'Palpitations without proof of arrhythmia', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '154', 'Suspected heart failure and elevated NT-proBNP *', NULL, '"Refer to 1-stop HF clinic where available. Where not available, reasonable for primary care to refer direct for ECHO. Timing of referral as per NICE Guidance 2018"', 'can_be_considered', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '155', 'Surveillance of known LV dysfunction to monitor effect of medical or device therapy', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '156', 'Surveillance of known LV dysfunction with change in clinical status', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '157', 'Family screening in subjects with 1st degree relative with inherited cardiac disease, inherited valvulopathy or inherited aortopathy.', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:33', 'not_indicated' ),
( '158', 'Initial investigation in patient with suspected hypertensive heart disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '159', 'Baseline and serial re-evaluations in patients undergoing therapy with cardiotoxic agents', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '160', 'Reassessment  in patients on cancer therapies with significant (gt x2 ULN) rise in cardiac biomarkers [Troponin, NT-proBNP].', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:07', 'not_indicated' ),
( '161', 'Hypotension in the absence of shock, clinical evidence of significant valvular disease or evidence of acute cardiac pathology such as AMI.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:50', 'not_indicated' ),
( '162', 'Routine surveillance in patients with HFPEF', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '163', 'Routine surveillance of maximally treated patients with HFREF in whom no further intervention is being contemplated and whose clinical status remains satisfactory', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '164', 'Routine re-evaluation in hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '165', 'Sinus arrhythmia', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '166', 'Syncope with previous ECHO and no clinical suspicion of heart disease and/or history of possible ICC', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '167', 'Syncope with clinical suspicion of cardiac disease', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '168', 'Syncope with family history suggestve of ICC', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '169', 'Probable neurocardiogenic syncope', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '170', 'Chest pain with no other symptoms and no signs of cardiac disease and normal ECG', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '171', 'Chest pain with abnormal ECG', NULL, '"ECG abnormalties do not include: sinus bradycardia, sinus arrhythmia or other changes not linked to coronary disease"', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '172', 'Exertional chest pain', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '173', 'Non-exertional, non-pleuritic chest pain.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:58', 'not_indicated' ),
( '174', 'Chest pain with FH of SCD or DCM', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '175', 'Chest pain with recent recreational drug use', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '176', 'Murmur with no clinical suspicion of cardiovascular disease and benign family history under the age of 50y and with no previous ECHO.', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '177', 'Murmur with clinical suspicion of cardiovascular disease', NULL, 'Removed the word innocent for semantic reasons.', 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '178', 'Pathological murmur', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '179', 'Chest wall deformities and scoliosis pre-operatively', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '180', 'Fatigue with no other signs and symptoms of cardiovascular disease, a normal ECG, and a benign family history.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:40', 'not_indicated' ),
( '181', 'History suggestive of endocarditis with other findings that would fulfill Duke\'s criteria with or without ECHO', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '182', 'Fever screen or CRP screen without findings to fulfil Duke\'s Criterial for Endocarditis with or without ECHO', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '183', 'Central cyanosis', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '184', 'Isolated peripheral cyanosis', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '185', 'Genotype positive screen for ICC', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '186', 'Desaturation on pulse oximetry with no signs of cardiac decompensation', NULL, 'indicated if suspicion of platypnoea orthodeoxia', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '187', 'Chromosomal abnormality known to be associated with cardiovascular disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '188', 'Chromosomal abnormality with undefined risk for cardiovascular disease', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '189', 'Cancer with suspicion of cardiac involvment on axial imaging', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '190', 'Muscular dystrophy', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '191', 'CKD IV or V with clinical suspicion of cardiovascular disease', NULL, 'Referral via secondary care', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '192', 'Obstructive sleep apnoea', NULL, NULL, 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '193', 'Diabetes with no clinical suspicion of cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '194', 'Dyslipidaemia with no clnical suspicion of cardiac disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '195', 'Suspected thromboembolic CVA, with no previous ECHO at, or after, event.', NULL, 'For guideline review', 'not_indicated', 'can_be_considered', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:33', 'not_indicated' ),
( '196', 'Peripheral arterial embolus with no obvious cause', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '197', 'Seizures, other neurologic disorders, or psychiatric disorders with no clnical suspicion of cardiac disese.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:11', 'not_indicated' ),
( '198', 'Storage diseases, mitochondrial and metabolic disorders.', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:19', 'not_indicated' ),
( '199', 'Suspected PE, not confirmed.', NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:13:27', 'not_indicated' ),
( '200', 'Confirmed acute PE where thrombolysis or thrombectomy may be considered (severe hypoxaemia, haemodynamic instability)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:23', 'not_indicated' ),
( '201', 'Confirmed PE where thombecomy or thrombolysis will not be considered regardless of ECHO findings', NULL, NULL, 'not_indicated', 'can_be_considered', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '202', 'Severe deceleration injury or chest trauma where cardiac injury is possible or suspected', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '203', 'Routine evaluation in the setting of mild chest trauma with no electrocardiographic changes or biomarker elevation', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '204', 'Initial evaluation when there is a reasonable suspicion of valvular or structural heart disease', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '205', 'Routine surveillance (lessThan 5 year) of mild valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '206', 'Routine surveillance (gtorequal 5 y) of mild valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '207', 'Routine surveillance (lessThan1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '208', 'Routine surveillance (gtorequal 1 y) of moderate valvular stenosis without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '209', 'Routine surveillance of trace valvular regurgitation with structurally normal valves', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '210', 'Routine surveillance (lessThan 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '211', 'Routine surveillance (gtorequal 5 y) of mild valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '212', 'Routine surveillance (lessThan 1 y) of moderate  valvular regurgitation without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '213', 'Routine surveillance (gtorequal 1 y) of moderate  valvular regurgitation without change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '214', 'Initial postoperative evaluation of prosthetic valve for establishment of baseline', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '215', 'Routine surveillance (lessThan 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '216', 'Routine surveillance (gtorequal 5 y after valve implantation) of bioprosthetic valve if no known or suspected valve dysfunction on post operative scan (excludes TAVI)', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '217', 'Evaluation of prosthetic valve with suspected dysfunction or a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '218', 'Re-evaluation of known prosthetic valve dysfunction when it would change management or guide therapy', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '219', 'Suspected cardiac mass', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '1', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '220', 'Suspected pericardial disease', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '221', 'Evaluation of the ascending aorta in the setting of a known or suspected connective tissue disease or genetic condition that predisposes to aortic aneurysm or dissection (e.g., Marfan syndrome).', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:12', 'not_indicated' ),
( '222', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection to establish a baseline rate of expansion or when the rate of expansion is excessive', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '223', 'Re-evaluation of known ascending aortic dilation or history of aortic dissection with a change in clinical status or cardiac exam or when findings may alter management or therapy', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '224', 'Routine re-evaluation for surveillance of known ascending aortic dilation or history of aortic dissection without a change in clinical status or cardiac exam when findings would not change management or therapy (excludes bicuspid aortic valve related disease)', NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '225', 'Routine re-evaluation of systemic hypertension without symptoms or signs of hypertensive heart disease', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '226', 'Re-evaluation of known hypertensive heart disease without a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '227', 'To determine candidacy for ventricular assist device', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '228', 'Optimization of ventricular assist device settings', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '229', 'Re-evaluation for signs/symptoms suggestive of ventricular assist device-related complications', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '230', 'Monitoring for rejection in a cardiac transplant recipient', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '231', 'Cardiac structure and function evaluation in a potential heart donor', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '232', 'Routine surveillance (lessThan1 y) of known cardiomyopathy without a change in clinical status or cardiac exam or change in therapy', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '233', 'Initial evaluation of known or suspected adult congenital heart disease', 'ACHD', NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '234', 'Known adult congenital heart disease with a change in clinical status or cardiac exam', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '235', 'Re-evaluation to guide therapy in known adult congenital heart disease', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '236', 'Routine surveillance (lessThan2 y) of adult congenital heart disease following complete repair with no residual significant defect and no change in clinical status', NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '237', 'Routine surveillance (gtorequal 1y) of adult congenital heart disease following complete repair with residual signficant defect or change in clinical status', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '238', 'Unchanged murmur in an asymptomatic individual with previous normal echocardiogram', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '239', 'Periodic repeat assessment of asymptomatic individual with haemodynamically-insignificant lesions, eg mitral annular calcification.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:12:03', 'not_indicated' ),
( '240', 'Chest pain with haemodynamic instability', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '241', 'New murmur following acute or recent myocardial infarction', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '242', 'Assessment of infarct size, presence of complications and baseline LV function following MI.', 'Post MI', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-14 23:56:14', 'not_indicated' ),
( '243', 'Evaluation of non-cardiac chest pain', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '244', 'Minor radiographic cardiomegaly in the absence of symptoms or signs of heart failure', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '245', 'Assessment of patients with oedema, normal venous pressure and no evidence of cardiac disease.', NULL, 'Referral based on BNP pathway', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-12 00:11:14', 'not_indicated' ),
( '246', 'Repeat assessment of small pericardial effusion without clinical change.', NULL, 'Consider changing to trivial rather than small.', 'not_indicated', 'can_be_considered', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '247', 'Lung disease with no clinical suspicion of cardiac involvement', NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '248', 'Lung disease with clinical suspicion of cardiac involvement (cor pulmonale)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '249', 'Suspected or established pulmonary hypertension', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '250', 'Evaluation of clinically suspected aortic coarctation', NULL, NULL, 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '251', 'Routine assessment in hypertension', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '252', 'Repeat assessment for LV mass regression with treated HTN', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '253', 'Sustained or paroxysmal AF or atrial flutter without change in clinical status', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '254', 'Sustained or paroxysmal SVT - new onset or change in clinical status', NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '255', 'Any indication where echocardiography will not change management', '', '', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:26', 'not_indicated' ),
( '256', 'Routine surveillance (lessThan 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review. Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'not_indicated', 'not_indicated', 'not_indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '257', 'Routine surveillance (gtorequal 6 months) of severe valvular stenosis or regurgitation without red flag symptoms', NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '258', 'Re-evaluation of severe valvular stenosis or regurgitation (lessThan 6 months) where red flag symptoms are present', NULL, '"RED FLAGS: Breathlessness; chest pain, palpitations or heart failure signs require urgent cardiology review; Presyncope; syncope: consider in-patient admission; New LV dysfunction (LVEF lessThan55% without other cause); Reducing LV ejection fraction"', 'can_be_considered', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '259', 'Surveillance (lessThan 3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '260', 'Surveillance (gtorequal3 years) of bicuspid aortic valve with no stenosis and no more than mild regurgitation', NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '261', 'Surveillance (lessThan 2 years) of bicuspid aortic valve with valve thickening and mild stenosis', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '262', 'Surveillance (gtorequal 2 years) of bicuspid aortic valve with early degenerative and mild stenosis', NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '263', 'Bicuspid valve with signficant stenosis or regurgitation (lessThan 6 months) and no red flag signs', NULL, NULL, 'indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '264', 'Bisucpid valve with aortopathy (gtorequal 12 months)', NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '265', 'Annual surveillance of bioprosthetic valve replacement from year 5 onwards (excludes TAVI)', '', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:02', 'not_indicated' ),
( '266', 'Routine surveillance of mechanical valve replacement, normal postoperative scan and no change in clinical status lessThan 10 years since implant.', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-12 00:11:02', 'not_indicated' ),
( '267', 'Annual surveillance of TAVI valve if clinically appropriate', '', '', 'not_indicated', 'indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-16 14:16:14', 'not_indicated' ),
( '268', 'LBBB with previous satisfactory ECHO and no change in clinical status or where device therapy is not being considered.', NULL, NULL, 'not_indicated', 'not_indicated', 'can_be_considered', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '269', 'LBBB with previous ECHO and change in clinical status or where device therapy is being considered', NULL, NULL, 'not_indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '270', 'Routine surveillance in patient-prosthesis mismatch and no change in clinical status lessThan 1 year', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '271', 'Shortness of breath with normal NT-proBNP', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '272', 'P-wave abnormalities excepting bifid p-waves', NULL, NULL, 'not_indicated', 'not_indicated', 'not_indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '273', 'Bifid p-wave suggestive of mitral stenosis', NULL, NULL, 'indicated', 'indicated', 'indicated', NULL, NULL, NULL, NULL, '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' ),
( '274', 'Left atrial thrombus', NULL, NULL, 'not_indicated', 'not_indicated', 'indicated', '0', '0', '0', '0', '2025-12-01 19:01:06', '2025-12-01 19:01:06', 'not_indicated' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "changes" ----------------------------------
BEGIN;

INSERT INTO `changes`(`changes_request`,`changes_requestor`,`changes_status`,`contexts_existing`,`contexts_new`,`id`,`indication_existing`,`indication_new`,`Indication_id`,`reason_for_close`,`created_at`) VALUES 
( 'test issue', 'SK', 'Closed', NULL, NULL, '1', NULL, NULL, NULL, 'Resolved', '2025-12-16 13:58:32' ),
( 'another request', 'SK', 'Open', NULL, NULL, '2', NULL, NULL, NULL, NULL, '2025-12-18 02:16:12' );
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


