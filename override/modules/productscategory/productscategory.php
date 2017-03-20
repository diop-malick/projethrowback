<?php

if (!defined('_PS_VERSION_'))
	exit;

class ProductsCategoryOverride extends ProductsCategory
{
	public function hookProductFooter($params)
	{
		$id_product = (int)$params['product']->id;
		$product = $params['product'];

		$cache_id = 'productscategory|'.$id_product.'|'.(isset($params['category']->id_category) ? (int)$params['category']->id_category : (int)$product->id_category_default);

		if (!$this->isCached('productscategory.tpl', $this->getCacheId($cache_id)))
		{

			$category = false;
			if (isset($params['category']->id_category))
				$category = $params['category'];
			else
			{
				if (isset($product->id_category_default) && $product->id_category_default > 1)
					$category = new Category((int)$product->id_category_default);
			}

			if (!Validate::isLoadedObject($category) || !$category->active)
				return false;

			// Get infos
			// custom throwback - limit from 100 to 14
			$category_products = $category->getProducts($this->context->language->id, 1, 14); 
			$nb_category_products = (int)count($category_products);
			$middle_position = 0;

			// Remove current product from the list
			if (is_array($category_products) && count($category_products))
			{
				foreach ($category_products as $key => $category_product)
				{
					if ($category_product['id_product'] == $id_product)
					{
						unset($category_products[$key]);
						break;
					}
				}

				$taxes = Product::getTaxCalculationMethod();
				if (Configuration::get('PRODUCTSCATEGORY_DISPLAY_PRICE'))
				{
					foreach ($category_products as $key => $category_product)
					{
						if ($category_product['id_product'] != $id_product)
						{
							if ($taxes == 0 || $taxes == 2)
							{
								$category_products[$key]['displayed_price'] = Product::getPriceStatic(
									(int)$category_product['id_product'],
									true,
									null,
									2
								);
							} elseif ($taxes == 1)
							{
								$category_products[$key]['displayed_price'] = Product::getPriceStatic(
									(int)$category_product['id_product'],
									false,
									null,
									2
								);
							}
						}
					}
				}

				// Get positions
				$middle_position = (int)round($nb_category_products / 2, 0);
				$product_position = $this->getCurrentProduct($category_products, (int)$id_product);

				// Flip middle product with current product
				if ($product_position)
				{
					$tmp = $category_products[$middle_position - 1];
					$category_products[$middle_position - 1] = $category_products[$product_position];
					$category_products[$product_position] = $tmp;
				}

				// If products tab higher than 30, slice it
				if ($nb_category_products > 30)
				{
					$category_products = array_slice($category_products, $middle_position - 15, 30, true);
					$middle_position = 15;
				}
			}

			// Display tpl
			$this->smarty->assign(
				array(
					'categoryProducts' => $category_products,
					'middlePosition' => (int)$middle_position,
					'ProdDisplayPrice' => Configuration::get('PRODUCTSCATEGORY_DISPLAY_PRICE')
				)
			);
		}

		return $this->display(__FILE__, 'productscategory.tpl', $this->getCacheId($cache_id));
	}

	
}
