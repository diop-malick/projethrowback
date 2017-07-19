<?php
class NewProductsController extends NewProductsControllerCore
{
    
    public function initContent()
    {
        parent::initContent();
        $products = Product::getNewProducts($this->context->language->id, (int)$this->p - 1, (int)$this->n, false, $this->orderBy, $this->orderWay);
        $groups = Size::getProductAttributeCombinations2($products , $this->context->language->id, $this->context->shop->id);
        $this->context->smarty->assign('groups', $groups);
   }

}


?>