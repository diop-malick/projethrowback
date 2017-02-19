<?php


// overrides 

// add maximum quantity per order per client

class Cart extends CartCore {

    /**
     * Update product quantity
     *
     * @param int $quantity Quantity to add (or substract)
     * @param int $id_product Product ID
     * @param int $id_product_attribute Attribute ID if needed
     * @param string $operator Indicate if quantity must be increased or decreased
     */
    public function updateQty($quantity, $id_product, $id_product_attribute = null, $id_customization = false,
        $operator = 'up', $id_address_delivery = 0, Shop $shop = null, $auto_add_cart_rule = true)
    {
        if (!$shop) {
            $shop = Context::getContext()->shop;
        }

        if (Context::getContext()->customer->id) {
            if ($id_address_delivery == 0 && (int)$this->id_address_delivery) { // The $id_address_delivery is null, use the cart delivery address
                $id_address_delivery = $this->id_address_delivery;
            } elseif ($id_address_delivery == 0) { // The $id_address_delivery is null, get the default customer address
                $id_address_delivery = (int)Address::getFirstCustomerAddressId((int)Context::getContext()->customer->id);
            } elseif (!Customer::customerHasAddress(Context::getContext()->customer->id, $id_address_delivery)) { // The $id_address_delivery must be linked with customer
                $id_address_delivery = 0;
            }
        }

        $quantity = (int)$quantity;
        $id_product = (int)$id_product;
        $id_product_attribute = (int)$id_product_attribute;
        $product = new Product($id_product, false, Configuration::get('PS_LANG_DEFAULT'), $shop->id);

        /* throwback - custom code */
        $front_features_static = Product::getFrontFeaturesStatic(Context::getContext()->language->id, $id_product);
        $maximal_product = 10000;
        foreach ($front_features_static as $value){
            if ($value['id_feature'] == 11) {
                // si la quantité commandable est définis, on définis la varaible quantié maximale 
                $maximal_product = $value['value'];
            }
        }

        if ($id_product_attribute) {
            $combination = new Combination((int)$id_product_attribute);
            if ($combination->id_product != $id_product) {
                return false;
            }
        }

        /* If we have a product combination, the minimal quantity is set with the one of this combination */
        if (!empty($id_product_attribute)) {
            $minimal_quantity = (int)Attribute::getAttributeMinimalQty($id_product_attribute);
        } else {
            $minimal_quantity = (int)$product->minimal_quantity;
        }

        if (!Validate::isLoadedObject($product)) {
            die(Tools::displayError());
        }

        if (isset(self::$_nbProducts[$this->id])) {
            unset(self::$_nbProducts[$this->id]);
        }

        if (isset(self::$_totalWeight[$this->id])) {
            unset(self::$_totalWeight[$this->id]);
        }

        Hook::exec('actionBeforeCartUpdateQty', array(
            'cart' => $this,
            'product' => $product,
            'id_product_attribute' => $id_product_attribute,
            'id_customization' => $id_customization,
            'quantity' => $quantity,
            'operator' => $operator,
            'id_address_delivery' => $id_address_delivery,
            'shop' => $shop,
            'auto_add_cart_rule' => $auto_add_cart_rule,
        ));

        if ((int)$quantity <= 0) {
            return $this->deleteProduct($id_product, $id_product_attribute, (int)$id_customization, 0, $auto_add_cart_rule);
        } elseif (!$product->available_for_order || (Configuration::get('PS_CATALOG_MODE') && !defined('_PS_ADMIN_DIR_'))) {
            return false;

        }
        /* Throwback - Override Code */
        //1 produit max par declinaison autorisé
        // For example, 1 max per same product/product-combination allowed
        elseif ($quantity > $maximal_product) { 
            return false;
        } 
        else {
            /* Check if the product is already in the cart */
            $result = $this->containsProduct($id_product, $id_product_attribute, (int)$id_customization, (int)$id_address_delivery);

            /* Update quantity if product already exist */
            if ($result) {
                if ($operator == 'up') {
                    $sql = 'SELECT stock.out_of_stock, IFNULL(stock.quantity, 0) as quantity
							FROM '._DB_PREFIX_.'product p
							'.Product::sqlStock('p', $id_product_attribute, true, $shop).'
							WHERE p.id_product = '.$id_product;

                    $result2 = Db::getInstance()->getRow($sql);
                    $product_qty = (int)$result2['quantity'];
                    // Quantity for product pack
                    if (Pack::isPack($id_product)) {
                        $product_qty = Pack::getQuantity($id_product, $id_product_attribute);
                    }
                    $new_qty = (int)$result['quantity'] + (int)$quantity;
                    /* Throwback - Override Code */
                    // max per same product/product-combination allowed
                    if ($new_qty > $maximal_product) { 
                        return false;
                    }
                    $qty = '+ '.(int)$quantity;

                    if (!Product::isAvailableWhenOutOfStock((int)$result2['out_of_stock'])) {
                        if ($new_qty > $product_qty) {
                            return false;
                        }
                    }
                } elseif ($operator == 'down') {
                    $qty = '- '.(int)$quantity;
                    $new_qty = (int)$result['quantity'] - (int)$quantity;
                    if ($new_qty < $minimal_quantity && $minimal_quantity > 1) {
                        return -1;
                    }
                } else {
                    return false;
                }

                /* Delete product from cart */
                if ($new_qty <= 0) {
                    return $this->deleteProduct((int)$id_product, (int)$id_product_attribute, (int)$id_customization, 0, $auto_add_cart_rule);
                } elseif ($new_qty < $minimal_quantity) {
                    return -1;
                } else {
                    Db::getInstance()->execute('
						UPDATE `'._DB_PREFIX_.'cart_product`
						SET `quantity` = `quantity` '.$qty.', `date_add` = NOW()
						WHERE `id_product` = '.(int)$id_product.
                        (!empty($id_product_attribute) ? ' AND `id_product_attribute` = '.(int)$id_product_attribute : '').'
						AND `id_cart` = '.(int)$this->id.(Configuration::get('PS_ALLOW_MULTISHIPPING') && $this->isMultiAddressDelivery() ? ' AND `id_address_delivery` = '.(int)$id_address_delivery : '').'
						LIMIT 1'
                    );
                }
            }
            /* Add product to the cart */
            elseif ($operator == 'up') {
                $sql = 'SELECT stock.out_of_stock, IFNULL(stock.quantity, 0) as quantity
						FROM '._DB_PREFIX_.'product p
						'.Product::sqlStock('p', $id_product_attribute, true, $shop).'
						WHERE p.id_product = '.$id_product;

                $result2 = Db::getInstance()->getRow($sql);

                // Quantity for product pack
                if (Pack::isPack($id_product)) {
                    $result2['quantity'] = Pack::getQuantity($id_product, $id_product_attribute);
                }

                if (!Product::isAvailableWhenOutOfStock((int)$result2['out_of_stock'])) {
                    if ((int)$quantity > $result2['quantity']) {
                        return false;
                    }
                }

                if ((int)$quantity < $minimal_quantity) {
                    return -1;
                }

                $result_add = Db::getInstance()->insert('cart_product', array(
                    'id_product' =>            (int)$id_product,
                    'id_product_attribute' =>    (int)$id_product_attribute,
                    'id_cart' =>                (int)$this->id,
                    'id_address_delivery' =>    (int)$id_address_delivery,
                    'id_shop' =>                $shop->id,
                    'quantity' =>                (int)$quantity,
                    'date_add' =>                date('Y-m-d H:i:s')
                ));

                if (!$result_add) {
                    return false;
                }
            }
        }

        // refresh cache of self::_products
        $this->_products = $this->getProducts(true);
        $this->update();
        $context = Context::getContext()->cloneContext();
        $context->cart = $this;
        Cache::clean('getContextualValue_*');
        if ($auto_add_cart_rule) {
            CartRule::autoAddToCart($context);
        }

        if ($product->customizable) {
            return $this->_updateCustomizationQuantity((int)$quantity, (int)$id_customization, (int)$id_product, (int)$id_product_attribute, (int)$id_address_delivery, $operator);
        } else {
            return true;
        }
    }

}