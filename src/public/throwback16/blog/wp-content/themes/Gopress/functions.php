<?php
/**
 * @package WordPress
 * @subpackage GoPress Theme
*/


// Set the content width based on the theme's design and stylesheet.
if ( ! isset( $content_width ) ) 
    $content_width = 620;



/*-----------------------------------------------------------------------------------*/
/*	Include functions
/*-----------------------------------------------------------------------------------*/
require_once( get_template_directory() .'/admin/theme-admin.php');
require_once( get_template_directory() .'/functions/pagination.php');
require_once( get_template_directory() .'/functions/shortcodes.php');
require_once( get_template_directory() .'/functions/flickr-widget.php');
require_once( get_template_directory() .'/functions/meta/usage.php');
require_once( get_template_directory() .'/functions/register-slides.php');



/*-----------------------------------------------------------------------------------*/
/*	Images
/*-----------------------------------------------------------------------------------*/
add_theme_support( 'post-thumbnails' );
add_image_size( 'full-size',  9999, 9999, false );
add_image_size( 'small-thumb',  50, 50, true );
add_image_size( 'slider',  660, 9999, false );
add_image_size( 'post-image',  315, 175, true );



/*-----------------------------------------------------------------------------------*/
/*	Javascsript
/*-----------------------------------------------------------------------------------*/

add_action('wp_enqueue_scripts','wpex_theme_scripts_function');
function wpex_theme_scripts_function() {
	// Load jQuery
	wp_enqueue_script('jquery');
	
	// Load Google Font
	wp_enqueue_style('google-font-lora', 'http://fonts.googleapis.com/css?family=Lora:400,400italic,700,700italic', 'style');
	
	// Site wide js
	wp_enqueue_script( 'hoverIntent', get_template_directory_uri() . '/js/jquery.hoverIntent.minified.js' );
	wp_enqueue_script( 'superfish', get_template_directory_uri() . '/js/jquery.superfish.js' );
	wp_enqueue_script( 'slides', get_template_directory_uri() . '/js/jquery.slides.min.js' );
	wp_enqueue_script( 'custom', get_template_directory_uri() . '/js/jquery.init.js' );
}



/*-----------------------------------------------------------------------------------*/
/*	Sidebars
/*-----------------------------------------------------------------------------------*/

//Register Sidebars
register_sidebar(array(
		'name'			=> 'Sidebar',
		'id'			=> 'sidebar',
		'description'	=> 'Widgets in this area will be shown in the sidebar.',
		'before_widget'	=> '<div class="sidebar-box clearfix">',
		'after_widget'	=> '</div>',
		'before_title'	=> '<h4><span>',
		'after_title'	=> '</span></h4>',
));
register_sidebar(array(
		'name'			=> 'Footer Left',
		'id'			=> 'footer-left',
		'description'	=> 'Widgets in this area will be shown in the footer left area.',
		'before_widget'	=> '<div class="footer-widget clearfix">',
		'after_widget'	=> '</div>',
		'before_title'	=> '<h4>',
		'after_title'	=> '</h4>',
));
register_sidebar(array(
		'name'			=> 'Footer Middle',
		'id'			=> 'footer-middle',
		'description'	=> 'Widgets in this area will be shown in the footer middle area.',
		'before_widget'	=> '<div class="footer-widget clearfix">',
		'after_widget'	=> '</div>',
		'before_title'	=> '<h4>',
		'after_title'	=> '</h4>',
));
register_sidebar(array(
		'name'			=> 'Footer Right',
		'id'			=> 'footer-right',
		'description'	=> 'Widgets in this area will be shown in the footer right area.',
		'before_widget'	=> '<div class="footer-widget clearfix">',
		'after_widget'	=> '</div>',
		'before_title'	=> '<h4>',
		'after_title'	=> '</h4>',
));

/*-----------------------------------------------------------------------------------*/
/*	Other functions
/*-----------------------------------------------------------------------------------*/

// Limit Post Word Count
function wpex_excerpt_length($length) {
	return 17;
}
add_filter('excerpt_length', 'new_excerpt_length');

//Replace Excerpt Link
function wpex_excerpt_more($more) {
       global $post;
	return '...';
}
add_filter('excerpt_more', 'new_excerpt_more');

// Enable Custom Background
add_theme_support( 'custom-background' );

// register navigation menus
register_nav_menus(
	array(
		'menu'	=>__('Menu'),
	)
);


// Localization Support
load_theme_textdomain( 'gopress', get_template_directory() .'/lang' );

/**
* Add thumbnails to post admin dashboard
* @since 1.0
*/
add_filter('manage_posts_columns', 'wpex_posts_columns', 5);
add_action('manage_posts_custom_column', 'wpex_posts_custom_columns', 5, 2);

/**
* Add thumbnails to post admin dashboard
* @since 1.1
*/
add_filter('manage_posts_columns', 'wpex_posts_columns', 5);
add_action('manage_posts_custom_column', 'wpex_posts_custom_columns', 5, 2);

function wpex_posts_columns($defaults){
    $defaults['wpex_post_thumbs'] = __( 'Thumbnail', 'wpex' );
    return $defaults;
}

function wpex_posts_custom_columns( $column_name, $id ){
    if( $column_name != 'wpex_post_thumbs' ) {
        return;	
	}
	$thumbnail = wp_get_attachment_image_src( get_post_thumbnail_id(), 'thumbnail');
	if (  $thumbnail ) {
		echo '<img src="' . $thumbnail[0] . '" alt="' . the_title_attribute('echo=0') . '" height="70" width="70" style="max-width:100%;height:auto;" />';
	} else {
		return;
	}
}
?>