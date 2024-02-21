-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mco1try
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `pxid` varchar(32) DEFAULT NULL,
  `clinicid` varchar(32) DEFAULT NULL,
  `doctorid` varchar(32) DEFAULT NULL,
  `apptid` varchar(32) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `TimeQueued` datetime DEFAULT NULL,
  `QueueDate` datetime DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `Virtual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`apptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointments_with_index`
--

DROP TABLE IF EXISTS `appointments_with_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments_with_index` (
  `pxid` varchar(32) DEFAULT NULL,
  `clinicid` varchar(32) DEFAULT NULL,
  `doctorid` varchar(32) DEFAULT NULL,
  `apptid` varchar(32) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `TimeQueued` datetime DEFAULT NULL,
  `QueueDate` datetime DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `Virtual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`apptid`),
  KEY `clinicid` (`clinicid`),
  KEY `doctorid` (`doctorid`),
  KEY `px` (`pxid`),
  CONSTRAINT `appointments_with_index_ibfk_1` FOREIGN KEY (`pxid`) REFERENCES `px` (`pxid`),
  CONSTRAINT `appointments_with_index_ibfk_2` FOREIGN KEY (`clinicid`) REFERENCES `clinics` (`clinicid`),
  CONSTRAINT `appointments_with_index_ibfk_3` FOREIGN KEY (`doctorid`) REFERENCES `doctors` (`doctorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinics`
--

DROP TABLE IF EXISTS `clinics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinics` (
  `clinicid` varchar(32) NOT NULL,
  `hospitalname` varchar(255) DEFAULT NULL,
  `IsHospital` tinyint(1) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `RegionName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clinicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinics_with_index`
--

DROP TABLE IF EXISTS `clinics_with_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinics_with_index` (
  `clinicid` varchar(32) NOT NULL,
  `hospitalname` varchar(255) DEFAULT NULL,
  `IsHospital` tinyint(1) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `RegionName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clinicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctorid` varchar(32) NOT NULL,
  `mainspecialty` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`doctorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doctors_with_index`
--

DROP TABLE IF EXISTS `doctors_with_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors_with_index` (
  `doctorid` varchar(32) NOT NULL,
  `mainspecialty` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`doctorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `px`
--

DROP TABLE IF EXISTS `px`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `px` (
  `pxid` varchar(32) NOT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `px_with_index`
--

DROP TABLE IF EXISTS `px_with_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `px_with_index` (
  `pxid` varchar(32) NOT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'mco1try'
--

--
-- Dumping routines for database 'mco1try'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-21 21:56:46
