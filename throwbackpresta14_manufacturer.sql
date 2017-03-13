-- MySQL dump 10.16  Distrib 10.1.19-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.1.19-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ps_manufacturer`
--

DROP TABLE IF EXISTS `ps_manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer` (
  `id_manufacturer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer`
--

LOCK TABLES `ps_manufacturer` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer` DISABLE KEYS */;
INSERT INTO `ps_manufacturer` VALUES (3,'New Balance','2012-11-06 20:36:48','2012-12-20 21:54:09',1),(4,'Jordan Brand','2012-11-06 22:40:57','2012-11-06 22:40:57',1),(6,'Nike Footwear','2012-12-16 18:35:52','2012-12-20 21:54:28',1),(7,'Reebok','2012-12-20 21:55:03','2012-12-20 21:55:03',1),(8,'Adidas','2012-12-22 21:37:26','2012-12-22 21:37:26',1),(9,'Asics','2013-01-21 22:04:59','2013-01-21 22:04:59',1),(10,'Puma','2013-02-07 15:16:32','2013-02-07 15:16:32',1),(11,'Ewing','2013-02-17 14:24:12','2013-02-17 14:24:12',1),(12,'Mitchell & Ness','2013-02-25 23:55:13','2013-02-25 23:55:13',1),(13,'Le Coq Sportif','2013-07-10 13:28:28','2013-07-10 13:28:28',1),(14,'ARKK Copenhagen','2015-10-01 01:37:19','2015-10-01 01:37:19',1);
/*!40000 ALTER TABLE `ps_manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_manufacturer_lang`
--

DROP TABLE IF EXISTS `ps_manufacturer_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_lang` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text,
  `short_description` text,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer_lang`
--

LOCK TABLES `ps_manufacturer_lang` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer_lang` DISABLE KEYS */;
INSERT INTO `ps_manufacturer_lang` VALUES (3,1,NULL,NULL,NULL,NULL,NULL),(3,2,NULL,NULL,NULL,NULL,NULL),(3,3,NULL,NULL,NULL,NULL,NULL),(3,4,NULL,NULL,NULL,NULL,NULL),(3,5,NULL,NULL,NULL,NULL,NULL),(4,1,NULL,NULL,NULL,NULL,NULL),(4,2,NULL,NULL,NULL,NULL,NULL),(4,3,NULL,NULL,NULL,NULL,NULL),(4,4,NULL,NULL,NULL,NULL,NULL),(4,5,NULL,NULL,NULL,NULL,NULL),(6,1,NULL,NULL,NULL,NULL,NULL),(6,2,NULL,NULL,NULL,NULL,NULL),(6,3,NULL,NULL,NULL,NULL,NULL),(6,4,NULL,NULL,NULL,NULL,NULL),(6,5,NULL,NULL,NULL,NULL,NULL),(7,1,NULL,NULL,NULL,NULL,NULL),(7,2,NULL,NULL,NULL,NULL,NULL),(7,3,NULL,NULL,NULL,NULL,NULL),(7,4,NULL,NULL,NULL,NULL,NULL),(7,5,NULL,NULL,NULL,NULL,NULL),(8,1,NULL,NULL,NULL,NULL,NULL),(8,2,NULL,NULL,NULL,NULL,NULL),(8,3,NULL,NULL,NULL,NULL,NULL),(8,4,NULL,NULL,NULL,NULL,NULL),(8,5,NULL,NULL,NULL,NULL,NULL),(9,1,NULL,NULL,NULL,NULL,NULL),(9,2,NULL,NULL,NULL,NULL,NULL),(9,3,NULL,NULL,NULL,NULL,NULL),(9,4,NULL,NULL,NULL,NULL,NULL),(9,5,NULL,NULL,NULL,NULL,NULL),(10,1,NULL,NULL,NULL,NULL,NULL),(10,2,NULL,NULL,NULL,NULL,NULL),(10,3,NULL,NULL,NULL,NULL,NULL),(10,4,NULL,NULL,NULL,NULL,NULL),(10,5,NULL,NULL,NULL,NULL,NULL),(11,1,NULL,NULL,NULL,NULL,NULL),(11,2,NULL,NULL,NULL,NULL,NULL),(11,3,NULL,NULL,NULL,NULL,NULL),(11,4,NULL,NULL,NULL,NULL,NULL),(11,5,NULL,NULL,NULL,NULL,NULL),(12,1,NULL,NULL,NULL,NULL,NULL),(12,2,NULL,NULL,NULL,NULL,NULL),(12,3,NULL,NULL,NULL,NULL,NULL),(12,4,NULL,NULL,NULL,NULL,NULL),(12,5,NULL,NULL,NULL,NULL,NULL),(13,1,NULL,'<p>Le Coq Sportif Footwear</p>',NULL,NULL,NULL),(13,2,NULL,'<p>Le Coq Sportif Footwear</p>',NULL,NULL,NULL),(13,3,NULL,NULL,NULL,NULL,NULL),(13,4,NULL,NULL,NULL,NULL,NULL),(13,5,NULL,NULL,NULL,NULL,NULL),(14,1,NULL,NULL,NULL,NULL,NULL),(14,2,NULL,NULL,NULL,NULL,NULL),(14,3,NULL,NULL,NULL,NULL,NULL),(14,4,NULL,NULL,NULL,NULL,NULL),(14,5,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ps_manufacturer_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_manufacturer_shop`
--

DROP TABLE IF EXISTS `ps_manufacturer_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_shop` (
  `id_manufacturer` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer_shop`
--

LOCK TABLES `ps_manufacturer_shop` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer_shop` DISABLE KEYS */;
INSERT INTO `ps_manufacturer_shop` VALUES (3,1),(4,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1);
/*!40000 ALTER TABLE `ps_manufacturer_shop` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-10 23:34:10
