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
            'total_products_wt' => $order->total_products_wt,
            'shippingCost' => $order->total_shipping,            
        ));

    }
 }
?>