/* PLUGIN

WP Optimize (suppression des brouillons, des r�visons d�articles et des spams)
Plugins Garbage Collector (pour supprimer des donn�es laiss�es dans la base par d�anciens plugins d�sinstall�s�)

BackWPup( sauvegardes automatiques de sa base de donn�es)

*/

/*
OPTIMISER LA BDD
https://facemweb.com/creation-site-internet/nettoyer-la-bdd-de-wordpress

-- d�sactiver le versionning des articles : dans wp-config.php

*/

-- Supprimer les vieux articles, le contenu d�pass�
-- tous les vieux articles, vieux d�il y a plus de 365 jours = result : 54 lignes supprim�es

DELETE FROM `wp_posts`
WHERE `post_type` = 'post' AND DATEDIFF(NOW(), `post_date`) > 365

-- supprimer les articles � partir d�une date
DELETE FROM `wp_posts`
WHERE `post_type` = 'post'
AND `post_date` < '2016-09-01 00:00:00'

/* 

Suprimer les images en � non attach� � (pas li�es � un article ou � une page) :

NETOYER LE DOSSIER : wp-content\uploads

les images ins�r�es dans les articles vont par d�faut dans le dossier wp-content/uploads.
ce dossier contient tous les fichiers ins�r�s dans les articles et pages : images, vid�os, audio, pdf etc

*/

-- All�ger la table des articles en supprimant les r�visions
-- purger la liste des r�visions
DELETE a,b,c
FROM `wp_posts` a
LEFT JOIN `wp_term_relationships` b ON (a.ID = b.object_id)
LEFT JOIN `wp_postmeta` c ON (a.ID = c.post_id)
WHERE a.post_type = 'revision';



-- Purger les commentaires de spam

-- DELETE FROM `wp_comments`
-- WHERE `comment_approved` = 'spam';

-- Purger les donn�es meta de commentaires supprim�s

-- DELETE FROM `wp_commentmeta`
-- WHERE `comment_id` NOT IN ( SELECT `comment_id` FROM `wp_comments` )

-- Supprimer les entr�es li�es � Akismet
-- DELETE FROM `wp_commentmeta`
-- WHERE `meta_key` LIKE '%akismet%'

-- Purger les donn�es meta des articles qui n�existent plus
DELETE pm
FROM `wp_postmeta` pm
LEFT JOIN `wp_posts` wp ON wp.ID = pm.post_id
WHERE wp.ID IS NULL

-- Supprimer les mots-cl�s non-utilis�s
DELETE FROM `wp_terms`
WHERE `term_id` IN (
                 SELECT `term_id`
                 FROM `wp_term_taxonomy`
                 WHERE `count` = 0 );

DELETE FROM `wp_term_taxonomy`
WHERE `term_id` NOT IN ( SELECT `term_id` FROM `wp_terms` );

DELETE FROM wp_term_relationships
WHERE term_taxonomy_id not IN ( SELECT term_taxonomy_id FROM wp_term_taxonomy );

-- Purger le cache des flux (RSS, ATOM �)
DELETE FROM wp_options
WHERE option_name LIKE ('_transient%_feed_%')

-- Supprimer l�information du � user agent � de chaque commentaire
UPDATE `wp_comments`
SET `comment_agent` = '';





