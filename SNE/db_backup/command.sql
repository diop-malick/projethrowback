-- Export

cd ... /SNE/db_backup_import

mysqldump -u root throwbacpresta16 > throwbackpresta16.sql


-- import 


mysql -h localhost -u root -p throwbacpresta14 < throwbacpresta14.sql