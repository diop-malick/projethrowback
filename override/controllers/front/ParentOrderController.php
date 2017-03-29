<?php
class ParentOrderController extends ParentOrderControllerCore
{
	/*
    public function getProductAttributeCombinations2($products) {
       $combinations = array();
       if ($products){
        foreach($products as $product){
               $product = new Product ($product['id_product'], $this->context->language->id);

               $combinations[$product->id] = $product->getAttributeCombinations($this->context->language->id);
           }
       }
       return $combinations;
   }*/
     protected function _assignSummaryInformations()
    {
        parent::_assignSummaryInformations();  

        $summary = $this->context->cart->getSummaryDetails();
    
		$combinations = array();
        $groups = array();
        $prod['id_product']=0;
        foreach ($summary['products'] as  $prod) {
        	//var_dump($prod['id_product']);
        	$product = new Product($prod['id_product'], true, $this->context->language->id, $this->context->shop->id);
        	$attributes_groups = $product->getAttributesGroups($this->context->language->id);

        	//$combinations[$prod['id_product']] = $product->getAttributeCombinations($this->context->language->id);

        	$attributes_combinations[$prod['id_product']] = $product->getAttributesInformationsByProduct($prod['id_product']);
        	
	        if (is_array($attributes_combinations[$prod['id_product']]) && count($attributes_combinations[$prod['id_product']])) {
	            foreach ($attributes_combinations[$prod['id_product']] as &$ac) {
	                foreach ($ac as &$val) {
	                    $val = str_replace(Configuration::get('PS_ATTRIBUTE_ANCHOR_SEPARATOR'), '_', Tools::link_rewrite(str_replace(array(',', '.'), '-', $val)));
	                }
	            }
	        } else {
	            $attributes_combinations[$prod['id_product']] = array();
	        }

        	if (is_array($attributes_groups) && $attributes_groups) {

		         foreach ($attributes_groups as $k => $row) {

		         		// Color management
		                if (isset($row['is_color_group']) && $row['is_color_group'] && (isset($row['attribute_color']) && $row['attribute_color']) || (file_exists(_PS_COL_IMG_DIR_.$row['id_attribute'].'.jpg'))) {
		                    $colors[$row['id_attribute']]['value'] = $row['attribute_color'];
		                    $colors[$row['id_attribute']]['name'] = $row['attribute_name'];
		                    if (!isset($colors[$row['id_attribute']]['attributes_quantity'])) {
		                        $colors[$row['id_attribute']]['attributes_quantity'] = 0;
		                    }
		                    $colors[$row['id_attribute']]['attributes_quantity'] += (int)$row['quantity'];
		                }

			         	if (!isset($groups[$prod['id_product']][$row['id_attribute_group']])) {
			                    $groups[$prod['id_product']][$row['id_attribute_group']] = array(
			                        'group_name' => $row['group_name'],
			                        'name' => $row['public_group_name'],
			                        'group_type' => $row['group_type'],
			                        'default' => -1,
			                    );
			            }

			            $groups[$prod['id_product']][$row['id_attribute_group']]['attributes'][$row['id_attribute']] = $row['attribute_name'];
			            if ($row['default_on'] && $groups[$prod['id_product']][$row['id_attribute_group']]['default'] == -1) {
			                    $groups[$prod['id_product']][$row['id_attribute_group']]['default'] = (int)$row['id_attribute'];
			            }
			            if (!isset($groups[$prod['id_product']][$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']])) {
			                    $groups[$prod['id_product']][$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']] = 0;
			            }
			                $groups[$prod['id_product']][$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']] += (int)$row['quantity'];


			                $combinations[$prod['id_product']][$row['id_product_attribute']]['attributes_values'][$row['id_attribute_group']] = $row['attribute_name'];
                			$combinations[$prod['id_product']][$row['id_product_attribute']]['attributes'][] = (int)$row['id_attribute'];
                

		       
		            } //end foreach attributes

		            if (!Product::isAvailableWhenOutOfStock($product->out_of_stock) && Configuration::get('PS_DISP_UNAVAILABLE_ATTR') == 0) {
		                foreach ($groups[$prod['id_product']] as &$group) {
		                    foreach ($group['attributes_quantity'] as $key => &$quantity) {
		                        if ($quantity <= 0) {
		                            unset($group['attributes'][$key]);
		                        }
		                    }
		                }
		             
		            }
		           
		          foreach ($combinations[$prod['id_product']] as $id_product_attribute => $comb) {
	                $attribute_list = '';
	                foreach ($comb['attributes'] as $id_attribute) {
	                    $attribute_list .= '\''.(int)$id_attribute.'\',';
	                }
	                $attribute_list = rtrim($attribute_list, ',');
	                $combinations[$prod['id_product']][$id_product_attribute]['list'] = $attribute_list;
	            }   
	            
            }

        } //end foreach products

         $this->context->smarty->assign('groups', $groups); 
         $this->context->smarty->assign('combinations', $combinations);
    }

    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'modal_dialog.css');
        $this->addJS(_THEME_JS_DIR_.'cart-update.js');
        $this->addJS(_THEME_JS_DIR_.'bootbox.js');
    }
 }
?>