<?php
class ProductController extends ProductControllerCore
{
    public function setMedia()
    {

      parent::setMedia();
    
         $this->addJS(array(
                _THEME_JS_DIR_.'jquery.kyco.easyshare.min.js'
            ));

    }

  }
?>