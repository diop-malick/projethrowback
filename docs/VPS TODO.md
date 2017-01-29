
# TODO


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



On active ensuite les mods et on redémarre
> a2enmod rewrite
a2enmod headers
a2enmod deflate
a2enmod expires
service apache2 restart
mod_rewrite


# Secure MYSQL

> mysql_secure_installation

# optimize mysql config
MySQLTuner


# phpmyadmin

* Supprimer le dossier d’installation zr redémarrer apache
sudo rm -rf /usr/share/phpmyadmin/setup
sudo service apache2 reload

# PHP - install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer



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


# =================================================== #
# schedule cron jobs
# =================================================== #

# =================================================== #
# Logs
# =================================================== #
logwatch ? 

configurer cron pour avoir le résultat tous les mati

# =================================================== #
# Cache
# =================================================== #
APC ?
varnish ?
memcache ?

# =================================================== #
# Serveur DNS
# =================================================== #

BIND : 
https://fr.wikipedia.org/wiki/BIND

bind9 ?
dnsutils ?


https://docs.ovh.com/display/public/CRVPS/Installation+d%27un+serveur+web+sous+Debian+8

http://crash-blog.com/installation-d-un-serveur-vps-ovh/

https://www.bisolweb.com/tutoriels/serveur-vps-ovh-tutoriel/


# check debian
systemctl or service
sudo systemctl restart apache2
