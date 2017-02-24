<?php
class OrderConfirmationController extends OrderConfirmationControllerCore
{
   /**
     * Assign template vars related to page content
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        $order = new Order($this->id_order) ;

        $this->context->smarty->assign(array(            
            'products' => $order->getProducts(),
            'total_price' => $order->total_paid,
            'total_price_without_tax' => $order->total_paid_tax_excl,
            'use_taxes' => (int)Configuration::get('PS_TAX'),
            'shipping_costs' => $order->total_shipping,            
        ));

    }
 }
?>