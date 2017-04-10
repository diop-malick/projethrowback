<?php

/*
* 04/02/2017
* Surcharge Module user info
* 
* Modify hook for display top
*/

if (!defined('_PS_VERSION_'))
	exit;

class BlocktopmenuOverride extends Blocktopmenu
{

    public function hookLeftColumn($params)
    {
         return $this->hookDisplayTop($params);
    }

     protected function generateCategoriesMenu($categories, $is_children = 0)
   {
       $html = '';

       foreach ($categories as $key => $category) {
           if ($category['level_depth'] > 2) return false;
           if ($category['level_depth'] > 1) {
               $cat = new Category($category['id_category']);
               $link = Tools::HtmlEntitiesUTF8($cat->getLink());
           } else {
               $link = $this->context->link->getPageLink('index');
           }

           /* Whenever a category is not active we shouldnt display it to customer */
           if ((bool)$category['active'] === false) {
               continue;
           }

           $html .= '<li'.(($this->page_name == 'category'
               && (int)Tools::getValue('id_category') == (int)$category['id_category']) ? ' class="sfHoverForce"' : '').'>';
           $html .= '<a href="'.$link.'" title="'.$category['name'].'">'.$category['name'].'</a>';

           if (isset($category['children']) && !empty($category['children'])) {
               $html .= '<ul>';
               $html .= $this->generateCategoriesMenu($category['children'], 1);

               if ((int)$category['level_depth'] > 1 && !$is_children) {
                   $files = scandir(_PS_CAT_IMG_DIR_);

                   if (count(preg_grep('/^'.$category['id_category'].'-([0-9])?_thumb.jpg/i', $files)) > 0) {
                       $html .= '<li class="category-thumbnail">';

                       foreach ($files as $file) {
                           if (preg_match('/^'.$category['id_category'].'-([0-9])?_thumb.jpg/i', $file) === 1) {
                               $html .= '<div><img src="'.$this->context->link->getMediaLink(_THEME_CAT_DIR_.$file)
                               .'" alt="'.Tools::SafeOutput($category['name']).'" title="'
                               .Tools::SafeOutput($category['name']).'" class="imgm" /></div>';
                           }
                       }

                       $html .= '</li>';
                   }
               }

               $html .= '</ul>';
           }

           $html .= '</li>';
       }

       return $html;
   }
}

