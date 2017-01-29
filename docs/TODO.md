

# --------------------------------------- #
#          Installing WordPress
# --------------------------------------- #
# get the latest stable build of WordPress and put it in the /public folder.
# if [ ! -d /vagrant/www/wp-admin ]; then # check if dir does not exist
#     cd "$vagrantdir"
#     wget http://wordpress.org/latest.tar.gz
#     tar xvf latest.tar.gz
#     mv wordpress/* ./
#     rmdir ./wordpress/
#     rm -f latest.tar.gz
# fi



# --------------------------------------- #
#          Install - SSL
# --------------------------------------- #

* Installer le https pour apt
apt-get install apt-transport-https

Installer et configurer le module ssl pour Apache2
Certificat ssl http
with self-signed certificate
created a self-signed SSL on localhost.
https://technique.arscenic.org/lamp-linux-apache-mysql-php/apache-le-serveur-http/modules-complementaires/article/installer-et-configurer-le-module-ssl-pour-apache2

check ssl :
dpkg -l | grep ssl

# --------------------------------------- #
#          Mail - Postfix
# --------------------------------------- #

Configuration de post fix pour l'envoi des mails
Configuration du serveur de messagerie pour que prestashop puisse envoyer ds mail

# improve port forwarding

forward_port = ->(guest, host = guest) do
  config.vm.network :forwarded_port,
    guest: guest,
    host: host,
    auto_correct: true
end

forward_port[3306]      # mysql
forward_port[80, 8080]  # apache


# Install tools - node, npm, bower
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
apt-get install -y nodejs
npm install -g bower

echo -e "\n--- Installing NodeJS and NPM"
# apt-get -y install nodejs >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Installing javascript components"
# npm install -g gulp bower >> /vagrant/vm_build.log 2>&1


# Config vhost
un vhost pointant vers son répertoire de source (en local sur son poste)…


# --------------------------------------- #
# Add Prestashop prestashop
# --------------------------------------- #


# Modifiez le propriétaire du répertoire prestashop et de son arborescence :
chown -R www-data:www-data /var/www/prestashop


# NODEJS
echo -e "\n--- Add Node 6.x rather than 4 ---\n"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> /vagrant/vm_build.log 2>&1

###### COnfig PHP

les session
purger à intervale de temps régulier : session.save_path = "/tmp"

le cache : memcache


# --------------------------------------- #
#  Install PHP7
# --------------------------------------- #

pour des performance accrue

https://www.h-hennes.fr/blog/2016/12/06/utiliser-plusieurs-version-de-php-avec-apache/

https://www.cyberciti.biz/faq/installing-php-7-on-debian-linux-8-jessie-wheezy-using-apt-get/

https://angristan.fr/installer-php-7-debian-8-jessie-depot-dotdeb/

http://www.dynamic-mess.com/php/installer-php7-debian/

https://www.linode.com/docs/websites/lamp/lamp-on-debian-8-jessie/

https://www.martar.fr/articles/installer-php-7-sur-un-serveur-debian

* PHP 7.0 (PHP-FPM & FastCGI)
FROM 'mod_php' to mod_fastcgi (fastcgi) avec PHP-FPM (FastCGI Process Manager).


# --------------------------------------- #
#          vhost apache
# --------------------------------------- #

# virtual host dev.fr within a file config named dev.conf
file='/etc/apache2/sites-available/dev.conf'
if [ ! -f "$file" ]; then
  SITE_CONF=$(cat <<EOF
<Directory /var/www/html>
  AllowOverride All
  Options +Indexes -MultiViews +FollowSymLinks
  AddDefaultCharset utf-8
  SetEnv ENVIRONMENT "development"
  php_flag display_errors On
  EnableSendfile Off
</Directory>
EOF
)
  echo "$SITE_CONF" > "$file"
fi

a2ensite dev

echo -e "\n--- Reload Apache"
service apache2 reload

# --------------------------------------- #
#          PHP FPM for apache
# --------------------------------------- #
# PHP en mode fastCGI
sudo apt-get install -y libapache2-mod-fastcgi
sudo apt-get install -y php5-fpm


# --------------------------------------- #
# Install OPcache gui script
# --------------------------------------- #
# http://php.net/manual/fr/book.opcache.php
# https://community.1and1.com/php-7/
# https://www.ekino.com/php-comment-configurer-utiliser-et-surveiller-opcache/

file='opcache.php'
if [ ! -f "$file" ]; then
  wget -nv -O "$file" https://raw.githubusercontent.com/amnuts/opcache-gui/master/index.php
fi




# --------------------------------------- #
#          Installing WordPress
# --------------------------------------- #
Pimp my shell, Zsh & Tmux
https://www.grafikart.fr/formations/serveur-linux/pimp-my-shell


# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    <Directory "/var/www/html/${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf






###to check
error

dpkg-preconfigure: unable to re-open stdin: No such file or directory
