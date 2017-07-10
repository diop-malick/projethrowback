<?php
/**
 * The default template for the not found section
 *
 * @package Fluida
 */
?> 
<header class="content-search pad-container no-results" <?php cryout_schema_microdata( 'element' ); ?>>

	<h1 class="entry-title" <?php cryout_schema_microdata( 'entry-title' ); ?>><?php _e( '', 'fluida' ); ?></h1>
	<h2 <?php cryout_schema_microdata( 'text' ); ?>><?php printf( __( '<em class="pas-resultat">Aucun résultat pour votre recherche:</em> <em>"%s"</em>', 'fluida' ), '<span>' . get_search_query() . '</span>' ); ?></h2>
	
	<?php get_search_form(); ?>
	
</header><!-- not-found -->