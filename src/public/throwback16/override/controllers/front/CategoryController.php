<?php
class CategoryController extends CategoryControllerCore
{
    public function getProductAttributeCombinations2($products) {
       $combinations = array();
       if ($products){
        foreach($products as $product){
               // load product object
               $product = new Product ($product['id_product'], $this->context->language->id);

               // get the product combinations data
               // create array combinations with key = id_product
               $combinations[$product->id] = $product->getAttributeCombinations($this->context->language->id);
           }
       }
       return $combinations;
   }
    public function initContent()
    {
        parent::initContent();

        $products = (isset($this->cat_products) && $this->cat_products) ? $this->cat_products : null;

        $combinations = $this->getProductAttributeCombinations2($products);
        
        
        $array_global = array('');
        foreach ($combinations as $combination) { 
        $i=0;      
            foreach ($combination as $item) {

                if(isset($item['group_name']) && $item['group_name']=="Taille"){
                    if($i==0){
                        $array_global[ $item['id_product'] ]["Taille"][] = $item['attribute_name'] ;
                        $i++;
                    }
                    
                    if (!in_array($item['attribute_name'], $array_global[ $item['id_product'] ]["Taille"]) )
                        $array_global[ $item['id_product'] ]["Taille"][] = $item['attribute_name'] ;
                }
            }
         }
         $this->context->smarty->assign('size_list', $array_global);  
    }
 }
?>