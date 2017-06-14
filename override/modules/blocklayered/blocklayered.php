<?php

if (!defined('_CAN_LOAD_FILES_'))
    exit;

class BlockLayeredOverride extends BlockLayered
{

  public function install()
{
    if(parent::install() && $this->registerHook('categoryTop'))
        return true;
    else return false;
}

public function hookCategoryTop($params)
{
    return $this->hookLeftColumn($params);
}

  public function ajaxCall()
  {
    global $smarty, $cookie;

    $selected_filters = $this->getSelectedFilters();
    $filter_block = $this->getFilterBlock($selected_filters);
    $this->getProducts($selected_filters, $products, $nb_products, $p, $n, $pages_nb, $start, $stop, $range);

    // Add pagination variable
    $nArray = (int)Configuration::get('PS_PRODUCTS_PER_PAGE') != 10 ? array((int)Configuration::get('PS_PRODUCTS_PER_PAGE'), 10, 20, 50) : array(10, 20, 50);
    // Clean duplicate values
    $nArray = array_unique($nArray);
    asort($nArray);

    Hook::exec(
      'actionProductListModifier',
      array(
        'nb_products' => &$nb_products,
        'cat_products' => &$products,
      )
    );

    if (version_compare(_PS_VERSION_, '1.6.0', '>=') === true)
      $this->context->controller->addColorsToProductList($products);

    $category = new Category(Tools::getValue('id_category_layered', Configuration::get('PS_HOME_CATEGORY')), (int)$cookie->id_lang);

    // Generate meta title and meta description
    $category_title = (empty($category->meta_title) ? $category->name : $category->meta_title);
    $category_metas = Meta::getMetaTags((int)$cookie->id_lang, 'category');
    $title = '';
    $keywords = '';

    if (is_array($filter_block['title_values']))
      foreach ($filter_block['title_values'] as $key => $val)
      {
        $title .= ' > '.$key.' '.implode('/', $val);
        $keywords .= $key.' '.implode('/', $val).', ';
      }

    $title = $category_title.$title;

    if (!empty($title))
      $meta_title = $title;
    else
      $meta_title = $category_metas['meta_title'];

    $meta_description = $category_metas['meta_description'];

    $keywords = Tools::substr(Tools::strtolower($keywords), 0, 1000);
    if (!empty($keywords))
      $meta_keywords = rtrim($category_title.', '.$keywords.', '.$category_metas['meta_keywords'], ', ');

    $smarty->assign(
      array(
        'homeSize' => Image::getSize(ImageType::getFormatedName('home')),
        'nb_products' => $nb_products,
        'category' => $category,
        'pages_nb' => (int)$pages_nb,
        'p' => (int)$p,
        'n' => (int)$n,
        'range' => (int)$range,
        'start' => (int)$start,
        'stop' => (int)$stop,
        'n_array' => ((int)Configuration::get('PS_PRODUCTS_PER_PAGE') != 10) ? array((int)Configuration::get('PS_PRODUCTS_PER_PAGE'), 10, 20, 50) : array(10, 20, 50),
        'comparator_max_item' => (int)(Configuration::get('PS_COMPARATOR_MAX_ITEM')),
        'products' => $products,
        'products_per_page' => (int)Configuration::get('PS_PRODUCTS_PER_PAGE'),
        'static_token' => Tools::getToken(false),
        'page_name' => 'category',
        'nArray' => $nArray,
        'compareProducts' => CompareProduct::getCompareProducts((int)$this->context->cookie->id_compare)
      )
    );

    // Prevent bug with old template where category.tpl contain the title of the category and category-count.tpl do not exists
    if (file_exists(_PS_THEME_DIR_.'category-count.tpl'))
      $category_count = $smarty->fetch(_PS_THEME_DIR_.'category-count.tpl');
    else
      $category_count = '';

    if ($nb_products == 0)
      $product_list = $this->display(__FILE__, 'blocklayered-no-products.tpl');
    else
      $product_list = $smarty->fetch(_PS_THEME_DIR_.'product-list.tpl');

    $vars = array(
      'filtersBlock' => utf8_encode($this->generateFiltersBlock($selected_filters)),
      'productList' => utf8_encode($product_list),
      'pagination' => $smarty->fetch(_PS_THEME_DIR_.'pagination.tpl'),
      'categoryCount' => $category_count,
      'meta_title' => $meta_title.' - '.Configuration::get('PS_SHOP_NAME'),
      'heading' => $meta_title,
      'meta_keywords' => isset($meta_keywords) ? $meta_keywords : null,
      'meta_description' => $meta_description,
      'current_friendly_url' => ((int)$n == (int)$nb_products) ? '#/show-all': '#'.$filter_block['current_friendly_url'],
      'filters' => $filter_block['filters'],
      'nbRenderedProducts' => (int)$nb_products,
      'nbAskedProducts' => (int)$n
    );

    if (version_compare(_PS_VERSION_, '1.6.0', '>=') === true)
      $vars = array_merge($vars, array('pagination_bottom' => $smarty->assign('paginationId', 'bottom')
        ->fetch(_PS_THEME_DIR_.'pagination.tpl')));
    /* We are sending an array in jSon to the .js controller, it will update both the filters and the products zones */
    return Tools::jsonEncode($vars);
  }



}

?>
