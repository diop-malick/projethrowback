https://gist.github.com/rrosiek/8190550

# check debian
systemctl or service
sudo systemctl restart apache2

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

# Config vhost
un vhost pointant vers son répertoire de source (en local sur son poste)…

# --------------------------------------- #
#          Install - SSL
# --------------------------------------- #
Installer et configurer le module ssl pour Apache2
Certificat ssl http
with self-signed certificate
created a self-signed SSL on localhost.
https://technique.arscenic.org/lamp-linux-apache-mysql-php/apache-le-serveur-http/modules-complementaires/article/installer-et-configurer-le-module-ssl-pour-apache2

check ssl :
dpkg -l | grep ssl


# --------------------------------------- #
#          Install - MYSQL 5.6 Setup
# --------------------------------------- #
replace mysql5.5 by 5.6 or 5.7

# --------------------------------------- #
# Add Prestashop prestashop
# --------------------------------------- #

Configuration du serveur de messagerie pour que prestashop puisse envoyer ds mail

# Modifiez le propriétaire du répertoire prestashop et de son arborescence :
chown -R www-data:www-data /var/www/prestashop


# NODEJS
echo -e "\n--- Add Node 6.x rather than 4 ---\n"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> /vagrant/vm_build.log 2>&1

# --------------------------------------- #
#  Install PHP7
# --------------------------------------- #

https://www.h-hennes.fr/blog/2016/12/06/utiliser-plusieurs-version-de-php-avec-apache/

https://www.cyberciti.biz/faq/installing-php-7-on-debian-linux-8-jessie-wheezy-using-apt-get/

https://angristan.fr/installer-php-7-debian-8-jessie-depot-dotdeb/

http://www.dynamic-mess.com/php/installer-php7-debian/

https://www.linode.com/docs/websites/lamp/lamp-on-debian-8-jessie/

https://www.martar.fr/articles/installer-php-7-sur-un-serveur-debian

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
#          PHP FPM for apache
# --------------------------------------- #
# PHP en mode fastCGI
sudo apt-get install -y libapache2-mod-fastcgi
sudo apt-get install -y php5-fpm

# --------------------------------------- #
#          Installing Prestashop
# --------------------------------------- #
## Change this to the PS version you'd like to use
PS_VERSION=prestashop_1.6.1.1.zip

## Download Prestashop
cd /vagrant
wget http://www.prestashop.com/download/old/$PS_VERSION
unzip -o $PS_VERSION
sudo rm ./$PS_VERSION


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
