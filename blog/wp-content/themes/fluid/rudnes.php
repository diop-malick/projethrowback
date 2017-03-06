<?php
/*
Template Name:sne
*/
// Which page of the blog are we on?
$paged = get_query_var('paged');
query_posts('cat=-0&paged='.$paged);
load_template(TEMPLATEPATH . '/front-page-rudness.php'); //loads index
?>






