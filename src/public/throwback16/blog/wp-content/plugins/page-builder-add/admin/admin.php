<?php
if ( ! defined( 'ABSPATH' ) ) exit;
class ULPB_AdminClass {

	function __construct(){

		$this->_init();
		$this->_hooks();
		$this->_filters();

	}

	function _init(){
		

	}

	function _hooks(){
		
		add_action( 'init', array( $this, 'ulpb_register_feed_post_type' ) );
		
		add_action( 'admin_enqueue_scripts', array( $this, 'wssf_admin_scripts' ));

		add_action('edit_form_after_title' ,array( $this, 'wssf_custom_UI_without_metabox' ));

		add_action( 'wp_ajax_nopriv_ulpb_admin_data', array( $this,'ulpb_admin_ajax')  );
		add_action( 'wp_ajax_ulpb_admin_data', array( $this,'ulpb_admin_ajax') );

		add_action( 'pre_get_posts', array($this,'pbp_custom_parse_request_tricksy') );
		
		add_filter( 'single_template', array( $this,'ulpb_main_front_html') );
		add_filter( 'get_pages', array($this,'add_pbp_tabs_to_dropdown') );
		add_filter( 'hidden_meta_boxes',array($this,'remove_meta_boxes_all'),10, 3 );

		add_filter( 'post_type_link', array($this,'pbp_custom_remove_cpt_slug'), 10, 3 );

		add_filter('template_redirect', array($this,'replace_default_front_page') );

		add_filter('manage_ulpb_post_posts_columns', array($this,'ulpb_columns_admin') );

		add_action('manage_ulpb_post_posts_custom_column',array($this,'ulpb_column_visitors_data'),10, 2);
		add_action('manage_ulpb_post_posts_custom_column',array($this,'ulpb_front_page_column'),10, 2);
	}

