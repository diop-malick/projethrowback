<?php

if (!defined('_CAN_LOAD_FILES_'))
    exit;

class CashOnDeliveryOverride extends CashOnDelivery
{
	public function hookDisplayPaymentTop($params)
    {
        return $this->display(__FILE__, 'payment_top.tpl'); 
    }

}

?>
