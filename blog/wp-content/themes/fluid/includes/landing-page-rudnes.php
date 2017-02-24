<?php
/**
 * Landing page functions
 * Used in front-page.php
 *
 * @package Fluida
 */





/**
 * boxes builder
 */
if ( ! function_exists( 'fluida_lpboxesrudness' ) ):
function fluida_lpboxesrudness( $sid = 1 ) {
	$fluids = cryout_get_option(
				array(
					 'fluida_lpboxmaintitle' . $sid,
					 'fluida_lpboxmaindesc' . $sid,
					 'fluida_lpboxcat' . $sid,
					 'fluida_lpboxrow' . $sid,
					 'fluida_lpboxcount' . $sid,
					 'fluida_lpboxlayout' . $sid,
					 'fluida_lpboxmargins' . $sid,
					 'fluida_lpboxanimation' . $sid,
					 'fluida_lpboxreadmore' . $sid,
					 'fluida_lpboxlength' . $sid,
				 )
			 );

	if ( ( $fluids['fluida_lpboxcount' . $sid] <= 0 ) || ( $fluids['fluida_lpboxcount' . $sid] == '-' ) ) return;

 	$box_counter = 1;
	$animated_class = "";
	if ( $fluids['fluida_lpboxanimation' . $sid] == 1 ) $animated_class = 'lp-boxes-animated';
	if ( $fluids['fluida_lpboxanimation' . $sid] == 2 ) $animated_class = 'lp-boxes-static';
    $custom_query = new WP_query();
    
    $paged = ( get_query_var('paged') ) ? get_query_var('paged') : 1;   

    $cat = '&category_name=creations-customs';

    $custom_query->query( 'showposts=' . $fluids['fluida_lpboxcount' . $sid] . $cat . '&ignore_sticky_posts=1'.'&paged='.$paged );
    if ( $custom_query->have_posts() ) : ?>
		<section class="lp-boxes lp-boxes-<?php echo absint( $sid ) ?> <?php  echo esc_attr( $animated_class ) ?> lp-boxes-rows-<?php echo absint( $fluids['fluida_lpboxrow' . $sid] ); ?>">
			<?php if( $fluids['fluida_lpboxmaintitle' . $sid] || $fluids['fluida_lpboxmaindesc' . $sid] ) { ?>
				<div class="lp-section-header">
					<?php if ( ! empty( $fluids['fluida_lpboxmaintitle' . $sid] ) ) { ?> <h2 class="lp-section-title"> <?php  echo do_shortcode( wp_kses_post( $fluids['fluida_lpboxmaintitle' . $sid] ) ); ?></h2><?php } ?>
					<?php if ( ! empty( $fluids['fluida_lpboxmaindesc' . $sid] ) ) { ?><div class="lp-section-desc"> <?php echo do_shortcode( wp_kses_post( $fluids['fluida_lpboxmaindesc' . $sid] ) ); ?></div><?php } ?>
				</div>
			<?php } ?>
			<div class="<?php if ( $fluids['fluida_lpboxlayout' . $sid] == 2 ) { echo 'lp-boxes-inside'; }?>
						<?php if ( $fluids['fluida_lpboxmargins' . $sid] == 2 ) { echo 'lp-boxes-margins'; }?>
						<?php if ( $fluids['fluida_lpboxmargins' . $sid] != 2 &&  $fluids['fluida_lpboxmargins' . $sid] != 2 ) { echo 'lp-boxes-padding'; }?>">
    		<?php while ( $custom_query->have_posts() ) :
	            $custom_query->the_post();
				if ( has_excerpt() ) {
					$excerpt = fluida_custom_excerpt( get_the_excerpt(), $fluids['fluida_lpboxlength' . $sid] );
				} else {
					$excerpt = fluida_custom_excerpt( get_the_content(), $fluids['fluida_lpboxlength' . $sid] );
				};
	            $box = array();
	            $box['colno'] = $box_counter++;
	            $box['counter'] = $fluids['fluida_lpboxcount' . $sid];
	            $box['title'] = get_the_title();
	            $box['content'] = $excerpt;
	            list( $box['image'], ) = wp_get_attachment_image_src( get_post_thumbnail_id( get_the_ID() ), 'fluida-lpbox-' . $sid );
	            $box['link'] = get_permalink();
				$box['readmore'] = do_shortcode( wp_kses_post( $fluids['fluida_lpboxreadmore' . $sid] ) );
	            $box['target'] = ''; // unused for now

            fluida_lpbox_output( $box );
        endwhile; ?>

        <div class="clearfix"></div>
        <div class="text-center"  style="color:red; font-weight:bold">
        <?php
		$big = 999999999; // need an unlikely integer

		echo paginate_links( array(
			'base' => str_replace( $big, '%#%', esc_url( get_pagenum_link( $big ) ) ),
			'format' => '?paged=%#%',
			'current' => max( 1, get_query_var('paged') ),
			'total' => $custom_query->max_num_pages
		) );
		?>
		</div>


			</div>
		</section><!-- .lp-boxes -->

<?php endif;
} //  fluida_lpboxes()
endif;



// FIN
