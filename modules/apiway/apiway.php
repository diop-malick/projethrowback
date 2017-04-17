<?php
/**
 * Store Commander
 *
 * @category administration
 * @author Mise En Prod - support@storecommander.com
 * @version 2015-09-11
 * @uses Prestashop modules
 * @since 2009
 * @copyright Copyright &copy; 2009-2015, Mise En Prod
 * @license commercial
 * All rights reserved! Copying, duplication strictly prohibited
 *
 * *****************************************
 * *           STORE COMMANDER             *
 * *   http://www.StoreCommander.com       *
 * *            V 2015-09-11               *
 * *****************************************
 *
 * Compatibility: PS version: 1.1 to 1.6
 *
 **/


class Apiway extends Module
{

    public $currentUrl = '';
    public $_err = array();
    public $context;

    public function __construct()
    {
        $this->name = 'apiway';
        $this->tab = 'administration';
        $this->version = '1.0.1';
        $this->author = 'Mise En Prod';
        $this->module_key = 'ebfcf64d8c9f16cd67ffd8b6b2760c53';
        parent::__construct();


        $this->page = basename(__FILE__, '.php');

        $this->displayName = $this->l('Store Commander APIWAY.tools');
        $this->description = $this->l('PrestaShop catalog management 10 times faster');

    }

    public function getContent()
    {
        $this->context = Context::getContext();

        $this->context->smarty->assign(array(
            'module_name' => $this->name
        ));

        $_html = '';
        $_html .=  $this->display(__FILE__, 'views/templates/hook/init_js.tpl');

        $_html .=  $this->display(__FILE__, 'etape_preinstall_1.5.tpl');
        return $_html;
    }
}