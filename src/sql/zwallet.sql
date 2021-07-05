-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2021 at 08:20 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zwallet`
--

-- --------------------------------------------------------

--
-- Table structure for table `balances`
--

CREATE TABLE `balances` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balance_nominal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `balances`
--

INSERT INTO `balances` (`id`, `user_id`, `balance_nominal`) VALUES
(1, 1, 565449),
(2, 2, 497347),
(3, 3, 248000),
(4, 4, 35870),
(5, 5, 593334);

-- --------------------------------------------------------

--
-- Table structure for table `blacklist_token`
--

CREATE TABLE `blacklist_token` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expire` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `content` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `created_at`, `content`) VALUES
(1, 1, '2021-06-14 12:17:02', '1#in#Top Up with instant method#1,000,000'),
(2, 1, '2021-06-14 12:17:20', '2#in#Top Up with instant method#20,000'),
(3, 1, '2021-06-14 13:05:34', '2#out#Transfer to Customer Twoo#348000'),
(4, 1, '2021-06-14 13:05:37', '2#out#Transfer to Customer Twoo#348000'),
(5, 1, '2021-06-14 15:03:01', '3#out#Transfer to Customer Three#248000'),
(6, 1, '2021-06-14 15:03:03', '3#out#Transfer to Customer Three#248000'),
(7, 1, '2021-06-14 15:03:27', '8#in#Top Up with instant method#400,000'),
(8, 1, '2021-06-14 15:04:03', '4#out#Transfer to Customer Four#35870'),
(9, 1, '2021-06-14 15:04:04', '4#out#Transfer to Customer Four#35870'),
(10, 1, '2021-06-14 15:04:34', '5#out#Transfer to Customer Five#125345'),
(11, 1, '2021-06-14 15:04:36', '5#out#Transfer to Customer Five#125345'),
(12, 1, '2021-06-14 15:05:00', '0#out#Transfer to Customer Five#236533'),
(13, 1, '2021-06-14 15:05:02', '0#out#Transfer to Customer Five#236533'),
(14, 2, '2021-06-14 18:23:17', '0#out#Transfer to Customer Onee#123333'),
(15, 2, '2021-06-14 18:23:19', '0#out#Transfer to Customer Onee#123333'),
(16, 1, '2021-06-15 01:06:34', '17#in#Top Up with instant method#20,000'),
(17, 1, '2021-06-15 01:26:03', '0#out#Transfer to Customer Twoo#56800'),
(18, 1, '2021-06-15 01:26:12', '0#out#Transfer to Customer Twoo#56800'),
(19, 1, '2021-06-15 02:28:43', '0#out#Transfer to Customer Five#125800'),
(20, 1, '2021-06-15 02:28:45', '0#out#Transfer to Customer Five#125800'),
(21, 1, '2021-06-15 02:28:45', '0#out#Transfer to Customer Five#125800'),
(22, 1, '2021-06-15 02:34:37', '36#in#Top Up with instant method#500,000'),
(23, 1, '2021-06-30 12:50:45', '0#out#Transfer to Customer Twoo#20000'),
(24, 1, '2021-06-30 12:50:45', 'undefined#out#Transfer to Customer Twoo#20000'),
(25, 1, '2021-06-30 12:51:05', '0#out#Transfer to Customer Twoo#20000'),
(26, 1, '2021-06-30 12:51:05', '0#out#Transfer to Customer Twoo#20000'),
(27, 1, '2021-06-30 12:51:20', '39#in#Top Up with instant method#50,000');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `periode` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `periode`, `avatar`, `price`) VALUES
(1, 'Spotify', 'monthly', '/images/users/usersProfile-1623427566222.png', 50000),
(2, 'Netflix', 'monthly', '/images/users/usersProfile-1623427598752.png', 190000),
(3, 'Youtube', 'monthly', '/images/users/usersProfile-1623427623518.png', 30000),
(4, 'Disney Hotstar', 'annually', '/images/users/usersProfile-1623427668465.jpeg', 450000);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `executor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `product_id`, `status`, `executor_id`) VALUES
(1, 1, 'active', 1);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `executor_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `nominal` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `executor_id`, `sender_id`, `receiver_id`, `nominal`, `type`, `note`, `created_at`) VALUES
(1, 1, 1, 1, 1000000, 'topup', NULL, '2021-04-17 12:17:02'),
(2, 1, 1, 1, 20000, 'topup', NULL, '2021-05-29 12:17:20'),
(3, 1, 1, 2, 348000, 'credit', 'buat jajan yaaa', '2021-05-20 13:05:34'),
(4, 2, 1, 2, 348000, 'debit', 'buat jajan yaaa', '2021-05-20 13:05:34'),
(5, 1, 1, 1, 50000, 'subscription', NULL, '2021-04-20 13:06:57'),
(6, 1, 1, 3, 248000, 'credit', 'buat beli siomay', '2021-06-14 15:03:01'),
(7, 3, 1, 3, 248000, 'debit', 'buat beli siomay', '2021-06-14 15:03:01'),
(8, 1, 1, 1, 400000, 'topup', NULL, '2021-06-14 15:03:27'),
(9, 1, 1, 4, 35870, 'credit', 'utang beli obat nyamuk', '2021-05-24 15:04:03'),
(10, 4, 1, 4, 35870, 'debit', 'utang beli obat nyamuk', '2021-05-24 15:04:03'),
(11, 1, 1, 5, 125345, 'credit', 'ehe', '2021-06-14 15:04:34'),
(12, 5, 1, 5, 125345, 'debit', 'ehe', '2021-06-14 15:04:34'),
(13, 1, 1, 5, 236533, 'credit', 'ehe ehe', '2021-06-14 15:05:00'),
(14, 5, 1, 5, 236533, 'debit', 'ehe ehe', '2021-06-14 15:05:00'),
(15, 2, 2, 1, 123333, 'credit', 'asd', '2021-06-14 18:23:17'),
(16, 1, 2, 1, 123333, 'debit', 'asd', '2021-06-14 18:23:17'),
(17, 1, 1, 1, 20000, 'topup', NULL, '2021-06-15 01:06:34'),
(18, 1, 1, 5, 56488, 'credit', '', '2021-06-15 01:19:31'),
(19, 5, 1, 5, 56488, 'debit', '', '2021-06-15 01:19:31'),
(26, 1, 1, 5, 24580, 'credit', 'aaa', '2021-06-15 01:27:10'),
(27, 5, 1, 5, 24580, 'debit', 'aaa', '2021-06-15 01:27:10'),
(32, 1, 1, 2, 56480, 'credit', '', '2021-06-15 02:07:47'),
(33, 2, 1, 2, 56480, 'debit', '', '2021-06-15 02:07:47'),
(34, 1, 1, 5, 125800, 'credit', 'asdasd', '2021-06-15 02:28:42'),
(35, 5, 1, 5, 125800, 'debit', 'asdasd', '2021-06-15 02:28:42'),
(36, 1, 1, 1, 500000, 'topup', NULL, '2021-06-15 02:34:37'),
(37, 1, 1, 2, 20000, 'credit', '', '2021-06-30 12:50:45'),
(38, 2, 1, 2, 20000, 'debit', '', '2021-06-30 12:50:45'),
(39, 1, 1, 1, 50000, 'topup', NULL, '2021-06-30 12:51:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `virtual_account` varchar(16) NOT NULL,
  `password` varchar(255) NOT NULL,
  `pin` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `status` enum('verified','not-verified') NOT NULL DEFAULT 'not-verified',
  `notification` enum('on','off') NOT NULL DEFAULT 'on'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `virtual_account`, `password`, `pin`, `username`, `phone`, `avatar`, `otp`, `status`, `notification`) VALUES
