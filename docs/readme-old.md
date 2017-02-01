

6. Only for FIRST Vagrant installation

Importer les fichiers , dans l'ordre , dans la base avec phpmyadmin.

- db_throwback_ps_dumpfile.sql
- db_throwback_wp_dumpfile.sql
- db_throwback_users.sql


Merger votre installation
--------

- exécuter les commandes suivantes 

```bash
cd /vagrant/public
rm dbdumpfile.sql
sudo mysqldump -uroot -proot --databases throwbackpresta16 > dbdumpfile.sql
```

- vérifier l'intégrité du fichier dumpfle.sql généré

- pull & merge last version 

Manips 
---------


Pour annuler le dernier commit : 

git reset

Pour annuler tous vos modifications courante et repartir d'une version clean :

git checkout .

git checkout --

git clean -fd

git pull 
