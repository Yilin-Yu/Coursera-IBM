-- Task 1 - Create a database.
CREATE DATABASE  IF NOT EXISTS `sales`;
USE `sales`;

-- Task 2 - Design a table named sales_data.
DROP TABLE IF EXISTS `sales_data`;
CREATE TABLE `sales_data` (
  `product_id` int NOT NULL,
  `customer_id` int,
  `price` int,
  `quantity` int,
  `timestamp` datetime
) ;

-- LOCK TABLES `sales_data` WRITE;
-- /*!40000 ALTER TABLE `actor` DISABLE KEYS */;
-- INSERT INTO `sales_data` VALUES (1,'PENELOPE','GUINESS','2006-02-15 11:34:33'),(2,'NICK','WAHLBERG','2006-02-15 11:34:33')(200,'THORA','TEMPLE','2006-02-15 11:34:33');
-- /*!40000 ALTER TABLE `actor` ENABLE KEYS */;
-- UNLOCK TABLES;

-- Task 4 - List the tables in the database sales
show tables;

-- Task 5. Write a query to find out the count of records in the tables sales_data.
SELECT COUNT(*) FROM `sales_data`;

-- Task 6 - Create an index named ts on the timestamp field.
-- Task 7 - List indexes
CREATE INDEX ts on sales_data(timestamp);
SHOW INDEX FROM sales_data;

-- Task 8 - Write a bash script to export data.
/* mysqldump -u root -paljfadhfjkd sales sales_data > salesdata.sql*/
