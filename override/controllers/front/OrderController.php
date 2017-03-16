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
            if (Tools::getValue('id_address_delivery') && Tools::getValue('id_address_delivery') != "rem") 
                $this->processAddress();
             if ($this->step == OrderController::STEP_PAYMENT) {
                $carrier = new Carrier((int)$this->context->cart->id_carrier , (int)$this->context->language->id);
                $addresse = new Address((int)$this->context->cart->id_address_delivery , (int)$this->context->language->id);

                $this->context->smarty->assign(array(
                'livraison' => $carrier,
                'adresse' => $addresse,
                )); 
            }
        }
    }

    /**
     * Order process controller
     */
    public function autoStep()
    {
        if ($this->step >= 2 && (!$this->context->cart->id_address_delivery || !$this->context->cart->id_address_invoice)) {
            Tools::redirect('index.php?controller=order&step=1');
        }

        if ($this->step > 2 && !$this->context->cart->isVirtualCart()) {
            $redirect = false;
            if (count($this->context->cart->getDeliveryOptionList()) == 0) {
                $redirect = true;
            }

             if (Tools::getValue('id_address_delivery') && Tools::getValue('id_address_delivery') != "rem") {                    
                $this->processAddress();
                $delivery_option = array(Tools::getValue('id_address_delivery') => Tools::getValue('delivery_option'));                
            }else{
                $delivery_option = $this->context->cart->getDeliveryOption();
            }

          
            
            if (is_array($delivery_option)) {
                $carrier = explode(',', $delivery_option[(int)$this->context->cart->id_address_delivery]);
            }

            if (!$redirect && !$this->context->cart->isMultiAddressDelivery()) {
                foreach ($this->context->cart->getProducts() as $product) {
                    $carrier_list = Carrier::getAvailableCarrierList(new Product($product['id_product']), null, $this->context->cart->id_address_delivery);
                    foreach ($carrier as $id_carrier) {
                        if (!in_array($id_carrier, $carrier_list)) {
                            $redirect = true;
                        } else {
                            $redirect = false;
                            break;
                        }
                    }
                    if ($redirect) {
                        break;
                    }
                }
            }
            
            if ($redirect) {
                Tools::redirect('index.php?controller=order&step=1');
            }
        }

        $delivery = new Address((int)$this->context->cart->id_address_delivery);
        $invoice = new Address((int)$this->context->cart->id_address_invoice);

        if ($delivery->deleted || $invoice->deleted) {
            if ($delivery->deleted) {
                unset($this->context->cart->id_address_delivery);
            }
            if ($invoice->deleted) {
                unset($this->context->cart->id_address_invoice);
            }
            Tools::redirect('index.php?controller=order&step=-1');
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

        // Adding CSS style sheet       
        if ($this->step == OrderController::STEP_DELIVERY || $this->step == OrderController::STEP_PAYMENT) {
            $this->addJS(_THEME_JS_DIR_.'order-carrier.js');
            $this->addJS(_THEME_JS_DIR_.'order-custom.js');
            $this->addCSS(_THEME_CSS_DIR_.'order-custom.css');
        }

    }
 }
?>
