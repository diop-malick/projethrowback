<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of #main and all content
 * after. Calls sidebar-footer.php for bottom widgets.
 *
 * @package Fluida
 */

?>
		<aside id="colophon" role="complementary" <?php cryout_schema_microdata( 'sidebar' );?>>
			<div id="colophon-inside" <?php fluida_footer_colophon_class();?>>
				<?php get_sidebar( 'footer' );?>
			</div>
		</aside><!-- #colophon -->

	</div><!-- #main -->


	<?php 
	// wp_footer(); 
	?>

	<!-- BEGIN - intégration WP-PS -->
	<?php		
	global $controllerPrestashop;
	$controllerPrestashop->displayFooterBlog();
	?>
	<!-- END - intégration WP-PS -->
	<link rel="stylesheet" type="text/css" href="<?php echo get_template_directory_uri(); ?>/style_responsive.css">
	<script type="text/javascript" src="<?php echo get_template_directory_uri(); ?>/style.js"></script>

</body>
</html>




