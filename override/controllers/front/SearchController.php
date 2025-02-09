<?php
class SearchController extends SearchControllerCore
{
  
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
            
            $groups = Size::getProductAttributeCombinations2($array_result['result'] , $this->context->language->id, $this->context->shop->id);
            $this->context->smarty->assign('groups', $groups);
  }
}
