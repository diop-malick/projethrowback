
<style type="text/css">
#lpp_logo{
	max-width: 320px;
    max-height: 80px;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul{
	list-style:none;
	margin:0;
	padding:0
}

<?php echo "#lpb_menu_widget-$j"; ?> ul a{
	display:block;
	color:<?php echo $menuColor; ?> !important;
	text-decoration:none;
	font-size: 16px;
	padding:0 15px;
	font-family:"HelveticaNeue","Helvetica Neue",Helvetica,Arial,sans-serif;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul li{
	position:relative;
	float:left;
	margin:0;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul li.current-menu-item{
	background:#ddd;

}

<?php echo "#lpb_menu_widget-$j"; ?> ul a:hover{
	color: #8e8c8c;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul ul{
	display:none;
	position:absolute;
	top:100%;
	left:0;
	background:#fff;
	padding:0;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul ul li{
	float:none;
	width:200px;
}

<?php echo "#lpb_menu_widget-$j"; ?> ul ul a{
}

<?php echo "#lpb_menu_widget-$j"; ?> ul ul ul{
	top:0;
	left:100%
}

<?php echo "#lpb_menu_widget-$j"; ?> ul li:hover > ul{
	display:block
}
</style>
<?php
ob_start();
?>
 <?php
wp_nav_menu( array( 'menu' => $menuName, 'container_id' => "lpb_menu_widget-$j" ) );
$this_widget_menu = ob_get_contents();
ob_end_clean();

?>