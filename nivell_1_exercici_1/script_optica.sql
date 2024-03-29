-- MySQL Script generated by MySQL Workbench
-- Thu Sep 21 00:56:30 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `optica` ;

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`adreces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`adreces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(45) NOT NULL,
  `num` VARCHAR(45) NOT NULL,
  `pis` VARCHAR(45) NOT NULL,
  `porta` VARCHAR(45) NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom_1` VARCHAR(45) NOT NULL,
  `cognom_2` VARCHAR(45) NOT NULL,
  `adreça_id` INT NOT NULL,
  `nif` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `client_prescriptor` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `clients_id_UNIQUE` (`id` ASC) ,
  INDEX `adreça_idx` (`adreça_id` ASC) ,
  INDEX `prescriptor_idx` (`client_prescriptor` ASC) ,
  CONSTRAINT `adreça_id`
    FOREIGN KEY (`adreça_id`)
    REFERENCES `optica`.`adreces` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `client_prescriptor`
    FOREIGN KEY (`client_prescriptor`)
    REFERENCES `optica`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`venedors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`venedors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom_1` VARCHAR(45) NOT NULL,
  `cognom_2` VARCHAR(45) NOT NULL,
  `carrec` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `data_incorporacio` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `venedors_id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveidors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom_empresa` VARCHAR(45) NOT NULL,
  `persona_contacte` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `adreça_prov_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `adreça_prov_id_idx` (`adreça_prov_id` ASC) ,
  CONSTRAINT `adreça_prov_id`
    FOREIGN KEY (`adreça_prov_id`)
    REFERENCES `optica`.`adreces` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `proveidor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `proveidors_id_idx` (`proveidor` ASC) ,
  UNIQUE INDEX `marques_id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `proveidor`
    FOREIGN KEY (`proveidor`)
    REFERENCES `optica`.`proveidors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`models` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `EAN` VARCHAR(13) NOT NULL,
  `unitats_estoc` INT NOT NULL,
  `tipus_muntura` ENUM('FLOTANT', 'PASTA', 'METÀL·LICA') NOT NULL,
  `status` ENUM('EN PRODUCCIÓ', 'DESCATALOGAT') NOT NULL,
  `preu` FLOAT NOT NULL,
  `marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_modelsEstoc_marques1_idx` (`marca_id` ASC) ,
  UNIQUE INDEX `ref_cataleg_model_UNIQUE` (`EAN` ASC) ,
  CONSTRAINT `fk_modelsEstoc_marques1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marques` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`factures` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `data` DATE NULL,
  `import` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_factures_clients1_idx` (`client_id` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_factures_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `optica`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`comandes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `client_id` INT NOT NULL,
  `venedor_id` INT NOT NULL,
  `codi_EAN` VARCHAR(13) NOT NULL,
  `gradOD` DECIMAL NULL,
  `gradOI` DECIMAL NULL,
  `colorOD` VARCHAR(45) NOT NULL,
  `colorOI` VARCHAR(45) NOT NULL,
  `preu_muntura` FLOAT NULL,
  `preu_vidres_graduats` FLOAT NULL,
  `preu_total` FLOAT NULL,
  `import_pendent` FLOAT NOT NULL,
  `dataLliurament` DATE NULL,
  `factura_id` INT NULL,
  `status` ENUM('OBERTA', 'TANCADA') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `clients_id_idx` (`client_id` ASC) ,
  INDEX `venedor_id_idx` (`venedor_id` ASC) ,
  INDEX `factura_id_idx` (`factura_id` ASC) ,
  CONSTRAINT `client`
    FOREIGN KEY (`client_id`)
    REFERENCES `optica`.`clients` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `venedor_id`
    FOREIGN KEY (`venedor_id`)
    REFERENCES `optica`.`venedors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `codi_EAN`
    FOREIGN KEY (`codi_EAN`)
    REFERENCES `optica`.`models` (`EAN`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `factura_id`
    FOREIGN KEY (`factura_id`)
    REFERENCES `optica`.`factures` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
