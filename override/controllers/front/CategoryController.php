<?php
class CategoryController extends CategoryControllerCore
{
    
    public function initContent()
    {
        parent::initContent();
        $products = (isset($this->cat_products) && $this->cat_products) ? $this->cat_products : null;
        $groups = Size::getProductAttributeCombinations2($products , $this->context->language->id, $this->context->shop->id);
        $this->context->smarty->assign('groups', $groups);
   }

}


?>