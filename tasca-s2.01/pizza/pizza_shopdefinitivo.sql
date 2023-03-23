-- MySQL Script generated by MySQL Workbench
-- Sun Mar 19 20:20:47 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizza_shop
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `pizza_shop` DEFAULT CHARACTER SET utf8 ;
USE `pizza_shop` ;

-- -----------------------------------------------------
-- Table `pizza_shop`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`province` (
  `province_id` INT NOT NULL AUTO_INCREMENT,
  `province_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`town`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`town` (
  `town_id` INT NOT NULL AUTO_INCREMENT,
  `town_name` VARCHAR(45) NOT NULL,
  `province_province_id` INT NOT NULL,
  PRIMARY KEY (`town_id`),
  INDEX `fk_town_province_idx` (`province_province_id` ASC),
  CONSTRAINT `fk_town_province`
    FOREIGN KEY (`province_province_id`)
    REFERENCES `pizza_shop`.`province` (`province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_surname` VARCHAR(100) NOT NULL,
  `customer_address` VARCHAR(100) NULL,
  `customer_postcode` VARCHAR(5) NULL,
  `customer_phone_number` VARCHAR(9) NOT NULL,
  `town_town_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_town1_idx` (`town_town_id` ASC),
  CONSTRAINT `fk_customer_town1`
    FOREIGN KEY (`town_town_id`)
    REFERENCES `pizza_shop`.`town` (`town_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`shop` (
  `shop_id` INT NOT NULL AUTO_INCREMENT,
  `shop_address` VARCHAR(100) NOT NULL,
  `shop_postcode` VARCHAR(5) NOT NULL,
  `town_town_id` INT NOT NULL,
  PRIMARY KEY (`shop_id`),
  INDEX `fk_shop_town1_idx` (`town_town_id` ASC),
  CONSTRAINT `fk_shop_town1`
    FOREIGN KEY (`town_town_id`)
    REFERENCES `pizza_shop`.`town` (`town_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;



-- -----------------------------------------------------
-- Table `pizza_shop`.`shop_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`shop_order` (
  `shop_order_id` INT NOT NULL AUTO_INCREMENT,
  `shop_order_datetime` DATETIME NOT NULL,
  `shop_order_option` ENUM('Delivery', 'shop') NOT NULL,
  `shop_order_price` DECIMAL(4,2) NOT NULL,
  `shop_shop_id` INT NOT NULL,
  `customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`shop_order_id`),
  INDEX `fk_shop_order_shop1_idx` (`shop_shop_id` ASC),
  INDEX `fk_shop_order_customer1_idx` (`customer_customer_id` ASC),
  CONSTRAINT `fk_shop_order_shop1`
    FOREIGN KEY (`shop_shop_id`)
    REFERENCES `pizza_shop`.`shop` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shop_order_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `pizza_shop`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` ENUM('Pizza ', 'Burger', 'Drink') NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_description` VARCHAR(200) NULL,
  `product_image` VARCHAR(200) NULL,
  `product_price` DECIMAL(10,2) NOT NULL,
  `category_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_category1_idx` (`category_category_id` ASC),
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `pizza_shop`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`order_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`order_has_products` (
  `product_product_id` INT NOT NULL,
  `shop_order_shop_order_id` INT NOT NULL,
  `products_quantity` INT NOT NULL,
  PRIMARY KEY (`product_product_id`, `shop_order_shop_order_id`),
  INDEX `fk_order_has_products_shop_order1_idx` (`shop_order_shop_order_id` ASC),
  INDEX `fk_order_has_products_product1_idx` (`product_product_id` ASC),
  CONSTRAINT `fk_order_has_products_shop_order1`
    FOREIGN KEY (`shop_order_shop_order_id`)
    REFERENCES `pizza_shop`.`shop_order` (`shop_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_products_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `pizza_shop`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NOT NULL,
  `employee_surname` VARCHAR(100) NOT NULL,
  `employee_nif` VARCHAR(9) NULL,
  `employee_phone_number` VARCHAR(45) NULL,
  `employee_position` ENUM('Cook', 'Delivery staff') NOT NULL,
  `shop_shop_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_shop1_idx` (`shop_shop_id` ASC),
  CONSTRAINT `fk_employee_shop1`
    FOREIGN KEY (`shop_shop_id`)
    REFERENCES `pizza_shop`.`shop` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `pizza_shop`.`order_delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_shop`.`order_delivery` (
  `shop_order_shop_order_id` INT NOT NULL,
  `employee_employee_id` INT NOT NULL,
  `order_delivery_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`shop_order_shop_order_id`, `employee_employee_id`),
  INDEX `fk_order_delivery_shop_order1_idx` (`shop_order_shop_order_id` ASC),
  CONSTRAINT `fk_order_delivery_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `pizza_shop`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_delivery_shop_order1`
    FOREIGN KEY (`shop_order_shop_order_id`)
    REFERENCES `pizza_shop`.`shop_order` (`shop_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;