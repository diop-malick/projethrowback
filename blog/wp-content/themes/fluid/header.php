<?php
/**
 * The Header
 *
 * Displays all of the <head> section and everything up till <main>
 *
 * @package Fluida
 */

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

<?php
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
$controllerPrestashop->displayHeaderBlog();
/* End - intégration WP-PS */
?>

	<div style="/* margin-top:0px; z-index:1000; */">
			<?php get_search_form(); ?>
		</div>
	<?php cryout_body_hook(); ?>
	<?php cryout_breadcrumbs_hook();?>

	<div id="content" class="cryout">
		<?php cryout_main_hook(); ?>
