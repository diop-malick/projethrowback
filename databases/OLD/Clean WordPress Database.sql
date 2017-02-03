/* PLUGIN

WP Optimize (suppression des brouillons, des révisons d’articles et des spams)
Plugins Garbage Collector (pour supprimer des données laissées dans la base par d’anciens plugins désinstallés…)

BackWPup( sauvegardes automatiques de sa base de données)

*/

/*
OPTIMISER LA BDD
https://facemweb.com/creation-site-internet/nettoyer-la-bdd-de-wordpress

-- désactiver le versionning des articles : dans wp-config.php

*/

-- Supprimer les vieux articles, le contenu dépassé
-- tous les vieux articles, vieux d’il y a plus de 365 jours = result : 54 lignes supprimées

DELETE FROM `wp_posts`
WHERE `post_type` = 'post' AND DATEDIFF(NOW(), `post_date`) > 365

-- supprimer les articles à partir d’une date
DELETE FROM `wp_posts`
WHERE `post_type` = 'post'
AND `post_date` < '2016-09-01 00:00:00'

/* 

Suprimer les images en « non attaché » (pas liées à un article ou à une page) :

NETOYER LE DOSSIER : wp-content\uploads

les images insérées dans les articles vont par défaut dans le dossier wp-content/uploads.
ce dossier contient tous les fichiers insérés dans les articles et pages : images, vidéos, audio, pdf etc

*/

-- Alléger la table des articles en supprimant les révisions
-- purger la liste des révisions
DELETE a,b,c
FROM `wp_posts` a
LEFT JOIN `wp_term_relationships` b ON (a.ID = b.object_id)
LEFT JOIN `wp_postmeta` c ON (a.ID = c.post_id)
WHERE a.post_type = 'revision';



-- Purger les commentaires de spam

-- DELETE FROM `wp_comments`
-- WHERE `comment_approved` = 'spam';

-- Purger les données meta de commentaires supprimés

-- DELETE FROM `wp_commentmeta`
-- WHERE `comment_id` NOT IN ( SELECT `comment_id` FROM `wp_comments` )

-- Supprimer les entrées liées à Akismet
-- DELETE FROM `wp_commentmeta`
-- WHERE `meta_key` LIKE '%akismet%'

-- Purger les données meta des articles qui n’existent plus
DELETE pm
FROM `wp_postmeta` pm
LEFT JOIN `wp_posts` wp ON wp.ID = pm.post_id
WHERE wp.ID IS NULL

-- Supprimer les mots-clés non-utilisés
DELETE FROM `wp_terms`
WHERE `term_id` IN (
                 SELECT `term_id`
                 FROM `wp_term_taxonomy`
                 WHERE `count` = 0 );

DELETE FROM `wp_term_taxonomy`
WHERE `term_id` NOT IN ( SELECT `term_id` FROM `wp_terms` );

DELETE FROM wp_term_relationships
WHERE term_taxonomy_id not IN ( SELECT term_taxonomy_id FROM wp_term_taxonomy );

-- Purger le cache des flux (RSS, ATOM …)
DELETE FROM wp_options
WHERE option_name LIKE ('_transient%_feed_%')

-- Supprimer l’information du « user agent » de chaque commentaire
UPDATE `wp_comments`
SET `comment_agent` = '';





