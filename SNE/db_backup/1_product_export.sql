-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `ps_employee`;
CREATE TABLE `ps_employee` (
  `id_employee` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_profile` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL DEFAULT '0',
  `lastname` varchar(32) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `last_passwd_gen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stats_date_from` date DEFAULT NULL,
  `stats_date_to` date DEFAULT NULL,
  `stats_compare_from` date DEFAULT NULL,
  `stats_compare_to` date DEFAULT NULL,
  `stats_compare_option` int(1) NOT NULL DEFAULT '1',
  `preselect_date_range` varchar(32) DEFAULT NULL,
  `bo_color` varchar(32) DEFAULT NULL,
  `bo_theme` varchar(32) DEFAULT NULL,
  `bo_css` varchar(64) DEFAULT 'admin-theme.css',
  `default_tab` int(10) unsigned NOT NULL DEFAULT '0',
  `bo_width` int(10) unsigned NOT NULL DEFAULT '0',
  `bo_menu` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `optin` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `id_last_order` int(10) unsigned NOT NULL DEFAULT '0',
  `id_last_customer_message` int(10) unsigned NOT NULL DEFAULT '0',
  `id_last_customer` int(10) unsigned NOT NULL DEFAULT '0',
  `last_connection_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id_employee`),
  KEY `employee_login` (`email`,`passwd`),
  KEY `id_employee_passwd` (`id_employee`,`passwd`),
  KEY `id_profile` (`id_profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ps_employee` (`id_employee`, `id_profile`, `id_lang`, `lastname`, `firstname`, `email`, `passwd`, `last_passwd_gen`, `stats_date_from`, `stats_date_to`, `stats_compare_from`, `stats_compare_to`, `stats_compare_option`, `preselect_date_range`, `bo_color`, `bo_theme`, `bo_css`, `default_tab`, `bo_width`, `bo_menu`, `active`, `optin`, `id_last_order`, `id_last_customer_message`, `id_last_customer`, `last_connection_date`) VALUES
(1, 1,  2,  'Sneakers', 'Throwback',  'bataille.christophe@gmail.com',  '33fea5102bc246c6315d1262b2ca5864', '2012-11-01 06:59:40',  '2013-01-01', '2014-01-20', NULL, NULL, 1,  NULL, '', 'default',  'admin-theme.css',  3,  0,  1,  1,  1,  2840, 1800, 3870, '0000-00-00'),
(2, 1,  2,  'Throwback',  'Admin',  'postmaster@throwback-sneakers.com',  '3fa845112219a3687937b61d8cd6f289', '2012-11-01 07:12:15',  '2017-01-01', '2017-12-31', NULL, NULL, 1,  NULL, '', 'default',  'admin-theme.css',  3,  0,  1,  1,  1,  2840, 1800, 3870, '2017-07-05'),
(3, 1,  2,  'Sneakers', 'Addict', 'jeremy@sneakersaddict.com',  'd4f40cd9fcb817d13b86de1bf1a1e061', '2012-11-02 13:17:08',  '2012-11-02', '2013-11-02', NULL, NULL, 1,  NULL, NULL, 'default',  'admin-theme.css',  3,  0,  1,  1,  1,  2840, 1800, 3870, '0000-00-00');

DROP TABLE IF EXISTS `ps_employee_shop`;
CREATE TABLE `ps_employee_shop` (
  `id_employee` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_employee`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ps_employee_shop` (`id_employee`, `id_shop`) VALUES
(1, 1),
(2, 1),
(3, 1);

-- 2017-07-05 15:05:17