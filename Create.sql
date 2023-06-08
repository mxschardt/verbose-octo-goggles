-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema coffee
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coffee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coffee` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `coffee` ;

-- -----------------------------------------------------
-- Table `coffee`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Addresses` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Town` VARCHAR(255) NOT NULL,
  `Street` VARCHAR(255) NOT NULL,
  `House` VARCHAR(63) NOT NULL,
  `Entrance` VARCHAR(63) NOT NULL,
  `Flat` VARCHAR(63) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Customers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(255) NOT NULL,
  `Phone` VARCHAR(255) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`, `Email`, `Phone`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Stores` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `AddressId` INT NOT NULL,
  `OpeningTime` TIME NULL DEFAULT NULL,
  `ClosingTime` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_Stores_AddressId` USING BTREE (`AddressId`) VISIBLE,
  CONSTRAINT `FK_Stores_Addresses_AddressId`
    FOREIGN KEY (`AddressId`)
    REFERENCES `coffee`.`Addresses` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Orders` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `StoreId` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `Status` VARCHAR(63) NOT NULL,
  PRIMARY KEY (`Id`, `StoreId`),
  INDEX `IX_Orders_CustomerId` USING BTREE (`CustomerId`) VISIBLE,
  INDEX `IX_Orders_StoreId` USING BTREE (`StoreId`) VISIBLE,
  CONSTRAINT `FK_Orders_Customers_CustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `coffee`.`Customers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_Orders_Stores_StoreId`
    FOREIGN KEY (`StoreId`)
    REFERENCES `coffee`.`Stores` (`Id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Delivery` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `OrderId` INT NOT NULL,
  `AddressId` INT NOT NULL,
  `DeliveryTime` TIMESTAMP NOT NULL,
  `Status` VARCHAR(63) NOT NULL,
  PRIMARY KEY (`Id`, `OrderId`),
  UNIQUE INDEX `OrderId_UNIQUE` (`OrderId` ASC) VISIBLE,
  INDEX `IX_Delivery_AddressId` USING BTREE (`AddressId`) VISIBLE,
  CONSTRAINT `fk_Delivery_1`
    FOREIGN KEY (`OrderId`)
    REFERENCES `coffee`.`Orders` (`Id`),
  CONSTRAINT `FK_Delivery_Addresses_AddressId`
    FOREIGN KEY (`AddressId`)
    REFERENCES `coffee`.`Addresses` (`Id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Employees` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Title` VARCHAR(63) NOT NULL,
  `Salary` DECIMAL(10,2) NOT NULL,
  `StoreId` INT NOT NULL,
  `Phone` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`, `StoreId`, `Phone`, `Email`),
  INDEX `IX_Employees_StoreId` USING BTREE (`StoreId`) VISIBLE,
  CONSTRAINT `FK_Employees_Stores_StoreId`
    FOREIGN KEY (`StoreId`)
    REFERENCES `coffee`.`Stores` (`Id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Products` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `Description` TEXT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  `ImageURI` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Menu` (
  `ProductId` INT NOT NULL,
  `StoreId` INT NOT NULL,
  PRIMARY KEY (`StoreId`, `ProductId`),
  INDEX `IX_ProductStore_StoreId` USING BTREE (`StoreId`) VISIBLE,
  INDEX `FK_ProductStore_Products_MenuId` (`ProductId` ASC) VISIBLE,
  CONSTRAINT `FK_ProductStore_Products_MenuId`
    FOREIGN KEY (`ProductId`)
    REFERENCES `coffee`.`Products` (`Id`)
    ON DELETE CASCADE,
  CONSTRAINT `FK_ProductStore_Stores_StoreId`
    FOREIGN KEY (`StoreId`)
    REFERENCES `coffee`.`Stores` (`Id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Orderproduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`OrderProduct` (
  `OrderId` INT NOT NULL,
  `ProductsId` INT NOT NULL,
  `Quantity` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`OrderId`, `ProductsId`),
  INDEX `IX_OrderProduct_ProductsId` USING BTREE (`ProductsId`) VISIBLE,
  INDEX `FK_OrderProduct_Orders_OrderId` (`OrderId` ASC) VISIBLE,
  CONSTRAINT `FK_OrderProduct_Orders_OrderId`
    FOREIGN KEY (`OrderId`)
    REFERENCES `coffee`.`Orders` (`Id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_OrderProduct_Products_ProductsId`
    FOREIGN KEY (`ProductsId`)
    REFERENCES `coffee`.`Products` (`Id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- function GetOrderTotal
-- -----------------------------------------------------
DELIMITER $$
CREATE FUNCTION `GetOrderTotal`(order_id INT) RETURNS INT
READS SQL DATA
BEGIN
  DECLARE total_price INT;
  
  SELECT SUM(`Quantity` * Price) INTO total_price
  FROM `coffee`.`OrderProduct`
  JOIN `coffee`.`Products` ON `coffee`.`OrderProduct`.`ProductsId` = `Products`.`Id`
  WHERE `coffee`.`OrderProduct`.`OrderId` = order_id;
  
  RETURN total_price;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- trigger CheckDeliveryMinAmount
-- -----------------------------------------------------
DELIMITER $$
CREATE TRIGGER `coffee`.`CheckDeliveryMinAmount`
BEFORE INSERT ON `coffee`.`Delivery`
FOR EACH ROW
BEGIN
    IF GetOrderTotal(NEW.`OrderId`) < 400 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'It is not possible to arrange delivery for this order. The minimum order amount for delivery is 400 rubles.';
    END IF;
END$$
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
