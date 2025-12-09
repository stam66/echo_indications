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
	`is_active` TinyInt( 1 ) NULL DEFAULT 1,
	`created_at` Timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` Timestamp NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 138;
-- -------------------------------------------------------------


-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE `users`( 
	`id` Int( 0 ) AUTO_INCREMENT NOT NULL,
	`username` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`password_hash` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
	`is_active` TinyInt( 1 ) NULL DEFAULT 1,
	`created_at` Timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` Timestamp NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `username` UNIQUE( `username` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 2;
-- -------------------------------------------------------------


-- CREATE INDEX "idx_contexts_sort" ----------------------------
CREATE INDEX `idx_contexts_sort` USING BTREE ON `contexts`( `sort_order` );
-- -------------------------------------------------------------


-- CREATE INDEX "context_id" -----------------------------------
CREATE INDEX `context_id` USING BTREE ON `indication_contexts`( `context_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "idx_indications_active" -----------------------
CREATE INDEX `idx_indications_active` USING BTREE ON `indications`( `is_active` );
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


