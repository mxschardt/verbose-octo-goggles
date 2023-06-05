INSERT INTO `coffee`.`Addresses` (`Id`, `Town`, `Street`, `House`, `Entrance`, `Flat`) VALUES
(1, 'Санкт-Петербург', 'Невский проспект', '28', '2Б', '7'),
(2, 'Москва', 'Ленинградский проспект', '15', '3', '23'),
(3, 'Москва', 'Тверская улица', '9', '1', '12');

INSERT INTO `coffee`.`Customers` (`Id`, `Email`, `Phone`, `Name`) VALUES
(1, 'eugine@example.com', '1234567890', 'Женя'),
(2, 'vasya@example.com', '0987654321', 'Вася'),
(3, 'adnrey@example.com', '5555555555', 'Андрей');

INSERT INTO `coffee`.`Stores` (`Id`, `AddressId`, `OpeningTime`, `ClosingTime`) VALUES
(1, 1, '08:00:00', '20:00:00'),
(2, 2, '09:00:00', '21:00:00'),
(3, 3, '10:00:00', '22:00:00');

INSERT INTO `coffee`.`Products` (`Id`, `Title`, `Description`, `Price`, `ImageURI`) VALUES
(1, 'Эспрессо', 'Кофейный напиток, приготовленный под давлением горячей воды через молотый кофе.', 200, 'https://example.com/espresso.jpg'),
(2, 'Капучино', 'Кофейный напиток на основе эспрессо, который происходит из Италии и традиционно готовится с пеной из обезжиренного молока.', 250, 'https://example.com/cappuccino.jpg'),
(3, 'Латте', 'Кофейный напиток, приготовленный на основе эспрессо и парового молока.', 250, 'https://example.com/latte.jpg'),
(4, 'Мокко', 'Шоколадно-ванильный вариант латте.', 260, 'https://example.com/mocha.jpg'),
(5, 'Американо', 'Кофейный напиток, приготовленный путем разбавления эспрессо горячей водой.', 220, 'https://example.com/americano.jpg'),
(6, 'Макиато', 'Кофейный напиток на основе эспрессо с небольшим количеством молока, обычно взбитого.', 260, 'https://example.com/macchiato.jpg');

INSERT INTO `coffee`.`Employees` (`Id`, `FirstName`, `LastName`, `Title`, `Salary`, `StoreId`, `Phone`, `Email`) VALUES
(1, 'Михаил', 'Иванов', 'Бариста', 2500.00, 1, '1112223333', 'mike@example.com'),
(2, 'Лиза', 'Петрова', 'Менеджер', 5000.00, 1, '4445556666', 'lisa@example.com'),
(3, 'Иван', 'Сидоров', 'Бариста', 2500.00, 2, '7778889999', 'ivan@example.com'),
(4, 'Таня','Козлова', 'Менеджер', 5000.00, 2, '0001112222', 'tanya@example.com'),
(5, 'Денис', 'Смирнов', 'Бариста', 2500.00, 3, '3334445555', 'denis@example.com'),
(6, 'Варвара', 'Кузнецова', 'Менеджер', 5000.00, 3, '6667778888', 'varvara@example.com');

INSERT INTO `coffee`.`Orders` (`Id`, `StoreId`, `CustomerId`, `Status`) VALUES
(1, 1, 1, 'Завершен'),
(2, 1, 2, 'В процессе'),
(3, 2, 1, 'Завершен'),
(4, 2, 3, 'Завершен'),
(5, 3, 2, 'В процессе'),
(6, 3, 3, 'В процессе');

INSERT INTO `coffee`.`OrderProduct` (`OrderId`, `ProductsId`, `Quantity`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 2),
(3, 2,1),
(3, 3, 1),
(3, 5, 3),
(4, 1, 2),
(4, 4, 1),
(5, 3, 1),
(5, 5, 2),
(6, 1, 1),
(6, 6, 3);

INSERT INTO `coffee`.`Menu` (`ProductId`, `StoreId`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(1, 3),
(3, 3),
(5, 3),
(6, 3);
