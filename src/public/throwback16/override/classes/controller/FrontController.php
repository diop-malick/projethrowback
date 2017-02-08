<?php
FrontController extends FrontControllerCore {

    public function addColorsToProductList(&$products)
    {
        // You may need to modify the parent code if the caching ignores your changes

        // Disable this if you dont want to add colors seperately;
        parent::addColorsToProductList($products);


        // @see AdminProductsController.php @ Line 4263
        foreach($products as &$p)
        {
            $attributes = $p->getAttributesResume($this->context->language->id);

            foreach ($attributes as $attribute)
            {
                // You may check if product_attribute is color + size here

                $id_product_attribute = $attribute['id_product_attribute'];
                $qty = StockAvailable::getQuantityAvailableByProduct((int)$obj->id, id_product_attribute);

                $p['product_attributes'][$id_product_attribute]['qty'] = $qty;
                $p['product_attributes'][$id_product_attribute]['name'] =  $attribute['attribute_designation'];

                // If you need individual color + size and their data, you will probably have to do some SQL,
                // because getAttributesResume doesn SQL to get this data too.
            }
        }
    }

}
?>