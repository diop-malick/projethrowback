
https://docs.ovh.com/display/public/CRVPS/Installation+d%27un+serveur+web+sous+Debian+8

* bas de page :
Sommaire de la série Monter un serveur dédié de A à Z

# check 

* voir l'uptime (la durée de fonctionnement de votre machine depuis le dernier redémarrage)
$ w
$ ping vps365425.ovh.net


* consulterjournal system 
journalctl -xn

* reboot serveur 
/sbin/reboot

* logs
tail -f /var/log/mail.log

* 

# terminal

Ctrl+l      effacer terminal
ctrl+d      exit terminal


# vim

recherche : apuyer sur "/" puis taper lemot recherhé, appuyer sur n pour parcourir les récurrences
inserer : i
sortir insert : échap
enregistrer et quitter : :wq ou :x
quitter : :q
Quitter sans enregistrer | :q! 
supprimer ligne courante : apuyer sur deux fois - dd
vim supprimer contenu fichier : 
active syntax on vim :
sudo vim ~/.vimrc
  ajouter "syntax on"

### log in ssh

ssh root@193.70.112.96 -p 5160  || ssh root@vps365425.ovh.net
connection par clé : clé généré avec Puttygen / connexion avec putty


send key to server : 
cat \Users\Malick\.ssh\id_rsa.pub
cat \Users\Malick\.ssh\id_rsa.pub | ssh root@193.70.112.96 'cat >> .ssh/authorized_keys'

to exit : logout or exit

lancer zsh : zsh
basculer sur bash : bash

# config ssh access

sudo vim /etc/ssh/sshd_config

  ajouter :  AllowUsers root
  changer port par défaut :
    Port 5789
sudo service ssh restart

# PIM my shell : zsh + oh-my-zsh + tmux
https://github.com/robbyrussell/oh-my-zsh
https://doc.ubuntu-fr.org/zsh
https://www.codementor.io/linux/tutorial/configure-linux-toolset-zsh-tmux-vim
https://www.grafikart.fr/formations/serveur-linux/pimp-my-shell

sudo apt-get install -y zsh
$ sudo apt-get install -y tmux

* switch defautl shell :
chsh -s /bin/zsh

* config zsh
cd
vim .zshrc

* reload zsh
source ~/.zshrc

* liste theme oh-my-zsh
dans ~/.oh-my-zsh/themes

used theme : https://github.com/nojhan/liquidprompt

* plugin oh-my-zsh à activer dans .zshrc :
plugins=(git)

* LES ALIAS :
voir alis git : alias | grep git

  $ g init
  $ g clone ...
  $ gl # équivalent à 'git pull'
  $ gp # équivalent à 'git push'
  $ gst # équivalent à 'git status'
  $ gss # équivalent à 'git status -s'

  $ gd # équivalent à 'git diff'
  $ gdc # équivalent à 'git diff --cached'

### UPDATE
sudo apt-get update && sudo apt-get upgrade -y


 
# =================================================== #
# Install Basic tools
# =================================================== #
sudo apt-get install -y unzip vim git curl



# =================================================== #
# WEB SERVEUR : Apache2
# =================================================== #
sudo apt-get install -y apache2
sudo apt-get install -y apache2-mpm-worker libapache2-mod-fastcgi


## PHP

sudo apt-get install -y php5 libapache2-mod-php5
sudo apt-get install -y php5-mysql php-pear php5-xdebug php5-curl php5-gd php5-mcrypt php-gettext

sudo /etc/init.d/apache2 restart
or 
systemctl reload apache2

### configure PHP fpm

* in etc/php5/apache2/php.init
change :
  display_errors = on

sudo /etc/init.d/apache2 restart

# passage PHP7-FPM en mod FastCGI avec Apache MPM Worker
https://www.skyminds.net/serveur-dedie-passage-au-mod-fastcgi-et-php-fpm-avec-apache-mpm-worker/
https://www.skyminds.net/serveur-dedie-installer-php7-fpm-avec-fastcgi-sous-debian/

http://www.love-moi.fr/2016/01/installer-php-7-avec-php-fpm-et-fastcgi.html


* list intalled php5
dpkg --list | grep php | awk '/^ii/{ print $2}'

* check php
php --version

* remove php5 package : do it in bash mode
cd
bash
sudo apt-get purge php5-*

php7.0-xdebug
php7.0-mcrypt
php7.0-gettext

