<?php
/**
 * Include and setup custom metaboxes and fields.
 *
 * @license  http://www.opensource.org/licenses/gpl-license.php GPL v2.0 (or later)
 * @link     https://github.com/jaredatch/Custom-Metaboxes-and-Fields-for-WordPress
 */

add_filter( 'cmb_meta_boxes', 'wpex_metaboxes' );
/**
 * Define the metabox and field configurations.
 *
 * @param  array $meta_boxes
 * @return array
 */
function wpex_metaboxes( array $meta_boxes ) {

	// Start with an underscore to hide fields from custom fields list
	$prefix = 'gopress_';
	
	// Highlights
	$meta_boxes[] = array(
		'id'         => 'wpex_slides_metabox',
		'title'      => __('Slide Options','wpex'),
		'pages'      => array( 'slides', ),
		'context'    => 'normal',
		'priority'   => 'high',
		'show_names' => true,
		'fields'     => array(
			array(
				'name' 	=> __('Slide Description','gopress'),
				'desc'	=> __('Enter a description for your slider (optiona). Use h2 tag for a nice title.','gopress'),
				'id'	=> $prefix . 'slides_description',
				'type'	=> 'textarea',
				'std'	=> ''
			),
			array(
				'name' 	=> __('Slide URL','gopress'),
				'desc'	=> __('Enter a URL to link this slide to - perfect for linking slides to pages on your site or other sites. Optional.','gopress'),
				'id'	=> $prefix . 'slides_url',
				'type' 	=> 'text',
				'std' 	=> ''
			),
		),
	);
	

	return $meta_boxes;
}

add_action( 'init', 'cmb_initializewpexmeta_boxes', 9999 );
/**
 * Initialize the metabox class.
 */
function cmb_initializewpexmeta_boxes() {

	if ( ! class_exists( 'cmb_Meta_Box' ) )
		require_once( get_template_directory() .'/functions/meta/init.php');

}