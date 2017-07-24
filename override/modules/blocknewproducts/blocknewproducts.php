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
	
	public function hookdisplayHomeTabContent($params)
	{
		$products = (isset(BlockNewProducts::$cache_new_products) && BlockNewProducts::$cache_new_products) ? BlockNewProducts::$cache_new_products : null;
		$tab_product = array();

		foreach ($products as  $prod) {
      $add_product = true;
			$product = new Product($prod['id_product'], true,$this->context->language->id, $this->context->shop->id);
      // get all others cateogry
      $categories_custom=Product::getProductCategoriesFull($prod['id_product'], 1);    
      // check if product is in accesories category
      foreach ($categories_custom as  $cat_custom) {        
        if ($cat_custom['name'] == "VÊTEMENTS" || $cat_custom['name'] == "ACCESSOIRES") {
          // if yes, not add in final products to asign
          $add_product = false;
          break;
        }
      }
      
			if($add_product)
				$tab_product[$i++] = $prod;
		}

		if (!$this->isCached('blocknewproducts_home.tpl', $this->getCacheId('blocknewproducts-home')))
		{
			$this->smarty->assign(array(
				'new_products' => $tab_product,
				'mediumSize' => Image::getSize(ImageType::getFormatedName('medium')),
				'homeSize' => Image::getSize(ImageType::getFormatedName('home'))
			));
		}
		
		if ($tab_product === false)
			return false;


    $groups = Size::getProductAttributeCombinations2($tab_product , $this->context->language->id, $this->context->shop->id);
    $this->context->smarty->assign('groups', $groups);

		return $this->display(__FILE__, 'blocknewproducts_home.tpl', $this->getCacheId('blocknewproducts-home'));
	}

  /* To display new product in PUSH ZONE of search result page */
  public function hookDisplaySearch($params)
  {
      return $this->hookRightColumn($params);
  }

  /* To display new product in PUSH ZONE of shopping cart  page */
    public function hookDisplayShoppingCartFooter($params)
  {
      return $this->hookRightColumn($params);
  }

  /* redifine header hook to add js file */
  public function hookHeader($params)
  {
    if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'index')
      $this->context->controller->addCSS(_THEME_CSS_DIR_.'product_list.css');

    $this->context->controller->addJS(_THEME_JS_DIR_.'modules/blocknewproducts/blocknewproducts.js');
    $this->context->controller->addCSS(_THEME_CSS_DIR_.'product.css');

    $this->context->controller->addCSS($this->_path.'blocknewproducts.css', 'all');
  }


}

