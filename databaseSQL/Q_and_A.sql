-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 30, 2021 at 06:41 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Q_and_A`
--

-- --------------------------------------------------------

--
-- Table structure for table `Administrators`
--

DROP TABLE IF EXISTS `Administrators`;
CREATE TABLE `Administrators` (
  `id` int(11) NOT NULL,
  `firstname` varchar(256) NOT NULL,
  `lastname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(2048) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`id`, `name`, `created`) VALUES
(1, 'Financial Preparedness\r\n', '2021-07-30 01:49:00'),
(2, 'Supplies\r\n', '2021-07-30 01:49:00'),
(3, 'Documents\r\n', '2021-07-30 01:50:50'),
(4, 'Information Seeking\r\n', '2021-07-30 01:50:50'),
(5, 'Drills for All Respondents\r\n', '2021-07-30 01:51:25'),
(6, 'Risk Identification\r\n', '2021-07-30 01:51:25'),
(7, 'Efficacy - Response\r\n', '2021-07-30 01:52:11'),
(8, 'Efficacy - Self Confidence\r\n', '2021-07-30 01:52:11'),
(9, 'Stages of Preparedness\r\n', '2021-07-30 01:52:53'),
(10, 'Disaster Experience\r\n', '2021-07-30 01:52:53'),
(11, 'Flood Section\r\n', '2021-07-30 01:53:47'),
(12, 'Hurricane Section\r\n', '2021-07-30 01:53:47'),
(13, 'Earthquake Section\r\n', '2021-07-30 01:54:45'),
(14, 'Demographics Section\r\n', '2021-07-30 01:54:45');

-- --------------------------------------------------------

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
CREATE TABLE `Questions` (
  `id` int(11) NOT NULL,
  `variable_name` varchar(256) NOT NULL,
  `question_text` text NOT NULL,
  `category_id` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Questions`
--

INSERT INTO `Questions` (`id`, `variable_name`, `question_text`, `category_id`, `created`, `modified`) VALUES
(1, 'a1', 'In the past six months, have you read, seen, or heard any information about how to get better prepared for a disaster?\r\n', 1, '2021-07-29 19:35:38', '2021-07-30 00:35:57'),
(2, 'a1a_enough_food_water', 'Read/saw/heard information on how to have enough food and water?\r\n', 1, '2021-07-29 19:35:38', '2021-07-30 00:35:57');

-- --------------------------------------------------------

--
-- Table structure for table `Responses`
--

DROP TABLE IF EXISTS `Responses`;
CREATE TABLE `Responses` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `question_response` text DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Surveys`
--

DROP TABLE IF EXISTS `Surveys`;
CREATE TABLE `Surveys` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `survey_category_id` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Survey_Categories`
--

DROP TABLE IF EXISTS `Survey_Categories`;
CREATE TABLE `Survey_Categories` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Survey_Categories`
--

INSERT INTO `Survey_Categories` (`id`, `name`, `created`, `modified`) VALUES
(1, 'national household survey', '2021-07-29 22:40:29', '2021-07-30 03:40:29');

-- --------------------------------------------------------

--
-- Table structure for table `Survey_Questions`
--

DROP TABLE IF EXISTS `Survey_Questions`;
CREATE TABLE `Survey_Questions` (
  `survey_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(256) NOT NULL,
  `lastname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(2048) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modfied` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Questions`
--
ALTER TABLE `Questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Responses`
--
ALTER TABLE `Responses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Surveys`
--
ALTER TABLE `Surveys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Survey_Categories`
--
ALTER TABLE `Survey_Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Survey_Questions`
--
ALTER TABLE `Survey_Questions`
  ADD PRIMARY KEY (`survey_id`,`question_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Questions`
--
ALTER TABLE `Questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Responses`
--
ALTER TABLE `Responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Surveys`
--
ALTER TABLE `Surveys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Survey_Categories`
--
ALTER TABLE `Survey_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
