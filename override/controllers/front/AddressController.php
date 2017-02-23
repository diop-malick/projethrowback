<?php
class AddressController extends AddressControllerCore
{
     public function displayAjax()
    {
        parent::displayAjax();
        
        $this->smartyOutputContent(_PS_THEME_DIR_.'address.tpl');
    }
 }
?>