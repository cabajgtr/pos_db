-- MySQL Script generated by MySQL Workbench
-- 04/19/16 15:55:51
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema reporting2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `reporting2` ;

-- -----------------------------------------------------
-- Schema reporting2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reporting2` DEFAULT CHARACTER SET latin1 ;
USE `reporting2` ;

-- -----------------------------------------------------
-- Table `reporting2`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reporting2`.`calendar` (
  `date_id` DATE NOT NULL,
  `week_start_date` DATE NOT NULL,
  `week_end_date` DATE NULL,
  `week_number` INT(2) NULL,
  `month_number` INT(2) NULL,
  `month_name` VARCHAR(3) NULL,
  `quarter_number` INT(1) NULL,
  `year` INT(4) NULL,
  `weekday_name` VARCHAR(3) NULL,
  `weekday_number` VARCHAR(45) NULL,
  `holiday_flag` TINYINT(1) NULL DEFAULT 0,
  `weekend_flag` TINYINT(1) NULL DEFAULT 0,
  `season` VARCHAR(10) NULL,
  `gregorian_month_number` INT(2) NULL,
  `gregorian_quarter_number` INT(1) NULL,
  `gregorian_year` INT(4) NULL,
  `gregorian_month_name` VARCHAR(3) NULL,
  PRIMARY KEY (`date_id`),
  INDEX `ix_weekly_end_date` (`week_end_date` ASC),
  INDEX `ix_year_week_end_date` (`year` ASC, `week_end_date` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `reporting2`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reporting2`.`customer` (
  `customer_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_number` INT UNSIGNED NULL,
  `customer_name` VARCHAR(64) NOT NULL,
  `channel` VARCHAR(10) NULL DEFAULT NULL,
  `address` VARCHAR(128) NULL DEFAULT NULL,
  `city` VARCHAR(24) NULL DEFAULT NULL,
  `state` VARCHAR(2) NULL DEFAULT NULL,
  `zip` VARCHAR(10) NULL DEFAULT NULL,
  `region` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC),
  UNIQUE INDEX `customer_number_UNIQUE` (`customer_number` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `reporting2`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reporting2`.`product` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(10) NULL,
  `description` VARCHAR(60) NULL DEFAULT NULL,
  `product_h1` VARCHAR(10) NULL DEFAULT NULL,
  `product_h2` VARCHAR(10) NULL DEFAULT NULL,
  `product_h3` VARCHAR(10) NULL DEFAULT NULL,
  `product_h4` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr1` VARCHAR(10) NULL,
  `product_attr2` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr3` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr4` VARCHAR(10) NULL DEFAULT NULL,
  `valid_from` DATE NOT NULL,
  `valid_to` DATE NULL DEFAULT NULL,
  `active_flag` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC),
  INDEX `sku_active` (`sku` ASC, `active_flag` ASC),
  INDEX `product_id_active` (`product_id` ASC, `active_flag` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `reporting2`.`fact_pos_actual_stage`
-- -----------------------------------------------------
DROP table `reporting2`.`fact_pos_actual_stage`;
CREATE TABLE IF NOT EXISTS `reporting2`.`fact_pos_actual_stage` (
  `date_id` DATE NOT NULL,
  `customer_id` INT(10) UNSIGNED NOT NULL,
  `product_id` INT NOT NULL,
  `pos_units` INT(11) NULL,
  `pos_sales` DECIMAL(19,4) NULL DEFAULT NULL,
  `inventory_units` INT(11) NULL DEFAULT NULL,
  `inventory_value` DECIMAL(19,4) NULL DEFAULT NULL,
  `country_code` VARCHAR(2) NULL DEFAULT 'US',
  `currency_code` VARCHAR(3) NULL DEFAULT 'USD',
  `sku` VARCHAR(10) NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `reporting2`.`fact_pos_actual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reporting2`.`fact_pos_actual` (
  `tx_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_id` DATE NOT NULL,
  `customer_id` INT(10) UNSIGNED NOT NULL,
  `product_id` INT NOT NULL,
  `pos_units` INT(11) NULL,
  `pos_sales` DECIMAL(19,4) NULL DEFAULT NULL,
  `inventory_units` INT(11) NULL DEFAULT NULL,
  `inventory_value` DECIMAL(19,4) NULL DEFAULT NULL,
  `country_code` VARCHAR(2) NULL DEFAULT 'US',
  `currency_code` VARCHAR(3) NULL DEFAULT 'USD',
  PRIMARY KEY (`tx_id`),
  INDEX `fk_fact_pos_actual_calendar_idx` (`date_id` ASC),
  INDEX `ix_fact_pos_actual_date_cust` (`customer_id` ASC, `date_id` ASC),
  UNIQUE INDEX `ix_fact_pos_actual_uniquenatkey` (`date_id` ASC, `customer_id` ASC, `product_id` ASC),
  INDEX `ix_fact_pos_actual_date_product` (`product_id` ASC, `date_id` ASC),
  CONSTRAINT `fk_txpos_customer_id0`
    FOREIGN KEY (`customer_id`)
    REFERENCES `reporting2`.`customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_txpos_product_id0`
    FOREIGN KEY (`product_id`)
    REFERENCES `reporting2`.`product` (`product_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_txpos_date_id0`
    FOREIGN KEY (`date_id`)
    REFERENCES `reporting2`.`calendar` (`date_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `reporting2`.`product_stage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reporting2`.`product_stage` (
  `sku` VARCHAR(10) NULL,
  `description` VARCHAR(60) NULL DEFAULT NULL,
  `product_h1` VARCHAR(10) NULL DEFAULT NULL,
  `product_h2` VARCHAR(10) NULL DEFAULT NULL,
  `product_h3` VARCHAR(10) NULL DEFAULT NULL,
  `product_h4` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr1` VARCHAR(10) NULL,
  `product_attr2` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr3` VARCHAR(10) NULL DEFAULT NULL,
  `product_attr4` VARCHAR(10) NULL DEFAULT NULL,
  `valid_from` DATE NOT NULL,
  `valid_to` DATE NULL DEFAULT NULL,
  `active_flag` TINYINT(1) NULL DEFAULT 1)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
