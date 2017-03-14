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

        $carrier = new Carrier((int)$order->id_carrier , (int)$this->context->language->id);
        $addresse = new Address((int)$order->id_address_delivery , (int)$this->context->language->id);

        $this->context->smarty->assign(array(            
            'products' => $order->getProducts(),
            'total_products_wt' => $order->total_products_wt,
            'shippingCost' => $order->total_shipping,
            'livraison' => $carrier,
            'adresse' => $addresse,        
        ));

    }
 }
?>