	function _filters(){

	}




function ulpb_register_feed_post_type() {

	$labels = array(
		'name'                => __( 'Page Builder', 'pbp-ps-cpt' ),
		'singular_name'       => __( 'Page Builder', 'pbp-ps-cpt' ),
		'add_new'             => _x( 'Add New Page', 'pbp-ps-cpt', 'pbp-ps-cpt' ),
		'add_new_item'        => __( 'Add New Page', 'pbp-ps-cpt' ),
		'edit_item'           => __( 'Edit Page', 'pbp-ps-cpt' ),
		'new_item'            => __( 'New Page', 'pbp-ps-cpt' ),
		'view_item'           => __( 'View Page', 'pbp-ps-cpt' ),
		'search_items'        => __( 'Search Pages', 'pbp-ps-cpt' ),
		'not_found'           => __( 'No Pages found', 'pbp-ps-cpt' ),
		'not_found_in_trash'  => __( 'No Pages found in Trash', 'pbp-ps-cpt' ),
		'parent_item_colon'   => __( 'Parent Page:', 'pbp-ps-cpt' ),
		'menu_name'           => __( 'Page Builder', 'pbp-ps-cpt' ),
	);

	$args = array(
		'labels'                   => $labels,
		'hierarchical'        => false,
		'description'         => 'Add Pages',
		'taxonomies'          => array(),
		'public'              => true,
		'show_ui'             => true,
		'show_in_menu'        => true,
		'show_in_admin_bar'   => false,
		'menu_position'       => null,
		'menu_icon'           => 'dashicons-welcome-add-page',
		'show_in_nav_menus'   => true,
		'publicly_queryable'  => true,
		'exclude_from_search' => false,
		'has_archive'         => true,
		'query_var'           => true,
		'can_export'          => true,
		'rewrite'             => true,
		'capability_type'     => 'post',
		'supports'            => array(
			'title'
			)
	);

	register_post_type( 'ulpb_post', $args );
}

function pbp_custom_remove_cpt_slug( $post_link, $post, $leavename ) {
 
    if ( 'ulpb_post' != $post->post_type || 'publish' != $post->post_status ) {
        return $post_link;
    }
 
    $post_link = str_replace( '/' . $post->post_type . '/', '/', $post_link );
 
    return $post_link;
}

function pbp_custom_parse_request_tricksy( $query ) {
 
    if ( ! $query->is_main_query() )
        return;
 
    if ( 2 != count( $query->query ) || ! isset( $query->query['page'] ) ) {
        return;
    }
 
    if ( ! empty( $query->query['name'] ) ) {
        $query->set( 'post_type', array( 'post', 'ulpb_post', 'page' ) );
    }
}


function wssf_admin_scripts( ) {

	$screen_id = get_current_screen();
	
	if ($screen_id->post_type !== 'ulpb_post'){} else{ ;
	wp_enqueue_script('jquery');
	wp_enqueue_script( 'media-upload' );
	wp_enqueue_script( 'underscore');
	wp_enqueue_script( 'backbone');
	//wp_enqueue_script( 'jquery-ui');
	wp_enqueue_script( 'wssf-backbone-builder-jqueryUI', ULPB_PLUGIN_URL.'/js/Backbone-resources/jquery-ui.js', array( 'jquery' ), false, false );
	wp_enqueue_script( 'wssf-backbone-builder-collectionView', ULPB_PLUGIN_URL.'/js/Backbone-resources/backbone.collectionView.js', array( 'jquery' ), false, true );
	wp_enqueue_script( 'wssf-backbone-builder-pbb-model-1', ULPB_PLUGIN_URL.'/admin/scripts/pbb-model-1.js', array( 'jquery' ), false, true );
	wp_enqueue_script( 'wssf-backbone-builder-pbb-model-2', ULPB_PLUGIN_URL.'/admin/scripts/pbb-model-2.js', array( 'jquery' ), false, true );
	wp_enqueue_script( 'wssf-backbone-builder-script-bb3', ULPB_PLUGIN_URL.'/admin/scripts/bb3.js', array( 'jquery' ), false, true );
	wp_enqueue_script( 'wssf-backbone-builder-script_collectionView', ULPB_PLUGIN_URL.'/admin/scripts/pbb-CollectionView.js', array( 'jquery' ), false, true );
	wp_enqueue_script( 'wssf-backbone-builder-script-pbb-drag-n-drop', ULPB_PLUGIN_URL.'/admin/scripts/pbb-drag-n-drop.js', array( 'jquery' ), false, true );

	
	wp_enqueue_style( 'wp-color-picker' );
	wp_enqueue_style( 'wssf-backbone-builder-jqueryUI-style', ULPB_PLUGIN_URL.'/js/Backbone-resources/jquery-ui.css' );
	wp_enqueue_style( 'wssf-adminUI-styling', ULPB_PLUGIN_URL.'/styles/admin-style.css' );

    wp_enqueue_script( 'wssf-color-picker-script', ULPB_PLUGIN_URL.'/js/alpha-picker.js', array( 'wp-color-picker' ), false, true );
    wp_enqueue_script( 'wssf-imgUpload-script', ULPB_PLUGIN_URL.'/js/image-upload.js', array( 'jquery' ), false, true );
    wp_enqueue_script( 'wssf-fontPicker-script', ULPB_PLUGIN_URL.'/js/g-font-family.js', array( 'jquery' ), false, true );
	}

}

function wssf_custom_UI_without_metabox($post){
	global $post;

	$screen_id = get_current_screen();
	
	if ($screen_id->post_type === 'ulpb_post') {
		include(ULPB_PLUGIN_PATH.'/admin/admin-ui.php');
		//include(ULPB_PLUGIN_PATH.'admin/bb3js.php');
	
	}
	
} /// wssf_custom_UI_without_metabox ends here


function ulpb_admin_ajax(){
	if($_SERVER['REQUEST_METHOD'] == 'GET') {

    	$page_id = intval($_GET['page_id']);
    	$data = get_post_meta( $page_id, 'ULPB_DATA', true );
   		echo json_encode( $data );
   		
   		exit();

	} elseif($_SERVER['REQUEST_METHOD'] == 'PUT') {

    	echo "this is a put request\n";

	} elseif ($_SERVER['REQUEST_METHOD'] == 'POST') {

		echo "this is a POST request\n";
		$data = json_decode( file_get_contents( 'php://input' ), true );
		$page_id  = intval($data['pageID']);
		$pageTitle    = $data['pageOptions']['pageSeoName'];
		$setFrontPage    = $data['pageOptions']['setFrontPage'];
		$loadWpHead    = $data['pageOptions']['loadWpHead'];
		$loadWpFooter    = $data['pageOptions']['loadWpFooter'];
		$user_id = get_current_user_id();
		$post = array(
			'ID'		=> wp_strip_all_tags($page_id),
			'post_title' => wp_strip_all_tags($pageTitle),
			'post_status' => 'publish',           
			'post_type' => 'ulpb_post'  
		);
		$post_id =  wp_insert_post($post);
		

		update_post_meta( $post_id, 'ULPB_DATA', $data );
		update_post_meta( $post_id, 'ULPB_FrontPage', $setFrontPage);
		update_post_meta( $post_id, 'ULPB_loadWpHead', $loadWpHead);
		update_post_meta( $post_id, 'ULPB_loadWpFooter', $loadWpFooter);
		$dataTest = get_post_meta( $page_id, 'ULPB_DATA', true );
		if (!empty($dataTest)) {
			echo "Data Saved";
		}
   		//var_dump($data);
   		exit();

	} elseif ($_SERVER['REQUEST_METHOD'] == 'DELETE') {

		echo "this is a Delete request\n";
		$data = json_decode( file_get_contents( 'php://input' ), true );
		echo json_encode( $data );
	}

} //  ulpb_admin_ajax() ends here .     




// Render Template
function ulpb_main_front_html($single_template) {
     global $post;
     //$ulpb_template_select = get_post_meta($post->ID,'ulpb_template_select',true);

    $ulpb_template = ULPB_PLUGIN_PATH.'public/templates/template.php';
  
     if ($post->post_type == 'ulpb_post') {
          $single_template = $ulpb_template;
     }
     return $single_template;
}



function remove_meta_boxes_all( $hidden, $screen, $use_defaults ){
    global $wp_meta_boxes;
    $cpt = 'ulpb_post'; // Modify this to your needs!

    if( $cpt === $screen->id && isset( $wp_meta_boxes[$cpt] ) )
    {
        $tmp = array();
        foreach( (array) $wp_meta_boxes[$cpt] as $context_key => $context_item )
        {
            foreach( $context_item as $priority_key => $priority_item )
            {
                foreach( $priority_item as $metabox_key => $metabox_item )
                    $tmp[] = $metabox_key;
            }
        }
        $hidden = $tmp;  // Override the current user option here.
    }
    return $hidden;
}

function add_pbp_tabs_to_dropdown( $pages ){
    $args = array(
        'post_type' => 'ulpb_post'
    );
    $items = get_posts($args);
    $pages = array_merge($pages, $items);

    return $pages;
}



function replace_default_front_page() {

    $args = array(
        'offset'           => 0,
        'orderby'          => 'date',
        'order'            => 'ASC',
        'post_type'        => 'ulpb_post',
        'post_status'      => 'publish',
    );
    
    $ulpb_pages = get_posts( $args );

    if (!empty($ulpb_pages)) {
        foreach ($ulpb_pages as $post) {
            $currentID = $post->ID;
            $ulpb_is_front_page = get_post_meta( $currentID, 'ULPB_FrontPage', true );

            if ($ulpb_is_front_page === 'true') {
            $ulpb_template_select = get_post_meta($currentID,'ULPB_FrontPage',true);
            $ulpb_template = ULPB_PLUGIN_PATH.'public/templates/template.php';
            
            if (is_home() || is_front_page() ) {
                    include($ulpb_template);
                    exit();

            }
    }

    }

    
    }

}


function ulpb_columns_admin($defaults) {
    $date = $defaults['date'];
    unset($defaults['date']);
    $defaults['ulpb_visitors']  = 'Visitor Count';
    $defaults['ulpb_front_page']  = 'Front Page';
    $defaults['date'] = $date;

    return $defaults;
}


function ulpb_column_visitors_data($column_name, $post_ID) {
    if ($column_name == 'ulpb_visitors') {
        $current_count = get_post_meta($post_ID,'ulpb_page_hit_counter',true);
        if (empty($current_count)) {
            $current_count = 0;
        }
        echo "<div style='padding: 7px 10px 8px 31px;background: #fff;border: 1px solid #D2D2D2;border-radius: 3px;width: 20%; min-width:200px;font-weight: bold;' >$current_count - Visits</div>";
    }
}


function ulpb_front_page_column($column_name, $post_ID) {
    if ($column_name == 'ulpb_front_page') {
        $ulpb_is_front_page = get_post_meta($post_ID,'ULPB_FrontPage',true);
        if ($ulpb_is_front_page === 'true') {
            $is_landing_page = 'background:#8bc34a;';
        }else{
            $is_landing_page = 'background:#f44336;';
        }
        echo "<div style='width:30px; height:30px; border-radius:100px; $is_landing_page'></div>";
    }
}









} //class ends
?>