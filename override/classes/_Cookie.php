<?php


// overrides 
// change limit sessions size
// http://www.t-prod.net/blog/e-commerce-site-marchand/changer-la-duree-de-la-session-cookie-du-panier-sur-prestashop

class Cookie extends CookieCore {

    /**
     * Get data if the cookie exists and else initialize an new one
     *
     * @param $name string Cookie name before encrypting
     * @param $path string
     */
    public function __construct($name, $path = '', $expire = null, $shared_urls = null, $standalone = false, $secure = false)
    {
        $this->_content = array();
        $this->_standalone = $standalone;
        // defautl : 1728000 - soit environ 20 jours
        // limit to 30 min
        //24h x 60 minutes x 60 secondes = 86400  = 1 jour
        //30 minutes x 60 secondes = 1800  = 1 jour
        $this->_expire = is_null($expire) ? time() + 1800 : (int)$expire;
        $this->_path = trim(($this->_standalone ? '' : Context::getContext()->shop->physical_uri).$path, '/\\').'/';
        if ($this->_path{0} != '/') {
            $this->_path = '/'.$this->_path;
        }
        $this->_path = rawurlencode($this->_path);
        $this->_path = str_replace('%2F', '/', $this->_path);
        $this->_path = str_replace('%7E', '~', $this->_path);
        $this->_domain = $this->getDomain($shared_urls);
        $this->_name = 'PrestaShop-'.md5(($this->_standalone ? '' : _PS_VERSION_).$name.$this->_domain);
        $this->_allow_writing = true;
        $this->_salt = $this->_standalone ? str_pad('', 8, md5('ps'.__FILE__)) : _COOKIE_IV_;
        if ($this->_standalone) {
            $this->_cipherTool = new Blowfish(str_pad('', 56, md5('ps'.__FILE__)), str_pad('', 56, md5('iv'.__FILE__)));
        } elseif (!Configuration::get('PS_CIPHER_ALGORITHM') || !defined('_RIJNDAEL_KEY_')) {
            $this->_cipherTool = new Blowfish(_COOKIE_KEY_, _COOKIE_IV_);
        } else {
            $this->_cipherTool = new Rijndael(_RIJNDAEL_KEY_, _RIJNDAEL_IV_);
        }
        $this->_secure = (bool)$secure;

        $this->update();
    }

}
