
# TODO



# links

https://www.bisolweb.com/tutoriels/serveur-vps-ovh-tutoriel/
https://www.prestashop.com/forums/topic/278026-tuto-installer-son-serveur-d%C3%A9di%C3%A9-vps-de-a-%C3%A0-z-sur-debian-7-et-8-ispconfig-site/

install php7
http://www.love-moi.fr/2016/01/installer-php-7-avec-php-fpm-et-fastcgi.html

https://gist.github.com/asmerkin/df919a6a79b081512366

# serveur
Debian 8 « Jessie »


# commont Command



# apache Module to enable

mod_rewrite

# php modules to activate


# step

## Préparation du système

add user and pawd : malick/diop
> sudo adduser malick

> sudo adduser malick sudo

Disable root remote ssh connexion, changer PermitRootLogin yes en PermitRootLogin no.
> sudo nano /etc/ssh/sshd_config

Configurer les locales, choose fr_CH, fr_FR
> sudo dpkg-reconfigure locales

Synchroniser automatiquement l’heure du serveur
> sudo apt-get install -y ntp ntpdate

dbconf get-selections tool
> sudo apt-get install -y debconf-utils

## configure security

Installer logwatch et fail2ban
> sudo apt-get install -y fail2ban

install iptable

## Installation de Apache / PHP / MySQL / PhpMyAdmin

apache

> apt-get install
libapache2-mod-fastcgi
php5-intl php-pear php5-imagick
php5-imap php5-mcrypt php5-memcache
php5-pspell php5-recode php5-snmp
php5-sqlite php5-tidy php5-xmlrpc php5-xsl
php5-dev


On active ensuite les mods et on redémarre
> a2enmod rewrite
a2enmod headers
a2enmod deflate
a2enmod expires
service apache2 restart

MySQL
> sudo apt-get install -y
sudo apt-get install php5-mysql

secure install
> mysql_secure_installation

 optimize mysql config
MySQLTuner


# phpmyadmin
sudo apt-get install -q -y phpmyadmin
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password your-app-pwd' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password your-admin-db-pwd' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password your-app-db-pwd' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apac

* Supprimer le dossier d’installation zr redémarrer apache
sudo rm -rf /usr/share/phpmyadmin/setup
sudo service apache2 reload

# varnish ?


# Installation du serveur DNS : le serveur de nom de domaine
apt-get install bind9 dnsutils

# autres


# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# SSL https
SSL Let's Encrypt

# server mail avec

Postfix

# ftp

VSFTPD

# server Dashbord admin

Installation HTOP | contrôle d’activité du serveur
> apt-get install htop

Installation de Midnight Commander |  gestionnaire de fichiers
> apt-get install mc

WEBMIN |  interface web d'admin de serveur unix, gestion des sites
> apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.801_all.deb
dpkg --install webmin_1.801_all.deb
https://vpsxxxxx.ovh.net:10000/

Installation de SysStat | système de monitoring intégré à webmin
> apt-get install perl rrdtool librrds-perl sysstat
http://sourceforge.net/projects/webminstats/files/Sysstats/
https://vpsxxxxx.ovh.net:10000/sysstats/display_all.cgi

install VIRTUALMIN |module webmin, config CPU et la RAM
> wget http://software.virtualmin.com/gpl/scripts/install.sh
chmod +x install.sh
./install.sh










https://docs.ovh.com/display/public/CRVPS/Installation+d%27un+serveur+web+sous+Debian+8
http://crash-blog.com/installation-d-un-serveur-vps-ovh/
https://www.bisolweb.com/tutoriels/serveur-vps-ovh-tutoriel/
