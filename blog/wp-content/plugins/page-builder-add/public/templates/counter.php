<?php

 // 86400 = 1 day
$allowed = array();

if (!isset($_COOKIE['ulpb_count']) && !is_user_logged_in()) {

	$current_count = get_post_meta($post->ID,'ulpb_page_hit_counter',true);
	$new_count = $current_count + 1;
	update_post_meta( $post->ID, 'ulpb_page_hit_counter', wp_kses("$new_count", $allowed ) );
	
	setcookie('ulpb_count', '1', time() + (86400 * 30), "/");

}

if (!is_user_logged_in()) {
	$current_view_count = get_post_meta($post->ID,'ulpb_page_views_counter',true);
	$new_view_count = $current_view_count + 1;
	update_post_meta( $post->ID, 'ulpb_page_views_counter', wp_kses("$new_view_count", $allowed ) );
}

?>