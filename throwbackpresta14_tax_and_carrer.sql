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

/*
DROP TABLE IF EXISTS ps_carrier;
DROP TABLE IF EXISTS ps_carrier_group;
DROP TABLE IF EXISTS ps_carrier_lang;
DROP TABLE IF EXISTS ps_carrier_shop;
DROP TABLE IF EXISTS ps_carrier_tax_rules_group_shop;
DROP TABLE IF EXISTS ps_carrier_zone;

DROP TABLE IF EXISTS ps_range_price;
DROP TABLE IF EXISTS ps_range_weight;

DROP TABLE IF EXISTS ps_tax;
DROP TABLE IF EXISTS ps_tax_lang;
DROP TABLE IF EXISTS ps_tax_rule;
DROP TABLE IF EXISTS ps_tax_rules_group;
DROP TABLE IF EXISTS ps_tax_rules_group_shop;
*/
--
-- Table structure for table `ps_carrier`
--

DROP TABLE IF EXISTS `ps_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier` (
  `id_carrier` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_reference` int(10) unsigned NOT NULL,
  `id_tax_rules_group` int(10) unsigned DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shipping_handling` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `range_behavior` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_module` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_free` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shipping_external` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `need_range` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `external_module_name` varchar(64) DEFAULT NULL,
  `shipping_method` int(2) NOT NULL DEFAULT '0',
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `max_width` int(10) DEFAULT '0',
  `max_height` int(10) DEFAULT '0',
  `max_depth` int(10) DEFAULT '0',
  `max_weight` decimal(20,6) DEFAULT '0.000000',
  `grade` int(10) DEFAULT '0',
  PRIMARY KEY (`id_carrier`),
  KEY `deleted` (`deleted`,`active`),
  KEY `reference` (`id_reference`,`deleted`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier`
--

LOCK TABLES `ps_carrier` WRITE;
/*!40000 ALTER TABLE `ps_carrier` DISABLE KEYS */;
INSERT INTO `ps_carrier` VALUES (1,1,0,'Throwback Sneakers',NULL,0,1,0,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(2,2,0,'My carrier',NULL,1,1,1,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(3,3,0,'La Poste - So Colissimo','http://www.colissimo.fr/portail_colissimo/suivreResultat.do?parcelnumber=@',0,1,0,0,1,0,1,1,'socolissimo',0,0,0,0,0,0.000000,0),(4,4,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(5,5,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(6,6,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(7,7,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(8,8,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(9,9,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(10,10,0,'Colissimo recommandé',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(11,11,0,'Livraison par Colissimo A/R',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(12,12,0,'Livraison par Colissimo A/R',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(13,13,0,'Livraison par Colissimo A/R',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(14,14,0,'Livraison par Colissimo A/R',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(15,15,0,'Colissimo international',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(16,16,0,'Livraison par Colissimo A/R',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(17,17,0,'Livraison par Colissimo A/R France',NULL,0,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(18,18,0,'Livraison par Colissimo A/R France',NULL,0,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(19,19,0,'Livraison par Colissimo A/R France',NULL,1,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(20,20,0,'Livraison par Colissimo A/R France',NULL,0,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(21,21,0,'Livraison par Colissimo A/R France',NULL,0,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(22,22,0,'Livraison par Colissimo A/R France',NULL,1,1,1,1,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(23,23,0,'Livraison par Colissimo A/R',NULL,1,0,1,0,0,0,0,0,NULL,1,1,0,0,0,0.000000,0),(24,24,0,'Livraison Colissimo Europe',NULL,1,1,1,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(25,25,0,'Livraison Colissimo Europe',NULL,1,1,1,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(26,26,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(27,27,0,'Colissimo international',NULL,1,1,1,0,0,0,0,0,NULL,1,0,0,0,0,0.000000,0),(28,28,0,'Livraison par Lettre Max',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(29,29,0,'Livraison par Lettre Max',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(30,30,0,'Livraison par Lettre Max',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(31,31,0,'Livraison par Colissimo',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(32,32,0,'Livraison par Lettre Max',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(33,33,0,'Livraison par Lettre Max',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(34,34,0,'Livraison Postexport',NULL,1,1,0,0,0,0,0,0,NULL,2,0,0,0,0,0.000000,0),(35,35,0,'Livraison Postexport (Enveloppe)',NULL,1,0,0,0,0,0,0,0,NULL,2,2,0,0,0,0.000000,0),(36,36,0,'Livraison par Colissimo',NULL,1,0,0,0,0,0,0,0,NULL,2,3,0,0,0,0.000000,0),(37,37,0,'Colissimo international',NULL,1,0,1,0,0,0,0,0,NULL,1,4,0,0,0,0.000000,0),(38,38,0,'Livraison Colissimo Europe',NULL,1,0,1,0,0,0,0,0,NULL,2,5,0,0,0,0.000000,0),(39,39,0,'Livraison par Colissimo A/R France',NULL,1,0,1,1,0,0,0,0,NULL,2,6,0,0,0,0.000000,0),(40,40,0,'Throwback Sneakers',NULL,0,1,0,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(41,41,0,'Throwback Sneakers',NULL,0,1,0,0,0,0,0,0,NULL,0,0,0,0,0,0.000000,0),(42,42,0,'Throwback Sneakers',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(43,43,0,'Retrait en magasin (45 Rue de Tourtille 75020 Paris)',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(44,44,0,'Retrait en magasin (45 Rue de Tourtille 75020 Paris)',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(45,45,0,'Retrait en magasin (45 Rue de Tourtille 75020 Paris)',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(46,46,0,'Retrait en magasin (45 Rue de Tourtille 75020 Paris)',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(47,47,0,'Retrait en magasin (67 Rue de Belleville 75020 Paris)',NULL,1,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(48,48,0,'Retrait en magasin (67 Rue de Belleville 75019 Paris)',NULL,0,1,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0),(49,49,0,'Retrait en magasin (67 Rue de Belleville 75019 Paris)',NULL,0,0,0,0,0,1,0,0,NULL,0,0,0,0,0,0.000000,0);
/*!40000 ALTER TABLE `ps_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_group`
--

DROP TABLE IF EXISTS `ps_carrier_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_group` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_group`
--

LOCK TABLES `ps_carrier_group` WRITE;
/*!40000 ALTER TABLE `ps_carrier_group` DISABLE KEYS */;
INSERT INTO `ps_carrier_group` VALUES (3,1),(17,1),(17,2),(23,1),(23,3),(23,4),(33,1),(33,2),(35,1),(35,2),(35,3),(35,4),(36,1),(36,2),(36,3),(36,4),(37,1),(37,3),(37,4),(38,1),(38,2),(38,3),(38,4),(39,1),(39,2),(39,3),(39,4),(49,1),(49,3),(49,4);
/*!40000 ALTER TABLE `ps_carrier_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_lang`
--

DROP TABLE IF EXISTS `ps_carrier_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_lang` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `delay` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_carrier`,`id_shop`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_lang`
--

LOCK TABLES `ps_carrier_lang` WRITE;
/*!40000 ALTER TABLE `ps_carrier_lang` DISABLE KEYS */;
INSERT INTO `ps_carrier_lang` VALUES (1,1,1,'Pick up in-store'),(1,1,2,'Retrait au magasin'),(1,1,3,'Recogida en la tienda'),(1,1,4,'Abholung im Geschäft'),(1,1,5,'Ritiro in magazzino'),(2,1,1,'Delivery next day!'),(2,1,2,'Livraison le lendemain !'),(2,1,3,'¡Entrega día siguiente!'),(2,1,4,'Zustellung am nächsten Tag!'),(2,1,5,'Consegna il giorno dopo!'),(3,1,1,'Do you deliver wherever you want in France.'),(3,1,2,'Avec La Poste, Faites-vous livrer là où vous le souhaitez en France Métropolitaine.'),(3,1,3,'Avec La Poste, Faites-vous livrer là où vous le souhaitez en France Métropolitaine.'),(3,1,4,'Avec La Poste, Faites-vous livrer là où vous le souhaitez en France Métropolitaine.'),(3,1,5,'Avec La Poste, Faites-vous livrer là où vous le souhaitez en France Métropolitaine.'),(4,1,1,'Delivery next day!'),(4,1,2,'Delais standard'),(4,1,3,'¡Entrega día siguiente!'),(4,1,4,'Zustellung am nächsten Tag!'),(4,1,5,'Consegna il giorno dopo!'),(5,1,1,'Delivery next day!'),(5,1,2,'Delais standard'),(5,1,3,'¡Entrega día siguiente!'),(5,1,4,'Zustellung am nächsten Tag!'),(5,1,5,'Consegna il giorno dopo!'),(6,1,1,'Delivery next day!'),(6,1,2,'Delais standard'),(6,1,3,'¡Entrega día siguiente!'),(6,1,4,'Zustellung am nächsten Tag!'),(6,1,5,'Consegna il giorno dopo!'),(7,1,1,'Delivery next day!'),(7,1,2,'Delais standard'),(7,1,3,'¡Entrega día siguiente!'),(7,1,4,'Zustellung am nächsten Tag!'),(7,1,5,'Consegna il giorno dopo!'),(8,1,1,'Delivery next day!'),(8,1,2,'Delais standard'),(8,1,3,'¡Entrega día siguiente!'),(8,1,4,'Zustellung am nächsten Tag!'),(8,1,5,'Consegna il giorno dopo!'),(9,1,1,'Delivery next day!'),(9,1,2,'Delais standard'),(9,1,3,'¡Entrega día siguiente!'),(9,1,4,'Zustellung am nächsten Tag!'),(9,1,5,'Consegna il giorno dopo!'),(10,1,1,'Delais standard'),(10,1,2,'Delais standard'),(10,1,3,'Delais standard'),(10,1,4,'Delais standard'),(10,1,5,'Delais standard'),(11,1,1,'Delais standard'),(11,1,2,'Delais standard'),(11,1,3,'Delais standard'),(11,1,4,'Delais standard'),(11,1,5,'Delais standard'),(12,1,1,'Delais standard'),(12,1,2,'Delais standard'),(12,1,3,'Delais standard'),(12,1,4,'Delais standard'),(12,1,5,'Delais standard'),(13,1,1,'Delais standard'),(13,1,2,'Delais standard'),(13,1,3,'Delais standard'),(13,1,4,'Delais standard'),(13,1,5,'Delais standard'),(14,1,1,'Delais standard'),(14,1,2,'Delais standard'),(14,1,3,'Delais standard'),(14,1,4,'Delais standard'),(14,1,5,'Delais standard'),(15,1,1,'Delais standard'),(15,1,2,'Delais standard'),(15,1,3,'Delais standard'),(15,1,4,'Delais standard'),(15,1,5,'Delais standard'),(16,1,1,'Delais standard'),(16,1,2,'Livraison par Colissimo A/R'),(16,1,3,'Delais standard'),(16,1,4,'Delais standard'),(16,1,5,'Delais standard'),(17,1,1,'Delais standard avec A/R'),(17,1,2,'Delais standard avec A/R'),(17,1,3,'Delais standard avec A/R'),(17,1,4,'Delais standard avec A/R'),(17,1,5,'Delais standard avec A/R'),(18,1,1,'Delais standard avec A/R'),(18,1,2,'Delais standard avec A/R'),(18,1,3,'Delais standard avec A/R'),(18,1,4,'Delais standard avec A/R'),(18,1,5,'Delais standard avec A/R'),(19,1,1,'Delais standard avec A/R'),(19,1,2,'Delais standard avec A/R'),(19,1,3,'Delais standard avec A/R'),(19,1,4,'Delais standard avec A/R'),(19,1,5,'Delais standard avec A/R'),(20,1,1,'Delais standard avec A/R'),(20,1,2,'Delais standard avec A/R'),(20,1,3,'Delais standard avec A/R'),(20,1,4,'Delais standard avec A/R'),(20,1,5,'Delais standard avec A/R'),(21,1,1,'Delais standard avec A/R'),(21,1,2,'Delais standard avec A/R'),(21,1,3,'Delais standard avec A/R'),(21,1,4,'Delais standard avec A/R'),(21,1,5,'Delais standard avec A/R'),(22,1,1,'Delais standard avec A/R'),(22,1,2,'Delais standard avec A/R'),(22,1,3,'Delais standard avec A/R'),(22,1,4,'Delais standard avec A/R'),(22,1,5,'Delais standard avec A/R'),(23,1,1,'Delais standard'),(23,1,2,'Livraison par Colissimo A/R'),(23,1,3,'Delais standard'),(23,1,4,'Delais standard'),(23,1,5,'Delais standard'),(24,1,1,'Delais standard'),(24,1,2,'Delais standard'),(24,1,3,'Delais standard'),(24,1,4,'Delais standard'),(24,1,5,'Delais standard'),(25,1,1,'Standard Delivery time'),(25,1,2,'Delais standard'),(25,1,3,'Delais standard'),(25,1,4,'Delais standard'),(25,1,5,'Delais standard'),(26,1,1,'Delivery next day!'),(26,1,2,'Delais standard'),(26,1,3,'¡Entrega día siguiente!'),(26,1,4,'Zustellung am nächsten Tag!'),(26,1,5,'Consegna il giorno dopo!'),(27,1,1,'Delais standard'),(27,1,2,'Delais standard'),(27,1,3,'Delais standard'),(27,1,4,'Delais standard'),(27,1,5,'Delais standard'),(28,1,1,'2 jours ouvrés'),(28,1,2,'2 jours ouvrés'),(28,1,3,'2 jours ouvrés'),(28,1,4,'2 jours ouvrés'),(28,1,5,'2 jours ouvrés'),(29,1,1,'2 jours ouvrés'),(29,1,2,'Délais standard (avec suivi)'),(29,1,3,'2 jours ouvrés'),(29,1,4,'2 jours ouvrés'),(29,1,5,'2 jours ouvrés'),(30,1,1,'2 jours ouvrés'),(30,1,2,'Délais standard (avec suivi)'),(30,1,3,'2 jours ouvrés'),(30,1,4,'2 jours ouvrés'),(30,1,5,'2 jours ouvrés'),(31,1,1,'Delivery next day!'),(31,1,2,'Delais standards'),(31,1,3,'¡Entrega día siguiente!'),(31,1,4,'Zustellung am nächsten Tag!'),(31,1,5,'Consegna il giorno dopo!'),(32,1,1,'2 jours ouvrés'),(32,1,2,'Délais standard (avec suivi)'),(32,1,3,'2 jours ouvrés'),(32,1,4,'2 jours ouvrés'),(32,1,5,'2 jours ouvrés'),(33,1,1,'2 jours ouvrés'),(33,1,2,'Délais standard (avec suivi)'),(33,1,3,'2 jours ouvrés'),(33,1,4,'2 jours ouvrés'),(33,1,5,'2 jours ouvrés'),(34,1,1,'Délais standards (avec suivi)'),(34,1,2,'Délais standards (avec suivi)'),(34,1,3,'Délais standards (avec suivi)'),(34,1,4,'Délais standards (avec suivi)'),(34,1,5,'Délais standards (avec suivi)'),(35,1,1,'Délais standards (avec suivi)'),(35,1,2,'Délais standards (avec suivi)'),(35,1,3,'Délais standards (avec suivi)'),(35,1,4,'Délais standards (avec suivi)'),(35,1,5,'Délais standards (avec suivi)'),(36,1,1,'Delivery next day!'),(36,1,2,'Délais standards (avec suivi)'),(36,1,3,'¡Entrega día siguiente!'),(36,1,4,'Zustellung am nächsten Tag!'),(36,1,5,'Consegna il giorno dopo!'),(37,1,1,'Delais standard'),(37,1,2,'Délais standards (avec suivi)'),(37,1,3,'Delais standard'),(37,1,4,'Delais standard'),(37,1,5,'Delais standard'),(38,1,1,'Standard Delivery time'),(38,1,2,'Délais standards (avec suivi)'),(38,1,3,'Delais standard'),(38,1,4,'Delais standard'),(38,1,5,'Delais standard'),(39,1,1,'Delais standard avec A/R'),(39,1,2,'Delais standards avec A/R'),(39,1,3,'Delais standard avec A/R'),(39,1,4,'Delais standard avec A/R'),(39,1,5,'Delais standard avec A/R'),(40,1,1,'In-store pick up'),(40,1,2,'Retrait au magasin'),(40,1,3,'Recogida en la tienda'),(40,1,4,'Abholung im Geschäft'),(40,1,5,'Ritiro in magazzino'),(41,1,1,'In-store pick up'),(41,1,2,'Retrait en magasin'),(41,1,3,'Recogida en la tienda'),(41,1,4,'Abholung im Geschäft'),(41,1,5,'Ritiro in magazzino'),(42,1,1,'In-store pick up'),(42,1,2,'Retrait en magasin'),(42,1,3,'Recogida en la tienda'),(42,1,4,'Abholung im Geschäft'),(42,1,5,'Ritiro in magazzino'),(43,1,1,'In-store pick up (see details in terms of delivery)'),(43,1,2,'Retrait en magasin (voir détails dans la partie \"livraison\")'),(43,1,3,'Recogida en la tienda'),(43,1,4,'Abholung im Geschäft'),(43,1,5,'Ritiro in magazzino'),(44,1,1,'In-store pick up (see details in \"delivery\" section)'),(44,1,2,'Retrait en magasin (voir détails dans la partie \"livraison\")'),(44,1,3,'Recogida en la tienda'),(44,1,4,'Abholung im Geschäft'),(44,1,5,'Ritiro in magazzino'),(45,1,1,'In-store pick up (see details in \"shipping\" section)'),(45,1,2,'Retrait en magasin (détails dans la partie \"livraison\")'),(45,1,3,'Recogida en la tienda'),(45,1,4,'Abholung im Geschäft'),(45,1,5,'Ritiro in magazzino'),(46,1,1,'In-store pick up (see details in \"shipping\" section)'),(46,1,2,'Retrait en magasin (détails dans la partie \"livraison\")'),(46,1,3,'Recogida en la tienda'),(46,1,4,'Abholung im Geschäft'),(46,1,5,'Ritiro in magazzino'),(47,1,1,'In-store pick up (see details in \"shipping\" section)'),(47,1,2,'Retrait en magasin (détails dans la partie \"livraison\")'),(47,1,3,'Recogida en la tienda'),(47,1,4,'Abholung im Geschäft'),(47,1,5,'Ritiro in magazzino'),(48,1,1,'In-store pick up (see details in \"shipping\" section)'),(48,1,2,'Retrait en magasin (détails dans la partie \"livraison\")'),(48,1,3,'Recogida en la tienda'),(48,1,4,'Abholung im Geschäft'),(48,1,5,'Ritiro in magazzino'),(49,1,1,'In-store pick up (see details in \"shipping\" section)'),(49,1,2,'Retrait en magasin (détails dans la partie \"livraison\")'),(49,1,3,'Recogida en la tienda'),(49,1,4,'Abholung im Geschäft'),(49,1,5,'Ritiro in magazzino');
/*!40000 ALTER TABLE `ps_carrier_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_shop`
--

DROP TABLE IF EXISTS `ps_carrier_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_shop`
--

LOCK TABLES `ps_carrier_shop` WRITE;
/*!40000 ALTER TABLE `ps_carrier_shop` DISABLE KEYS */;
INSERT INTO `ps_carrier_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1);
/*!40000 ALTER TABLE `ps_carrier_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_tax_rules_group_shop`
--

DROP TABLE IF EXISTS `ps_carrier_tax_rules_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_tax_rules_group_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_tax_rules_group`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_tax_rules_group_shop`
--

LOCK TABLES `ps_carrier_tax_rules_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_carrier_tax_rules_group_shop` DISABLE KEYS */;
INSERT INTO `ps_carrier_tax_rules_group_shop` VALUES (1,0,1),(2,1,1),(3,0,1),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1),(9,0,1),(10,0,1),(11,0,1),(12,0,1),(13,0,1),(14,0,1),(15,0,1),(16,0,1),(17,0,1),(18,0,1),(19,0,1),(20,0,1),(21,0,1),(22,0,1),(23,0,1),(24,0,1),(25,0,1),(26,0,1),(27,0,1),(28,0,1),(29,0,1),(30,0,1),(31,0,1),(32,0,1),(33,0,1),(34,0,1),(35,0,1),(36,0,1),(37,0,1),(38,0,1),(39,0,1),(40,0,1),(41,0,1),(42,0,1),(43,0,1),(44,0,1),(45,0,1),(46,0,1),(47,0,1),(48,0,1),(49,0,1);
/*!40000 ALTER TABLE `ps_carrier_tax_rules_group_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_zone`
--

DROP TABLE IF EXISTS `ps_carrier_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_zone` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_zone`
--

LOCK TABLES `ps_carrier_zone` WRITE;
/*!40000 ALTER TABLE `ps_carrier_zone` DISABLE KEYS */;
INSERT INTO `ps_carrier_zone` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(7,1),(7,8),(8,9),(9,9),(10,9),(11,9),(12,9),(12,10),(13,9),(13,10),(14,9),(14,10),(14,11),(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),(15,7),(15,8),(16,9),(16,10),(16,11),(17,9),(18,9),(19,9),(20,9),(21,9),(22,9),(23,10),(23,11),(24,1),(25,1),(26,9),(27,2),(27,3),(27,4),(27,5),(27,6),(27,7),(27,8),(28,9),(29,9),(30,9),(31,9),(32,1),(32,2),(32,3),(32,5),(32,7),(32,9),(32,10),(32,11),(33,9),(33,10),(33,11),(34,1),(34,2),(34,3),(34,5),(34,6),(34,7),(35,2),(35,3),(35,5),(35,6),(35,7),(36,9),(37,2),(37,3),(37,4),(37,5),(37,6),(37,7),(37,8),(38,1),(39,9),(40,1),(40,9),(41,1),(41,9),(42,1),(42,9),(43,1),(43,9),(44,1),(44,9),(45,1),(45,9),(46,9),(47,9),(48,9),(49,9);
/*!40000 ALTER TABLE `ps_carrier_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_range_price`
--

DROP TABLE IF EXISTS `ps_range_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_price` (
  `id_range_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_price`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_range_price`
--

LOCK TABLES `ps_range_price` WRITE;
/*!40000 ALTER TABLE `ps_range_price` DISABLE KEYS */;
INSERT INTO `ps_range_price` VALUES (1,2,0.000000,10000.000000),(2,3,0.000000,10000.000000),(3,4,0.000000,10000.000000),(4,5,0.000000,10000.000000),(5,6,0.000000,10000.000000),(6,7,0.000000,10000.000000),(7,8,0.000000,10000.000000),(9,19,0.000000,199.990000),(10,20,0.000000,199.990000),(11,21,0.000000,199.990000),(12,22,20.000000,199.990000),(24,25,0.000000,20.000000),(13,25,20.000000,199.990000),(14,25,200.000000,1000000.000000),(15,26,20.000000,199.990000),(16,26,200.000000,1000000.000000),(17,30,0.000000,20.000000),(23,31,0.000000,20.000000),(18,31,20.000000,199.990000),(19,31,200.000000,1000000.000000),(20,32,0.000000,20.000000),(21,33,0.000000,20.000000),(22,34,0.000000,20.000000),(25,35,0.000000,20.000000),(33,35,20.010000,250.000000),(26,36,0.000000,14.890000),(27,36,14.900000,199.990000),(28,36,200.000000,1000000.000000),(29,38,0.000000,20.000000),(30,38,20.000000,199.990000),(31,38,200.000000,1000000.000000),(32,39,20.000000,199.990000);
/*!40000 ALTER TABLE `ps_range_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_range_weight`
--

DROP TABLE IF EXISTS `ps_range_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_weight` (
  `id_range_weight` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_weight`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_range_weight`
--

LOCK TABLES `ps_range_weight` WRITE;
/*!40000 ALTER TABLE `ps_range_weight` DISABLE KEYS */;
INSERT INTO `ps_range_weight` VALUES (1,2,0.000000,10000.000000),(3,4,0.000000,10000.000000),(4,5,0.000000,10000.000000),(5,6,0.000000,0.510000),(6,6,0.500000,1.000000),(7,6,1.000000,2.000000),(8,6,2.000000,3.000000),(9,6,3.000000,5.000000),(10,6,5.000000,7.000000),(11,6,7.000000,10.000000),(12,6,10.000000,16.000000),(13,7,0.000000,0.510000),(14,7,0.500000,1.000000),(15,7,1.000000,2.000000),(16,7,2.000000,3.000000),(17,7,3.000000,5.000000),(18,7,5.000000,7.000000),(19,7,7.000000,10.000000),(20,7,10.000000,16.000000),(21,8,0.000000,0.510000),(22,8,0.500000,1.000000),(23,8,1.000000,2.000000),(24,8,2.000000,3.000000),(25,8,3.000000,5.000000),(26,8,5.000000,7.000000),(27,8,7.000000,10.000000),(28,8,10.000000,16.000000),(29,9,0.000000,0.510000),(30,9,0.500000,1.000000),(31,9,1.000000,2.000000),(32,9,2.000000,3.000000),(33,9,3.000000,5.000000),(34,9,5.000000,7.000000),(35,9,7.000000,10.000000),(36,9,10.000000,16.000000),(37,11,0.000000,0.500000),(38,11,0.500000,1.000000),(39,11,1.000000,2.000000),(40,11,2.000000,3.000000),(41,11,3.000000,5.000000),(43,11,5.000000,7.000000),(44,11,7.000000,10.000000),(46,11,10.000000,15.000000),(47,12,0.000000,0.500000),(48,12,0.500000,1.000000),(49,12,1.000000,2.000000),(50,12,2.000000,3.000000),(51,12,3.000000,5.000000),(52,12,5.000000,7.000000),(53,12,7.000000,10.000000),(54,12,10.000000,15.000000),(55,13,0.000000,0.500000),(56,13,0.500000,1.000000),(57,13,1.000000,2.000000),(58,13,2.000000,3.000000),(59,13,3.000000,5.000000),(60,13,5.000000,7.000000),(61,13,7.000000,10.000000),(62,13,10.000000,15.000000),(63,14,0.000000,0.500000),(64,14,0.500000,1.000000),(65,14,1.000000,2.000000),(66,14,2.000000,3.000000),(67,14,3.000000,5.000000),(68,14,5.000000,7.000000),(69,14,7.000000,10.000000),(70,14,10.000000,15.000000),(71,15,0.000000,1.000000),(73,15,1.000000,2.000000),(74,15,2.000000,3.000000),(75,15,3.000000,5.000000),(76,15,5.000000,7.000000),(77,15,7.000000,10.000000),(78,15,10.000000,15.000000),(79,16,0.000000,0.500000),(80,16,0.500000,1.000000),(81,16,1.000000,2.000000),(82,16,2.000000,3.000000),(83,16,3.000000,5.000000),(84,16,5.000000,7.000000),(85,16,7.000000,10.000000),(86,16,10.000000,15.000000),(87,23,0.000000,0.500000),(88,23,0.500000,1.000000),(89,23,1.000000,2.000000),(90,23,2.000000,3.000000),(91,23,3.000000,5.000000),(92,23,5.000000,7.000000),(93,23,7.000000,10.000000),(94,23,10.000000,15.000000),(95,26,0.000000,0.510000),(96,26,0.500000,1.000000),(97,26,1.000000,2.000000),(98,26,2.000000,3.000000),(99,26,3.000000,5.000000),(100,26,5.000000,7.000000),(101,26,7.000000,10.000000),(102,26,10.000000,16.000000),(103,27,0.000000,1.000000),(104,27,1.000000,2.000000),(105,27,2.000000,3.000000),(106,27,3.000000,5.000000),(107,27,5.000000,7.000000),(108,27,7.000000,10.000000),(109,27,10.000000,15.000000),(110,31,0.000000,0.510000),(111,31,0.500000,1.000000),(112,31,1.000000,2.000000),(113,31,2.000000,3.000000),(114,31,3.000000,5.000000),(115,31,5.000000,7.000000),(116,31,7.000000,10.000000),(117,31,10.000000,16.000000),(118,36,0.000000,0.510000),(119,36,0.500000,1.000000),(120,36,1.000000,2.000000),(121,36,2.000000,3.000000),(122,36,3.000000,5.000000),(123,36,5.000000,7.000000),(124,36,7.000000,10.000000),(125,36,10.000000,16.000000),(126,37,0.000000,1.000000),(127,37,1.000000,2.000000),(128,37,2.000000,3.000000),(129,37,3.000000,5.000000),(130,37,5.000000,7.000000),(131,37,7.000000,10.000000),(132,37,10.000000,15.000000);
/*!40000 ALTER TABLE `ps_range_weight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax`
--

DROP TABLE IF EXISTS `ps_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax` (
  `id_tax` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(10,3) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_tax`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax`
--

LOCK TABLES `ps_tax` WRITE;
/*!40000 ALTER TABLE `ps_tax` DISABLE KEYS */;
INSERT INTO `ps_tax` VALUES (1,20.000,1,0),(2,7.000,1,0),(3,5.500,1,0),(4,2.100,1,0),(5,20.000,1,0);
/*!40000 ALTER TABLE `ps_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_lang`
--

DROP TABLE IF EXISTS `ps_tax_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_lang` (
  `id_tax` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_tax`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_lang`
--

LOCK TABLES `ps_tax_lang` WRITE;
/*!40000 ALTER TABLE `ps_tax_lang` DISABLE KEYS */;
INSERT INTO `ps_tax_lang` VALUES (1,1,'TVA FR 19.6%'),(1,2,'TVA FR 20%'),(1,3,'TVA FR 19.6%'),(1,4,'TVA FR 19.6%'),(1,5,'TVA FR 19.6%'),(2,1,'TVA FR 7%'),(2,2,'TVA FR 7%'),(2,3,'TVA FR 7%'),(2,4,'TVA FR 7%'),(2,5,'TVA FR 7%'),(3,1,'TVA FR 5.5%'),(3,2,'TVA FR 5.5%'),(3,3,'TVA FR 5.5%'),(3,4,'TVA FR 5.5%'),(3,5,'TVA FR 5.5%'),(4,1,'TVA FR 2.1%'),(4,2,'TVA FR 2.1%'),(4,3,'TVA FR 2.1%'),(4,4,'TVA FR 2.1%'),(4,5,'TVA FR 2.1%'),(5,1,'TVA FR'),(5,2,'TVA FR'),(5,3,'TVA FR'),(5,4,'TVA FR'),(5,5,'TVA FR');
/*!40000 ALTER TABLE `ps_tax_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rule`
--

DROP TABLE IF EXISTS `ps_tax_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rule` (
  `id_tax_rule` int(11) NOT NULL AUTO_INCREMENT,
  `id_tax_rules_group` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_state` int(11) NOT NULL,
  `zipcode_from` varchar(12) NOT NULL,
  `zipcode_to` varchar(12) NOT NULL,
  `behavior` int(11) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tax_rule`),
  UNIQUE KEY `tax_rule` (`id_tax_rules_group`,`id_country`,`id_state`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `id_tax` (`id_tax`),
  KEY `category_getproducts` (`id_tax_rules_group`,`id_country`,`id_state`,`zipcode_from`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rule`
--

LOCK TABLES `ps_tax_rule` WRITE;
/*!40000 ALTER TABLE `ps_tax_rule` DISABLE KEYS */;
INSERT INTO `ps_tax_rule` VALUES (1,1,3,0,'0','0',0,1,''),(2,1,236,0,'0','0',0,1,''),(3,1,16,0,'0','0',0,1,''),(4,1,20,0,'0','0',0,1,''),(5,1,1,0,'0','0',0,1,''),(6,1,86,0,'0','0',0,1,''),(7,1,9,0,'0','0',0,1,''),(8,1,6,0,'0','0',0,1,''),(9,1,8,0,'0','0',0,1,''),(10,1,26,0,'0','0',0,1,''),(11,1,10,0,'0','0',0,1,''),(12,1,76,0,'0','0',0,1,''),(13,1,125,0,'0','0',0,1,''),(14,1,131,0,'0','0',0,1,''),(15,1,12,0,'0','0',0,1,''),(16,1,143,0,'0','0',0,1,''),(17,1,139,0,'0','0',0,1,''),(18,1,13,0,'0','0',0,1,''),(19,1,2,0,'0','0',0,1,''),(20,1,14,0,'0','0',0,1,''),(21,1,15,0,'0','0',0,1,''),(22,1,36,0,'0','0',0,1,''),(23,1,193,0,'0','0',0,1,''),(24,1,37,0,'0','0',0,1,''),(25,1,7,0,'0','0',0,1,''),(26,1,18,0,'0','0',0,1,''),(27,2,3,0,'0','0',0,2,''),(28,2,236,0,'0','0',0,2,''),(29,2,16,0,'0','0',0,2,''),(30,2,20,0,'0','0',0,2,''),(31,2,1,0,'0','0',0,2,''),(32,2,86,0,'0','0',0,2,''),(33,2,9,0,'0','0',0,2,''),(34,2,6,0,'0','0',0,2,''),(35,2,8,0,'0','0',0,2,''),(36,2,26,0,'0','0',0,2,''),(37,2,10,0,'0','0',0,2,''),(38,2,76,0,'0','0',0,2,''),(39,2,125,0,'0','0',0,2,''),(40,2,131,0,'0','0',0,2,''),(41,2,12,0,'0','0',0,2,''),(42,2,143,0,'0','0',0,2,''),(43,2,139,0,'0','0',0,2,''),(44,2,13,0,'0','0',0,2,''),(45,2,2,0,'0','0',0,2,''),(46,2,14,0,'0','0',0,2,''),(47,2,15,0,'0','0',0,2,''),(48,2,36,0,'0','0',0,2,''),(49,2,193,0,'0','0',0,2,''),(50,2,37,0,'0','0',0,2,''),(51,2,7,0,'0','0',0,2,''),(52,2,18,0,'0','0',0,2,''),(53,3,3,0,'0','0',0,3,''),(54,3,236,0,'0','0',0,3,''),(55,3,16,0,'0','0',0,3,''),(56,3,20,0,'0','0',0,3,''),(57,3,1,0,'0','0',0,3,''),(58,3,86,0,'0','0',0,3,''),(59,3,9,0,'0','0',0,3,''),(60,3,6,0,'0','0',0,3,''),(61,3,8,0,'0','0',0,3,''),(62,3,26,0,'0','0',0,3,''),(63,3,10,0,'0','0',0,3,''),(64,3,76,0,'0','0',0,3,''),(65,3,125,0,'0','0',0,3,''),(66,3,131,0,'0','0',0,3,''),(67,3,12,0,'0','0',0,3,''),(68,3,143,0,'0','0',0,3,''),(69,3,139,0,'0','0',0,3,''),(70,3,13,0,'0','0',0,3,''),(71,3,2,0,'0','0',0,3,''),(72,3,14,0,'0','0',0,3,''),(73,3,15,0,'0','0',0,3,''),(74,3,36,0,'0','0',0,3,''),(75,3,193,0,'0','0',0,3,''),(76,3,37,0,'0','0',0,3,''),(77,3,7,0,'0','0',0,3,''),(78,3,18,0,'0','0',0,3,''),(79,4,3,0,'0','0',0,4,''),(80,4,236,0,'0','0',0,4,''),(81,4,16,0,'0','0',0,4,''),(82,4,20,0,'0','0',0,4,''),(83,4,1,0,'0','0',0,4,''),(84,4,86,0,'0','0',0,4,''),(85,4,9,0,'0','0',0,4,''),(86,4,6,0,'0','0',0,4,''),(87,4,8,0,'0','0',0,4,''),(88,4,26,0,'0','0',0,4,''),(89,4,10,0,'0','0',0,4,''),(90,4,76,0,'0','0',0,4,''),(91,4,125,0,'0','0',0,4,''),(92,4,131,0,'0','0',0,4,''),(93,4,12,0,'0','0',0,4,''),(94,4,143,0,'0','0',0,4,''),(95,4,139,0,'0','0',0,4,''),(96,4,13,0,'0','0',0,4,''),(97,4,2,0,'0','0',0,4,''),(98,4,14,0,'0','0',0,4,''),(99,4,15,0,'0','0',0,4,''),(100,4,36,0,'0','0',0,4,''),(101,4,193,0,'0','0',0,4,''),(102,4,37,0,'0','0',0,4,''),(103,4,7,0,'0','0',0,4,''),(104,4,18,0,'0','0',0,4,''),(132,5,8,0,'0','0',0,1,''),(133,5,98,0,'0','0',0,5,''),(134,5,241,0,'0','0',0,5,''),(135,5,141,0,'0','0',0,5,''),(136,5,144,0,'0','0',0,5,''),(137,5,148,0,'0','0',0,5,''),(138,5,176,0,'0','0',0,5,''),(139,5,179,0,'0','0',0,5,''),(140,5,182,0,'0','0',0,5,''),(141,5,183,0,'0','0',0,5,'');
/*!40000 ALTER TABLE `ps_tax_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rules_group`
--

DROP TABLE IF EXISTS `ps_tax_rules_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group` (
  `id_tax_rules_group` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `active` int(11) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rules_group`
--

LOCK TABLES `ps_tax_rules_group` WRITE;
/*!40000 ALTER TABLE `ps_tax_rules_group` DISABLE KEYS */;
INSERT INTO `ps_tax_rules_group` VALUES (1,'FR Taux standard (19.6%)',1,0,'2017-03-06 15:47:02','2017-03-06 15:47:02'),(2,'FR Taux réduit (7%)',1,0,'2017-03-06 15:47:02','2017-03-06 15:47:02'),(3,'FR Taux réduit (5.5%)',1,0,'2017-03-06 15:47:02','2017-03-06 15:47:02'),(4,'FR Taux super réduit (2.1%)',1,0,'2017-03-06 15:47:02','2017-03-06 15:47:02'),(5,'TVA FR',1,0,'2017-03-06 15:47:02','2017-03-06 15:47:02');
/*!40000 ALTER TABLE `ps_tax_rules_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rules_group_shop`
--

DROP TABLE IF EXISTS `ps_tax_rules_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group_shop` (
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rules_group_shop`
--

LOCK TABLES `ps_tax_rules_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_tax_rules_group_shop` DISABLE KEYS */;
INSERT INTO `ps_tax_rules_group_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1);
/*!40000 ALTER TABLE `ps_tax_rules_group_shop` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-09 21:33:23
