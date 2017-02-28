<?php
class OrderController extends OrderControllerCore
{
    /**
     * Carrier step override
     */

    const STEP_SUMMARY_EMPTY_CART = -1;
    const STEP_ADDRESSES = -2;
    const STEP_DELIVERY = 1;
    const STEP_PAYMENT = 3;

     public function postProcess()
    {
        // Update carrier selected on preProccess in order to fix a bug of
        // block cart when it's hooked on leftcolumn
        if ($this->step == OrderController::STEP_PAYMENT && Tools::isSubmit('processCarrier')) {
            $this->processCarrier();
        }
    }



    protected function _assignCarrier()
    {

        global $orderTotal;
        
        //Assign Adress Core
        $addressDelivery = new Address((int)$this->context->cart->id_address_delivery);
        if(Validate::isLoadedObject($addressDelivery)){
            parent::_assignAddress();
            parent::processAddressFormat();
        }        


        // Assign carrier core
        parent::_assignCarrier();
      

        /* We may need to display an order summary */
        $this->context->smarty->assign($this->context->cart->getSummaryDetails());

        $this->context->smarty->assign(array(
            'total_price' => (float)$orderTotal,            
        ));

        $addressDelivery = new Address((int)$this->context->cart->id_address_delivery);

        $this->id_country = (int)$addressDelivery->id_country;
        // Generate countries list
        if (Configuration::get('PS_RESTRICT_DELIVERED_COUNTRIES')) {
            $countries = Carrier::getDeliveredCountries($this->context->language->id, true, true);
        } else {
            $countries = Country::getCountries($this->context->language->id, true);
        }

        // @todo use helper
        $list = '';
        foreach ($countries as $country) {
            $selected = ((int)$country['id_country'] === $this->id_country) ? ' selected="selected"' : '';
            $list .= '<option value="'.(int)$country['id_country'].'"'.$selected.'>'.htmlentities($country['name'], ENT_COMPAT, 'UTF-8').'</option>';
        }

        // Assign vars
        $this->context->smarty->assign(array(
            'countries_list' => $list,
            'countries' => $countries,
            'select_address' => (int)$this->context->cart->id_address_delivery,
            'idSelectedCountry' => (int)$this->id_country,
            'idSelectedState' => (int)$addressDelivery->id_state,
            
        ));


        
       
    }

    public function setMedia()
    {
        parent::setMedia();
        
        
        $this->addCSS(_THEME_CSS_DIR_.'tabs.css');       
        $this->addJS(array(
            _THEME_JS_DIR_.'tabs.js',            
            _THEME_JS_DIR_.'tools/vatManagement.js',
            _THEME_JS_DIR_.'tools/statesManagement.js',
            _THEME_JS_DIR_.'order-address.js',
           
        ));

        if ($this->step == OrderController::STEP_DELIVERY) {
            $this->addJS(_THEME_JS_DIR_.'order-carrier.js');
        }
       
    }
 }
?>