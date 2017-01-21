Machine Virtual pour le projet Throwback
========================================

Objectif
--------

industrialiser l’installation de Prestashop sur mon serveur de développement

Vagrant LAMP stack pour Throwback/Prestashop :


Desc
----

Contient la stack LAMP (Linux Apache MySQL PHP) et les modules nécessaires à Prestashop
Chaque version disposera de sa propre base de données
built a vagrant/virtualbox web server as a development sandbo

Stack
-----
OS: Debian 8
Web server : Apache 2
Php 5.6 + severals extensions
MySQL 5.5
PHPMyAdmin & Adminer
Prestashop 1.6


steps to make it work !
----------------------

1. Assurez vous que l'option virtualisation est activé sur vôtre OS
pour windows, tapez 'systeminfo' en command line pour vérifiez

Si c'est pas activez, aller l'activer dans le BIOS avant de continuer

2. Installer  VirtualBox et Vagrant sur vôtre machine

3. cloner le project

4. entrer dans le dossier du projet, tapez 'vagrant up' and enjoy !

5. Accés aux différents outils :

6. Accès aux outils :

..* l'interface d'administration de la boutique Prestashop :
admin URL : http://localhost:8081/throwback16/admin-dev
Admin access : pub@prestashop.com / 0123456789

..* Accès au front-end :
cliquez sur "Voir mon magasin" en haut à droite de l'interface admin
ou http://localhost:8081/throwback16/

..* DB admin :

Root User : root / root
shop User : test / test

PhpMyadmin
 http://localhost:8081/phpmyadmin/

Adminer
http://localhost:8081/adminer.php/


Troubleshooting
----------------

make a coffee for me and may be... i'll come help you :-)
