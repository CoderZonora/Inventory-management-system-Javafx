-- SQLite-Compatible SQL Dump

-- Remove MySQL-specific directives
-- SQLite doesn't support SQL_MODE, time zones, character set settings, or transaction settings like START TRANSACTION

-- Remove MySQL character set and collation configurations
-- This makes the script compatible with SQLite

-- Database: `inventory_management_system`
-- --------------------------------------------------------

-- Table structure for table `month_names`
CREATE TABLE `month_names` (
    `month_number` INTEGER PRIMARY KEY,
    `month_name` TEXT NOT NULL UNIQUE
);

-- Insert month names and their corresponding numbers
INSERT INTO `month_names` (`month_number`, `month_name`) VALUES
(1, 'JANUARY'),
(2, 'FEBRUARY'),
(3, 'MARCH'),
(4, 'APRIL'),
(5, 'MAY'),
(6, 'JUNE'),
(7, 'JULY'),
(8, 'AUGUST'),
(9, 'SEPTEMBER'),
(10, 'OCTOBER'),
(11, 'NOVEMBER'),
(12, 'DECEMBER');


-- Table structure for table `billing`
CREATE TABLE `billing` (
    `item_number` TEXT NOT NULL,
    `quantity` INTEGER NOT NULL,
    `price` REAL NOT NULL,
    `total_amount` REAL NOT NULL,
    `id` INTEGER PRIMARY KEY AUTOINCREMENT
);

-- Table structure for table `customers`
CREATE TABLE `customers` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `Name` TEXT NOT NULL,
    `PhoneNumber` TEXT NOT NULL UNIQUE
);

-- Dumping data for table `customers`
INSERT INTO `customers` (`id`, `Name`, `PhoneNumber`) VALUES
(1, 'Aman', '7070564601'),
(2, 'Anikaith', '7070564603'),
(3, 'Abhishek', '9818977363');

-- Table structure for table `employees`
CREATE TABLE `employees` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `Name` TEXT NOT NULL,
    `PhoneNumber` TEXT NOT NULL UNIQUE
);

-- Dumping data for table `employees`
INSERT INTO `employees` (`id`, `Name`, `PhoneNumber`) VALUES
(1, 'Lorem', '9293323232'),
(2, 'Ipsum', '9039203203'),
(3, 'Dolor', '9818977363');

-- Table structure for table `inv_seq`
CREATE TABLE `inv_seq` (
    `next_not_cached_value` INTEGER NOT NULL,
    `minimum_value` INTEGER NOT NULL,
    `maximum_value` INTEGER NOT NULL,
    `start_value` INTEGER NOT NULL,
    `increment` INTEGER NOT NULL,
    `cache_size` INTEGER NOT NULL,
    `cycle_option` INTEGER NOT NULL,
    `cycle_count` INTEGER NOT NULL
);

-- Dumping data for table `inv_seq`
INSERT INTO `inv_seq` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
(3001, 1, 99999999999999, 1, 1, 1000, 0, 0);

-- Table structure for table `products`
CREATE TABLE `products` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `item_number` TEXT NOT NULL,
    `item_group` TEXT NOT NULL,
    `quantity` INTEGER NOT NULL,
    `price` REAL NOT NULL
);

-- Dumping data for table `products`
INSERT INTO `products` (`id`, `item_number`, `item_group`, `quantity`, `price`) VALUES
(1, 'AX123456', 'Shirts', 60, 700.00),
(2, 'BX123456', 'Shirts', 100, 300.00),
(3, 'ZX123456', 'Shirts', 40, 800.00);

-- Table structure for table `purchase`
CREATE TABLE `purchase` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `invoice` TEXT NOT NULL,
    `shop_and_address` TEXT NOT NULL,
    `total_items` INTEGER NOT NULL,
    `total_amount` REAL NOT NULL,
    `date_of_purchase` TEXT NOT NULL
);

-- Dumping data for table `purchase`
INSERT INTO `purchase` (`id`, `invoice`, `shop_and_address`, `total_items`, `total_amount`, `date_of_purchase`) VALUES
(1, '123XB123', 'AB, Yamuna Nagar,Delhi', 50, 200000.00, '2023-05-30'),
(2, 'babab', 'abbaban', 100, 100000.00, '2023-05-29');

-- Table structure for table `sales`
CREATE TABLE `sales` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `inv_num` TEXT NOT NULL,
    `cust_id` INTEGER NOT NULL,
    `price` REAL NOT NULL,
    `quantity` INTEGER NOT NULL,
    `total_amount` REAL NOT NULL,
    `date` TEXT NOT NULL,
    `item_number` TEXT NOT NULL,
    FOREIGN KEY (`cust_id`) REFERENCES `customers` (`id`)
);

-- Dumping data for table `sales`
INSERT INTO `sales` (`id`, `inv_num`, `cust_id`, `price`, `quantity`, `total_amount`, `date`, `item_number`) VALUES
(28, 'INV-1', 23, 700.00, 4, 2800.00, '2023-06-03', 'AX123456'),
(29, 'INV-1', 23, 800.00, 2, 1600.00, '2023-06-03', 'ZX123456'),
(30, 'INV-2', 24, 700.00, 4, 2800.00, '2023-06-03', 'AX123456'),
(31, 'INV-3', 25, 900.00, 2, 1800.00, '2023-06-03', 'AX123456'),
(32, 'INV-3', 25, 800.00, 1, 800.00, '2023-06-03', 'ZX123456'),
(33, 'INV-4', 23, 700.00, 2, 1400.00, '2023-06-04', 'AX123456'),
(34, 'INV-5', 23, 300.00, 2, 600.00, '2023-06-04', 'BX123456'),
(35, 'INV-6', 23, 700.00, 3, 2100.00, '2024-11-05', 'AX123456'),
(36, 'INV-7', 24, 800.00, 1, 800.00, '2024-11-05', 'ZX123456');

-- Table structure for table `users`
CREATE TABLE `users` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `username` TEXT NOT NULL,
    `password` TEXT NOT NULL
);

-- Dumping data for table `users`
INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

