-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2025 at 12:23 PM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_statement_sp` (IN `_userId` VARCHAR(50) CHARSET utf8, IN `_from` DATE, IN `_to` DATE)   BEGIN

set @tbalnce = 0;
set @expense = 0;
set @income = 0;

if(_from = '0000-00-00')THEN


CREATE TEMPORARY TABLE tb SELECT expense.data,
expense.user_id,if(type = 'Income',amount,0) Income,if(type
= 'Expense',amount,0) 'Expense' ,if(type = 'Income',
@tbalnce:=@tbalnce+amount ,@tbalnce:=@tbalnce-amount)
'Balance' FROM expense WHERE expense.user_id = _userId ORDER
by expense.data ASC;

SELECT * FROM tb

UNION

SELECT '','', SUM(Income),SUM(Expense) ,@tbalnce FROM tb;
 
ELSE


CREATE TEMPORARY TABLE tb SELECT expense.data,
expense.user_id,if(type = 'Income',amount,0) Income,if(type
= 'Expense',amount,0) 'Expense' ,if(type = 'Income',
@tbalnce:=@tbalnce+amount ,@tbalnce:=@tbalnce-amount)
'Balance' FROM expense WHERE expense.user_id = _userId AND
expense.data BETWEEN _from and _to   ORDER
by expense.data ASC;

SELECT * FROM tb

UNION

SELECT '','', SUM(Income),SUM(Expense) ,@tbalnce FROM tb;
 
 END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_expense_sp` (IN `id` INT, IN `_amount` FLOAT(11,2), IN `_type` VARCHAR(50) CHARSET utf8, IN `_desc` TEXT CHARSET utf8, IN `_userId` VARCHAR(50) CHARSET utf8)   BEGIN 

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

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_balance_fn` (`_userId` VARCHAR(250) CHARSET utf8) RETURNS FLOAT(11,2)  BEGIN

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
(1, 1000.00, 'Income', 'From Ajax', 'USR001', '2025-01-01 11:25:43'),
(2, 1000.00, 'Income', 'ajax', 'USR001', '2025-02-01 11:26:50'),
(3, 1000.00, 'Expense', 'fuad', 'USR001', '2025-03-01 11:27:41'),
(4, 1000.00, 'Expense', 'From Ajax', 'USR001', '2025-04-01 11:27:54'),
(5, 100.00, 'Income', 'From Ajax', 'USR001', '2025-05-01 11:32:13'),
(6, 100.00, 'Expense', 'From Ajax', 'USR001', '2025-05-01 11:32:25'),
(7, 900.00, 'Income', 'From Ajax', 'USR001', '2025-06-01 11:33:36'),
(8, 900.00, 'Expense', 'From Ajax', 'USR001', '2025-06-02 11:33:57'),
(9, 1000.00, 'Income', 'From Ajax', 'USR001', '2025-06-03 11:25:43'),
(10, 1000.00, 'Income', 'ajax', 'USR001', '2025-06-04 11:26:50'),
(11, 1000.00, 'Expense', 'fuad', 'USR001', '2025-06-05 11:27:41'),
(12, 1000.00, 'Expense', 'From Ajax', 'USR001', '2025-06-06 11:27:54'),
(13, 100.00, 'Income', 'From Ajax', 'USR001', '2025-06-07 11:32:13'),
(14, 100.00, 'Expense', 'From Ajax', 'USR001', '2025-06-08 11:32:25'),
(15, 900.00, 'Income', 'From Ajax', 'USR001', '2025-06-09 11:33:36'),
(16, 900.00, 'Expense', 'From Ajax', 'USR001', '2025-06-10 11:33:57'),
(17, 1000.00, 'Income', 'From Ajax', 'USR001', '2025-06-11 11:25:43'),
(18, 1000.00, 'Income', 'ajax', 'USR001', '2025-06-12 11:26:50'),
(19, 1000.00, 'Expense', 'fuad', 'USR001', '2025-06-13 11:27:41'),
(20, 1000.00, 'Expense', 'From Ajax', 'USR001', '2025-06-14 11:27:54'),
(21, 100.00, 'Income', 'From Ajax', 'USR001', '2025-06-15 11:32:13'),
(22, 100.00, 'Expense', 'From Ajax', 'USR001', '2025-06-16 11:32:25'),
(23, 900.00, 'Income', 'From Ajax', 'USR001', '2025-06-17 11:33:36'),
(24, 900.00, 'Expense', 'From Ajax', 'USR001', '2025-06-18 11:33:57'),
(25, 1000.00, 'Income', 'xasan', 'USR001', '2025-06-19 10:19:00'),
(26, 1000.00, 'Expense', 'Fuad Mohamed Nur', 'USR001', '2025-06-20 10:19:18');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
