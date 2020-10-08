-- MySQL Script generated by MySQL Workbench
-- Thu Sep 17 10:29:16 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema csunvb_csu
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema csunvb_csu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `csunvb_csu` DEFAULT CHARACTER SET utf8 ;
USE `csunvb_csu` ;

-- -----------------------------------------------------
-- Table `csunvb_csu`.`bases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`bases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`novas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`novas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `number_UNIQUE` (`number` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`drugs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`batches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`batches` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL DEFAULT 'new',
  `drug_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_batches_drugs_idx` (`drug_id` ASC) ,
  UNIQUE INDEX `number_UNIQUE` (`number` ASC) ,
  CONSTRAINT `fk_batches_drugs`
    FOREIGN KEY (`drug_id`)
    REFERENCES `csunvb_csu`.`drugs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `initials` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `admin` TINYINT NOT NULL,
  `firstconnect` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `initials_UNIQUE` (`initials` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`stupsheets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`stupsheets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `week` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `base_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stupsheets_bases1_idx` (`base_id` ASC) ,
  UNIQUE INDEX `STUPSHEETUNIQ` (`week` ASC, `base_id` ASC) ,
  CONSTRAINT `fk_stupsheets_bases1`
    FOREIGN KEY (`base_id`)
    REFERENCES `csunvb_csu`.`bases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`pharmachecks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`pharmachecks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `start` INT NOT NULL,
  `end` INT NULL,
  `batch_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `stupsheet_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pharmachecks_batches1_idx` (`batch_id` ASC) ,
  INDEX `fk_pharmachecks_users1_idx` (`user_id` ASC) ,
  INDEX `fk_pharmachecks_stupsheets1_idx` (`stupsheet_id` ASC) ,
  CONSTRAINT `fk_pharmachecks_batches1`
    FOREIGN KEY (`batch_id`)
    REFERENCES `csunvb_csu`.`batches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pharmachecks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pharmachecks_stupsheets1`
    FOREIGN KEY (`stupsheet_id`)
    REFERENCES `csunvb_csu`.`stupsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`novachecks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`novachecks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `start` INT NOT NULL,
  `end` INT NULL,
  `drug_id` INT NOT NULL,
  `nova_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `stupsheet_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_novachecks_drugs1_idx` (`drug_id` ASC) ,
  INDEX `fk_novachecks_novas1_idx` (`nova_id` ASC) ,
  INDEX `fk_novachecks_users1_idx` (`user_id` ASC) ,
  INDEX `fk_novachecks_stupsheets1_idx` (`stupsheet_id` ASC) ,
  CONSTRAINT `fk_novachecks_drugs1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `csunvb_csu`.`drugs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_novachecks_novas1`
    FOREIGN KEY (`nova_id`)
    REFERENCES `csunvb_csu`.`novas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_novachecks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_novachecks_stupsheets1`
    FOREIGN KEY (`stupsheet_id`)
    REFERENCES `csunvb_csu`.`stupsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`restocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`restocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `batch_id` INT NOT NULL,
  `nova_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restocks_batches1_idx` (`batch_id` ASC) ,
  INDEX `fk_restocks_novas1_idx` (`nova_id` ASC) ,
  INDEX `fk_restocks_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_restocks_batches1`
    FOREIGN KEY (`batch_id`)
    REFERENCES `csunvb_csu`.`batches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restocks_novas1`
    FOREIGN KEY (`nova_id`)
    REFERENCES `csunvb_csu`.`novas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restocks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`stupsignatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`stupsignatures` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `day` INT NOT NULL,
  `stupsheet_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stupsignatures_stupsheets1_idx` (`stupsheet_id` ASC) ,
  INDEX `fk_stupsignatures_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_stupsignatures_stupsheets1`
    FOREIGN KEY (`stupsheet_id`)
    REFERENCES `csunvb_csu`.`stupsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stupsignatures_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`stupsheet_use_nova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`stupsheet_use_nova` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stupsheet_id` INT NOT NULL,
  `nova_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stupsheet_use_nova_stupsheets1_idx` (`stupsheet_id` ASC) ,
  INDEX `fk_stupsheet_use_nova_novas1_idx` (`nova_id` ASC) ,
  UNIQUE INDEX `unique_use` (`stupsheet_id` ASC, `nova_id` ASC) ,
  CONSTRAINT `fk_stupsheet_use_nova_stupsheets1`
    FOREIGN KEY (`stupsheet_id`)
    REFERENCES `csunvb_csu`.`stupsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stupsheet_use_nova_novas1`
    FOREIGN KEY (`nova_id`)
    REFERENCES `csunvb_csu`.`novas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`stupsheet_use_batch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`stupsheet_use_batch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stupsheet_id` INT NOT NULL,
  `batch_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stupsheet_use_batch_stupsheets1_idx` (`stupsheet_id` ASC) ,
  INDEX `fk_stupsheet_use_batch_batches1_idx` (`batch_id` ASC) ,
  UNIQUE INDEX `unique_use` (`stupsheet_id` ASC, `batch_id` ASC) ,
  CONSTRAINT `fk_stupsheet_use_batch_stupsheets1`
    FOREIGN KEY (`stupsheet_id`)
    REFERENCES `csunvb_csu`.`stupsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stupsheet_use_batch_batches1`
    FOREIGN KEY (`batch_id`)
    REFERENCES `csunvb_csu`.`batches` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`todosheets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`todosheets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `week` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `base_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_todosheets_bases1_idx` (`base_id` ASC) ,
  CONSTRAINT `fk_todosheets_bases1`
    FOREIGN KEY (`base_id`)
    REFERENCES `csunvb_csu`.`bases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`todothings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`todothings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `daything` TINYINT NOT NULL DEFAULT 1,
  `type` INT NOT NULL DEFAULT 1 COMMENT '1: done/not done\n2: has a value',
  `display_order` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `text_UNIQUE` (`description` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`todos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`todos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `todothing_id` INT NOT NULL,
  `todosheet_id` INT NOT NULL,
  `user_id` INT NULL,
  `value` VARCHAR(45) NULL,
  `done_at` DATETIME NULL,
  `day_of_week` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_todoitems_todotexts1_idx` (`todothing_id` ASC) ,
  INDEX `fk_todoitems_todosheets1_idx` (`todosheet_id` ASC) ,
  INDEX `fk_todoitems_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_todoitems_todotexts1`
    FOREIGN KEY (`todothing_id`)
    REFERENCES `csunvb_csu`.`todothings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_todoitems_todosheets1`
    FOREIGN KEY (`todosheet_id`)
    REFERENCES `csunvb_csu`.`todosheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_todoitems_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`guardsheets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`guardsheets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `base_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_guardsheets_bases1_idx` (`base_id` ASC) ,
  UNIQUE INDEX `uniq` (`base_id` ASC, `date` ASC) ,
  CONSTRAINT `fk_guardsheets_bases1`
    FOREIGN KEY (`base_id`)
    REFERENCES `csunvb_csu`.`bases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`guardsections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`guardsections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`guardlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`guardlines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(45) NOT NULL,
  `guard_sections_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_guard_lines_guard_sections1_idx` (`guard_sections_id` ASC) ,
  CONSTRAINT `fk_guard_lines_guard_sections1`
    FOREIGN KEY (`guard_sections_id`)
    REFERENCES `csunvb_csu`.`guardsections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`guardcontents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`guardcontents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(45) NULL,
  `guard_line_id` INT NOT NULL,
  `guardsheet_id` INT NOT NULL,
  `day_check` INT NULL,
  `day_check_user_id` INT NOT NULL,
  `night_check` INT NULL,
  `night_check_user_id` INT NOT NULL,
  `carry_on` INT NOT NULL DEFAULT 0 COMMENT 'If true, the comment must be transferred on to the next guardsheet when it’s opened',
  PRIMARY KEY (`id`),
  INDEX `fk_guard_items_guard_lines1_idx` (`guard_line_id` ASC) ,
  INDEX `fk_guard_items_guardsheets1_idx` (`guardsheet_id` ASC) ,
  INDEX `fk_guard_items_users1_idx` (`day_check_user_id` ASC) ,
  INDEX `fk_guard_items_users2_idx` (`night_check_user_id` ASC) ,
  CONSTRAINT `fk_guard_items_guard_lines1`
    FOREIGN KEY (`guard_line_id`)
    REFERENCES `csunvb_csu`.`guardlines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guard_items_guardsheets1`
    FOREIGN KEY (`guardsheet_id`)
    REFERENCES `csunvb_csu`.`guardsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guard_items_users1`
    FOREIGN KEY (`day_check_user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guard_items_users2`
    FOREIGN KEY (`night_check_user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`crews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`crews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `boss` TINYINT NOT NULL DEFAULT 0,
  `day` TINYINT NOT NULL DEFAULT 1,
  `guardsheet_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_crews_guardsheets1_idx` (`guardsheet_id` ASC) ,
  INDEX `fk_crews_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_crews_guardsheets1`
    FOREIGN KEY (`guardsheet_id`)
    REFERENCES `csunvb_csu`.`guardsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crews_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `csunvb_csu`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `csunvb_csu`.`guard_use_nova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `csunvb_csu`.`guard_use_nova` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nova_id` INT NOT NULL,
  `guardsheet_id` INT NOT NULL,
  `day` INT NOT NULL DEFAULT 1,
  INDEX `fk_novas_has_guardsheets_guardsheets1_idx` (`guardsheet_id` ASC) ,
  INDEX `fk_novas_has_guardsheets_novas1_idx` (`nova_id` ASC) ,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_novas_has_guardsheets_novas1`
    FOREIGN KEY (`nova_id`)
    REFERENCES `csunvb_csu`.`novas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_novas_has_guardsheets_guardsheets1`
    FOREIGN KEY (`guardsheet_id`)
    REFERENCES `csunvb_csu`.`guardsheets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
