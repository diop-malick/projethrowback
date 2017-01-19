
https://docs.ovh.com/display/public/CRVPS/Installation+d%27un+serveur+web+sous+Debian+8

# terminal

Ctrl+l      effacer terminal
ctrl+d      exit terminal


# vim

recherche : apuyer sur "/"
inserer : i
sortir insert : échap
enregistrer et quitter : :wq
quitter : :q

# log in ssh

ssh root@193.70.112.96  || ssh root@vps365425.ovh.net
connection par clé : clé généré avec Puttygen / connexion avec putty

# logout

logout

lancer zsh : zsh
basculer sur bash : bash

# UPDATE
sudo apt-get update && sudo apt-get upgrade -y


# Install Basic tools

sudo apt-get install -y unzip vim git curl

# WEB SERVEUR : Apache2

sudo apt-get install -y apache2



# PHP

sudo apt-get install -y php5 libapache2-mod-php5
sudo apt-get install -y php5-mysql php-pear php5-xdebug php5-curl php5-gd php5-mcrypt php-gettext

sudo /etc/init.d/apache2 restart

# configure PHP

* in etc/php5/apache2/php.init
change :
  display_errors = on

sudo /etc/init.d/apache2 restart

# configure apache

* Enabling mod_rewrite for URL rewriting

sudo a2enmod rewrite

sudo /etc/init.d/apache2 restart

# SGBD : MySQL

sudo apt-get install -y mysql-server

sudo /etc/init.d/apache2 restart

# PHPMyAdmin

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


# config ssh access

sudo vim /etc/ssh/sshd_config

  ajouter :  AllowUsers root

sudo service ssh restart

# PIM my shell
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

# check info

* IP and hostname

hostname
hostname -f
ifconfig

* To list your Debian version

lsb_release -a

* apache version

/usr/sbin/apache2 -v

* list intalled php5

dpkg --list | grep php | awk '/^ii/{ print $2}'

* check php

php --version

* mysql

sudo service mysql status
mysql --version
