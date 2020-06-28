-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 17 aug 2019 om 12:12
-- Serverversie: 5.7.24
-- PHP-versie: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `essentialmode`
--

-- --------------------------------------------------------

--
-- Table structure for table `owned_vehicles`
--

DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE `owned_vehicles` (
  `owner` varchar(50) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Etat de la voiture',
  `garagesociety` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage du Circuit',
  `garagedocks` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage des Dock',
  `garageranch` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage du Ranch',
  `garagesandy` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage de Sandy',
  `garagedepaleto` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage de Paleto',
  `parkingcentral` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Parking Central',
  `type` varchar(10) NOT NULL DEFAULT 'car',
  `job` varchar(50),
  `stored` tinyint(1) NOT NULL DEFAULT '0',
  `modelname` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

  ALTER TABLE `owned_vehicles` ADD `security` int(1) NOT NULL DEFAULT '0' COMMENT 'Alarm system state' AFTER `owner`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
