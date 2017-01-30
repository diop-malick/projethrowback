#! /usr/bin/env bash

###
#
# Shell automated script (building the LAMP stack)
# Perform an unattended installation
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

# turn off "frontend" (prompts) during installations
# install without prompting the user to answer any questions
export DEBIAN_FRONTEND="noninteractive"



# ---------------------------------------
# Variables
# ---------------------------------------




# ---------------------------------------
#          Update & basic Tools Setup
# ---------------------------------------

echo -e "\n--- Mkay, installing now... ---\n"

# basculer en superutilisateur
sudo su # ou sudo -i
echo -e "\n--- Vérifier l'appartenance au groupe sudo \n"
groups

# update time zone
TIME_ZONE='Europe/Paris'
echo "$TIME_ZONE" > /etc/timezone

echo -e "\n--- Updating packages list ---\n"
sudo apt-get update 
# sudo apt-get upgrade -y

echo -e "\n--- Install basic tools ---\n"
sudo apt-get install -y unzip
sudo apt-get install -y git curl


# --------------------------------------- #
#          MYSQL 5.5 & Phpmyadmin Setup
# --------------------------------------- #

ROOTPASSWD='root' # Mysql default root user

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"

# configure a root password for MySQL before we can install it
debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOTPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOTPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $ROOTPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOTPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $ROOTPASSWD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"


# Installing Packages
apt-get install -y mysql-server mysql-client phpmyadmin >> /vagrant/vm_build.log 2>&1

# each virtual host, give access to your PHPMyAdmin installation
# symbolic link from the document root to the phpMyAdmin installation location (/usr/share/phpmyadmin)
echo -e "\n--- setup phpmyadmin by adding a simple symlink ---\n"
sudo ln -fs /usr/share/phpmyadmin /var/www/phpmyadmin # create a symbolic link named phpmyadmin in apache doc root

# --------------------------------------- #
#          Apache & PHP Setup
# --------------------------------------- #

echo -e "\n--- Installing Aapche packages ---\n"
apt-get install -y apache2

echo -e "\n--- Installing PHP-specific packages ---\n"
apt-get install -y php5
# module PHP5 pour le serveur web Apache 2 : https://packages.debian.org/sid/libapache2-mod-php5
apt-get install -y libapache2-mod-php5 >> /vagrant/vm_build.log 2>&1
apt-get install -y php5-mysql php-pear php5-xdebug php5-curl php5-gd php5-mcrypt php-gettext

echo -e "\n--- Enabling mod_rewrite for URL rewriting ---\n"
a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

# PHP  Composer

echo -e "\n--- Installing Composer for PHP package management"
curl --silent https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# SYNC web root folder

echo -e "\n--- Setting document root to public directory ---\n"

vagrantdir='/vagrant/public'
apacherootfolder='/var/www/html'

if [ ! -d "$vagrantdir" ]; then
  mkdir "$vagrantdir"
fi

# linking between the Apache 2.4 default web public directory /var/www/html folder and the public vagrant folder
echo -e "\n--- Setting document root to public directory ---\n"
if [ ! -L "$apacherootfolder" ]; then
  rm -rf "$apacherootfolder"
  ln -fs "$vagrantdir" "$apacherootfolder"
fi

echo -e "\n--- Restarting Apache ---\n"
service apache2 restart >> /vagrant/vm_build.log 2>&1

# change to web directory
cd "$vagrantdir" || exit


# PHP info

file='phpinfo.php'
if [ ! -f "$file" ]; then
  echo -e "\n--- Creating  phpinfo script"
  echo '<?php phpinfo();' > "$file"
fi


# ADMINER

file='adminer.php'
if [ ! -f "$file" ]; then
  echo -e "\n--- Adding Adminer for Database management"
  wget -nv -O "$file" http://www.adminer.org/latest.php
  wget -nv https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css
fi


# --------------------------------------- #
#          Installing Prestashop
# --------------------------------------- #

DBPRESTA16='throwbackpresta16'
DBPRESTA17='throwbackpresta17'
DBPRESTAUSER='test'
DBPRESTAPASSWD='test'

PRESTADOMAIN="localhost:8081"

PS_VERSION_1_6='prestashop_1.6.1.11.zip'
PS_VERSION_1_7='prestashop_1.7.0.4.zip'

