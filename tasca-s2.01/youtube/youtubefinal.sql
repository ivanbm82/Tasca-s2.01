-- MySQL Script generated by MySQL Workbench
-- Tue Mar 21 19:15:17 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;
USE `YouTube` ;

-- -----------------------------------------------------
-- Table `YouTube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`channel` (
  `channel_id` INT NOT NULL AUTO_INCREMENT,
  `channel_name` VARCHAR(100) NOT NULL,
  `channel_description` VARCHAR(200) NULL,
  `channel_creationDate` DATE NOT NULL,
  PRIMARY KEY (`channel_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(100) NOT NULL,
  `user_password` VARCHAR(100) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_birthDate` DATE NOT NULL,
  `user_gender` ENUM('M', 'F') NOT NULL,
  `user_country` VARCHAR(45) NOT NULL,
  `user_zipCode` VARCHAR(5) NULL,
  `channel_channel_id` INT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_user_channel1_idx` (`channel_channel_id` ASC),
  CONSTRAINT `fk_user_channel1`
    FOREIGN KEY (`channel_channel_id`)
    REFERENCES `YouTube`.`channel` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`state` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_name` ENUM('Public', 'Hidden', 'Private') NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `video_title` VARCHAR(100) NOT NULL,
  `video_description` VARCHAR(250) NULL DEFAULT NULL,
  `video_size` DOUBLE NOT NULL,
  `video_fileName` VARCHAR(45) NULL DEFAULT NULL,
  `video_publicationDatetime` DATETIME NOT NULL,
  `video_duration` TIME NOT NULL,
  `video_thumbnail` VARCHAR(250) NULL DEFAULT NULL,
  `video_numReproductions` INT NOT NULL,
  `video_numLikes` INT NOT NULL,
  `video_numDislikes` INT NOT NULL,
  `state_state_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_video_state_idx` (`state_state_id` ASC),
  INDEX `fk_video_user1_idx` (`user_user_id` ASC),
  CONSTRAINT `fk_video_state`
    FOREIGN KEY (`state_state_id`)
    REFERENCES `YouTube`.`state` (`state_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `YouTube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`subscription` (
  `user_user_id` INT NOT NULL,
  `channel_channel_id` INT NOT NULL,
  PRIMARY KEY (`user_user_id`, `channel_channel_id`),
  INDEX `fk_video_has_user_user1_idx` (`user_user_id` ASC),
  INDEX `fk_subscription_channel1_idx` (`channel_channel_id` ASC),
  CONSTRAINT `fk_video_has_user_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `YouTube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscription_channel1`
    FOREIGN KEY (`channel_channel_id`)
    REFERENCES `YouTube`.`channel` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `playlist_name` VARCHAR(45) NOT NULL,
  `playlist_creationDate` DATE NOT NULL,
  `state_state_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_state1_idx` (`state_state_id` ASC),
  CONSTRAINT `fk_playlist_state1`
    FOREIGN KEY (`state_state_id`)
    REFERENCES `YouTube`.`state` (`state_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`videoInteraction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`videoInteraction` (
  `video_video_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  `videoInteraction_likeOrDislike` ENUM('Like', 'Dislike') NOT NULL,
  `videoInteraction_datetime` DATETIME NULL,
  `playlist_playlist_id` INT NULL,
  PRIMARY KEY (`video_video_id`, `user_user_id`),
  INDEX `fk_video_has_user_user2_idx` (`user_user_id` ASC),
  INDEX `fk_video_has_user_video2_idx` (`video_video_id` ASC),
  INDEX `fk_videoInteraction_playlist1_idx` (`playlist_playlist_id` ASC),
  CONSTRAINT `fk_video_has_user_video2`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `YouTube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_user_user2`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `YouTube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videoInteraction_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `YouTube`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`comment` (
  `comment_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  `comment_text` VARCHAR(45) NOT NULL,
  `comment_datetime` DATETIME NOT NULL,
  INDEX `fk_video_has_user_user3_idx` (`user_user_id` ASC),
  INDEX `fk_video_has_user_video3_idx` (`video_video_id` ASC),
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `fk_video_has_user_video3`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `YouTube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_user_user3`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `YouTube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`commentInteraction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`commentInteraction` (
  `comment_comment_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  `commentInteraction_likeOrDislike` ENUM('Like', 'Dislike') NOT NULL,
  `commentInteraction_datetime` DATETIME NULL,
  PRIMARY KEY (`comment_comment_id`, `user_user_id`),
  INDEX `fk_commentInteraction_user1_idx` (`user_user_id` ASC),
  CONSTRAINT `fk_commentInteraction_comment1`
    FOREIGN KEY (`comment_comment_id`)
    REFERENCES `YouTube`.`comment` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_commentInteraction_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `YouTube`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`tag_has_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`tag_has_video` (
  `tag_tag_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  PRIMARY KEY (`tag_tag_id`, `video_video_id`),
  INDEX `fk_tag_has_video_video1_idx` (`video_video_id` ASC),
  INDEX `fk_tag_has_video_tag1_idx` (`tag_tag_id` ASC),
  CONSTRAINT `fk_tag_has_video_tag1`
    FOREIGN KEY (`tag_tag_id`)
    REFERENCES `YouTube`.`tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tag_has_video_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `YouTube`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `YouTube`.`channel`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`channel` (`channel_id`, `channel_name`, `channel_description`, `channel_creationDate`) VALUES (1, 'Futbol Total', 'Canal del periodista deportivo', '2022-09-21');
INSERT INTO `YouTube`.`channel` (`channel_id`, `channel_name`, `channel_description`, `channel_creationDate`) VALUES (2, 'Noticias 24', 'Noticias de actualidad', '2016-11-21');
INSERT INTO `YouTube`.`channel` (`channel_id`, `channel_name`, `channel_description`, `channel_creationDate`) VALUES (3, 'TodoRock', 'Musica Rock ', '2021-08-30');
INSERT INTO `YouTube`.`channel` (`channel_id`, `channel_name`, `channel_description`, `channel_creationDate`) VALUES (4, 'EstilenCasa', 'Todo lo que quieras para el hogar, las mejores ideas', '2018-02-16');
INSERT INTO `YouTube`.`channel` (`channel_id`, `channel_name`, `channel_description`, `channel_creationDate`) VALUES (5, 'EnglishallAge', 'Aprende Ingles', '2012-05-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`user` (`user_id`, `user_email`, `user_password`, `user_name`, `user_birthDate`, `user_gender`, `user_country`, `user_zipCode`, `channel_channel_id`) VALUES (1, 'dgdgsgs@gmail.com', '1234', 'dgdgsgs', '1988-12-27', 'M', 'Spain', '08120', 1);
INSERT INTO `YouTube`.`user` (`user_id`, `user_email`, `user_password`, `user_name`, `user_birthDate`, `user_gender`, `user_country`, `user_zipCode`, `channel_channel_id`) VALUES (2, '454gfgd@gmail.com', '4567', '454gfgd', '1995-03-27', 'F', 'Spain', '08110', 2);
INSERT INTO `YouTube`.`user` (`user_id`, `user_email`, `user_password`, `user_name`, `user_birthDate`, `user_gender`, `user_country`, `user_zipCode`, `channel_channel_id`) VALUES (3, 'miwewl@hotmail.com', '9853', 'miwewl', '1975-02-22', 'M', 'Spain', 'NULL', 3);
INSERT INTO `YouTube`.`user` (`user_id`, `user_email`, `user_password`, `user_name`, `user_birthDate`, `user_gender`, `user_country`, `user_zipCode`, `channel_channel_id`) VALUES (4, 'cadad@ccma.cat', '1010', 'cadad', '1965-06-18', 'M', 'Spain', '08452', 4);
INSERT INTO `YouTube`.`user` (`user_id`, `user_email`, `user_password`, `user_name`, `user_birthDate`, `user_gender`, `user_country`, `user_zipCode`, `channel_channel_id`) VALUES (5, 'lksdfaop@gmail.com', '4321', 'lksdfaop', '1982-11-02', 'F', 'Spain', 'NULL', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`state`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`state` (`state_id`, `state_name`) VALUES (1, 'Public');
INSERT INTO `YouTube`.`state` (`state_id`, `state_name`) VALUES (2, 'Private');
INSERT INTO `YouTube`.`state` (`state_id`, `state_name`) VALUES (3, 'Hidden');

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`video`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (1, 'Messi Xavi antes del clásico Barça - Madrid de la Supercopa', 'Messi desde dentro ', 5.25, '.AVI', '2022-08-14', '00:22:19', NULL, 2348 , 183, 3, 1, 1);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (2, 'Madrid 0 - 5 Barça ', 'Hablamos de los mjores gole ', 12.33, '.AVI', '2022-08-14', '00:56:18', NULL, 15156, 529, 15, 1, 1);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (3, 'Guerrra Ucrania', 'los actos innecesarios', 1.15, '.MP4', '2021-12-18', '00:02:44', NULL, 15395, 328, 5, 1, 2);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (5, 'Metallica - Black Album', 'Todo lo que no se sabe de este album', 4.56, '.MOV', '2022-12-20', '00:21:57', NULL, 694, 27, 0, 1, 4);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (6, 'to be', 'MasterClass', 4.41, '.MOV', '2021-01-09', '00:17:22', NULL, 1232, 45, 1, 1, 4);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (7, 'Madrid 3 - 5 Barça ', 'Hablamos de los mjores gole ', 12.33, '.AVI', '2022-08-14', '00:56:18', NULL, 15156, 529, 15, 1, 2);
INSERT INTO `YouTube`.`video` (`video_id`, `video_title`, `video_description`, `video_size`, `video_fileName`, `video_publicationDatetime`, `video_duration`, `video_thumbnail`, `video_numReproductions`, `video_numLikes`, `video_numDislikes`, `state_state_id`, `user_user_id`) VALUES (8, 'Valencia 0 - 5 Barça ', 'Hablamos de los mjores gole ', 12.33, '.AVI', '2022-08-14', '00:56:18', NULL, 15156, 529, 15, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (1, '#FTotal');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (2, '#Not24');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (3, '#Rock');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (4, '#InHouse');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (5, '#Vaughann');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (6, '#sport');
INSERT INTO `YouTube`.`tag` (`tag_id`, `tag_name`) VALUES (7, '#cartas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`subscription`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`subscription` (`user_user_id`, `channel_channel_id`) VALUES (1, 2);
INSERT INTO `YouTube`.`subscription` (`user_user_id`, `channel_channel_id`) VALUES (1, 3);
INSERT INTO `YouTube`.`subscription` (`user_user_id`, `channel_channel_id`) VALUES (2, 4);
INSERT INTO `YouTube`.`subscription` (`user_user_id`, `channel_channel_id`) VALUES (2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`playlist` (`playlist_id`, `playlist_name`, `playlist_creationDate`, `state_state_id`) VALUES (1, 'Música para descansar', '2022-05-22', 2);
INSERT INTO `YouTube`.`playlist` (`playlist_id`, `playlist_name`, `playlist_creationDate`, `state_state_id`) VALUES (2, 'Bricomania', '2022-12-19', 2);
COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`videoInteraction`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (3, 1, 'Like', '2021-02-10', 1);
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (2, 1, 'Like', '2021-10-22', 1);
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (5, 2, 'Like', '2023-01-01', 2);
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (6, 2, 'Like', '2023-01-12', 2);
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (7, 1, 'Dislike', '2022-11-16', NULL);
INSERT INTO `YouTube`.`videoInteraction` (`video_video_id`, `user_user_id`, `videoInteraction_likeOrDislike`, `videoInteraction_datetime`, `playlist_playlist_id`) VALUES (1, 3, 'Dislike', '2023-01-15', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`comment` (`comment_id`, `video_video_id`, `user_user_id`, `comment_text`, `comment_datetime`) VALUES (1, 1, 2, 'Me gusta', '2023-01-15');
INSERT INTO `YouTube`.`comment` (`comment_id`, `video_video_id`, `user_user_id`, `comment_text`, `comment_datetime`) VALUES (2, 5, 1, 'Bufff', '2023-01-13');
INSERT INTO `YouTube`.`comment` (`comment_id`, `video_video_id`, `user_user_id`, `comment_text`, `comment_datetime`) VALUES (3, 3, 1, 'No se entiende', '2021-12-09');
INSERT INTO `YouTube`.`comment` (`comment_id`, `video_video_id`, `user_user_id`, `comment_text`, `comment_datetime`) VALUES (4, 2, 5, 'Son increible', '2023-01-12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`commentInteraction`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`commentInteraction` (`comment_comment_id`, `user_user_id`, `commentInteraction_likeOrDislike`, `commentInteraction_datetime`) VALUES (1, 1, 'Like', '2023-01-15');
INSERT INTO `YouTube`.`commentInteraction` (`comment_comment_id`, `user_user_id`, `commentInteraction_likeOrDislike`, `commentInteraction_datetime`) VALUES (2, 4, 'Dislike', '2023-01-14');
INSERT INTO `YouTube`.`commentInteraction` (`comment_comment_id`, `user_user_id`, `commentInteraction_likeOrDislike`, `commentInteraction_datetime`) VALUES (3, 5, 'Like', '2022-03-28');
INSERT INTO `YouTube`.`commentInteraction` (`comment_comment_id`, `user_user_id`, `commentInteraction_likeOrDislike`, `commentInteraction_datetime`) VALUES (4, 1, 'Dislike', '2023-01-12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `YouTube`.`tag_has_video`
-- -----------------------------------------------------
START TRANSACTION;
USE `YouTube`;
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (1, 1);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (1, 2);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (2, 3);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (3, 6);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (4, 3);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (5, 5);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (5, 6);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (6, 7);
INSERT INTO `YouTube`.`tag_has_video` (`tag_tag_id`, `video_video_id`) VALUES (7, 7);

COMMIT;

