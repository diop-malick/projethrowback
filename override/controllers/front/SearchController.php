<?php
class SearchController extends SearchControllerCore
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
        $query_no_stopwords = $string = Tools::getValue('search_query', Tools::getValue('ref'));
        // search  stopwords
        $blacklist = Tools::strtolower(Configuration::get('PS_SEARCH_BLACKLIST', $this->context->language->id));
        if (!empty($blacklist)) {
              $query_no_stopwords = preg_replace('/(?<=\s)('.$blacklist.')(?=\s)/Su', '', $query_no_stopwords);
              $query_no_stopwords = preg_replace('/^('.$blacklist.')(?=\s)/Su', '', $query_no_stopwords);
              $query_no_stopwords = preg_replace('/(?<=\s)('.$blacklist.')$/Su', '', $query_no_stopwords);
              $query_no_stopwords = preg_replace('/^('.$blacklist.')$/Su', '', $query_no_stopwords);
        }
        // search for aliases for each word of the query
        $words = explode(' ', $string);
        $processed_words = array();
        $alias_words = array();

        foreach ($words as $word) {
            $alias = new Alias(null, $word);
            if (Validate::isLoadedObject($alias)) {
                $processed_words[] = $alias->search;
                $alias_words [] = $alias->search;
            } else {
                $processed_words[] = $word;
            }
        }
        //
        $string = implode(' ', $alias_words);
        $string = preg_replace('/[._]+/', '', $string);
        $string = ltrim(preg_replace('/([^ ])-/', '$1 ', ' '.$string));
        $string = preg_replace('/[._]+/', '', $string);
        $string = preg_replace('/[^\s]-+/', '', $string);

        $this->context->smarty->assign(array(
            'alias' => $string,
            'search_query' => $query_no_stopwords,));

            /*  Add  Product's attribute    */
            $array_result = Search::find($this->context->language->id, $query_no_stopwords, 1, 10, 'position', 'desc');
            $combinations = $this->getProductAttributeCombinations2($array_result['result']);


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