# Nom du dossier Prestashop qu'on doit creer
newdir='throwback16' # prestashop folder, prestashop base uri

echo -e "\n--- Prestashop - Installing ... \n"

# On se positionne dans le dossier web
cd "$vagrantdir" || exit

#On vérifie que le dossier n'existe pas
if [ -d "$newdir" ]; then
    printf "%s existe !" $newdir
#Si le dossier n'existe pas on lance le processus

# DROP existing DB
sudo mysqldump -uroot -p$ROOTPASSWD --databases $DBPRESTA16 > dbdumpfile_old.sql


mysql -uroot -p$ROOTPASSWD "DROP DATABASE $DBPRESTA16"

# backup DB

dumpfile='dbdumpfile.sql'
rm "$dumpfile"
sudo mysqldump -uroot -p$ROOTPASSWD $DBPRESTA16 < dbdumpfile.sql
# sudo mysqldump -uroot -proot --databases throwbackpresta16 throwbackpresta17 > dbdumpfile.sql
mysql -uroot -p$ROOTPASSWD -e "GRANT ALL PRIVILEGES ON $DBPRESTA16.* TO '$DBPRESTAUSER'@'localhost' IDENTIFIED BY '$DBPRESTAPASSWD';" > /vagrant/vm_build.log 2>&1


else
  # Téléchargement de l'archive depuis le site prestashop
  if [ ! -f "$PS_VERSION_1_6" ]; then

    printf "\n Download 1.6 archive ..."
    wget –quiet http://www.prestashop.com/download/old/$PS_VERSION_1_6 >/dev/null 2>&1

  fi

  if [ ! -f "$PS_VERSION_1_7" ]; then

    printf "\n Download 1.7 archive ..."
    wget –quie http://www.prestashop.com/download/old/$PS_VERSION_1_7 >/dev/null 2>&1

  fi

  # On dézippe l'archive
  unzip $PS_VERSION_1_6 >/dev/null 2>&1
  # on déplace les fichiers et on supprime ce dossier et l'archive pour finir
  printf "\n Rename unziped folder from prestashop to $newdir"
  mv prestashop "$newdir"
  # echo "Delete downloaded zip "
  # rm $PS_VERSION_1_6


  printf "\n--- Prestashop - Setting up MySQL user and database \n"

  mysql -uroot -p$ROOTPASSWD -e "CREATE DATABASE IF NOT EXISTS $DBPRESTA16" >> /vagrant/vm_build.log 2>&1
  mysql -uroot -p$ROOTPASSWD -e "CREATE DATABASE IF NOT EXISTS $DBPRESTA17" >> /vagrant/vm_build.log 2>&1

  # mysql -uroot -p$ROOTPASSWD -e "CREATE USER IF NOT EXISTS 'test'@'localhost' IDENTIFIED BY 'test';"
  mysql -uroot -p$ROOTPASSWD -e "GRANT ALL PRIVILEGES ON $DBPRESTA16.* TO '$DBPRESTAUSER'@'localhost' IDENTIFIED BY '$DBPRESTAPASSWD';" > /vagrant/vm_build.log 2>&1
  mysql -uroot -p$ROOTPASSWD -e "GRANT ALL PRIVILEGES ON $DBPRESTA17.* TO '$DBPRESTAUSER'@'localhost';" > /vagrant/vm_build.log 2>&1

  # on se place dans le nouveau dossier
  cd "$newdir" || exit

  printf "\n--- install prestashop with CLI installer \n"
  # http://doc.prestashop.com/display/PS16/Installer+PrestaShop+en+ligne+de+commande
  cd install || exit
  sudo php index_cli.php --language=fr --timezone=Europe/Paris --base_uri="/$newdir" --domain=$PRESTADOMAIN --db_server=localhost --db_name=$DBPRESTA16 --db_user=$DBPRESTAUSER --db_password=$DBPRESTAPASSWD

  # Pour finir on renomme le dossier d'install et le dossier d'admin
  cd .. || exit
  mv install _install
  sudo mv admin admin16

fi



# --------------------------------------- #
#          Virtual Machine clean
# --------------------------------------- #

printf "\n--- Updating packages list ---\n"
apt-get update 

# Clean package installed list
apt-get clean >> /vagrant/vm_build_clean.log 2>&1
