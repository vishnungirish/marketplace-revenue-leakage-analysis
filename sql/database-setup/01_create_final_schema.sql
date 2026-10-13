-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema marketplace_revenue_analysis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema marketplace_revenue_analysis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `marketplace_revenue_analysis` DEFAULT CHARACTER SET utf8 ;
USE `marketplace_revenue_analysis` ;

-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`products` (
  `product_id` INT NOT NULL,
  `category` VARCHAR(50) NULL,
  `sub_category` VARCHAR(50) NOT NULL,
  `brand` VARCHAR(50) NULL,
  `supplier_id` INT NOT NULL,
  `cost_price` DECIMAL(10,2) NOT NULL,
  `mrp` DECIMAL(10,2) NOT NULL,
  `weight_kg` DECIMAL(8,2) NULL,
  `launch_date` DATE NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`payment_fees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`payment_fees` (
  `payment_method` VARCHAR(30) NOT NULL,
  `fee_percentage` DECIMAL(5,2) NOT NULL,
  `settlement_days` INT NULL,
  PRIMARY KEY (`payment_method`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`orders` (
  `order_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `selling_price` DECIMAL(10,2) NOT NULL,
  `order_status` VARCHAR(20) NULL,
  `payment_method` VARCHAR(30) NOT NULL,
  `order_channel` VARCHAR(20) NULL,
  `warehouse_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_products_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_orders_payment_fees_idx` (`payment_method` ASC) VISIBLE,
  CONSTRAINT `fk_orders_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `marketplace_revenue_analysis`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`discounts` (
  `discount_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `discount_amount` DECIMAL(10,2) NOT NULL,
  `discount_type` VARCHAR(30) NOT NULL,
  `coupon_code` VARCHAR(30) NULL,
  `is_stackable` CHAR(1) NULL,
  PRIMARY KEY (`discount_id`),
  INDEX `fk_discounts_orders_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_discounts_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `marketplace_revenue_analysis`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`returns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`returns` (
  `return_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `return_flag` CHAR(1) NULL,
  `return_reason` VARCHAR(50) NULL,
  `return_initiated_date` DATE NULL,
  `refund_mode` VARCHAR(30) NULL,
  `refund_status` VARCHAR(20) NULL,
  `customer_fault_flag` CHAR(1) NULL,
  PRIMARY KEY (`return_id`),
  INDEX `fk_returns_orders_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_returns_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `marketplace_revenue_analysis`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marketplace_revenue_analysis`.`logistics_cost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marketplace_revenue_analysis`.`logistics_cost` (
  `logistics_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `shipping_cost` DECIMAL(10,2) NOT NULL,
  `reverse_shipping_cost` DECIMAL(10,2) NOT NULL,
  `delivery_days` INT,
  `delivery_status` VARCHAR(20) NULL,
  PRIMARY KEY (`logistics_id`),
  INDEX `fk_logistics_orders_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_logistics_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `marketplace_revenue_analysis`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
