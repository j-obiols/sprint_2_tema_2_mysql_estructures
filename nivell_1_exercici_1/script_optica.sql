-- MySQL Script generated by MySQL Workbench
-- Sun May 14 16:50:08 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`adreces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`adreces` (
  `adreces_id` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(45) NOT NULL,
  `num` VARCHAR(45) NOT NULL,
  `pis` VARCHAR(45) NOT NULL,
  `porta` VARCHAR(45) NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adreces_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clients` (
  `clients_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `adreça` INT NOT NULL,
  `nif` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `dataRegistre` DATE NOT NULL,
  `prescriptor` INT NULL,
  PRIMARY KEY (`clients_id`),
  UNIQUE INDEX `clients_id_UNIQUE` (`clients_id` ASC),
  INDEX `adreça_idx` (`adreça` ASC),
  INDEX `prescriptor_idx` (`prescriptor` ASC),
  CONSTRAINT `adreça`
    FOREIGN KEY (`adreça`)
    REFERENCES `optica`.`adreces` (`adreces_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `prescriptor`
    FOREIGN KEY (`prescriptor`)
    REFERENCES `optica`.`clients` (`clients_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`venedors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venedors` (
  `venedors_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NOT NULL,
  `carrec` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`venedors_id`),
  UNIQUE INDEX `venedors_id_UNIQUE` (`venedors_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveidors` (
  `proveidors_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `adreçaProv` INT NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`proveidors_id`),
  UNIQUE INDEX `proveidors_id_UNIQUE` (`proveidors_id` ASC),
  INDEX `adreça_idx` (`adreçaProv` ASC),
  CONSTRAINT `adreçaProv`
    FOREIGN KEY (`adreçaProv`)
    REFERENCES `optica`.`adreces` (`adreces_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marques` (
  `marques_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `proveidor` INT NOT NULL,
  PRIMARY KEY (`marques_id`),
  INDEX `proveidors_id_idx` (`proveidor` ASC),
  UNIQUE INDEX `marques_id_UNIQUE` (`marques_id` ASC),
  CONSTRAINT `proveidor`
    FOREIGN KEY (`proveidor`)
    REFERENCES `optica`.`proveidors` (`proveidors_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`comandesUlleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`comandesUlleres` (
  `comandesUlleres_id` INT NOT NULL AUTO_INCREMENT,
  `dataComanda` DATE NOT NULL,
  `client` INT NOT NULL,
  `venedor` INT NOT NULL,
  `marca` INT NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `gradOD` DECIMAL NOT NULL,
  `gradOI` DECIMAL NOT NULL,
  `tipusMuntura` VARCHAR(45) NULL,
  `colorOD` VARCHAR(45) NOT NULL,
  `colorOI` VARCHAR(45) NOT NULL,
  `preu` FLOAT NOT NULL,
  `dataLliurament` DATE NULL,
  PRIMARY KEY (`comandesUlleres_id`),
  UNIQUE INDEX `comandesUlleres_id_UNIQUE` (`comandesUlleres_id` ASC),
  INDEX `clients_id_idx` (`client` ASC),
  INDEX `marca_idx` (`marca` ASC),
  INDEX `venedor_idx` (`venedor` ASC),
  CONSTRAINT `client`
    FOREIGN KEY (`client`)
    REFERENCES `optica`.`clients` (`clients_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `marca`
    FOREIGN KEY (`marca`)
    REFERENCES `optica`.`marques` (`marques_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `venedor`
    FOREIGN KEY (`venedor`)
    REFERENCES `optica`.`venedors` (`venedors_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
