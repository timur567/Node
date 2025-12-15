-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `Access_Level`
--

DROP TABLE IF EXISTS `Access_Level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Access_Level` (
  `ID_Access_Level` int NOT NULL AUTO_INCREMENT,
  `Level_Name` varchar(45) NOT NULL,
  `User_ID_User` int NOT NULL,
  PRIMARY KEY (`ID_Access_Level`),
  KEY `fk_Access_Level_User1_idx` (`User_ID_User`),
  CONSTRAINT `fk_Access_Level_User1` FOREIGN KEY (`User_ID_User`) REFERENCES `User` (`ID_User`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Access_Level`
--

LOCK TABLES `Access_Level` WRITE;
/*!40000 ALTER TABLE `Access_Level` DISABLE KEYS */;
INSERT INTO `Access_Level` VALUES (1,'Администратор',0),(2,'Модератор контента',0),(3,'Редактор',0),(4,'Пользователь',0),(5,'Администратор',0),(6,'Модератор контента',0),(7,'Редактор',0),(8,'Пользователь',0),(9,'Администратор',0),(10,'Модератор контента',0),(11,'Редактор',0),(12,'Пользователь',0),(13,'Администратор',0),(14,'Модератор контента',0),(15,'Редактор',0),(16,'Пользователь',0),(17,'Администратор',1),(18,'Модератор контента',2),(19,'Редактор',3),(20,'Пользователь',4),(21,'Администратор',1),(22,'Модератор контента',2),(23,'Редактор',2),(24,'Пользователь',4),(25,'Администратор',1),(26,'Модератор контента',2),(27,'Редактор',3),(28,'Пользователь',4),(29,'Администратор',1),(30,'Модератор контента',2),(31,'Редактор',3),(32,'Пользователь',4),(33,'Пользователь',5),(34,'Администратор',1),(35,'Модератор контента',2),(36,'Редактор',4),(37,'Пользователь',4),(38,'Пользователь',5);
/*!40000 ALTER TABLE `Access_Level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Access_Level_has_Privileges`
--

DROP TABLE IF EXISTS `Access_Level_has_Privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Access_Level_has_Privileges` (
  `Access_Level_ID_Access_Level` int NOT NULL,
  `Privileges_ID_Privileges` int NOT NULL,
  PRIMARY KEY (`Access_Level_ID_Access_Level`,`Privileges_ID_Privileges`),
  KEY `fk_Access_Level_has_Privileges_Privileges1_idx` (`Privileges_ID_Privileges`),
  KEY `fk_Access_Level_has_Privileges_Access_Level1_idx` (`Access_Level_ID_Access_Level`),
  CONSTRAINT `fk_Access_Level_has_Privileges_Access_Level1` FOREIGN KEY (`Access_Level_ID_Access_Level`) REFERENCES `Access_Level` (`ID_Access_Level`),
  CONSTRAINT `fk_Access_Level_has_Privileges_Privileges1` FOREIGN KEY (`Privileges_ID_Privileges`) REFERENCES `Privileges` (`ID_Privileges`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Access_Level_has_Privileges`
--

LOCK TABLES `Access_Level_has_Privileges` WRITE;
/*!40000 ALTER TABLE `Access_Level_has_Privileges` DISABLE KEYS */;
INSERT INTO `Access_Level_has_Privileges` VALUES (1,1),(1,2),(1,3),(1,4),(2,4),(3,4),(4,4),(1,5),(2,5),(3,5),(1,6),(2,6),(3,6),(1,7),(2,7),(1,8),(2,8),(3,8),(1,9),(2,9),(1,10),(2,10),(3,10),(1,11),(2,11),(1,12),(2,12),(1,13),(2,13),(1,14),(1,15);
/*!40000 ALTER TABLE `Access_Level_has_Privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categories` (
  `ID_Categories` int NOT NULL,
  `Categories_Name` varchar(45) NOT NULL,
  `Categories_ID_Categories` int NOT NULL,
  PRIMARY KEY (`ID_Categories`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Content`
--

DROP TABLE IF EXISTS `Content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Content` (
  `ID_Content` int NOT NULL AUTO_INCREMENT,
  `Content_Types` varchar(45) NOT NULL,
  `Mode` varchar(45) NOT NULL,
  `Status` varchar(45) NOT NULL,
  `Date_Public` date DEFAULT NULL,
  `Formscol1` varchar(45) DEFAULT NULL,
  `User_ID_User` int NOT NULL,
  PRIMARY KEY (`ID_Content`),
  KEY `fk_Content_User1_idx` (`User_ID_User`),
  CONSTRAINT `fk_Content_User1` FOREIGN KEY (`User_ID_User`) REFERENCES `User` (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Content`
--

LOCK TABLES `Content` WRITE;
/*!40000 ALTER TABLE `Content` DISABLE KEYS */;
/*!40000 ALTER TABLE `Content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Content_has_Tegs`
--

DROP TABLE IF EXISTS `Content_has_Tegs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Content_has_Tegs` (
  `Content_ID_Content` int NOT NULL,
  `Tegs_ID_Tegs` int NOT NULL,
  PRIMARY KEY (`Content_ID_Content`,`Tegs_ID_Tegs`),
  KEY `fk_Content_has_Tegs_Tegs1_idx` (`Tegs_ID_Tegs`),
  KEY `fk_Content_has_Tegs_Content1_idx` (`Content_ID_Content`),
  CONSTRAINT `fk_Content_has_Tegs_Content1` FOREIGN KEY (`Content_ID_Content`) REFERENCES `Content` (`ID_Content`),
  CONSTRAINT `fk_Content_has_Tegs_Tegs1` FOREIGN KEY (`Tegs_ID_Tegs`) REFERENCES `Tegs` (`ID_Tegs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Content_has_Tegs`
--

LOCK TABLES `Content_has_Tegs` WRITE;
/*!40000 ALTER TABLE `Content_has_Tegs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Content_has_Tegs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Parents_has_Forms`
--

DROP TABLE IF EXISTS `Parents_has_Forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Parents_has_Forms` (
  `Parents_ID_Parents` int NOT NULL,
  `Forms_ID_Forms` int NOT NULL,
  PRIMARY KEY (`Parents_ID_Parents`,`Forms_ID_Forms`),
  KEY `fk_Parents_has_Forms_Forms1_idx` (`Forms_ID_Forms`),
  KEY `fk_Parents_has_Forms_Parents1_idx` (`Parents_ID_Parents`),
  CONSTRAINT `fk_Parents_has_Forms_Forms1` FOREIGN KEY (`Forms_ID_Forms`) REFERENCES `Content` (`ID_Content`),
  CONSTRAINT `fk_Parents_has_Forms_Parents1` FOREIGN KEY (`Parents_ID_Parents`) REFERENCES `Categories` (`ID_Categories`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Parents_has_Forms`
--

LOCK TABLES `Parents_has_Forms` WRITE;
/*!40000 ALTER TABLE `Parents_has_Forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `Parents_has_Forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Privileges`
--

DROP TABLE IF EXISTS `Privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Privileges` (
  `ID_Privileges` int NOT NULL AUTO_INCREMENT,
  `Privileges_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_Privileges`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Privileges`
--

LOCK TABLES `Privileges` WRITE;
/*!40000 ALTER TABLE `Privileges` DISABLE KEYS */;
INSERT INTO `Privileges` VALUES (1,'Создание пользователей'),(2,'Удаление пользователей'),(3,'Редактирование прав доступа'),(4,'Просмотр всех объектов'),(5,'Создание новых записей'),(6,'Редактирование своих записей'),(7,'Редактирование чужих записей'),(8,'Удаление своих записей'),(9,'Удаление чужих записей'),(10,'Публикация записей'),(11,'Архивирование записей'),(12,'Просмотр статистики'),(13,'Экспорт данных'),(14,'Импорт данных'),(15,'Настройка системы');
/*!40000 ALTER TABLE `Privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tegs`
--

DROP TABLE IF EXISTS `Tegs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tegs` (
  `ID_Tegs` int NOT NULL AUTO_INCREMENT,
  `Tegs_Name` varchar(45) NOT NULL,
  `Slug` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_Tegs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tegs`
--

LOCK TABLES `Tegs` WRITE;
/*!40000 ALTER TABLE `Tegs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tegs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `ID_User` int NOT NULL AUTO_INCREMENT,
  `Login` varchar(45) DEFAULT NULL,
  `Password` varchar(45) NOT NULL,
  `User_Name` varchar(45) NOT NULL,
  `TelNum` varchar(45) NOT NULL,
  `Start_Use` date DEFAULT NULL,
  `Is_Active` tinyint NOT NULL,
  PRIMARY KEY (`ID_User`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'admin','hashed_pass_1','Александр Иванов','+79123456789','2023-01-15',0),(2,'moderator','hashed_pass_2','Елена Петрова','+79234567890','2023-03-22',0),(3,'editor1','hashed_pass_3','Дмитрий Сидоров','+79876543211','2022-12-01',0),(4,'editor2','hashed_pass_4','Ольга Кузнецова','+79456789012','2024-06-10',0),(5,'user1','hashed_pass_5','Николай Федоров','+79567890123','2025-12-08',0),(6,NULL,'hashed_pass_5','Николай Федоров','+79567890123','2022-12-08',0);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11 16:14:46
