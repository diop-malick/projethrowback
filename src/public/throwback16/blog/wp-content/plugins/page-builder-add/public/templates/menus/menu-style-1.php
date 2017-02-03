
<style type="text/css">
#lpp_logo{
	max-width: 320px;
    max-height: 80px;
}
#lpb_menu_widget{
	text-align: center;
	display: block;
	margin-left: 10%;
}

#lpb_menu_widget ul{
	list-style:none;
	margin:0;
	padding:0
}

#lpb_menu_widget ul a{
	display:block;
	color:<?php echo $menuColor; ?>;
	text-decoration:none;
	font-size: 16px;
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