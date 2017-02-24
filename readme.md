Projet Throwback SNEAKERS
========================================

Stack
-----
- Prestashop 1.6.11
- Wordpress 4.7

A utiliser avec Un environnement WAMP : Laragon ou Wamp Serveur

steps to make it work !
----------------------

1. Cloner le repo


4. placer le project dans le répertorie web laragon :

laragon/wwww/thorwback16



5. Installer les baseS de donnée

importer les fichers sql : throwbackpresta-DEV.sql et throwbackwordpress-DEV.sql


7. Accès aux webapps & outils :

* boutique :
- FO : http://localhost/throwback16/admin16
- BO : http://localhost/throwback16/

- Admin : pub@prestashop.com / 0123456789
- Client : pub@prestashop.com / aqwzsx123


* Wordpress :
- Front | https://throwback16.dev/blog
- Back | https://throwback16.dev/blog/wp-admin/
- login : Gael / dedeagassi


Troubleshooting
----------------


* droit acce fichier :

exécuter laragon en mod administrateur

* augmenter la limite d'import de fichier sur phpmyadmin :
/etc/php5/apache2/php.ini

Set the variables upload_max_filesize, post_max_size, memory_limit in php.ini to the right values
post_max_size : 50M

    * trooble shooting
Fatal error: Maximum execution time of 300 seconds exceeded

Pour modifier le temps limit d'éxécution de phpmyadmin, il faut aller dans :
Phpmyadmin\libraries\config.default.php et trouver la ligne :

$cfg['ExecTimeLimit'] = 300;

remplaçant 300 par 1800 (ou plus) on augmente la durée maximale en seconde autoriser pour exécuter un script,  ce qui permet d'importer des fichiers beaucoup plus gros.

Deploy on remote SNE server
----------------

* add multiple pushurl for sne given remote

git remote add sneorigin ssh://dev@vps365425.ovh.net:29/home/dev/mygithub/throwback.git

* verify remotes config

git remote -v

* when you want to deploy on sne serveur , push to sneorigin :

dev / snedev
