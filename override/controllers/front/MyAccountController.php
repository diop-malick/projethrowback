<?php

class MyAccountController extends MyAccountControllerCore
{

    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'my-account.css');
        // overrides - add js 
        $this->addJS(_THEME_JS_DIR_.'my-account.js');
    }

    /**
     * Assign template vars related to page content
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        $has_address = $this->context->customer->getAddresses($this->context->language->id);
        $this->context->smarty->assign(array(
            'has_customer_an_address' => empty($has_address),
            'voucherAllowed' => (int)CartRule::isFeatureActive(),
            'returnAllowed' => (int)Configuration::get('PS_ORDER_RETURN'),
            
            // overrides - add mailchmps parameter 
            'processMailchimpsInscription'  => Tools::getValue('processMailchimpsInscription')

        ));
        $this->context->smarty->assign('HOOK_CUSTOMER_ACCOUNT', Hook::exec('displayCustomerAccount'));

        $this->setTemplate(_PS_THEME_DIR_.'my-account.tpl');
    }
}
