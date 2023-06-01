CREATE OR REPLACE VIEW `coffee`.`SalesStatistics` AS
SELECT
  p.Title AS `Product`,
  SUM(op.Quantity) AS `Total Sales`,
  COUNT(DISTINCT o.Id) AS `Total Orders`
FROM
  `coffee`.`Products` p
  JOIN `coffee`.`OrderProduct` op ON p.Id = op.ProductsId
  JOIN `coffee`.`Orders` o ON op.OrderId = o.Id
GROUP BY
  p.Id
ORDER BY
  `Total Sales` DESC;