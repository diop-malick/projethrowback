<?php

if (!defined('_CAN_LOAD_FILES_'))
    exit;

class Hipay_ProfessionalOverride extends Hipay_Professional
{

    public function hookPayment($params)
    {
        
        /* BEGIN - Custom code */
        // Add Iframe directly on payment Page
        // copied from Redirect::generatePayment
        

        require_once(dirname(__FILE__) . '/../../../modules/hipay_professional/classes/webservice/HipayPayment.php');
        $results = null;
        // $object = ModuleCore::getInstanceByName("blockmanufacturer");
        $object_hipay_professional = Module::getInstanceByName('hipay_professional');
        // var_dump($object_hipay_professional);
        $payment = new HipayPayment($object_hipay_professional);

        if ($payment->generate($results) == false) {
            $description = $results->generateResult->description;
            Tools::displayError('An error occurred while getting transaction informations', $description);
        } else {
            if (!$object_hipay_professional->configHipay->payment_form_type) {
                $this->context->smarty->assign(array(
                    'iframe_url' => $results->generateResult->redirectUrl,
                    'cart_id' => $this->context->cart->id,
                    'currency' => $this->context->currency->iso_code,
                    'amount' => $this->context->cart->getOrderTotal(true, Cart::BOTH),
                    'nbProducts' => $this->context->cart->nbProducts(),
                ));
            }
        }
        /* END - Custom code */

        $currency_id = $params['cart']->id_currency;
        $currency = new Currency((int)$currency_id);
        $isocode_currency = $currency->iso_code;

        $config_hipay = $this->configHipay;
        if ((!$this->configHipay->sandbox_mode && $this->configHipay->selected->currencies->production->$isocode_currency->accountID)
            || ($this->configHipay->sandbox_mode && $this->configHipay->selected->currencies->sandbox->$isocode_currency->accountID)
        ) {
            if (in_array($isocode_currency, $this->limited_currencies) == false) {
                return false;
            }

            $this->smarty->assign(array(
                'domain' => Tools::getShopDomainSSL(true),
                'module_dir' => $this->_path,
                'payment_button' => $this->getPaymentButton(),
                'min_amount' => $this->min_amount,
                'configHipay' => $this->objectToArray($config_hipay),
                'lang' => Tools::strtolower($this->context->language->iso_code),
            ));

            $this->smarty->assign('hipay_prod', !(bool)$this->configHipay->sandbox_mode);

            return $this->display(dirname(__FILE__), 'views/templates/hook/payment.tpl');
        }

       return false;
    }

}

?>
