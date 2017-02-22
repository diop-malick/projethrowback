
<style type="text/css">
#lpp_logo{
	display: inline-block;
	float: left;
	max-width: 320px;
    max-height: 80px;
}
.<?php echo "widget-$j-menuFixed"; ?> {
	width: 100%;
	position: fixed;
	top: 0;
	z-index: 999;
	padding: 5px 0 5px 0;
}
.custom-logo{
	max-width:380px;
	max-height: 95px;
}
#menuWrap{
	width: 90%;
	display: block;
	margin:0 auto;
	margin:0 5% 0 5%;
}
#lpb_menu_widget{
	display: inline-block;
	float:right;
}

#lpb_menu_widget ul{
	list-style:none;
	padding:0;
}

#lpb_menu_widget ul a{
	display:block;
	color:<?php echo $menuColor; ?>;
	text-decoration:none;
	font-size: 18px;
	padding:0 25px;
	font-family:"HelveticaNeue","Helvetica Neue",Helvetica,Arial,sans-serif;
}

#lpb_menu_widget ul li{
	position:relative;
	float:left;
	margin:0;
	padding:5px;
}

#lpb_menu_widget ul li.current-menu-item{
	background:#ddd;
}

#lpb_menu_widget ul a:hover{
	color: #8e8c8c;
}

#lpb_menu_widget ul ul{
	display:none;
	position:absolute;
	top:100%;
	left:0;
	background:#fff;
	padding:0;
}

#lpb_menu_widget ul ul li{
	float:none;
	width:200px;
}

#lpb_menu_widget ul ul a{
}

#lpb_menu_widget ul ul ul{
	top:0;
	left:100%
}

#lpb_menu_widget ul li:hover > ul{
	display:block
}
</style>
<?php
ob_start();
?>
<div id="menuWrap">
<div id="lpp_logo"><?php 
if(!has_custom_logo()) {
	?>
    <h1 style="font-size:2.5em !important;"><?php bloginfo('name'); ?></h1>
    <?php
} else{ the_custom_logo();  }

 ?></div>
 <?php
wp_nav_menu( array( 'menu' => $menuName, 'container_id' => 'lpb_menu_widget' ) );
$this_widget_menu = ob_get_contents();
ob_end_clean();

?>
</div>