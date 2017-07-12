<?php
/**
 * The Header
 *
 * Displays all of the <head> section and everything up till <main>
 *
 * @package Fluida
 */


require_once(dirname(__FILE__).'/../../../../config/config.inc.php');
// require_once(dirname(__FILE__).'/../../../../config/config.inc.php');
global $controllerPrestashop;
$controllerPrestashop = new FrontController();
$controllerPrestashop->init();
$controllerPrestashop->setMedia();
Context::getContext()->smarty->assign(array('meta_title' => html_entity_decode(get_the_title()), 
	                                           'meta_description' => get_post_meta($post->ID,'description',true),
	                                           'meta_keywords' => ''
	                                         ));
global $wp;
$current_url = home_url(add_query_arg(array(),$wp->request))."/";
if(strpos($current_url, "/en/")){
	$lang = new Language(2);
	Context::getContext()->language = $lang;
}
else{
	$lang = new Language(1);
	Context::getContext()->language = $lang;
}


?><!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<?php cryout_meta_hook(); ?>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
<?php
	cryout_header_hook();
	wp_head();
?>
</head>

<body <?php body_class(); cryout_schema_microdata( 'body' );?>>

	<!-- BEGIN - intégration WP-PS  -->
	<?php $controllerPrestashop->displayHeaderBlog(); ?>
	<!-- End - intégration WP-PS  -->

	<div id="weglot_here"></div>

	<!-- Widget RECHERCHE -->
	<div id="searchform-header">
		<?php get_search_form(); ?>
	</div>
	<!-- // Widget RECHERCHE -->

	
			<?php //echo do_shortcode( '[serious-slider id=13]' );?>
	

	<?php cryout_body_hook(); ?>
	<?php cryout_breadcrumbs_hook();?>

	<div id="content" class="cryout">
		<?php cryout_main_hook(); ?>
