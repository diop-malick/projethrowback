<?php
class ParentOrderController extends ParentOrderControllerCore
{
	/*
    public function getProductAttributeCombinations2($products) {
       $combinations = array();
       if ($products){
        foreach($products as $product){
               $product = new Product ($product['id_product'], $this->context->language->id);

               $combinations[$product->id] = $product->getAttributesGroups($this->context->language->id);
           }
       }
       return $combinations;
   }*/
     protected function _assignSummaryInformations()
    {
        parent::_assignSummaryInformations();  

        $summary = $this->context->cart->getSummaryDetails();

        $product = new Product ($summary['products'], $this->context->language->id);
       
        $attributes_groups = $product->getAttributesGroups($this->context->language->id);

      //var_dump($product);exit;
         $groups = array();

         if (is_array($attributes_groups) && $attributes_groups) {

		         foreach ($attributes_groups as $k => $row) {

		         	if (!isset($groups[$row['id_attribute_group']])) {
		                    $groups[$row['id_attribute_group']] = array(
		                        'group_name' => $row['group_name'],
		                        'name' => $row['public_group_name'],
		                        'group_type' => $row['group_type'],
		                        'default' => -1,
		                    );
		                }

		                $groups[$row['id_attribute_group']]['attributes'][$row['id_attribute']] = $row['attribute_name'];
		                if ($row['default_on'] && $groups[$row['id_attribute_group']]['default'] == -1) {
		                    $groups[$row['id_attribute_group']]['default'] = (int)$row['id_attribute'];
		                }
		                if (!isset($groups[$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']])) {
		                    $groups[$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']] = 0;
		                }
		                $groups[$row['id_attribute_group']]['attributes_quantity'][$row['id_attribute']] += (int)$row['quantity'];
		       
		            }

		            if (!Product::isAvailableWhenOutOfStock($product->out_of_stock) && Configuration::get('PS_DISP_UNAVAILABLE_ATTR') == 0) {
		                foreach ($groups as &$group) {
		                    foreach ($group['attributes_quantity'] as $key => &$quantity) {
		                        if ($quantity <= 0) {
		                            unset($group['attributes'][$key]);
		                        }
		                    }
		                }

		             
		            }

          }
          //
          //

          
         $this->context->smarty->assign('groups', $groups); 
    }
 }
?>