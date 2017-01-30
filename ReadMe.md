Machine Virtual pour le projet Throwback
========================================

Vagrant LAMP stack for Throwback, to Set up distributed development environments with VAGRANT

Contient la stack LAMP et les modules nécessaires à Prestashop. Chaque boutique disposera de sa propre base de données.

Objectifs
-----

- industrialiser l’installation de Prestashop sur les env de développement
- built a vagrant/virtualbox web server as a development sandbox
- distribute this environment across team members
- iso-prod dev env
- anyone working on the project will benefit from the same environment


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
admin URL : http://localhost:8081/throwback16/admin16
Admin access : pub@prestashop.com / 0123456789

..* Accès au front-end :
cliquez sur "Voir mon magasin" en haut à droite de l'interface admin
ou http://localhost:8081/throwback16/

..* DB admin :

Root User : root / root
throwbackDB User : test / test

PhpMyadmin
 http://localhost:8081/phpmyadmin/

Adminer
http://localhost:8081/adminer.php/


dump DB
-------

cd /vagrant/public
rm dbdumpfile.sql
sudo mysqldump -uroot -proot --databases throwbackpresta16 > dbdumpfile.sql

vérifier l'intégrité du cichier dumpfle.sql

Manips 
---------


Pour annuler tous vos modifs et epartir d'une version clean

git checkout .
git reset
git clean -fd

git pull 

Troubleshooting
----------------

- make a coffee for me and may be... i'll come help you :-)

- if You experience some error with the conf, let me known it.

Ressources :
----------------

Installer PrestaShop en ligne de commande
http://doc.prestashop.com/display/PS16/Installer+PrestaShop+en+ligne+de+commande

https://www.shellcheck.net/

https://gist.github.com/asmerkin/df919a6a79b081512366

https://gist.github.com/rrosiek/8190550

mysqlDump
http://cipcnet.insa-lyon.fr/sqltut/nexen/mysqldump.html




