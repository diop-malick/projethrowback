<?php

require_once(dirname(__FILE__).'../../../config/config.inc.php');
require_once(dirname(__FILE__).'../../../init.php');
switch (Tools::getValue('method')) {
  case 'myMethod' :
	
	$id_customer = Context::getContext()->customer->id;
	if($id_customer){
		$statut = 1;
		$data =  array('newsletter' => 1 );
    	$where = ' id_customer = '.(int)$id_customer;
    	die( Tools::jsonEncode( array('result'=> Db::getInstance()->update('customer' , $data ,$where) ) ) );	
	}
	else
		die( Tools::jsonEncode( array('result'=> false ) ) );
	
    break;
  default:
    exit;
}
exit;
?>