-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2025 at 03:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_expense_sp` (IN `_id` INT, IN `_amount` FLOAT(11,2), IN `_type` VARCHAR(50) CHARSET utf8, IN `_desc` TEXT CHARSET utf8, IN `_userId` VARCHAR(50) CHARSET utf8)   BEGIN 

if EXISTS(SELECT * FROM expense WHERE expense.id = _id)THEN

UPDATE expense SET expense.amount = _amount, expense.type = _type,
expense.description = _desc where  expense.id = _id;

SELECT 'Updated' as Message;

ELSE

if(_type = 'Expense')THEN

if((SELECT get_user_balance_fn(_userId) < _amount ))THEN 

SELECT 'Deny' as Message;


ELSE

INSERT into 
expense(expense.amount,expense.type,expense.description,expense.user_id)
VALUES(_amount,_type,_desc,_userId);

SELECT 'Registered' as Message;

END if;

ELSE

INSERT into 
expense(expense.amount,expense.type,expense.description,expense.user_id)
VALUES(_amount,_type,_desc,_userId);

SELECT 'Registered' as Message;

END if;

END if;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_balance_fn` (`_userId` VARCHAR(250)) RETURNS FLOAT(11,2)  BEGIN

SET @balance = 0.00;

SET @income = (SELECT sum(expense.amount) FROM 
expense WHERE expense.type = 'Income' AND
expense.user_id = _userId);

SET @expense = (SELECT sum(expense.amount) FROM 
expense WHERE expense.type = 'Expense' AND
expense.user_id = _userId);

SET @balance = (ifnull( @income,0) -
ifnull( @expense,0));

RETURN @balance;
                
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `amount` float(11,2) NOT NULL,
  `type` varchar(15) NOT NULL,
  `description` text NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `amount`, `type`, `description`, `user_id`, `data`) VALUES
(1, 20.00, 'Expense', 'Waa Qarash', 'USR001', '2025-05-29 16:24:00'),
(2, 60.00, 'Income', 'Website Host', 'USR001', '2025-05-29 16:35:22'),
(3, 50.00, 'Expense', 'Cashir', 'USR001', '2025-05-29 16:42:31'),
(4, 1000.00, 'Income', 'From Ajax', 'USR001', '2025-05-31 18:42:17'),
(5, 990.00, 'Expense', 'From Ajax', 'USR001', '2025-05-31 18:44:01'),
(6, 1000.00, 'Income', 'ridwaan', 'USR001', '2025-05-31 19:41:43'),
(7, 1090.00, 'Expense', 'From Ajax', 'USR001', '2025-05-31 19:42:16'),
(8, 91.00, 'Income', 'ridwaan', 'USR001', '2025-05-31 19:48:10'),
(9, 90.00, 'Income', 'Fuad MohamecNur Warsame Inikaay Warsame Wehliye', 'USR001', '2025-05-31 19:58:00'),
(10, 91.00, 'Expense', 'From Ajax', 'USR001', '2025-05-31 20:18:33'),
(11, 1.00, 'Income', 'ridwaan', 'USR001', '2025-05-31 20:19:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
