-- MySQL Script generated by MySQL Workbench
-- Thu Dec 22 14:14:12 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pagaoseguro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pagaoseguro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pagaoseguro` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci ;
USE `pagaoseguro` ;

-- -----------------------------------------------------
-- Table `pagaoseguro`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagaoseguro`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagaoseguro`.`api`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagaoseguro`.`api` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `publicHash` VARCHAR(255) NOT NULL,
  `privateHash` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_api_user_idx` (`user` ASC),
  CONSTRAINT `fk_api_user`
    FOREIGN KEY (`user`)
    REFERENCES `pagaoseguro`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagaoseguro`.`credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagaoseguro`.`credit_card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `card` VARCHAR(255) NOT NULL,
  `valid` VARCHAR(255) NOT NULL,
  `secure` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_credit_card_user1_idx` (`user` ASC),
  CONSTRAINT `fk_credit_card_user1`
    FOREIGN KEY (`user`)
    REFERENCES `pagaoseguro`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagaoseguro`.`token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagaoseguro`.`token` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NOT NULL,
  `expires` INT NOT NULL,
  `limite` INT NOT NULL,
  `creditCard` INT NOT NULL,
  INDEX `fk_token_user1_idx` (`user` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_token_credit_card1_idx` (`creditCard` ASC),
  CONSTRAINT `fk_token_user1`
    FOREIGN KEY (`user`)
    REFERENCES `pagaoseguro`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_token_credit_card1`
    FOREIGN KEY (`creditCard`)
    REFERENCES `pagaoseguro`.`credit_card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagaoseguro`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagaoseguro`.`transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `api` INT NOT NULL,
  `token` INT NOT NULL,
  `value` INT NOT NULL,
  `date` INT NOT NULL,
  INDEX `fk_transaction_token1_idx` (`token` ASC),
  INDEX `fk_transaction_api1_idx` (`api` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_transaction_token1`
    FOREIGN KEY (`token`)
    REFERENCES `pagaoseguro`.`token` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_api1`
    FOREIGN KEY (`api`)
    REFERENCES `pagaoseguro`.`api` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;