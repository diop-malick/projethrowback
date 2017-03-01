<?php
class FrontController extends FrontControllerCore
{
    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'menu/vertical-responsive-menu.css');
        $this->addCSS(_THEME_CSS_DIR_.'style.css');
        $this->addJS(_THEME_JS_DIR_.'menu/define.js');
        if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'index' || isset($this->context->controller->php_self) && $this->context->controller->php_self == 'search')
            $this->addJS(_THEME_JS_DIR_.'menu/home.js');
        elseif (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'category')
            $this->addJS(_THEME_JS_DIR_.'menu/category.js');
        if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'product') {
            $this->addJS(_THEME_JS_DIR_.'jquery.countdown-2.0.4/jquery.countdown.min.js');
        }


        $this->addJS(_THEME_JS_DIR_.'form-validator/jquery.form-validator.js');
        $this->addCSS(_THEME_JS_DIR_.'form-validator/theme-default.css');
        $this->addCSS(_THEME_CSS_DIR_.'validator.css');
        $this->addJS(_THEME_JS_DIR_.'validator.js');
        $this->addJS(_THEME_JS_DIR_.'bootbox.js');

        $this->addjqueryPlugin('fancybox');

    }

        /**
     * Compiles and outputs page header section (including HTML <head>)
     *
     * @param bool $display If true, renders visual page header section
     * @deprecated 1.5.0.1
     */
    public function displayHeaderBlog($display = true)
    {
        Tools::displayAsDeprecated();

        $this->initHeader();
        $hook_header = Hook::exec('displayHeader');
        if ((Configuration::get('PS_CSS_THEME_CACHE') || Configuration::get('PS_JS_THEME_CACHE')) && is_writable(_PS_THEME_DIR_.'cache')) {
            // CSS compressor management
            if (Configuration::get('PS_CSS_THEME_CACHE')) {
                $this->css_files = Media::cccCss($this->css_files);
            }

            //JS compressor management
            if (Configuration::get('PS_JS_THEME_CACHE')) {
                $this->js_files = Media::cccJs($this->js_files);
            }
        }

        // Call hook before assign of css_files and js_files in order to include correctly all css and javascript files
        $this->context->smarty->assign(array(
            'HOOK_HEADER'       => $hook_header,
            'HOOK_TOP'          => Hook::exec('displayTop')
        ));

        $this->context->smarty->assign(array(
            'css_files' => $this->css_files,
            'js_files'  => ($this->getLayout() && (bool)Configuration::get('PS_JS_DEFER')) ? array() : $this->js_files
        ));

        $this->display_header = $display;
        $this->smartyOutputContent(_PS_THEME_DIR_.'header-blog.tpl');
    }
}
?>
