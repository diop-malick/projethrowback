#! /usr/bin/env bash

# turn off "frontend" (prompts) during installations
# disable queries for user manual interactions
# install without prompting the user to answer any questions
export DEBIAN_FRONTEND="noninteractive"


###
#
# vagrantbootstrap_mysql.sh
#
# Vagrant provision script for php, Apache, MySQL, phpMyAdmin
#
# This script assumes your Vagrantfile has been configured to map the root of
# your application to /vagrant and that your web root is the "public" folder.
#
# Standard and error output is sent to
# /vagrant/vm_build.log during provisioning.
#
###


# ---------------------------------------
# Variables
# ---------------------------------------
# accée à la DB
DBHOST='localhost'
DBPRESTA16='throwbackpresta16'
DBPRESTA17='throwbackpresta17'
DBPRESTAUSER='test'
DBPRESTAPASSWD='test'
ROOTPASSWD='root' # for default root user

PRESTADOMAIN="localhost:8081"
PRESTABASEURI="throwback16" # == newdir

#Accès administration
contactEmail="demo@demo.com"
adminpass='demodemo'

# Shell script (building the LAMP stack)
# automated script
# on a non-interactive shell
# Perform an unattended installation


# ---------------------------------------
#          Update & basic Tools Setup
# ---------------------------------------
echo -e "\n--- Mkay, installing now... ---\n"

# update time zone
# TIME_ZONE='Europe/Paris'
# echo "$TIME_ZONE" > /etc/timezone
# dpkg-reconfigure -f noninteractive tzdata

echo -e "\n--- Updating packages list ---\n"
sudo apt-get update && sudo apt-get upgrade -y

echo -e "\n--- Install basic tools ---\n"
sudo apt-get install -y unzip
sudo apt-get install -y vim git curl

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update

# --------------------------------------- #
#          MYSQL 5.5 & Phpmyadmin Setup
# --------------------------------------- #
# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"

# configure a root password for MySQL before we can install it
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOTPASSWD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOTPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $ROOTPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOTPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $ROOTPASSWD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"


# Installing Packages
sudo apt-get install -y mysql-server mysql-client phpmyadmin >> /vagrant/vm_build.log 2>&1

# each virtual host, give access to your PHPMyAdmin installation
# symbolic link from the document root to the phpMyAdmin installation location (/usr/share/phpmyadmin)
echo -e "\n--- setup phpmyadmin by adding a simple symlink ---\n"
sudo ln -fs /usr/share/phpmyadmin /var/www/phpmyadmin # create a symbolic link named phpmyadmin in apache doc root
# sudo ln -fs /usr/share/phpmyadmin /var/www/html/example.org/public_html

# --------------------------------------- #
#          Apache & PHP Setup
# --------------------------------------- #

echo -e "\n--- Installing Aapche packages ---\n"
sudo apt-get install -y apache2
# sudo apt-get install -y apache2.2-common

echo -e "\n--- Installing PHP-specific packages ---\n"
sudo apt-get install -y php5
# module PHP5 pour le serveur web Apache 2 : https://packages.debian.org/sid/libapache2-mod-php5
sudo apt-get install -y libapache2-mod-php5 >> /vagrant/vm_build.log 2>&1
sudo apt-get install -y php5-mysql php-pear php5-xdebug php5-curl php5-gd php5-mcrypt php-gettext

echo -e "\n--- Enabling mod_rewrite for URL rewriting ---\n"
sudo a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
# sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

echo -e "\n--- Setting document root to public directory ---\n"
vagrantdir='/vagrant/public'
apacherootfolder='/var/www/html'
if [ ! -d "$vagrantdir" ]; then
  mkdir "$vagrantdir"
fi
# linking between the Apache 2.4 public directory /var/www folder and the public vagrant folder
echo -e "\n--- Setting document root to public directory ---\n"
# The default Debian document root is /var/www/html
if [ ! -L "$apacherootfolder" ]; then
  sudo rm -rf "$apacherootfolder"
  sudo ln -fs "$vagrantdir" "$apacherootfolder"
fi

echo -e "\n--- Restarting Apache ---\n"
service apache2 restart >> /vagrant/vm_build.log 2>&1


# --------- change to web directory

cd "$vagrantdir"

# --------- vhost
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
  sudo echo "$SITE_CONF" > "$file"
fi

sudo a2ensite dev

echo -e "\n--- Reload Apache"
service apache2 restart >> /vagrant/vm_build.log 2>&1
sudo service apache2 reload


