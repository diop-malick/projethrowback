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
-- Table structure for table `ps_cms`
--

DROP TABLE IF EXISTS `ps_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms` (
  `id_cms` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms_category` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `indexation` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cms`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms`
--

LOCK TABLES `ps_cms` WRITE;
/*!40000 ALTER TABLE `ps_cms` DISABLE KEYS */;
INSERT INTO `ps_cms` VALUES (1,1,0,1,0),(2,1,1,1,0),(3,1,2,1,0),(4,1,3,1,0),(5,1,4,1,0),(7,3,0,1,0),(8,3,1,1,0),(11,3,2,1,0),(12,4,0,1,0),(14,4,1,1,0),(16,4,2,1,0);
/*!40000 ALTER TABLE `ps_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_block`
--

DROP TABLE IF EXISTS `ps_cms_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_block` (
  `id_cms_block` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms_category` int(10) unsigned NOT NULL,
  `location` tinyint(1) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `display_store` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cms_block`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_block`
--

LOCK TABLES `ps_cms_block` WRITE;
/*!40000 ALTER TABLE `ps_cms_block` DISABLE KEYS */;
INSERT INTO `ps_cms_block` VALUES (1,1,0,0,1);
/*!40000 ALTER TABLE `ps_cms_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_block_lang`
--

DROP TABLE IF EXISTS `ps_cms_block_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_block_lang` (
  `id_cms_block` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_cms_block`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_block_lang`
--

LOCK TABLES `ps_cms_block_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_block_lang` DISABLE KEYS */;
INSERT INTO `ps_cms_block_lang` VALUES (1,1,'Informations'),(1,2,'Informations');
/*!40000 ALTER TABLE `ps_cms_block_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_block_page`
--

DROP TABLE IF EXISTS `ps_cms_block_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_block_page` (
  `id_cms_block_page` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms_block` int(10) unsigned NOT NULL,
  `id_cms` int(10) unsigned NOT NULL,
  `is_category` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_block_page`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_block_page`
--

LOCK TABLES `ps_cms_block_page` WRITE;
/*!40000 ALTER TABLE `ps_cms_block_page` DISABLE KEYS */;
INSERT INTO `ps_cms_block_page` VALUES (1,1,1,0),(2,1,2,0),(3,1,3,0),(4,1,4,0),(5,1,5,0);
/*!40000 ALTER TABLE `ps_cms_block_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_block_shop`
--

DROP TABLE IF EXISTS `ps_cms_block_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_block_shop` (
  `id_cms_block` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_block`,`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_block_shop`
--

LOCK TABLES `ps_cms_block_shop` WRITE;
/*!40000 ALTER TABLE `ps_cms_block_shop` DISABLE KEYS */;
INSERT INTO `ps_cms_block_shop` VALUES (1,1);
/*!40000 ALTER TABLE `ps_cms_block_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category`
--

DROP TABLE IF EXISTS `ps_cms_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(10) unsigned NOT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cms_category`),
  KEY `category_parent` (`id_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category`
--

LOCK TABLES `ps_cms_category` WRITE;
/*!40000 ALTER TABLE `ps_cms_category` DISABLE KEYS */;
INSERT INTO `ps_cms_category` VALUES (1,0,1,1,'2017-01-29 19:09:10','2017-01-29 19:09:10',0),(3,1,2,1,'2017-02-27 13:33:34','2017-02-28 11:59:07',0),(4,1,2,1,'2017-02-28 16:41:35','2017-02-28 16:48:23',1);
/*!40000 ALTER TABLE `ps_cms_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category_lang`
--

DROP TABLE IF EXISTS `ps_cms_category_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_lang` (
  `id_cms_category` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(128) NOT NULL,
  `description` text,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`,`id_lang`),
  KEY `category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category_lang`
--

LOCK TABLES `ps_cms_category_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_category_lang` DISABLE KEYS */;
INSERT INTO `ps_cms_category_lang` VALUES (1,1,1,'Accueil','','accueil','','',''),(1,2,1,'Accueil','','accueil','','',''),(3,1,1,'Services','Conditions de Livraison, Conditions de Paiement, Retours et Remboursements','services','Services','',''),(3,2,1,'Les services de Throwback Sneakers','','les-services-de-throwback-sneakers','','',''),(4,1,1,'Liens Légaux','Liens légaux','liens-legaux','Liens légaux','',''),(4,2,1,'Liens Légaux','','liens-legaux','','','');
/*!40000 ALTER TABLE `ps_cms_category_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category_shop`
--

DROP TABLE IF EXISTS `ps_cms_category_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_shop` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category_shop`
--

LOCK TABLES `ps_cms_category_shop` WRITE;
/*!40000 ALTER TABLE `ps_cms_category_shop` DISABLE KEYS */;
INSERT INTO `ps_cms_category_shop` VALUES (1,1),(3,1),(4,1);
/*!40000 ALTER TABLE `ps_cms_category_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_lang`
--

DROP TABLE IF EXISTS `ps_cms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_lang` (
  `id_cms` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `meta_title` varchar(128) NOT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `content` longtext,
  `link_rewrite` varchar(128) NOT NULL,
  PRIMARY KEY (`id_cms`,`id_shop`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_lang`
--

LOCK TABLES `ps_cms_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_lang` DISABLE KEYS */;
INSERT INTO `ps_cms_lang` VALUES (1,1,1,'Livraison','Nos conditions de livraison','conditions, livraison, délais, expédition, colis','<h1>Nos conditions de liva</h1>','livraison'),(1,2,1,'Livraison','Nos conditions de livraison','conditions, livraison, délais, expédition, colis','<h2>Expéditions et retours</h2>\r\n<h3>Expédition de votre colis</h3>\r\n<p>Les colis sont généralement expédiés dans un délai de 2 jours après réception du paiement. Ils sont expédiés via UPS avec un numéro de suivi et remis sans signature. Les colis peuvent également être expédiés via UPS Extra et remis contre signature. Veuillez nous contacter avant de choisir ce mode de livraison, car il induit des frais supplémentaires. Quel que soit le mode de livraison choisi, nous vous envoyons un lien pour suivre votre colis en ligne.</p>\r\n<p>Les frais d\'expédition incluent les frais de préparation et d\'emballage ainsi que les frais de port. Les frais de préparation sont fixes, tandis que les frais de transport varient selon le poids total du colis. Nous vous recommandons de regrouper tous vos articles dans une seule commande. Nous ne pouvons regrouper deux commandes placées séparément et des frais d\'expédition s\'appliquent à chacune d\'entre elles. Votre colis est expédié à vos propres risques, mais une attention particulière est portée aux objets fragiles.<br /><br />Les dimensions des boîtes sont appropriées et vos articles sont correctement protégés.</p>','livraison'),(2,1,1,'Mentions légales','Mentions légales','mentions, légales, crédits','<h2>Mentions légales</h2><h3>Crédits</h3><p>Conception et production :</p><p>cette boutique en ligne a été créée à l\'aide du <a href=\"http://www.prestashop.com\">logiciel PrestaShop. </a>Rendez-vous sur le <a href=\"http://www.prestashop.com/blog/en/\">blog e-commerce de PrestaShop</a> pour vous tenir au courant des dernières actualités et obtenir des conseils sur la vente en ligne et la gestion d\'un site d\'e-commerce.</p>','mentions-legales'),(2,2,1,'Mentions légales','Mentions légales','mentions, légales, crédits','<h2>Mentions légales</h2><h3>Crédits</h3><p>Conception et production :</p><p>cette boutique en ligne a été créée à l\'aide du <a href=\"http://www.prestashop.com\">logiciel PrestaShop. </a>Rendez-vous sur le <a href=\"http://www.prestashop.com/blog/en/\">blog e-commerce de PrestaShop</a> pour vous tenir au courant des dernières actualités et obtenir des conseils sur la vente en ligne et la gestion d\'un site d\'e-commerce.</p>','mentions-legales'),(3,1,1,'Conditions d\'utilisation','Nos conditions d\'utilisation','conditions, utilisation, vente','<h1 class=\"page-heading\">Conditions d\'utilisation</h1>\n<h3 class=\"page-subheading\">Règle n° 1</h3>\n<p class=\"bottom-indent\">Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<h3 class=\"page-subheading\">Règle n° 2</h3>\n<p class=\"bottom-indent\">Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam&#1102;</p>\n<h3 class=\"page-subheading\">Règle n° 3</h3>\n<p class=\"bottom-indent\">Tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam&#1102;</p>','conditions-utilisation'),(3,2,1,'Conditions d\'utilisation','Nos conditions d\'utilisation','conditions, utilisation, vente','<h1 class=\"page-heading\">Conditions d\'utilisation</h1>\n<h3 class=\"page-subheading\">Règle n° 1</h3>\n<p class=\"bottom-indent\">Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<h3 class=\"page-subheading\">Règle n° 2</h3>\n<p class=\"bottom-indent\">Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam&#1102;</p>\n<h3 class=\"page-subheading\">Règle n° 3</h3>\n<p class=\"bottom-indent\">Tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam&#1102;</p>','conditions-utilisation'),(4,1,1,'A propos','En savoir plus sur notre entreprise','à propos, informations','<h1 class=\"page-heading bottom-indent\">A propos</h1>\n<div class=\"row\">\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-block\">\n<h3 class=\"page-subheading\">Notre entreprise</h3>\n<p><strong class=\"dark\">Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididun.</strong></p>\n<p>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam. Lorem ipsum dolor sit amet conse ctetur adipisicing elit.</p>\n<ul class=\"list-1\">\n<li><em class=\"icon-ok\"></em>Produits haute qualité</li>\n<li><em class=\"icon-ok\"></em>Service client inégalé</li>\n<li><em class=\"icon-ok\"></em>Remboursement garanti pendant 30 jours</li>\n</ul>\n</div>\n</div>\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-box\">\n<h3 class=\"page-subheading\">Notre équipe</h3>\n<img title=\"cms-img\" src=\"../img/cms/cms-img.jpg\" alt=\"cms-img\" width=\"370\" height=\"192\" />\n<p><strong class=\"dark\">Lorem set sint occaecat cupidatat non </strong></p>\n<p>Eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.</p>\n</div>\n</div>\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-box\">\n<h3 class=\"page-subheading\">Témoignages</h3>\n<div class=\"testimonials\">\n<div class=\"inner\"><span class=\"before\">“</span>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.<span class=\"after\">”</span></div>\n</div>\n<p><strong class=\"dark\">Lorem ipsum dolor sit</strong></p>\n<div class=\"testimonials\">\n<div class=\"inner\"><span class=\"before\">“</span>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod.<span class=\"after\">”</span></div>\n</div>\n<p><strong class=\"dark\">Ipsum dolor sit</strong></p>\n</div>\n</div>\n</div>','a-propos'),(4,2,1,'A propos','En savoir plus sur notre entreprise','à propos, informations','<h1 class=\"page-heading bottom-indent\">A propos</h1>\n<div class=\"row\">\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-block\">\n<h3 class=\"page-subheading\">Notre entreprise</h3>\n<p><strong class=\"dark\">Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididun.</strong></p>\n<p>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam. Lorem ipsum dolor sit amet conse ctetur adipisicing elit.</p>\n<ul class=\"list-1\">\n<li><em class=\"icon-ok\"></em>Produits haute qualité</li>\n<li><em class=\"icon-ok\"></em>Service client inégalé</li>\n<li><em class=\"icon-ok\"></em>Remboursement garanti pendant 30 jours</li>\n</ul>\n</div>\n</div>\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-box\">\n<h3 class=\"page-subheading\">Notre équipe</h3>\n<img title=\"cms-img\" src=\"../img/cms/cms-img.jpg\" alt=\"cms-img\" width=\"370\" height=\"192\" />\n<p><strong class=\"dark\">Lorem set sint occaecat cupidatat non </strong></p>\n<p>Eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.</p>\n</div>\n</div>\n<div class=\"col-xs-12 col-sm-4\">\n<div class=\"cms-box\">\n<h3 class=\"page-subheading\">Témoignages</h3>\n<div class=\"testimonials\">\n<div class=\"inner\"><span class=\"before\">“</span>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.<span class=\"after\">”</span></div>\n</div>\n<p><strong class=\"dark\">Lorem ipsum dolor sit</strong></p>\n<div class=\"testimonials\">\n<div class=\"inner\"><span class=\"before\">“</span>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet conse ctetur adipisicing elit. Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod.<span class=\"after\">”</span></div>\n</div>\n<p><strong class=\"dark\">Ipsum dolor sit</strong></p>\n</div>\n</div>\n</div>','a-propos'),(5,1,1,'Paiement sécurisé','Notre méthode de paiement sécurisé','paiement sécurisé, ssl, visa, mastercard, paypal','<h2>Paiement sécurisé</h2>\n<h3>Notre paiement sécurisé</h3><p>Avec SSL</p>\n<h3>Avec Visa/Mastercard/Paypal</h3><p>A propos de ce service</p>','paiement-securise'),(5,2,1,'Paiement sécurisé','Notre méthode de paiement sécurisé','paiement sécurisé, ssl, visa, mastercard, paypal','<h2>Paiement sécurisé</h2>\n<h3>Notre paiement sécurisé</h3><p>Avec SSL</p>\n<h3>Avec Visa/Mastercard/Paypal</h3><p>A propos de ce service</p>','paiement-securise'),(7,1,1,'Conditions de Livraison','','','<div class=\"resp-tab-content tab resp-tab-content-active\">\r\n<div class=\"resp-tab-content tab\">\r\n<p align=\"justify\"><strong><span>-Expédition des commandes:</span></strong></p>\r\n<p align=\"justify\">Les commandes Throwback Sneakers sont expédiées par Colissimo La Poste. Le tarif du colis est calculé sur base du poids total estimé des articles compris dans chaque commande. Il comprend emballages, manutention et frais postaux.</p>\r\n<p align=\"justify\"><strong>Important: La livraison est désormais gratuite en Union Européenne, Suisse, Andorre et à Monaco à partir de 200€ d\'achat.</strong></p>\r\n<div>\r\n<p align=\"justify\">Pour la France Metropolitaine, Monaco et Andorre, selon l\'option choisie par le client lors de la commande, la livraison est réalisée par La Poste, soit en Colissimo, soit en Colissimo recommandé avec signature du destinataire à réception.</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Pour toute autre destination, la livraison sera faite par La Poste en Colissimo international (avec signature du destinataire à réception).</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Tous les colis expédiés par Throwback Sneakers possèdent un numéro de suivi qui sera communiqué au client dès l\'expédition effectuée.</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Les commandes sont traitées, préparées et expédiées, c’est-à-dire remises à notre transporteur, dans un délai de 24/48 heures à compter de :</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">-La validation du paiement par le client lorsqu’il est réalisé par virement paypal ou par carte bancaire en ligne</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">-La réception des règlements réalisés par virement</p>\r\n</div>\r\n<div> </div>\r\n<p align=\"justify\">Throwback Sneakers s\'engage à faire le nécessaire pour que les commandes soient livrées dans les 30 jours suivant la validation et réception du règlement. Le transporteur s\'engage, quant à lui, par contrat avec Throwback Sneakers, à livrer la commande à l\'adresse de l\'acheteur fournie par Throwback Sneakers.</p>\r\n<p align=\"justify\">Pour signaler toute difficulté liée à la livraison, le client dispose d’un formulaire de contact en ligne et d’un numéro de téléphone (+33(0)9.50.64.02.96) pour contacter Throwback Sneakers.</p>\r\n<p align=\"justify\">Pour les livraisons hors de la France métropolitaine, le client s\'engage à régler toutes les taxes dues à l\'importation des produits, droits de douane, taxe sur la valeur ajoutée, et toutes autres taxes dues en vertu des lois du pays de réception de la commande. Throwback Sneakers ne saurait être tenu pour responsable du défaut d\'acquittement des taxes au paiement desquelles est tenu le client.</p>\r\n<p align=\"justify\">Quelque soit le lieu de livraison, le colis sera présenté à l\'adresse du destinataire en journée. En cas d\'absence, un avis de passage est laissé à l\'adresse de livraison. Les éventuels frais de nouvelles présentations sont à la charge du client. Le client est tenu de vérifier l\'état des produits lors de la réception. En cas de dommages, il doit mentionner avec précision ses réserves sur le bon de livraison, et les réitérer auprès du transporteur par lettre recommandée avec accusé de réception dans les trois (3) jours suivant la livraison conformément aux dispositions de l\'article L.133-3 du Code de commerce. Il doit en outre informer Throwback Sneakers par lettre recommandée avec accusé de réception de tous dommages dus au transport dans les huit (8) jours suivant la réception. Aucune réclamation ne sera acceptée en cas de non-respect de ces formalités.</p>\r\n</div>\r\n</div>','conditions-de-livraison'),(7,2,1,'Conditions de Livraison','','','','conditions-de-livraison'),(8,1,1,'Conditions de Paiement','','','<p><span>Les systèmes d’enregistrement automatique sont considérés comme valant preuve de la nature et du contenu de la commande. Throwback Sneakers confirme l’acceptation de sa commande au client à l’adresse e-mail que celui-ci aura communiquée. La vente sera conclue à compter de la validation par Throwback Sneakers du paiement de la commande c’est-à-dire de la date de validation du paiement pour les commandes réglées en ligne par carte bancaire (Paypal, cartes Visa, Mastercard, American Express, Aurore, Cofinoga ou 4 Etoiles) ou de la date de réception du règlement par virement ou par chèque (nous consulter). Throwback Sneakers se réserve en tout état de cause le droit de refuser ou d’annuler toute commande d’un client avec lequel existerait un différend relatif au paiement d’une commande antérieure.</span></p>\r\n<div><span><strong>- PRIX et PAIEMENT</strong></span></div>\r\n<div>\r\n<p align=\"justify\"> </p>\r\n<p align=\"justify\">Le prix est exprimé en Euros hors taxes (HT). Le prix indiqué sur les fiches produit ne comprend pas le transport. Le prix indiqué dans la confirmation de commande est le prix définitif, exprimé hors taxes. Ce prix comprend le prix des produits, les frais de manutention, d\'emballage et de conservation des produits, les frais de transport, d\'assurances et de mise en service. Le paiement peut être effectué soit:</p>\r\n<p align=\"justify\">-par paiement en ligne via Paypal ou par carte Visa, Mastercard, American Express, Aurore, Cofinoga ou 4 Etoiles</p>\r\n<div>-par virement bancaire (nous consulter): le colis sera expédié une fois le virement crédité sur le compte bancaire.</div>\r\n<div> </div>\r\n<div>Les paiements par chèque ne sont pas acceptés.</div>\r\n</div>','conditions-de-paiement'),(8,2,1,'Conditions de Paiement','','','','conditions-de-paiement'),(11,1,1,'Retours et Remboursements','','','<p><span>Conformément aux dispositions des articles L.121-20 et suivants du Code de la consommation, le client dispose de 7 jours à compter de la date de réception pour retourner le produit dans son emballage d\'origine pour remplacement ou remboursement. Le retour est aux frais de l\'acheteur et ne sera accepté que si le produit n\'a pas été déconditionné / utilisé. Tout retour doit impérativement être précédé de l\'attribution d\'un numéro de retractation obtenu par le biais de Throwbacksneakers avant d\'être retourné (l\'adresse sera communiquée sur demande). A défaut, le colis sera refusé. Le remboursement interviendra dans les 30 jours suivant la date à laquelle le client a exercé son droit à rétractation (article L121-20-1 du Code de la consommation).</span></p>','retours-et-remboursements'),(11,2,1,'Retours et Remboursements','','','','retours-et-remboursements'),(12,1,1,'Mentions légales','','','<div class=\"rte\">\r\n<div><span><strong>- CONFIDENTIALITE</strong></span></div>\r\n<div><span> </span></div>\r\n<div><span><span>Les informations vous concernant sont destinées uniquement à Throwback Sneakers, pour le traitement des commandes et l\'envoi de newletter (si vous y avez consenti au préalable).<br />En aucun cas, les données personnelles recueillies sur le site <a href=\"http://www.google.com/url?q=http%3A%2F%2Fwww.throwback-sneakers.com&amp;sa=D&amp;sntz=1&amp;usg=AFQjCNFB5zOEpj1SCEyMlhvFUv-MPw5D0w\" target=\"_blank\">www.throwback-sneakers.com</a> ne seront cédées ou vendues à des tiers.<br />Aucune adresse email ne sera transmise à des tiers y compris à nos partenaires sans votre accord.<br />Vous disposez d’un droit d’accès, de modification, de rectification et de suppression des données qui vous concernent (art. 34 de la loi « Informatique et libertés » du 06/01/78).<br />Pour l’exercer, envoyez nous votre demande en utilisant notre <a href=\"http://throwback-sneakers.com/fr/contactez-nous\">formulaire de contact</a>.</span></span></div>\r\n<div><span><span> </span></span></div>\r\n<div><span><span><strong>- COPYRIGHT/protection de la marque</strong></span></span></div>\r\n<div><span><span> </span></span></div>\r\n<div><span><span>Conformément aux textes et dispositions régissant les droits d’auteurs, les droits de propriété littéraire et artistique et/ou les droits voisins, la reproduction, la représentation et l’usage de tout ou partie des éléments composant le site Throwback Sneakers (<a href=\"http://www.google.com/url?q=http%3A%2F%2Fwww.throwback-sneakers.com&amp;sa=D&amp;sntz=1&amp;usg=AFQjCNFB5zOEpj1SCEyMlhvFUv-MPw5D0w\" target=\"_blank\">www.throwback-sneakers.com</a>) à des fins autres que privées sont interdites sans autorisation écrite de l’éditeur du site.</span></span></div>\r\n<div>\r\n<p>Les images et les textes diffusés sur ce site sont la propriété exclusive de Throwback Sneakers et ne peuvent en aucun cas être téléchargées, diffusées, stockées, enregistrées, réutilisées, retransmises, modifiées et plus généralement utilisées à d’autres fins ou d’une autre manière que celles expressément mentionnées aux présentes, sans l’autorisation écrite préalable de l’éditeur du site.<br />La loi incrimine au titre du délit de contrefaçon toute reproduction, représentation ou diffusion, par quelque moyen que ce soit, d’une oeuvre de l’esprit en violation des droits de l’auteur, tels qu’ils sont définis et réglementés par la loi (CPI, art L.335-3).</p>\r\n<p> </p>\r\n<div><span><strong>- CREDITS</strong></span></div>\r\n<div> </div>\r\n<span>Conception et réalisation : </span>Ce site internet a été réalisé en utilisant la solution open-source <a href=\"http://www.prestashop.com/\">PrestaShop</a>™.</div>\r\n</div>','mentions-legales'),(12,2,1,'Mentions légales','','','','mentions-legales'),(14,1,1,'Données personnelles et Cookies','','','','donnees-personnelles-et-cookies'),(14,2,1,'Données personnelles et Cookies','','','','donnees-personnelles-et-cookies'),(16,1,1,'Conditions générales de vente','','','<div class=\"rte\">\r\n<div>\r\n<p align=\"justify\">Propriété du site : le site est la propriété de la société Throwback Sneakers en sa totalité, ainsi que l\'ensemble des droits y afférents. Toute reproduction, intégrale ou partielle, est interdite sauf autorisation expresse et préalable de Throwback Sneakers.</p>\r\n</div>\r\n<div><span> </span></div>\r\n<div><span><strong>- ACCEPTATION DES CONDITIONS GENERALES DE VENTE</strong></span></div>\r\n<div><span> </span></div>\r\n<div>\r\n<p align=\"justify\">Le client reconnaît avoir pris connaissance, préalablement à la passation de commande, des conditions générales de vente énoncées sur cette page. Les présentes conditions générales de vente régissent les relations contractuelles entre Throwback Sneakers et son client. Elles prévaudront sur toutes autres conditions figurant dans tout autre document, sauf dérogation préalable, expresse et écrite de Throwback Sneakers. Les présentes conditions générales de vente peuvent être modifiées à tout moment par Throwback Sneakers, sans préavis.</p>\r\n</div>\r\n<div><span><span><strong> </strong></span></span></div>\r\n<div><span><strong>- COMMANDE</strong></span></div>\r\n<div><span><span><strong> </strong></span></span></div>\r\n<div>\r\n<p align=\"justify\">Les systèmes d’enregistrement automatique sont considérés comme valant preuve de la nature et du contenu de la commande. Throwback Sneakers confirme l’acceptation de sa commande au client à l’adresse e-mail que celui-ci aura communiquée. La vente sera conclue à compter de la validation par Throwback Sneakers du paiement de la commande c’est-à-dire de la date de validation du paiement pour les commandes réglées en ligne par carte bancaire (Paypal, cartes Visa, Mastercard, American Express, Aurore, Cofinoga ou 4 Etoiles) ou de la date de réception du règlement par virement ou par chèque (nous consulter). Throwback Sneakers se réserve en tout état de cause le droit de refuser ou d’annuler toute commande d’un client avec lequel existerait un différend relatif au paiement d’une commande antérieure.</p>\r\n<p align=\"justify\"> </p>\r\n</div>\r\n<div><span><strong>- PRIX et PAIEMENT</strong></span></div>\r\n<div>\r\n<p align=\"justify\"> </p>\r\n<p align=\"justify\">Le prix est exprimé en Euros hors taxes (HT). Le prix indiqué sur les fiches produit ne comprend pas le transport. Le prix indiqué dans la confirmation de commande est le prix définitif, exprimé hors taxes. Ce prix comprend le prix des produits, les frais de manutention, d\'emballage et de conservation des produits, les frais de transport, d\'assurances et de mise en service. Le paiement peut être effectué soit:</p>\r\n<p align=\"justify\">-par paiement en ligne via Paypal ou par carte Visa, Mastercard, American Express, Aurore, Cofinoga ou 4 Etoiles</p>\r\n<div>-par virement bancaire (nous consulter): le colis sera expédié une fois le virement crédité sur le compte bancaire.</div>\r\n<div> </div>\r\n<div>Les paiements par chèque ne sont pas acceptés.</div>\r\n<div> </div>\r\n<span><strong>- CLAUSE DE RESERVE DE PROPRIETE</strong></span></div>\r\n<div><span> </span></div>\r\n<div>\r\n<p align=\"justify\">De convention expresse, et conformément aux dispositions de la loi du 12 mai 1980, les produits commandés restent la propriété de Throwback Sneakers jusqu\'au paiement intégral de leur prix par le client. En cas d\'inexécution de ses obligations par le client, quelle qu\'en soit la cause, Throwbacks Sneakers sera en droit d\'exiger la restitution immédiate des produits aux frais, risques et périls du client.</p>\r\n</div>\r\n<div><span> </span></div>\r\n<div><span><strong>- DISPONIBILITE et EXPEDITION DES PRODUITS</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<div>\r\n<p align=\"justify\">L\'indication \"en stock\" signifie que l\'objet est disponible chez Throwback Sneakers au moment de la commande.</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">L\'indication \"épuisé\" signifie que l\'objet n\'est plus disponible à la vente.</p>\r\n</div>\r\n<div><span> </span></div>\r\n<div>\r\n<p align=\"justify\">Pour la France Metropolitaine, Monaco et Andorre, selon l\'option choisie par le client lors de la commande, la livraison est réalisée par La Poste, soit en Colissimo, soit en Colissimo recommandé avec signature du destinataire à réception.</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Pour toute autre destination, la livraison sera faite par La Poste en Colissimo international (avec signature du destinataire à réception).</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Tous les colis expédiés par Throwback Sneakers possèdent un numéro de suivi qui sera communiqué au client dès l\'expédition effectuée.</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">Les commandes sont traitées, préparées et expédiées, c’est-à-dire remises à notre transporteur, dans un délai de 24/48 heures à compter de :</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">-La validation du paiement par le client lorsqu’il est réalisé par virement paypal ou par carte bancaire en ligne</p>\r\n</div>\r\n<div>\r\n<p align=\"justify\">-La réception des règlements réalisés par virement ou par chèque</p>\r\n</div>\r\n<div> </div>\r\n<div>\r\n<p align=\"justify\">Throwback Sneakers s\'engage à faire le nécessaire pour que les commandes soient livrées dans les 30 jours suivant la validation et réception du règlement. Le transporteur s\'engage, quant à lui, par contrat avec Throwback Sneakers, à livrer la commande à l\'adresse de l\'acheteur fournie par Throwback Sneakers.</p>\r\n<p align=\"justify\">Pour signaler toute difficulté liée à la livraison, le client dispose d’un formulaire de contact en ligne et d’un numéro de téléphone (+339.51.38.81.69) pour contacter Throwback Sneakers.</p>\r\n<p align=\"justify\">Pour les livraisons hors de la France métropolitaine, le client s\'engage à régler toutes les taxes dues à l\'importation des produits, droits de douane, taxe sur la valeur ajoutée, et toutes autres taxes dues en vertu des lois du pays de réception de la commande. Throwback Sneakers ne saurait être tenu pour responsable du défaut d\'acquittement des taxes au paiement desquelles est tenu le client.</p>\r\n<p align=\"justify\">Quelque soit le lieu de livraison, le colis sera présenté à l\'adresse du destinataire en journée. En cas d\'absence, un avis de passage est laissé à l\'adresse de livraison. Les éventuels frais de nouvelles présentations sont à la charge du client. Le client est tenu de vérifier l\'état des produits lors de la réception. En cas de dommages, il doit mentionner avec précision ses réserves sur le bon de livraison, et les réitérer auprès du transporteur par lettre recommandée avec accusé de réception dans les trois (3) jours suivant la livraison conformément aux dispositions de l\'article L.133-3 du Code de commerce. Il doit en outre informer Throwback Sneakers par lettre recommandée avec accusé de réception de tous dommages dus au transport dans les huit (8) jours suivant la réception. Aucune réclamation ne sera acceptée en cas de non-respect de ces formalités.</p>\r\n<p align=\"justify\">Throwback Sneakers sera, en tout état de cause, dégagé de son obligation de livrer en cas de :</p>\r\n<p align=\"justify\">-survenance d\'un cas de force majeure tel que notamment la guerre, l\'émeute, l\'incendie, les grèves, les accidents et l\'impossibilité d\'être approvisionné,</p>\r\n<p align=\"justify\">-inexécution par le client de l\'une de ses obligations (paiement du prix, exactitude des informations communiquées par le client telles que l\'adresse de livraison)</p>\r\n<div> </div>\r\n</div>\r\n<div><span><strong>- LIMITATION de RESPONSABILITE</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<div>\r\n<p align=\"justify\">Les renseignements donnés sur le site (photographies, fiches produits, prix, etc) sont donnés à titre indicatif. Throwback Sneakers s\'efforce de veiller à l\'exactitude des informations présentées sur le site. Les erreurs susceptibles de s\'y être introduites sont fortuites et sont rectifiées dans les plus brefs délais.</p>\r\n<div> </div>\r\n<div><span><strong>- RETRACTATION</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<p align=\"justify\">Conformément aux dispositions des articles L.121-20 et suivants du Code de la consommation, le client dispose de 7 jours à compter de la date de réception pour retourner le produit dans son emballage d\'origine pour remplacement ou remboursement. Le retour est aux frais de l\'acheteur et ne sera accepté que si le produit n\'a pas été déconditionné / utilisé. Tout retour doit impérativement être précédé de l\'attribution d\'un numéro de retractation obtenu par le biais de Throwbacksneakers avant d\'être retourné (l\'adresse sera communiquée sur demande). A défaut, le colis sera refusé. Le remboursement interviendra dans les 30 jours suivant la date à laquelle le client a exercé son droit à rétractation (article L121-20-1 du Code de la consommation).</p>\r\n<div> </div>\r\n<div><span><strong>- INFORMATIONS LEGALES</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<p align=\"justify\">Les informations nominatives relatives au client sont indispensables pour le traitement et l\'acheminement des commandes, l\'établissement des factures et contrats de garantie. Le défaut de renseignement entraîne la non validation de la commande. Conformément à la loi \" Informatique et Libertés \", le traitement des informations nominatives relatives aux clients a fait l\'objet d\'une déclaration auprès de la Commission Nationale de l\'Informatique et des Libertés (CNIL). Le client dispose (article 34 de la loi du 6 janvier 1978) d\'un droit d\'accès, de modification, de rectification et de suppression des données qui le concernent, qu\'il peut exercer auprès de Throwback Sneakers.</p>\r\n<div> </div>\r\n<div><span><strong>- DROIT APPLICABLE</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<p align=\"justify\">Toutes les ventes de Throwback Sneakers sont soumises au droit français. En cas de litige, seul le Tribunal de Paris est compétent.</p>\r\n<div> </div>\r\n<div><span><strong>- IMMATRICULATION</strong></span></div>\r\n<div><span><strong> </strong></span></div>\r\n<div>Throwback Sneakers</div>\r\n<div>France</div>\r\n<div>Tel +33(0)9.50.64.02.96</div>\r\n<div>Tel France metropolitaine 09.50.64.02.96</div>\r\n<p align=\"justify\">N° de SIRET 513 158 931 00024 \"Dispensé d\'immatriculation en application de l\'article L123-1-1 du code du commerce\"</p>\r\n</div>\r\n</div>','conditions-generales-de-vente'),(16,2,1,'Conditions générales de vente','','','','conditions-generales-de-vente');
/*!40000 ALTER TABLE `ps_cms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_role`
--

DROP TABLE IF EXISTS `ps_cms_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role` (
  `id_cms_role` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `id_cms` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_role`,`id_cms`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_role`
--

LOCK TABLES `ps_cms_role` WRITE;
/*!40000 ALTER TABLE `ps_cms_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cms_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_role_lang`
--

DROP TABLE IF EXISTS `ps_cms_role_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role_lang` (
  `id_cms_role` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_cms_role`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_role_lang`
--

LOCK TABLES `ps_cms_role_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_role_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cms_role_lang` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-10 18:53:44
