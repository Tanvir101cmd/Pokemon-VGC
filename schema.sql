-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pokemonvgc
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ability`
--

DROP TABLE IF EXISTS `ability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ability` (
  `name` varchar(200) NOT NULL,
  `effect` text,
  PRIMARY KEY (`name`),
  KEY `idx_ability_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bst`
--

DROP TABLE IF EXISTS `bst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bst` (
  `pokemon_sid` int NOT NULL,
  `hp` int DEFAULT NULL,
  `attack` int DEFAULT NULL,
  `sp_atk` int DEFAULT NULL,
  `defence` int DEFAULT NULL,
  `sp_def` int DEFAULT NULL,
  `spd` int DEFAULT NULL,
  PRIMARY KEY (`pokemon_sid`),
  CONSTRAINT `bst_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_no` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `effect` text,
  PRIMARY KEY (`item_no`)
) ENGINE=InnoDB AUTO_INCREMENT=921 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moves`
--

DROP TABLE IF EXISTS `moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moves` (
  `code` int NOT NULL,
  `name` varchar(200) NOT NULL,
  `power` int DEFAULT NULL,
  `accuracy` int DEFAULT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  `effect` text,
  `category` enum('Special','Physical','Status') DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `type_name` (`type_name`),
  KEY `idx_moves_name` (`name`),
  CONSTRAINT `moves_ibfk_1` FOREIGN KEY (`type_name`) REFERENCES `types` (`name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nature`
--

DROP TABLE IF EXISTS `nature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nature` (
  `name` varchar(50) NOT NULL,
  `increase_stat` enum('hp','atk','def','spa','spd','spe') DEFAULT NULL,
  `decrease_stat` enum('hp','atk','def','spa','spd','spe') DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pokemon`
--

DROP TABLE IF EXISTS `pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon` (
  `sid` int NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `idx_pokemon_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pokemon_abilities`
--

DROP TABLE IF EXISTS `pokemon_abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_abilities` (
  `pokemon_sid` int NOT NULL,
  `ability_name` varchar(200) NOT NULL,
  `hidden` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`pokemon_sid`,`ability_name`),
  KEY `ability_name` (`ability_name`),
  CONSTRAINT `pokemon_abilities_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_abilities_ibfk_2` FOREIGN KEY (`ability_name`) REFERENCES `ability` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pokemon_moves`
--

DROP TABLE IF EXISTS `pokemon_moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_moves` (
  `pokemon_sid` int NOT NULL,
  `move_code` int NOT NULL,
  PRIMARY KEY (`pokemon_sid`,`move_code`),
  KEY `move_code` (`move_code`),
  CONSTRAINT `pokemon_moves_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_moves_ibfk_2` FOREIGN KEY (`move_code`) REFERENCES `moves` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pokemon_types`
--

DROP TABLE IF EXISTS `pokemon_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_types` (
  `pokemon_sid` int NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `type_name1` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pokemon_sid`,`type_name`),
  KEY `type_name` (`type_name`),
  CONSTRAINT `pokemon_types_ibfk_1` FOREIGN KEY (`pokemon_sid`) REFERENCES `pokemon` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_types_ibfk_2` FOREIGN KEY (`type_name`) REFERENCES `types` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_pokemon`
--

DROP TABLE IF EXISTS `team_pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_id` int NOT NULL,
  `slot` tinyint DEFAULT NULL,
  `pokemon_sid` int NOT NULL,
  `item_no` int DEFAULT NULL,
  `ability_name` varchar(200) DEFAULT NULL,
  `nature` varchar(50) DEFAULT NULL,
  `level` int DEFAULT '50',
  `gender` enum('M','F','N') DEFAULT 'N',
  `shiny` tinyint(1) DEFAULT '0',
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
  CONSTRAINT `team_pokemon_ibfk_5` FOREIGN KEY (`nature`) REFERENCES `nature` (`name`),
  CONSTRAINT `team_pokemon_chk_1` CHECK ((`slot` between 1 and 6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_pokemon_evs`
--

DROP TABLE IF EXISTS `team_pokemon_evs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_evs` (
  `team_pokemon_id` int NOT NULL,
  `hp` int DEFAULT '0',
  `atk` int DEFAULT '0',
  `def` int DEFAULT '0',
  `spa` int DEFAULT '0',
  `spd` int DEFAULT '0',
  `spe` int DEFAULT '0',
  PRIMARY KEY (`team_pokemon_id`),
  CONSTRAINT `team_pokemon_evs_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_pokemon_evs_chk_1` CHECK (((((((`hp` + `atk`) + `def`) + `spa`) + `spd`) + `spe`) <= 510))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_pokemon_ivs`
--

DROP TABLE IF EXISTS `team_pokemon_ivs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_ivs` (
  `team_pokemon_id` int NOT NULL,
  `hp` int DEFAULT '31',
  `atk` int DEFAULT '31',
  `def` int DEFAULT '31',
  `spa` int DEFAULT '31',
  `spd` int DEFAULT '31',
  `spe` int DEFAULT '31',
  PRIMARY KEY (`team_pokemon_id`),
  CONSTRAINT `team_pokemon_ivs_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_pokemon_moves`
--

DROP TABLE IF EXISTS `team_pokemon_moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_pokemon_moves` (
  `team_pokemon_id` int NOT NULL,
  `move_code` int DEFAULT NULL,
  `slot` tinyint NOT NULL,
  PRIMARY KEY (`team_pokemon_id`,`slot`),
  KEY `move_code` (`move_code`),
  CONSTRAINT `team_pokemon_moves_ibfk_1` FOREIGN KEY (`team_pokemon_id`) REFERENCES `team_pokemon` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_pokemon_moves_ibfk_2` FOREIGN KEY (`move_code`) REFERENCES `moves` (`code`),
  CONSTRAINT `team_pokemon_moves_chk_1` CHECK ((`slot` between 1 and 4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `team_name` varchar(200) DEFAULT NULL,
  `format` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_team_player` (`player_id`),
  KEY `idx_team_format` (`format`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `name` varchar(100) NOT NULL,
  `strength` varchar(50) DEFAULT NULL,
  `weakness` varchar(50) DEFAULT NULL,
  `immunity` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `pass` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-31 19:37:49
