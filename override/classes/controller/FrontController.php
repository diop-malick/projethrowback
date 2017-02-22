<?php
class FrontController extends FrontControllerCore
{
    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'menu/vertical-responsive-menu.css');
        $this->addCSS(_THEME_CSS_DIR_.'style.css');
        $this->addJS(_THEME_JS_DIR_.'menu/define.js');
        if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'index')
            $this->addJS(_THEME_JS_DIR_.'menu/home.js');
        elseif (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'category')
            $this->addJS(_THEME_JS_DIR_.'menu/category.js');
        if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'product')
            $this->addJS(_THEME_JS_DIR_.'jquery.countdown-2.0.4/jquery.countdown.min.js');

        $this->addJS(_THEME_JS_DIR_.'form-validator/jquery.form-validator.js');
        $this->addCSS(_THEME_JS_DIR_.'form-validator/theme-default.css');
        $this->addJS(_THEME_JS_DIR_.'validator.js');

        $this->addjqueryPlugin('fancybox');

    }
}
?>