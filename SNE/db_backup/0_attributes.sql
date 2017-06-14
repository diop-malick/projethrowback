-- Export

cd ... /SNE/db_backup_import
mysqldump -u root throwbacpresta14 ps_attribute ps_attribute_group ps_attribute_group_lang ps_attribute_group_shop ps_attribute_impact ps_attribute_lang ps_attribute_shop > throwbackpresta14_attributes.sql

-- modif to radio

-- delete in throwbackpresta16

DROP TABLE IF EXISTS ps_attribute;
DROP TABLE IF EXISTS ps_attribute_group;
DROP TABLE IF EXISTS ps_attribute_group_lang;
DROP TABLE IF EXISTS ps_attribute_group_shop;
DROP TABLE IF EXISTS ps_attribute_impact;
DROP TABLE IF EXISTS ps_attribute_lang;
DROP TABLE IF EXISTS ps_attribute_shop;


-- import 

mysql -h localhost -u root -p throwbackpresta16 < throwbackpresta14_attributes


