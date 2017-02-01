
<?php

/* Webbax - 24.02.16 - intégration WP-PS */
require_once(dirname(__FILE__).'/../../../../config/config.inc.php');
global $controllerPrestashop;
$controllerPrestashop = new FrontController();
$controllerPrestashop->init();
$controllerPrestashop->setMedia();
Context::getContext()->smarty->assign(array('meta_title' => html_entity_decode(get_the_title()), 
                                            'meta_description' => get_post_meta($post->ID,'description',true),
                                            'meta_keywords' => ''
                                            ));
$controllerPrestashop->displayHeader();



// footer.php
<?php 
/* Webbax - 24.02.16 - intégration WP-PS */
global $controllerPrestashop;
$controllerPrestashop->displayFooter();
?>

?>





