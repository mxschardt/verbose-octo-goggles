-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
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
  `Entrance` VARCHAR(63) NULL DEFAULT NULL,
  `Flat` VARCHAR(63) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coffee`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffee`.`Customers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(63) NOT NULL,
  `Phone` VARCHAR(63) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`, `Email`, `Phone`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
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
AUTO_INCREMENT = 0
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
AUTO_INCREMENT = 0
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
AUTO_INCREMENT = 0
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
AUTO_INCREMENT = 0
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
-- Table `coffee`.`OrderProduct`
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

USE `coffee` ;

-- -----------------------------------------------------
-- procedure CreateCustomer
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateCustomer`(
    IN Name VARCHAR(63),
	IN Phone VARCHAR(63),
	IN Email VARCHAR(255)
)
BEGIN
	INSERT INTO Customers(Email, Phone, Name)
    VALUES (Email, Phone, Name);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateEmployee
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateEmployee`(
	IN FirstName VARCHAR(255),
    IN LastName VARCHAR(255),
    IN Title VARCHAR(63),
    IN Salary DECIMAL(10,2),
    IN StoreId INT,
	IN Phone VARCHAR(255),
	IN Email VARCHAR(255)
)
BEGIN
	INSERT INTO Employees(FirstName, LastName, Title, Salary, StoreId, Phone, Email)
    VALUES (FirstName, LastName, Title, Salary, StoreId, Phone, Email);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateOrder
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateOrder`(
  IN `in_StoreId` INT,
  IN `in_CustomerId` INT,
  IN `in_Products` VARCHAR(255)
)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE product_id, product_quantity INT;
	DECLARE product_cursor CURSOR FOR
	  SELECT CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(in_Products, ',', n.digit+1), ',', -1) AS UNSIGNED) AS product,
			 SUBSTRING_INDEX(SUBSTRING_INDEX(in_Products, ':', n.digit+1), ':', -1) AS quantity
	  FROM
	  (SELECT 0 AS digit UNION ALL
	   SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
	   SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
	   SELECT 9) n
	  WHERE n.digit <= LENGTH(in_Products) - LENGTH(REPLACE(in_Products, ',', ''));

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  INSERT INTO `coffee`.`Orders` (`StoreId`, `CustomerId`, `Status`) 
  VALUES (in_StoreId, in_CustomerId, 'Pending');

  SET @order_id = LAST_INSERT_ID();

  OPEN product_cursor;

  product_loop: LOOP
    FETCH product_cursor INTO product_id, product_quantity;

    IF done THEN
      LEAVE product_loop;
    END IF;

    INSERT INTO `coffee`.`OrderProduct` (`OrderId`, `ProductsId`, `Quantity`)
    VALUES (@order_id, product_id, product_quantity);
  END LOOP;

  CLOSE product_cursor;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateProduct
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateProduct`(
	Title VARCHAR(255),
	Description TEXT, 
	Price DECIMAL(10,2),
	ImageURI VARCHAR(255)
)
BEGIN
	INSERT INTO `coffee`.`Products`(Title, Description, Price, ImageURI)
    VALUES (Title, Description, Price, ImageURI);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateStore
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `CreateStore`(
    IN `Town` VARCHAR(255),
    IN `Street` VARCHAR(255),
    IN `House` VARCHAR(63),
    IN `Entrance` VARCHAR(63),
    IN `Flat` VARCHAR(63),
    IN `OpeningTime` TIME,
    IN `ClosingTime` TIME
)
BEGIN
    DECLARE v_AddressID INT;

    SELECT Id INTO v_AddressID
    FROM coffee.Addresses a
    WHERE a.Town = Town AND a.Street = Street AND a.House = House AND a.Entrance = Entrance AND a.Flat = Flat
    LIMIT 1;

    -- Если адрес не существует, вставляем новый адрес
    IF v_AddressID IS NULL THEN
        INSERT INTO `coffee`.`Addresses`(`Town`, `Street`, `House`, `Entrance`, `Flat`)
        VALUES (Town, Street, House, Entrance, Flat);

        SET v_AddressID = LAST_INSERT_ID();
    END IF;

    -- Вставка данных о магазине с использованием ID адреса
    INSERT INTO `coffee`.`Stores`(AddressId, OpeningTime, ClosingTime)
    VALUES (v_AddressID, OpeningTime, ClosingTime);

    SELECT v_AddressID AS AddressID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function GetOrderTotal
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` FUNCTION `GetOrderTotal`(order_id INT) RETURNS int
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
-- procedure UpdateEmployee
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `UpdateEmployee`(
    IN p_Id INT,
    IN p_Title VARCHAR(63),
    IN p_Salary DECIMAL(10,2)
)
BEGIN
    -- Обновление позиции сотрудника, если передано значение
    IF p_Title IS NOT NULL THEN
        UPDATE Employees
        SET Title = p_Title
        WHERE Id = p_Id;
    
    -- Обновление зарплаты сотрудника, если передано значение
    ELSEIF p_Salary IS NOT NULL THEN
        UPDATE Employees
        SET Salary = p_Salary
        WHERE Id = p_Id;
    
    ELSE 
		UPDATE Employees
		SET Title = p_Title, Salary = p_Salary
		WHERE Id = p_Id;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateOrderStatus
-- -----------------------------------------------------

DELIMITER $$
USE `coffee`$$
CREATE DEFINER=`root`@`%` PROCEDURE `UpdateOrderStatus`(
    IN p_Id INT,
    IN p_Status VARCHAR(63)
)
BEGIN
    -- Обновление статуса заказа
    UPDATE Orders o
    SET o.`Status` = p_Status
    WHERE Id = p_Id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `coffee`;

DELIMITER $$
USE `coffee`$$
CREATE
DEFINER=`root`@`%`
TRIGGER `coffee`.`CheckDeliveryMinAmount`
BEFORE INSERT ON `coffee`.`Delivery`
FOR EACH ROW
BEGIN
    IF GetOrderTotal(NEW.`OrderId`) < 400 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'It is not possible to arrange delivery for this order. The minimum order amount for delivery is 400 rubles.';
    END IF;
END$$


DELIMITER ;
