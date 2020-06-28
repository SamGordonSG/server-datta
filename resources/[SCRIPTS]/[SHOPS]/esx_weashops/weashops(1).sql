-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 04 juin 2020 à 02:47
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Structure de la table `weashops`
--

DROP TABLE IF EXISTS `weashops`;
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `weashops`
--

INSERT INTO `weashops` (`id`, `name`, `item`, `price`) VALUES
(1, 'BlackWeashop', 'WEAPON_FLASHLIGHT', 700),
(2, 'BlackWeashop', 'WEAPON_MACHETE', 1100),
(3, 'BlackWeashop', 'WEAPON_SWITCHBLADE', 1500),
(4, 'GunShop', 'WEAPON_BAT', 1000),
(5, 'BlackWeashop', 'WEAPON_MICROSMG', 17000),
(6, 'BlackWeashop', 'WEAPON_SAWNOFFSHOTGUN', 35000),
(7, 'BlackWeashop', 'WEAPON_ASSAULTRIFLE', 110000),
(8, 'BlackWeashop', 'WEAPON_SPECIALCARBINE', 165000),
(9, 'BlackWeashop', 'WEAPON_SNIPERRIFLE', 1240000),
(10, 'BlackWeashop', 'WEAPON_FIREWORK', 20000),
(11, 'BlackWeashop', 'WEAPON_GRENADE', 6500),
(12, 'BlackWeashop', 'WEAPON_BZGAS', 3500),
(13, 'GunShop', 'WEAPON_FIREEXTINGUISHER', 1000),
(14, 'GunShop', 'WEAPON_BALL', 50),
(15, 'BlackWeashop', 'WEAPON_SMOKEGRENADE', 1000),
(16, 'BlackWeashop', 'WEAPON_CARBINERIFLE', 120000),
(17, 'BlackWeashop', 'WEAPON_GUSENBERG', 180000),
(18, 'GunShop', 'WEAPON_KNUCKLE', 500),
(19, 'GunShop', 'WEAPON_FLASHLIGHT', 600),
(20, 'GunShop', 'WEAPON_KNIFE', 2500),
(21, 'GunShop', 'WEAPON_FLARE', 2500);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
