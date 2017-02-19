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
</body>
</html>


<?php
/* BEGIN - intégration WP-PS */
global $controllerPrestashop;
$controllerPrestashop->displayFooter();
/* END - intégration WP-PS */
?>
<style type="text/css">
.lp-boxes .lp-box-overlay{
	background-color: rgba(53, 53, 53, 0.35) !important;
}
</style>
