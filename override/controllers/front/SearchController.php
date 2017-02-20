<?php
class SearchController extends SearchControllerCore
{
  public function initContent()
  {
        parent::initContent();
        $query = Tools::getValue('search_query', Tools::getValue('ref'));
        $this->context->smarty->assign('alias', Search::sanitize($query, $this->context->language->id)); // Alias variable

  }
}