echo -e "\n--- Creating  phpinfo script"

file='phpinfo.php'
if [ ! -f "$file" ]; then
  echo '<?php phpinfo();' > "$file"
fi


echo -e "\n--- Adding Adminer for Database management"

file='adminer.php'
if [ ! -f "$file" ]; then
  wget -nv -O "$file" http://www.adminer.org/latest.php
  wget -nv https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css
fi

echo -e "\n--- Installing Composer for PHP package management"
sudo curl --silent https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo -e "\n--- Installing NodeJS and NPM"
# apt-get -y install nodejs >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Installing javascript components"
# npm install -g gulp bower >> /vagrant/vm_build.log 2>&1

# --------------------------------------- #
#          Installing Prestashop
# --------------------------------------- #

PS_VERSION_1_6='prestashop_1.6.1.11.zip'
PS_VERSION_1_7='prestashop_1.7.0.4.zip'
#Nom du dossier qu'on doit creer
newdir=$PRESTABASEURI

# sudo mysql_secure_installation

echo -e "\n--- Prestashop - Installing ... \n"

#On se positionne dans le dossier web
cd "$vagrantdir"

#On vérifie que le dossier n'existe pas
if [ -d "$newdir" ]; then
    echo "$newdir existe !"
#Si le dossier n'existe pas on lance le processus
else
  # Téléchargement de l'archive depuis le site prestashop
  if [ ! -f "$PS_VERSION_1_6" ]; then
    wget –quiet http://www.prestashop.com/download/old/$PS_VERSION_1_6 >/dev/null 2>&1
  fi
  if [ ! -f "$PS_VERSION_1_7" ]; then
    wget –quie http://www.prestashop.com/download/old/$PS_VERSION_1_7 >/dev/null 2>&1
  fi
  # On dézippe l'archive
  unzip $PS_VERSION_1_6 >/dev/null 2>&1
  # on déplace les fichiers et on supprime ce dossier et l'archive pour finir
  echo "Rename unziped folder prestashop to $newdir"
  mv prestashop "$newdir"

  # echo "Delete unzip result prestashop folder"
  # rm -rf prestashop

  # echo "Delete downloaded zip "
  # rm $PS_VERSION_1_6
fi

echo -e "\n--- Prestashop - Setting up MySQL user and database \n"
sudo mysql -uroot -p$ROOTPASSWD -e "CREATE DATABASE IF NOT EXISTS $DBPRESTA16" >> /vagrant/vm_build.log 2>&1
sudo mysql -uroot -p$ROOTPASSWD -e "CREATE USER IF NOT EXISTS '$DBPRESTAUSER'@'localhost' IDENTIFIED BY '$DBPRESTAPASSWD';"
sudo mysql -uroot -p$ROOTPASSWD -e "GRANT ALL PRIVILEGES ON $DBPRESTA16.* TO '$DBPRESTAUSER'@'localhost';" > /vagrant/vm_build.log 2>&1

sudo mysql -uroot -p$ROOTPASSWD -e "CREATE DATABASE IF NOT EXISTS $DBPRESTA17" >> /vagrant/vm_build.log 2>&1
sudo mysql -uroot -p$ROOTPASSWD -e "GRANT ALL PRIVILEGES ON $DBPRESTA17.* TO '$DBPRESTAUSER'@'localhost';" > /vagrant/vm_build.log 2>&1

#on se place dans le nouveau dossier
cd "$newdir"

echo "\n--- install prestashop with CLI installer \n"
# http://doc.prestashop.com/display/PS16/Installer+PrestaShop+en+ligne+de+commande
cd install
#sudo php index_cli.php --language=en --timezone=Europe/Paris --domain=localhost:8081/prestashop16/ --db_server=localhost --db_name=$DBPRESTA --db_user=$DBUSER --db_password=$ROOTPASSWD
sudo php index_cli.php --base_uri="/$newdir" --domain=$PRESTADOMAIN --db_name=$DBPRESTAUSER --db_user=root --db_password=$DBPRESTAPASSWD
# sudo php index_cli.php --base_uri='/prestashop16' --domain='localhost:8081' --db_name=throwbackpresta16 --db_user=root --db_password=root

#Pour finir on renomme le dossier d'install et le dossier d'admin
cd ..
mv install _install
mv admin admin-dev

# --------------------------------------- #
#          Virtual Machine clean
# --------------------------------------- #

# Suppression de paquets d'installation
sudo apt-get clean >> /vagrant/vm_build_clean.log 2>&1
