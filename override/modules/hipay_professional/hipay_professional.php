<?php

if (!defined('_CAN_LOAD_FILES_'))
    exit;

class Hipay_ProfessionalOverride extends Hipay_Professional
{

    public function hookPaymentTop()
    {
        //$this->context->controller->addJS($this->_path . 'views/js/front.js');
        return $this->display(__FILE__, 'payment_top.tpl');
    }

}

?>
