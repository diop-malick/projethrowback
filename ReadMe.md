Machine Virtual pour le projet Throwback
========================================

Vagrant LAMP stack for Throwback, to Set up distributed development environments with VAGRANT.

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
- OS: Debian 8
- Web server : Apache 2
- Php 5.6 + severals extensions
- MySQL 5.5
- PHPMyAdmin & Adminer
- Prestashop 1.6


steps to make it work !
----------------------

1. Assurez vous que l'option virtualisation est activé sur vôtre OS
pour windows, tapez 'systeminfo' en command line pour vérifiez

Si c'est pas activez, aller l'activer dans le BIOS avant de continuer

2. Installer  VirtualBox et Vagrant sur vôtre machine

  
4. cloner le project

5. entrer dans le dossier du projet, tapez 'vagrant up'.
 
Allez prendre un café, cette étape peut être très longue si vous installez vagrant pour la première fois.


7. Accès aux webapps & outils :

* BO boutique :
- admin URL : http://localhost:8081/throwback16/admin16
- Admin access : pub@prestashop.com / 0123456789

* FO boutique :
cliquez sur "Voir mon magasin" en haut à droite de l'interface admin
ou http://localhost:8081/throwback16/

* DB admin :

- Root User : root / root
- throwbackDB User : test / test
- wordpress user : usertbwp / pwdtbwp

- PhpMyadmin | http://localhost:8081/phpmyadmin/
- Adminer http://localhost:8081/adminer.php/

..* Wordpress : 
- Front | http://localhost:8081/throwback16/blog
- Back | http://localhost:8081/throwback16/blog/wp-admin/

..* Wordpress admin user : 
- identifiant : tbwpadmin
- password : T2KK#gXK6ffel$HMkW
- mail : mdiop.sne@gmail.com


Troubleshooting
----------------

if You experience some error with the conf, let me known, make a coffee for me and may be... i'll come help you :-)


Ressources :
----------------

Installer PrestaShop en ligne de commande
http://doc.prestashop.com/display/PS16/Installer+PrestaShop+en+ligne+de+commande

https://www.shellcheck.net/

https://gist.github.com/asmerkin/df919a6a79b081512366

https://gist.github.com/rrosiek/8190550

mysqlDump
http://cipcnet.insa-lyon.fr/sqltut/nexen/mysqldump.html



* Si vous avez un problème de Sync folder Vagrant/virtualBox (Only for FIRST Vagrant installation) Installer le plugin vagrant pour virtualBox : 

ouvrez un terminal et lancer la command suivante : 
```bash
vagrant plugin install vagrant-vbguest
```

source : https://github.com/mitchellh/vagrant/issues/6769 