* install PHP7
sudo apt-get install php7.0 php7.0-fpm
sudo apt-get install php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-xdebug php7.0-mcrypt php7.0-mbstring php7.0-imagick php7.0-imap libpcre3

* fichier init : /etc/php/7.0/fpm/php.ini

    activer directive :
        error_log = /var/log/php_errors.log
        display_errors = on
    augmente la valeur des directives upload :
      upload_max_filesize = 32M
      post_max_size = 32M
    assigne le bon fuseau horaire : date.timezone = Europe/Paris
    définis  session :
      session.save_handler = files
      session.save_path = ""
      session.gc_probability = 1
      session.gc_divisor = 100
      session.gc_maxlifetime = 1440
      session.lazy_write = On

* Rédémarer PHP-FPM et Apache :
service php7.0-fpm restart
service apache2 restart

* Apache tourne désormais avec mod_fastcgi et PHP-FPM!


# configure apache

* Enabling mod_rewrite for URL rewriting

sudo a2enmod rewrite

sudo /etc/init.d/apache2 restart


# --------------------------------------- #
#          SGBD : MySQL 5.5
# --------------------------------------- #

sudo apt-get install -y mysql-server

sudo /etc/init.d/apache2 restart

change root password : https://wiki.debian-fr.xyz/Changer_le_mot_de_passe_mysql

* check mysql package 
dpkg -l | grep mysql

# --------------------------------------- #
#          SGBD : MySQL 5.6
# --------------------------------------- #

1. via DEBIAN backport 

https://backports.debian.org/Instructions/

OR 

2. via MySQL APT repository 
https://dev.mysql.com/downloads/repo/apt/
https://wiki.zoneminder.com/Install_MySQL_5.6_on_Debian_Jessie

* Backup DB
mysqldump --databases mantisdb mail testlinkdb > dbtoolsdump.sql

wget -q http://dev.mysql.com/get/mysql-apt-config_0.8.1-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.1-1_all.deb  | choose mysql 1.6
sudo apt-get update
sudo apt-get install mysql-server

sudo service mysql status
sudo service mysql stop
sudo service mysql start 

sudo systemctl restart mysql

mysql_upgrade -u root -pmysqlsne123

dpkg -l | grep mysql | grep ii
mysql --version

* mysql conf : /etc/mysql/my.cnf

* Configure iptables for firewall
sudo iptables -I INPUT -p udp --dport 3306 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3306 --syn -j ACCEPT

* allow remote access :
comment the followinf line in my.conf : 
  skip-networking
  bind-address = 127.0.0.1

* test remote conection
telnet 193.70.112.96 3306
mysql -u throwbackpresta  -pHYn99OxM4yP6TsSe -h 193.70.112.96

* Logs
https://www.it-connect.fr/activer-les-logs-dans-mysql/

* check 
voir liste process : run sql command : show full processlist
voir paramètre cache : SHOW VARIABLES LIKE 'query_cache_%';
max connetion : SHOW VARIABLES LIKE 'max%connections';

* MYSQL Performance : Optimisation
- slow remote connection > stop dns lookup, removes the dependency on the DNS sevice : turn off MySQL reverse DNS turned
http://www.vionblog.com/skip-name-resolve-to-speed-up-mysql-and-avoid-problems/

- moteur de données :
MyISAM plutôt que InnoDB
encodage UTF-8

 MySqlTuner  ?

- Query cache : query_cache_type 
http://sametmax.com/optimiser-mysql-en-utilisant-le-cache-query_cache_size/

- cache : memcache & innod db
https://dev.mysql.com/doc/refman/5.6/en/innodb-memcached-benefits.html

 MysqlCheck ?
 https://www.saotn.org/check-repair-and-optimize-mysql-tables-with-mysqlcheck/

# --------------------------------------- #
#          PHPMyAdmin
# --------------------------------------- #

cd /var/www/html/
wget https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.tar.gz
tar xzf https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.tar.gz
rm https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.tar.gz
mv phpMyAdmin-4.6.5.2-all-languages phpmyadmin


# Server FTP : proFTPD
https://www.grafikart.fr/formations/serveur-linux/proftpd

sudo apt-get install -y proftpd

  version standalone sur port 21
  TODO : ouvrir le port 21

* ajouter utlisateur ftp  
sudo adduser sneftp

* change config :
sudo vim /etc/proftpd/proftpd.conf


# --------------------------------------- #
#          Virtual Host Apache
# --------------------------------------- #


# --------------------------------------- #
#          https SSL/TLS
# --------------------------------------- #


