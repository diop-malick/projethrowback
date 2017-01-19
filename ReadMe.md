

Objectif :
’industrialiser l’installation de Prestashop sur mon serveur de développement

Vagrant LAMP stack pour Throwback/Prestashop :

Desc :
Contient la stack LAMP (Linux Apache MySQL PHP) et les modules nécessaires à Prestashop
Chaque version disposera de sa propre base de données
built a vagrant/virtualbox web server as a development sandbo

Stack :
VM Guest OS: Debian 8
apache 2, php 5.6, MySQL 5.5 , PHPMyAdmin, adminer
Prestashop 1.6

1 - Installer  VirtualBox et Vagrant sur vôtre machine

2 - cloner le projec

3 - entr le dossier du projet et faite un : vagrant up

5 - Dossiers :

dossier web : src\public

4 - Accés aux différents outils :


# Accès au front-end :
cliquez sur "Voir mon magasin" en haut à droite de l'interface admin
ou
http://localhost:8081/prestashop16/

# Administration DB

* PhpMyadmin
 http://localhost:8081/phpmyadmin/

* Adminer
  http://localhost:8081/adminer.php/

Admin :
username : root
password : root

prestashop
user : test
password : test


# Accès à l'interface d'administration de Prestashop :
* admin URL
http://localhost/prestashop16/admin-dev

* Admin access :
email = pub@prestashop.com
password = 0123456789
