<?php
/***
* Special Thanks To Devin Price
* This file is a modified of the original plugin found @https://github.com/devinsays/slides-post-type - Special Thanks!
***/

if ( ! class_exists( 'Symple_Slides_Post_Type' ) ) :
class Symple_Slides_Post_Type {

	function __construct() {

		// Adds the slides post type
		add_action( 'init', array( &$this, 'slides_init' ), 0 );

		// Thumbnail support for slides posts
		add_theme_support( 'post-thumbnails', array( 'slides' ) );

		// Adds columns in the admin view for thumbnail and taxonomies
		add_filter( 'manage_edit-slides_columns', array( &$this, 'slides_edit_columns' ) );
		add_action( 'manage_posts_custom_column', array( &$this, 'slides_column_display' ), 10, 2 );

		// Give the slides menu item a unique icon
		add_action( 'admin_head', array( &$this, 'slides_icon' ) );
	}
	

	function slides_init() {

		/**
		 * Enable the Slides custom post type
		 * http://codex.wordpress.org/Function_Reference/register_post_type
		 */

		$labels = array(
			'name'					=> __( 'Slides', 'gopress' ),
			'singular_name'			=> __( 'Slides Item', 'gopress' ),
			'add_new'				=> __( 'Add New Item', 'gopress' ),
			'add_new_item'			=> __( 'Add New Slides Item', 'gopress' ),
			'edit_item'				=> __( 'Edit Slides Item', 'gopress' ),
			'new_item'				=> __( 'Add New Slides Item', 'gopress' ),
			'view_item'				=> __( 'View Item', 'gopress' ),
			'search_items'			=> __( 'Search Slides', 'gopress' ),
			'not_found'				=> __( 'No slides items found', 'gopress' ),
			'not_found_in_trash'	=> __( 'No slides items found in trash', 'gopress' )
		);
		
		$args = array(
	    	'labels'				=> $labels,
	    	'public'				=> true,
			'supports'				=> array( 'title', 'thumbnail', 'custom-fields' ),
			'capability_type'		=> 'post',
			'rewrite'				=> array("slug"	=> "slides"), // Permalinks format
			'has_archive'			=> false,
			'exclude_from_search'	=> true,
			'show_in_nav_menus'		=> false
		); 
		
		$args = apply_filters('symple_slides_args', $args);
		
		register_post_type( 'slides', $args );

	}

	/**
	 * Add Columns to Slides Edit Screen
	 * http://wptheming.com/2010/07/column-edit-pages/
	 */

	function slides_edit_columns( $slides_columns ) {
		$slides_columns = array(
			"cb"				=> "<input type=\"checkbox\" />",
			"title"				=> __('Title', 'column name'),
			"slides_thumbnail"	=> __('Thumbnail', 'gopress'),
			"author"			=> __('Author', 'gopress'),
			"comments"			=> __('Comments', 'gopress'),
			"date"				=> __('Date', 'gopress'),
		);
		$slides_columns['comments'] = '<div class="vers"><img alt="Comments" src="' . esc_url( admin_url( 'images/comment-grey-bubble.png' ) ) . '" /></div>';
		return $slides_columns;
	}

	function slides_column_display( $slides_columns, $post_id ) {

		// Code from: http://wpengineer.com/display-post-thumbnail-post-page-overview

		switch ( $slides_columns ) {

			// Display the thumbnail in the column view
			case "slides_thumbnail":
				$width = (int) 80;
				$height = (int) 80;
				$thumbnail_id = get_post_meta( $post_id, '_thumbnail_id', true );

				// Display the featured image in the column view if possible
				if ( $thumbnail_id ) {
					$thumb = wp_get_attachment_image( $thumbnail_id, array($width, $height), true );
				}
				if ( isset( $thumb ) ) {
					echo $thumb;
				} else {
					echo __('None', 'gopress');
				}
				break;	

			// Display the slides tags in the column view
			case "slides_category":

			if ( $category_list = get_the_term_list( $post_id, 'slides_category', '', ', ', '' ) ) {
				echo $category_list;
			} else {
				echo __('None', 'gopress');
			}
			break;	

			// Display the slides tags in the column view
			case "slides_tag":

			if ( $tag_list = get_the_term_list( $post_id, 'slides_tag', '', ', ', '' ) ) {
				echo $tag_list;
			} else {
				echo __('None', 'gopress');
			}
			break;			
		}
	}
	
	/**
	 * Displays the custom post type icon in the dashboard
	 */

	function slides_icon() { ?>
	    <style type="text/css" media="screen">
	        #menu-posts-slides .wp-menu-image {
	            background: url(<?php echo get_template_directory_uri(). '/images/post-types/slides-icon.png'; ?>) no-repeat 6px -17px !important;
	        }
			#menu-posts-slides:hover .wp-menu-image, #menu-posts-slides.wp-has-current-submenu .wp-menu-image {
	            background-position:6px 7px !important;
	        }
	    </style>
	<?php }

}

new Symple_Slides_Post_Type;

endif;