https://letsencrypt.org/docs/
https://certbot.eff.org/#debianjessie-apache

* https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-debian-8

* http://tutos.tangui.eu.org/2016/08/09/deployer-letsencrypt-sur-debian-jessie/

https://grafikart.fr/tutoriels/divers/comprends-ssl-tls-745
https://www.grafikart.fr/formations/serveur-linux/apache-ssl-letsencrypt

https://www.skyminds.net/serveur-dedie-securiser-apache-avec-https-http-avec-la-couche-tlsssl-en-perfect-forward-secrecy/

Secure Apache with Free Let's Encrypt SSL Certificate on Debian 8

Securisé le nom de domaine 
Mise en place du protocole HTTPS avec un certificat SSL/TLS, pour encrypter les échanges avec le serveur et sécuriser les informations

https -> certificat SSL signé par un organisme de certif

SSL :
  Secure Sockets Layer (SSL) est un protocole cryptographique
TLS :
  Transport Layer Security (TLS) est le successeur de SSL

OpenSSL : 
Let's Encrypt : autorité de certificat, outils pour mise en place automatique de certificat

*  Enable SSL Module

$ sudo a2enmod ssl
$ sudo a2ensite default-ssl.conf
$ sudo service apache2 restart

* access domain name via HTTPS : 
https://vps365425.ovh.net/

* backport

$ echo 'deb http://ftp.debian.org/debian jessie-backports main' | sudo tee /etc/apt/sources.list.d/backports.list

$ sudo apt-get update

$ sudo apt-get install -y python-certbot-apache -t jessie-backports

* 
$ vim /etc/apache2/sites-available/000-default.conf

* Check the configuration file syntax
$ sudo apache2ctl configtest

* restart 
$ sudo systemctl restart apache2

* Adjusting the Firewall : iptables
$ sudo iptables -S

* Set Up the SSL Certificate
$ sudo certbot --apache

* Rep certificats générés : /etc/letsencrypt/live/ 


* test configuration : 
https://www.ssllabs.com/ssltest/analyze.html?d=vps365425.ovh.net

* Auto Renewal
$ sudo certbot renew

sudo crontab -e

*  Details about your renewal 
 cat /etc/letsencrypt/renewal/caeszar.tk.conf




apt-get install -y openssl
openssl genrsa -aes256 -out certificat.key 4096


# configure httml/ssl OPENSSL

# check info

* IP and hostname

hostname
hostname -f
ifconfig

ifconfig | grep "inet addr"

* voir user 
whoami
su - www-data

* To list your Debian version

lsb_release -a

* apache version
/usr/sbin/apache2 -v

chsow apache module :
sudo apache2ctl -M | sort

vérif apache conf :
apache2ctl configtest

* check package is installed :
dpkg -s <packagename>




* mysql

sudo service mysql status
mysql --version

vérifier les espace diques :
df
df -i

* identifier les répertoires qui en consomment le plus:
```bash
for i in /*; do echo $i; find $i |wc -l; done
for i in /var/*; do echo $i; find $i |wc -l; done
for i in /var/lib/*; do echo $i; find $i |wc -l; done
```

* calcul taille répertoire
du -s /var/lib/php/sessions

* liste user 
cat /etc/passwd | awk -F: '{print $ 1}'

* aficher groupes
cat /etc/group | awk -F: '{print $ 1}'

## ménage

* un petit ménage dans les paquets obsolètes
apt-get autoclean && apt-get autoremove

# --------------------------------------- #
#          testlink
# --------------------------------------- #



# lynx
navigateur Web en mode texte utlisable via console

apt-get install -y lynx
lynx http://193.70.112.96/info


# --------------------------------------- #
#          WEBMIN
# --------------------------------------- #
https://doc.ubuntu-fr.org/webmin
https://homeserver-diy.net/wiki/index.php?title=Installation_d%27une_interface_web_Webmin

Webmin : 
interface Web basée sur Perl pour l’administration système sous Linux.
permet d’administrer les serveurs via un navigateur

virtualmin : 

* features 
gestion comptes utilisateurs, gérer les quotas disque, configurer les fichiers, contrôler le serveur Apache ainsi que MySQL et PHP.

- rules : 
le laisser en anglais 

* ajout dépôt 
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list

* Récupérer et installer la clé GPG
wget http://www.webmin.com/jcameron-key.asc 
apt-key add jcameron-key.asc


* update and install 
apt-get update && apt-get install -y webmin

* update password of webmin user root