(1, 'cust1@example.com', '7500175781872561', '$2b$10$0vTPIMJTHanXS7l0tm7uqOKxHVI1DaknNrSSJRXrQgKP7UoND5xhm', '$2b$10$nV.Ny5uW/9fVjzHFap4kceNtIx9C.TWziHWhafyDd/g5J3KmEjrwq', 'Customer Onee', '88855550000', '/images/users/usersProfile-1623696473124.jpg', 'snu6oq', 'verified', 'on'),
(2, 'cust2@example.com', '4994856186608176', '$2b$10$FNTkGJtel97QB11BwOAfDuef1l/CGT5HiqU1Jy8Vape1bGu6/28P6', '$2b$10$eEpUUCyM0o1Z7KNWR7SAN.MYYaZZORc1JKQD.9bH0lT7pLld4mV1y', 'Customer Twoo', '88855552222', '/images/users/usersProfile-1623675777684.jpg', '30lsnb', 'verified', 'on'),
(3, 'cust3@example.com', '9354634265034186', '$2b$10$UZo1oI5sbtjO/wyBvlHhGeu/2tnrVBg35O1NfYmbcpWTjQX7VOf6G', '$2b$10$3tHP83viznMMkQ3wVWgg7eYCmWYN19yfpONCcKm2gUBEKTzSqZahi', 'Customer Three', '88855553333', '/images/users/usersProfile-1623675816485.jpg', '1nttuc', 'verified', 'on'),
(4, 'cust4@example.com', '8826223731135311', '$2b$10$wSrFVzeOM42FASrVSUNgHeJrceXtabmZ6kaTewUvKQEqHxQoZgViW', '$2b$10$vi7X.HaR4ms76I0OFLVs5ujQ2FG/lAt8E3Ry/YnAJ7XCzEasP79t.', 'Customer Four', '88855554444', '/images/users/usersProfile-1623675843316.jpg', 'c2top2', 'verified', 'on'),
(5, 'cust5@example.com', '7683349475473365', '$2b$10$dZi0Bx.5OQlLSBGDm/bfXOCWoN/XHAMmLO7teupEn1KMRZZTk.tly', '$2b$10$ODfWWCCCQwBlylAc6DPNP.CLXQAnlagSMhmarbY0.k3NYtYXEf4Ua', 'Customer Five', '88855555555', '/images/users/usersProfile-1623675869768.jpg', '5llwuu', 'verified', 'on'),
(6, 'cust6@example.com', '1155736263020595', '$2b$10$gY.jkKCWLqiRxwyhnYbede.J./kJmHEQvj2dYdn.EnW1ObKQs1gfC', '$2b$10$tmAIheoG8TcyC4DompzduOsW7H2pKi2QL8unQHZVyGoBa5bdJr5Na', 'Customer Sixx', '8885555777', '/images/users/usersProfile-1624852111745.jpg', '7zexli', 'verified', 'on');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balances`
--
ALTER TABLE `balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`user_id`);

--
-- Indexes for table `blacklist_token`
--
ALTER TABLE `blacklist_token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_notif` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `executor_id` (`executor_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `virtual_account` (`virtual_account`),
  ADD UNIQUE KEY `otp` (`otp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `balances`
--
ALTER TABLE `balances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `blacklist_token`
--
ALTER TABLE `blacklist_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `balances`
--
ALTER TABLE `balances`
  ADD CONSTRAINT `users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `user_notif` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`executor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `sender_id` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `refresh_token` ON SCHEDULE EVERY 3 HOUR STARTS '2021-06-10 10:36:17' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'refresh token in token blacklist' DO DELETE FROM `zwallet`.`blacklist_token` WHERE `expire` < NOW()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
