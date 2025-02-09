<?php
/**
 * The template for displaying Search results pages.
 *
 * @package Fluida
 */

get_header(); 

?>

	<div id="container" class="<?php echo fluida_get_layout_class(); ?>">
		<main id="main" role="main" class="main">
			<?php cryout_before_content_hook(); ?>

			<?php if ( have_posts() ) : ?>

				<header class="content-search pad-container" <?php cryout_schema_microdata( 'element' ); ?>>
					<h1 class="page-title" <?php cryout_schema_microdata( 'entry-title' ); ?>>
						<?php printf( __( '<em class="result_found">Votre recherche:</em> "%s"', 'fluida' ), '<strong>' . get_search_query() . '</strong>' ); ?>
					</h1>
					
				</header>

				<div id="content-masonry" class="row" <?php cryout_schema_microdata( 'blog' ); ?>>
					<?php /* Start the Loop */
					while ( have_posts() ) : the_post();
						get_template_part( 'content/content', get_post_format() );
					endwhile;
					?>
				</div><!--content-masonry-->
				
				<div class="row text-center"> <?php fluida_pagination(); ?> </div>

			<?php else :

				get_template_part( 'content/content-notfound',get_post_format()  );
				?><div id="content-masonry"></div><?php

			endif; ?>

			<?php cryout_after_content_hook(); ?>
		</main><!-- #main -->

		<?php fluida_get_sidebar(); ?>
	</div><!-- #primary -->

<?php get_footer(); ?>