sudo /usr/share/webmin/changepass.pl /etc/webmin root webminsne123

sudo service webmin restart


- Accès à Webmin 
https://IP_server:10000/  ou  https://vps365425.ovh.net:10000/
  root / webminsne123

* usages
reboot (redémarrer) d'apache == dans serveur / appliquer tout les changement

* install virtualmin
http://www.webmin.com/vdownload.html

* active let's encryp ssl with webmin
choose the Let's Encrypt option via Webmin - Webmin Configuration - SSL - Let's Encrypt

# =================================================== #
# SECURITE - IPTABLES & FAILBAN
# =================================================== #
https://www.skyminds.net/serveur-dedie-securisation-des-services-avec-iptables-et-fail2ban/
https://www.grafikart.fr/formations/serveur-linux/fail2ban

* sécurisation de la couche TCP/IP
https://www.skyminds.net/serveur-dedie-securisation-de-la-couche-tcpip/
spoofing : ?
SYN flood : ?
attaques Man In The Middle (MITM) : ?
redirections ICMP ?


# =================================================== #
# MAIL SERVER
# =================================================== #

https://doc.ubuntu-fr.org/postfix

https://www.grafikart.fr/formations/serveur-linux/postfix-sendonly
https://www.grafikart.fr/tutoriels/serveur/email-dns-dkim-spf-551

https://postfix.traduc.org/index.php/BASIC_CONFIGURATION_README.html

https://www.skyminds.net/serveur-dedie-creation-dun-serveur-mail-postfix-securise-avec-saslauthd-et-certificat-ssl-et-courier-acces-pop-et-imap-utilisant-une-base-mysql-dutilisateursdomaines-virtuels/

https://openclassrooms.com/courses/gerer-votre-mail-a-la-unix/do-you-speak-smtp#r-1359207

https://forum.free-h.org/probleme-configuration-mails-vps-t20045.html

~# need
don’t want to run a mail server
want to send email, and you don’t care about receiving it
want people to receive the emails that your server sends

sOLUTION : 
INSTALL & configure postix as a SMTP server
+ SASL
+ chiffrement via SSL/TLS

Config d'un serveur SMTP

Serveur Messagerie sortant avec SMTP :

to know : 
'utilitaire en ligne de commande "mail" envoit un mail en passant par un MTA (postfix, exim4, sendmail...)  qui doit forcément être installé sur ta machine

MTA : agent de transfert de courriel = The SMTP server
Postfix : 
MTA (SMTP)
serveur de mail, permet de relayer les mail vers l'extérieur

Exim : logiciel de serveur de messagerie par défaut sur debian
Dovecot :  serveur IMAP et POP3 | https://fr.wikipedia.org/wiki/Dovecot

# ssmtp ?


# postfix
apt-get purge 'exim4*'
apt-get install -y mailutils
apt-get install -y postfix


config type : Internet Site
System mail name : http://vps365425.ovh.net/

apt-get install -y postfix-mysql libsasl2-2 libsasl2-modules libsasl2-modules-sql sasl2-bin libpam-mysql heirloom-mailx gamin
apt-get install -y openssl
apt-get install -y postfixadmin

dpkg --list | grep postfix | awk '/^ii/{ print $2}'

* fichier conf : /etc/postfix/main.cf 

  -  modifier les interfaces pour ne pas écouter l'extérieur (notre serveur ne servira pas de relai).
  inet_interfaces = loopback-only

* reload 
systemctl reload postfix

* test mail send :
echo "Message Body" | mail -s "Message Subject" demotutosne@mailinator.com 


#  configurer un serveur de messagerie sortant (pouvoir envoyer des courriels sans en héberger) avec « postfix »






# =================================================== #
# Apache web root - CHMOD permissions
# =================================================== #
http://www.leshirondellesdunet.com/chmod-et-chown
https://openclassrooms.com/courses/reprenez-le-controle-a-l-aide-de-linux/les-utilisateurs-et-les-droits#ss_part_3
https://www.cyberciti.biz/faq/howto-linux-add-user-to-group/

https://doc.ubuntu-fr.org/permissions

* Add a existing ftp user to existing group
usermod -a -G www-data ftpsne

sudo chown -R www-data:www-data /var/www
sudo chgrp -R www-data /var/www     ajout groupe propiétaire réperoire
sudo chmod -R g+rwx /var/www      ajout droit read writeexecute au groupe

réesécuter a chaque nouveau dossier : 
sudo chown -R www-data:www-data /var/www



