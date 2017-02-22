<?php
/*
Plugin Name: Page Builder by PluginOps
Description: A drag and drop, responsive page builder that simplifies building your landing pages.
Version: 1.2.1
Author: PluginOps
Author URI: http://pluginops.com/
License: GPL V2
*/


if ( ! defined( 'ABSPATH' ) ) exit;
include 'config.php';
include 'includes.php';


function ulpb_plugin_add_settings_link( $links ) {
    $settings_link = '<a href="admin.php?page=page-builder-dashboard-ulpb">' . __( 'Dashboard' ) . '</a>';
    $support_link = '<a href="http://pluginops.com/support/">' . __( 'Support' ) . '</a>';
    array_push( $links, $settings_link );
    array_push( $links, $support_link );
  	return $links;
}
$plugin = plugin_basename( __FILE__ );
add_filter( "plugin_action_links_$plugin", 'ulpb_plugin_add_settings_link' );



register_activation_hook(__FILE__, 'ulpb_plugin_activation');
add_action('admin_init', 'ulpb_plugin_redirect_activation');

function ulpb_plugin_activation() {
add_option('ulpb_plugin_activation_check_option', true);
}

function ulpb_plugin_redirect_activation() {
if (get_option('ulpb_plugin_activation_check_option', false)) {
    delete_option('ulpb_plugin_activation_check_option');
    if(!isset($_GET['activate-multi']))
    {
        wp_redirect("edit.php?post_type=ulpb_post&page=page-builder-dashboard-ulpb");
        exit();
    }
 }
}



?>