-- MySQL Script generated by MySQL Workbench
-- Fri Sep 22 23:43:02 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(254) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `birth_date` DATE NULL,
  `genre` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postal_code` VARCHAR(12) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(5000) NOT NULL,
  `file_name` VARCHAR(45) NOT NULL,
  `file_size` VARCHAR(3) NOT NULL,
  `length` TIME NOT NULL,
  `thumbnail` VARCHAR(45) NULL,
  `views` BIGINT NULL,
  `likes` BIGINT NULL,
  `dislikes` BIGINT NULL,
  `published_at` DATETIME NOT NULL,
  `status` ENUM('PUBLIC', 'PRIVATE', 'UNLISTED') NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC) ,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`tag_name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel_name` VARCHAR(100) NOT NULL,
  `channel_creator_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `channel_creator_id_idx` (`channel_creator_id` ASC) ,
  CONSTRAINT `channel_creator_id`
    FOREIGN KEY (`channel_creator_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`tag_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`tag_video` (
  `video_tagged_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`video_tagged_id`, `tag_id`),
  INDEX `video_id_idx` (`video_tagged_id` ASC) ,
  CONSTRAINT `tag_id`
    FOREIGN KEY (`tag_id`)
    REFERENCES `youtube`.`tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `video_tagged_id`
    FOREIGN KEY (`video_tagged_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_name` VARCHAR(100) NOT NULL,
  `status_playlist` ENUM('PUBLIC', 'PRIVATE') NOT NULL,
  `created_at` DATE NOT NULL,
  `user_owner_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_owner_id` ASC) ,
  CONSTRAINT `user_owner_id`
    FOREIGN KEY (`user_owner_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist_video` (
  `playlist_id` INT NOT NULL,
  `video_in_playlist_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_in_playlist_id`),
  INDEX `fk_video_playlist_playlists1_idx` (`playlist_id` ASC) ,
  CONSTRAINT `video_in_playlist_id`
    FOREIGN KEY (`video_in_playlist_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlists` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video_reaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_reaction` (
  `video_id` INT NOT NULL,
  `user_reacting_id` INT NOT NULL,
  `reaction_type` ENUM('LIKE', 'DISLIKE') NOT NULL,
  `date_time` DATETIME NOT NULL,
  INDEX `fk_video_has_likes_videos1_idx` (`video_id` ASC) ,
  INDEX `fk_video_has_likes_users1_idx` (`user_reacting_id` ASC) ,
  PRIMARY KEY (`video_id`, `user_reacting_id`),
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_reacting_id`
    FOREIGN KEY (`user_reacting_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
  `id` INT NOT NULL,
  `comment_content` VARCHAR(10000) NOT NULL,
  `user_author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_author_id_idx` (`user_author_id` ASC) ,
  CONSTRAINT `user_author_id`
    FOREIGN KEY (`user_author_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comment_reaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comment_reaction` (
  `comment_with_reaction_id` INT NOT NULL,
  `user_reacted_id` INT NOT NULL,
  `type` ENUM('LIKE', 'DISLIKE') NOT NULL,
  `date_time` DATETIME NOT NULL,
  PRIMARY KEY (`comment_with_reaction_id`, `user_reacted_id`),
  CONSTRAINT `user_reacted_id`
    FOREIGN KEY (`user_reacted_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `comment_with_reaction`
    FOREIGN KEY (`comment_with_reaction_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`channel_subscriber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channel_subscriber` (
  `channel_id` INT NOT NULL,
  `user_subs_id` INT NOT NULL,
  PRIMARY KEY (`channel_id`, `user_subs_id`),
  INDEX `fk_canal_has_subscribers_canal1_idx` (`channel_id` ASC) ,
  CONSTRAINT `user_subs_id`
    FOREIGN KEY (`user_subs_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `channel_id`
    FOREIGN KEY (`channel_id`)
    REFERENCES `youtube`.`channels` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comment_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comment_video` (
  `video_commented_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  INDEX `fk_video_has_comments_videos1_idx` (`video_commented_id` ASC) ,
  PRIMARY KEY (`comment_id`, `video_commented_id`),
  CONSTRAINT `video_commented_id`
    FOREIGN KEY (`video_commented_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `comment_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
