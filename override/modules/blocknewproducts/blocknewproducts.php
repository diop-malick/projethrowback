<?php

/*
* 14/02/2017
* Surcharge Module New products
* 
* Modify hook for display top
*/

if (!defined('_PS_VERSION_'))
	exit;

class BlockNewProductsOverride extends BlockNewProducts
{
	/**
	* Returns module content for header
	*
	* @param array $params Parameters
	* @return string Content
	*/
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
	public function hookdisplayHomeTabContent($params)
	{
		if (!$this->isCached('blocknewproducts_home.tpl', $this->getCacheId('blocknewproducts-home')))
		{
			$this->smarty->assign(array(
				'new_products' => BlockNewProducts::$cache_new_products,
				'mediumSize' => Image::getSize(ImageType::getFormatedName('medium')),
				'homeSize' => Image::getSize(ImageType::getFormatedName('home'))
			));
		}
		
		if (BlockNewProducts::$cache_new_products === false)
			return false;

		$products = (isset(BlockNewProducts::$cache_new_products) && BlockNewProducts::$cache_new_products) ? BlockNewProducts::$cache_new_products : null;

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

		return $this->display(__FILE__, 'blocknewproducts_home.tpl', $this->getCacheId('blocknewproducts-home'));
	}
}

