/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.1.2-MariaDB, for osx10.20 (arm64)
--
-- Host: localhost    Database: PokemonVGC
-- ------------------------------------------------------
-- Server version	12.1.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `ability`
--

DROP TABLE IF EXISTS `ability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ability` (
  `name` varchar(200) NOT NULL,
  `effect` text DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `idx_ability_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ability`
--

LOCK TABLES `ability` WRITE;
/*!40000 ALTER TABLE `ability` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ability` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `bst`
--

DROP TABLE IF EXISTS `bst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bst` (
  `pokemon_sid` int(11) NOT NULL,
  `hp` int(11) DEFAULT NULL,
  `attack` int(11) DEFAULT NULL,
  `sp_atk` int(11) DEFAULT NULL,
  `defence` int(11) DEFAULT NULL,
  `sp_def` int(11) DEFAULT NULL,
  `spd` int(11) DEFAULT NULL,
  PRIMARY KEY (`pokemon_sid`),
  CONSTRAINT `bst_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bst`
--

LOCK TABLES `bst` WRITE;
/*!40000 ALTER TABLE `bst` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `bst` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `encounters`
--

DROP TABLE IF EXISTS `encounters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounters` (
  `region_id` int(11) NOT NULL,
  `pokemon_sid` int(11) NOT NULL,
  `encounter_rate` int(11) DEFAULT NULL,
  `method` varchar(50) NOT NULL,
  PRIMARY KEY (`region_id`,`pokemon_sid`,`method`),
  KEY `pokemon_sid` (`pokemon_sid`),
  CONSTRAINT `encounters_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`),
  CONSTRAINT `encounters_ibfk_2` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounters`
--

LOCK TABLES `encounters` WRITE;
/*!40000 ALTER TABLE `encounters` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `encounters` VALUES
(1,1,33,'Gift'),
(1,4,33,'Gift'),
(1,7,33,'Gift'),
(2,16,50,'Grass'),
(2,19,50,'Grass'),
(3,10,5,'Grass'),
(3,13,5,'Grass'),
(3,16,45,'Grass'),
(3,19,45,'Grass'),
(4,54,5,'Super Rod'),
(4,54,100,'Surfing'),
(4,60,60,'Good Rod'),
(4,60,40,'Super Rod'),
(4,61,40,'Super Rod'),
(4,79,5,'Super Rod'),
(4,79,100,'Surfing'),
(4,118,20,'Good Rod'),
(4,129,20,'Good Rod'),
(4,129,100,'Old Rod'),
(4,130,15,'Super Rod'),
(5,10,40,'Walking'),
(5,11,10,'Walking'),
(5,13,40,'Walking'),
(5,25,5,'Walking'),
(7,20,5,'Walking'),
(7,21,40,'Walking'),
(7,27,30,'Walking'),
(7,96,25,'Walking'),
(11,16,30,'Grass'),
(11,21,35,'Grass'),
(11,29,15,'Grass'),
(11,32,15,'Grass'),
(11,39,10,'Grass'),
(11,56,10,'Grass'),
(12,19,20,'Grass'),
(12,21,5,'Grass'),
(12,23,35,'Grass'),
(12,27,5,'Grass'),
(12,56,30,'Grass'),
(12,72,100,'Surfing'),
(12,98,60,'Good Rod'),
(12,98,84,'Super Rod'),
(12,116,60,'Good Rod'),
(12,116,84,'Super Rod'),
(12,129,10,'Old Rod'),
(12,129,100,'Special'),
(12,130,15,'Super Rod'),
(13,54,1,'Super Rod'),
(13,72,100,'Surfing'),
(13,79,1,'Super Rod'),
(13,98,60,'Good Rod'),
(13,98,84,'Super Rod'),
(13,116,60,'Good Rod'),
(13,116,84,'Super Rod'),
(13,124,100,'Special'),
(13,129,10,'Old Rod'),
(13,130,15,'Super Rod'),
(14,10,20,'Grass'),
(14,13,20,'Grass'),
(14,16,15,'Grass'),
(14,43,25,'Grass'),
(14,63,15,'Grass'),
(14,69,25,'Grass'),
(14,72,100,'Surfing'),
(14,98,60,'Good Rod'),
(14,98,84,'Super Rod'),
(14,116,60,'Good Rod'),
(14,116,84,'Super Rod'),
(14,129,100,'Old Rod'),
(14,130,15,'Super Rod'),
(15,16,20,'Grass'),
(15,17,5,'Grass'),
(15,43,35,'Grass'),
(15,44,5,'Grass'),
(15,48,30,'Grass'),
(15,69,35,'Grass'),
(15,70,5,'Grass'),
(15,72,100,'Surfing'),
(15,98,84,'Super Rod'),
(15,116,84,'Super Rod'),
(15,129,100,'Old Rod'),
(15,130,15,'Super Rod'),
(15,132,5,'Grass'),
(16,16,10,'Grass'),
(16,17,5,'Grass'),
(16,43,35,'Grass'),
(16,44,5,'Grass'),
(16,48,30,'Grass'),
(16,69,35,'Grass'),
(16,70,5,'Grass'),
(16,132,15,'Grass'),
(17,16,20,'Grass'),
(17,17,5,'Grass'),
(17,43,35,'Grass'),
(17,44,5,'Grass'),
(17,48,30,'Grass'),
(17,69,35,'Grass'),
(17,70,5,'Grass'),
(17,132,5,'Grass'),
(18,54,100,'Surfing'),
(18,60,60,'Good Rod'),
(18,79,100,'Surfing'),
(18,118,20,'Good Rod'),
(18,118,40,'Super Rod'),
(18,119,40,'Super Rod'),
(18,129,20,'Good Rod'),
(18,129,100,'Old Rod'),
(18,130,15,'Super Rod'),
(19,16,30,'Grass'),
(19,43,35,'Grass'),
(19,52,20,'Grass'),
(19,56,10,'Grass'),
(19,63,5,'Grass'),
(19,69,35,'Grass'),
(20,16,30,'Grass'),
(20,43,35,'Grass'),
(20,52,20,'Grass'),
(20,56,10,'Grass'),
(20,63,5,'Grass'),
(20,69,35,'Grass'),
(20,72,100,'Surfing'),
(20,98,84,'Super Rod'),
(20,116,84,'Super Rod'),
(20,129,100,'Old Rod'),
(20,130,15,'Super Rod'),
(21,16,20,'Grass'),
(21,17,5,'Grass'),
(21,43,35,'Grass'),
(21,44,5,'Grass'),
(21,48,30,'Grass'),
(21,69,35,'Grass'),
(21,70,5,'Grass'),
(21,72,100,'Surfing'),
(21,98,84,'Super Rod'),
(21,116,84,'Super Rod'),
(21,129,100,'Old Rod'),
(21,130,15,'Super Rod'),
(21,143,100,'Special'),
(22,60,60,'Good Rod'),
(22,72,100,'Surfing'),
(22,73,5,'Surfing'),
(22,90,40,'Super Rod'),
(22,116,40,'Super Rod'),
(22,117,4,'Super Rod'),
(22,118,20,'Good Rod'),
(22,120,40,'Super Rod'),
(22,129,100,'Old Rod'),
(22,130,15,'Super Rod'),
(23,60,60,'Good Rod'),
(23,72,100,'Surfing'),
(23,73,5,'Surfing'),
(23,90,40,'Super Rod'),
(23,116,40,'Super Rod'),
(23,118,20,'Good Rod'),
(23,120,40,'Super Rod'),
(23,129,100,'Old Rod'),
(24,16,30,'Grass'),
(24,17,5,'Grass'),
(24,19,20,'Grass'),
(24,20,10,'Grass'),
(24,72,100,'Surfing'),
(24,114,100,'Grass'),
(24,129,100,'Old Rod'),
(25,138,100,'Fossil'),
(25,140,100,'Fossil'),
(25,142,100,'Fossil'),
(26,72,100,'Surfing'),
(26,73,5,'Surfing'),
(26,83,100,'Special'),
(26,90,40,'Super Rod'),
(26,116,40,'Super Rod'),
(26,120,40,'Super Rod'),
(27,16,15,'Grass'),
(27,37,5,'Grass'),
(27,43,30,'Grass'),
(27,52,40,'Grass'),
(27,56,10,'Grass'),
(27,58,5,'Grass'),
(27,69,30,'Grass'),
(28,16,30,'Grass'),
(28,23,15,'Grass'),
(28,27,15,'Grass'),
(28,37,10,'Grass'),
(28,43,20,'Grass'),
(28,52,25,'Grass'),
(28,58,10,'Grass'),
(29,106,100,'Gift'),
(29,107,100,'Gift'),
(29,122,100,'Special'),
(29,131,100,'Gift'),
(30,88,100,'Surfing'),
(30,109,100,'Surfing'),
(30,123,100,'Special'),
(30,127,100,'Special'),
(30,133,100,'Gift'),
(30,137,100,'Special'),
(30,147,100,'Special'),
(32,19,10,'Grass'),
(32,21,10,'Grass'),
(32,29,30,'Grass'),
(32,32,30,'Grass'),
(32,56,45,'Grass'),
(32,60,100,'Surfing'),
(32,61,5,'Surfing'),
(32,118,40,'Super Rod'),
(32,119,40,'Super Rod'),
(32,129,100,'Old Rod'),
(33,22,5,'Grass'),
(33,24,25,'Grass'),
(33,28,25,'Grass'),
(33,55,5,'Surfing'),
(33,80,5,'Surfing'),
(33,99,40,'Super Rod'),
(33,102,10,'Grass'),
(33,117,40,'Super Rod'),
(33,129,100,'Old Rod'),
(33,132,15,'Grass'),
(34,19,40,'Grass'),
(34,21,30,'Grass'),
(34,23,25,'Grass'),
(34,27,25,'Grass'),
(34,29,5,'Grass'),
(34,32,5,'Grass'),
(35,21,30,'Grass'),
(35,66,10,'Grass'),
(35,72,100,'Surfing'),
(35,98,80,'Super Rod'),
(35,100,40,'Grass'),
(35,116,80,'Super Rod');
/*!40000 ALTER TABLE `encounters` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_no` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `effect` text DEFAULT NULL,
  PRIMARY KEY (`item_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `moves`
--

DROP TABLE IF EXISTS `moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `moves` (
  `code` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `power` int(11) DEFAULT NULL,
  `accuracy` int(11) DEFAULT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  `effect` text DEFAULT NULL,
  `category` enum('Special','Physical') DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `type_name` (`type_name`),
  KEY `idx_moves_name` (`name`),
  CONSTRAINT `moves_ibfk_1` FOREIGN KEY (`type_name`) REFERENCES `types` (`name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moves`
--

LOCK TABLES `moves` WRITE;
/*!40000 ALTER TABLE `moves` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `moves` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `nature`
--

DROP TABLE IF EXISTS `nature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nature` (
  `name` varchar(50) NOT NULL,
  `increase_stat` enum('hp','atk','def','spa','spd','spe') DEFAULT NULL,
  `decrease_stat` enum('hp','atk','def','spa','spd','spe') DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nature`
--

LOCK TABLES `nature` WRITE;
/*!40000 ALTER TABLE `nature` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `nature` VALUES
('Adamant','atk','spa'),
('Bashful',NULL,NULL),
('Bold','def','atk'),
('Brave','atk','spe'),
('Calm','spd','atk'),
('Careful','spd','spa'),
('Docile',NULL,NULL),
('Gentle','spd','def'),
('Hardy',NULL,NULL),
('Hasty','spe','def'),
('Impish','def','spa'),
('Jolly','spe','spa'),
('Lax','def','spd'),
('Lonely','atk','def'),
('Mild','spa','def'),
('Modest','spa','atk'),
('Naive','spe','spd'),
('Naughty','atk','spd'),
('Quiet','spa','spe'),
('Quirky',NULL,NULL),
('Rash','spa','spd'),
('Relaxed','def','spe'),
('Sassy','spd','spe'),
('Serious',NULL,NULL),
('Timid','spe','atk');
/*!40000 ALTER TABLE `nature` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pokemon`
--

DROP TABLE IF EXISTS `pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon` (
  `sid` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `catch_rate` int(11) DEFAULT 45,
  PRIMARY KEY (`sid`),
  KEY `idx_pokemon_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon`
--

LOCK TABLES `pokemon` WRITE;
/*!40000 ALTER TABLE `pokemon` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `pokemon` VALUES
(1,'Bulbasaur',45),
(2,'Ivysaur',45),
(3,'Venusaur',45),
(4,'Charmander',45),
(5,'Charmeleon',45),
(6,'Charizard',45),
(7,'Squirtle',45),
(8,'Wartortle',45),
(9,'Blastoise',45),
(10,'Caterpie',255),
(11,'Metapod',120),
(12,'Butterfree',45),
(13,'Weedle',255),
(14,'Kakuna',120),
(15,'Beedrill',45),
(16,'Pidgey',255),
(17,'Pidgeotto',120),
(18,'Pidgeot',45),
(19,'Rattata',255),
(20,'Raticate',120),
(21,'Spearow',255),
(22,'Fearow',90),
(23,'Ekans',255),
(24,'Arbok',120),
(25,'Pikachu',190),
(26,'Raichu',75),
(27,'Sandshrew',255),
(28,'Sandslash',90),
(29,'Nidoran F',235),
(30,'Nidorina',120),
(31,'Nidoqueen',45),
(32,'Nidoran M',235),
(33,'Nidorino',120),
(34,'Nidoking',45),
(35,'Clefairy',120),
(36,'Clefable',25),
(37,'Vulpix',120),
(38,'Ninetales',75),
(39,'Jigglypuff',120),
(40,'Wigglytuff',50),
(41,'Zubat',190),
(42,'Golbat',90),
(43,'Oddish',255),
(44,'Gloom',120),
(45,'Vileplume',45),
(46,'Paras',190),
(47,'Parasect',75),
(48,'Venonat',190),
(49,'Venomoth',75),
(50,'Diglett',255),
(51,'Dugtrio',50),
(52,'Meowth',190),
(53,'Persian',90),
(54,'Psyduck',190),
(55,'Golduck',75),
(56,'Mankey',190),
(57,'Primeape',75),
(58,'Growlithe',190),
(59,'Arcanine',75),
(60,'Poliwag',255),
(61,'Poliwhirl',120),
(62,'Poliwrath',45),
(63,'Abra',200),
(64,'Kadabra',75),
(65,'Alakazam',50),
(66,'Machop',190),
(67,'Machoke',75),
(68,'Machamp',45),
(69,'Bellsprout',255),
(70,'Weepinbell',120),
(71,'Victreebel',45),
(72,'Tentacool',190),
(73,'Tentacruel',60),
(74,'Geodude',190),
(75,'Graveler',75),
(76,'Golem',45),
(77,'Ponyta',190),
(78,'Rapidash',60),
(79,'Slowpoke',190),
(80,'Slowbro',75),
(81,'Magnemite',190),
(82,'Magneton',60),
(83,'Farfetch\'d',45),
(84,'Doduo',190),
(85,'Dodrio',45),
(86,'Seel',190),
(87,'Dewgong',75),
(88,'Grimer',190),
(89,'Muk',75),
(90,'Shellder',190),
(91,'Cloyster',60),
(92,'Gastly',190),
(93,'Haunter',75),
(94,'Gengar',45),
(95,'Onix',45),
(96,'Drowzee',190),
(97,'Hypno',75),
(98,'Krabby',225),
(99,'Kingler',60),
(100,'Voltorb',190),
(101,'Electrode',60),
(102,'Exeggcute',90),
(103,'Exeggutor',45),
(104,'Cubone',190),
(105,'Marowak',75),
(106,'Hitmonlee',45),
(107,'Hitmonchan',45),
(108,'Lickitung',45),
(109,'Koffing',190),
(110,'Weezing',60),
(111,'Rhyhorn',120),
(112,'Rhydon',60),
(113,'Chansey',30),
(114,'Tangela',45),
(115,'Kangaskhan',45),
(116,'Horsea',225),
(117,'Seadra',75),
(118,'Goldeen',225),
(119,'Seaking',60),
(120,'Staryu',225),
(121,'Starmie',60),
(122,'Mr. Mime',45),
(123,'Scyther',45),
(124,'Jynx',45),
(125,'Electabuzz',45),
(126,'Magmar',45),
(127,'Pinsir',45),
(128,'Tauros',45),
(129,'Magikarp',255),
(130,'Gyarados',45),
(131,'Lapras',45),
(132,'Ditto',35),
(133,'Eevee',45),
(134,'Vaporeon',45),
(135,'Jolteon',45),
(136,'Flareon',45),
(137,'Porygon',45),
(138,'Omanyte',45),
(139,'Omastar',45),
(140,'Kabuto',45),
(141,'Kabutops',45),
(142,'Aerodactyl',45),
(143,'Snorlax',25),
(144,'Articuno',3),
(145,'Zapdos',3),
(146,'Moltres',3),
(147,'Dratini',45),
(148,'Dragonair',75),
(149,'Dragonite',45),
(150,'Mewtwo',3),
(151,'Mew',3);
/*!40000 ALTER TABLE `pokemon` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pokemon_abilities`
--

DROP TABLE IF EXISTS `pokemon_abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_abilities` (
  `pokemon_sid` int(11) NOT NULL,
  `ability_name` varchar(200) NOT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`pokemon_sid`,`ability_name`),
  KEY `ability_name` (`ability_name`),
  CONSTRAINT `pokemon_abilities_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_abilities_ibfk_2` FOREIGN KEY (`ability_name`) REFERENCES `ability` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_abilities`
--

LOCK TABLES `pokemon_abilities` WRITE;
/*!40000 ALTER TABLE `pokemon_abilities` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `pokemon_abilities` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pokemon_moves`
--

DROP TABLE IF EXISTS `pokemon_moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_moves` (
  `pokemon_sid` int(11) NOT NULL,
  `move_code` int(11) NOT NULL,
  PRIMARY KEY (`pokemon_sid`,`move_code`),
  KEY `move_code` (`move_code`),
  CONSTRAINT `pokemon_moves_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_moves_ibfk_2` FOREIGN KEY (`move_code`) REFERENCES `moves` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_moves`
--

LOCK TABLES `pokemon_moves` WRITE;
/*!40000 ALTER TABLE `pokemon_moves` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `pokemon_moves` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `pokemon_types`
--

DROP TABLE IF EXISTS `pokemon_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_types` (
  `pokemon_sid` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`pokemon_sid`,`type_name`),
  KEY `type_name` (`type_name`),
  CONSTRAINT `pokemon_types_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_types_ibfk_2` FOREIGN KEY (`type_name`) REFERENCES `types` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_types`
--

LOCK TABLES `pokemon_types` WRITE;
/*!40000 ALTER TABLE `pokemon_types` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `pokemon_types` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `regions` VALUES
(1,'Pallet Town','A quiet seaside town where every journey begins.'),
(2,'Route 1','A winding path through tall grass connecting Pallet Town and Viridian City.'),
(3,'Route 2','A path that leads to Diglett\'s Cave and Viridian Forest.'),
(4,'Viridian City','The city of Eternal Greenery.'),
(5,'Viridian Forest','A deep and misty forest full of bug-type Pokémon.'),
(6,'Pewter City','A quiet city nestled among the rocks.'),
(7,'Route 11','A seaside path leading to the Diglett Cave.'),
(11,'Route 3','A rocky path leading towards Mt. Moon.'),
(12,'Route 4','A route linking Mt. Moon and Cerulean City. Features a Pokemon Center near the cave entrance.'),
(13,'Cerulean City','A city surrounded by a mysterious blue aura. Home to the Cerulean Gym and the Bike Shop.'),
(14,'Route 24','The famous Nugget Bridge. Beyond the bridge lies a path through tall grass toward Route 25.'),
(15,'Route 13','A seaside route featuring a narrow path through a maze of fences.'),
(16,'Route 14','A coastal route situated between Routes 13 and 15. It is known for its high grass and Bird Keepers.'),
(17,'Route 15','The eastern end of the seaside path leading toward Fuchsia City.'),
(18,'Fuchsia City','A historic city known for its Safari Zone and the Soul Badge. It is surrounded by water and lush trees.'),
(19,'Route 5','A path connecting Cerulean City to Saffron City. It houses the original Pokemon Day Care.'),
(20,'Route 6','A path connecting Saffron City to Vermilion City. A pond here allows for various water-type encounters.'),
(21,'Route 12','A long bridge popular with fishers. It is often blocked by a sleeping Snorlax.'),
(22,'Route 19','A water route extending south from Fuchsia City towards the Seafoam Islands.'),
(23,'Route 20','A water route that is split in two by the Seafoam Islands. It leads to Cinnabar Island.'),
(24,'Route 21','A water route located south of Pallet Town.'),
(25,'Cinnabar Island','A volcanic island housing the Pokemon Lab where fossils are revived.'),
(26,'Vermilion City','Kanto\'s primary port city. Home to the S.S. Anne and Lt. Surge\'s Gym.'),
(27,'Route 7','A short, east-west path connecting Saffron City and Celadon City.'),
(28,'Route 8','The path linking Lavender Town to Saffron City, featuring a diverse range of Pokemon.'),
(29,'Saffron City','The massive golden city of Kanto. It is the headquarters of Silph Co. and features two rival gyms.'),
(30,'Celadon City','A glittering city of dreams and home to the Kanto Department Store and Game Corner.'),
(32,'Route 22','The gateway to the Indigo Plateau, located west of Viridian City.'),
(33,'Route 23','The elite path leading to Victory Road, accessible only to those who have earned all eight Kanto Badges.'),
(34,'Route 9','A rocky, uneven path connecting Cerulean City to the Rock Tunnel.'),
(35,'Route 10','A route divided by the Rock Tunnel. Its northern waterway leads to the Power Plant.');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `team_pokemon`
--

DROP TABLE IF EXISTS `team_pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL,
  `slot` tinyint(4) DEFAULT NULL CHECK (`slot` between 1 and 6),
  `pokemon_sid` int(11) NOT NULL,
  `item_no` int(11) DEFAULT NULL,
  `ability_name` varchar(200) DEFAULT NULL,
  `nature` varchar(50) DEFAULT NULL,
  `level` int(11) DEFAULT 50,
  `gender` enum('M','F','N') DEFAULT 'N',
  `shiny` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_id` (`team_id`,`slot`),
  KEY `pokemon_sid` (`pokemon_sid`),
  KEY `item_no` (`item_no`),
  KEY `ability_name` (`ability_name`),
  KEY `nature` (`nature`),
  CONSTRAINT `team_pokemon_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_pokemon_ibfk_2` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`),
  CONSTRAINT `team_pokemon_ibfk_3` FOREIGN KEY (`item_no`) REFERENCES `items` (`item_no`),
  CONSTRAINT `team_pokemon_ibfk_4` FOREIGN KEY (`ability_name`) REFERENCES `ability` (`name`),
  CONSTRAINT `team_pokemon_ibfk_5` FOREIGN KEY (`nature`) REFERENCES `nature` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_pokemon`
--

LOCK TABLES `team_pokemon` WRITE;
/*!40000 ALTER TABLE `team_pokemon` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `team_pokemon` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `team_pokemon_evs`
--

DROP TABLE IF EXISTS `team_pokemon_evs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_evs` (
  `team_pokemon_id` int(11) NOT NULL,
  `hp` int(11) DEFAULT 0,
  `atk` int(11) DEFAULT 0,
  `def` int(11) DEFAULT 0,
  `spa` int(11) DEFAULT 0,
  `spd` int(11) DEFAULT 0,
  `spe` int(11) DEFAULT 0,
  PRIMARY KEY (`team_pokemon_id`),
  CONSTRAINT `team_pokemon_evs_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_pokemon_evs`
--

LOCK TABLES `team_pokemon_evs` WRITE;
/*!40000 ALTER TABLE `team_pokemon_evs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `team_pokemon_evs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `team_pokemon_ivs`
--

DROP TABLE IF EXISTS `team_pokemon_ivs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_ivs` (
  `team_pokemon_id` int(11) NOT NULL,
  `hp` int(11) DEFAULT 31,
  `atk` int(11) DEFAULT 31,
  `def` int(11) DEFAULT 31,
  `spa` int(11) DEFAULT 31,
  `spd` int(11) DEFAULT 31,
  `spe` int(11) DEFAULT 31,
  PRIMARY KEY (`team_pokemon_id`),
  CONSTRAINT `team_pokemon_ivs_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_pokemon_ivs`
--

LOCK TABLES `team_pokemon_ivs` WRITE;
/*!40000 ALTER TABLE `team_pokemon_ivs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `team_pokemon_ivs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `team_pokemon_moves`
--

DROP TABLE IF EXISTS `team_pokemon_moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_moves` (
  `team_pokemon_id` int(11) NOT NULL,
  `move_code` int(11) DEFAULT NULL,
  `slot` tinyint(4) NOT NULL CHECK (`slot` between 1 and 4),
  PRIMARY KEY (`team_pokemon_id`,`slot`),
  KEY `move_code` (`move_code`),
  CONSTRAINT `team_pokemon_moves_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_pokemon_moves_ibfk_2` FOREIGN KEY (`move_code`) REFERENCES `moves` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_pokemon_moves`
--

LOCK TABLES `team_pokemon_moves` WRITE;
/*!40000 ALTER TABLE `team_pokemon_moves` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `team_pokemon_moves` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `team_name` varchar(200) DEFAULT NULL,
  `format` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_team_player` (`player_id`),
  KEY `idx_team_format` (`format`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `name` varchar(100) NOT NULL,
  `strength` int(11) DEFAULT NULL,
  `weakness` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `pass` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES
(1,'Ash','ash.ketchum@gmail.com','pikachu123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-01-01 19:16:08
