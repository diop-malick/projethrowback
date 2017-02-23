<?php
/**
 * The Header
 *
 * Displays all of the <head> section and everything up till <main>
 *
 * @package Fluida
 */


/* BEGIN - intégration WP-PS */
require_once(dirname(__FILE__).'/../../../../config/config.inc.php');
global $controllerPrestashop;
$controllerPrestashop = new FrontController();
$controllerPrestashop->init();
$controllerPrestashop->setMedia();
Context::getContext()->smarty->assign(array('meta_title' => html_entity_decode(get_the_title()), 
                                           'meta_description' => get_post_meta($post->ID,'description',true),
                                           'meta_keywords' => ''
                                           ));
$controllerPrestashop->displayHeader();
/* End - intégration WP-PS */

?><!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<?php cryout_meta_hook(); ?>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
<?php
	cryout_header_hook();
	wp_head();
?>
</head>

<body <?php body_class(); cryout_schema_microdata( 'body' );?>>
	<?php cryout_body_hook(); ?>
	<?php cryout_breadcrumbs_hook();?>

	<div id="content" class="cryout">
		<?php cryout_main_hook(); ?>
