<?php
class FrontController extends FrontControllerCore
{
    public function setMedia()
    {
        parent::setMedia();
        $this->addCSS(_THEME_CSS_DIR_.'menu/vertical-responsive-menu.css');
        $this->addCSS(_THEME_CSS_DIR_.'style.css');
        $this->addCSS(_THEME_CSS_DIR_.'style-upto-479.css');
        $this->addCSS(_THEME_CSS_DIR_.'style-upto-767.css');
        $this->addCSS(_THEME_CSS_DIR_.'style-768-991.css');
        $this->addCSS(_THEME_CSS_DIR_.'style-upto-991.css');
        $this->addCSS(_THEME_CSS_DIR_.'style-992-toUp.css');

        $this->addJS(_THEME_JS_DIR_.'form-validator/jquery.form-validator.min.js');
        $this->addCSS(_THEME_JS_DIR_.'form-validator/theme-default.css');  

        $this->addJS(_THEME_JS_DIR_.'global_custom.js');      

        $this->addjqueryPlugin('fancybox');
        $this->addJS(_THEME_JS_DIR_.'spin.js');

        $customer = new Customer((int)$this->context->customer->id); 
       
	    $this->context->smarty->assign(array(
	            'newsletter'       => $customer->newsletter,
	        ));

    }

    /**
     * Compiles and outputs page header section (including HTML <head>)
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
            'HOOK_TOP'          => Hook::exec('displayTop'),
            // 'HOOK_LEFT_COLUMN'  => ($this->display_column_left  ? Hook::exec('displayLeftColumn') : ''),
            // 'HOOK_RIGHT_COLUMN' => ($this->display_column_right ? Hook::exec('displayRightColumn', array('cart' => $this->context->cart)) : ''),
            'HOOK_FOOTER'       => Hook::exec('displayFooter')
        ));

        $this->context->smarty->assign(array(
            'css_files' => $this->css_files,
            'js_files'  => ($this->getLayout() && (bool)Configuration::get('PS_JS_DEFER')) ? array() : $this->js_files
        ));

        $this->display_header = $display;
        $this->smartyOutputContent(_PS_THEME_DIR_.'header-blog.tpl');
    }

    /**
     * Compiles and outputs page footer section
     */
    public function displayFooterBlog($display = true)
    {
        $this->smartyOutputContent(_PS_THEME_DIR_.'footer-blog.tpl');
    }
}
?>
