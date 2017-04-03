<?php
defined('_PS_VERSION_') OR die('No Direct Script Access Allowed');
/**
 * Description of ajax
 *
 * @author Mohammad Arifur Rahman 
 * @todo Description
 * @link http://smartdatasoft.net description
 * @version v1.1
 * @copyright (c) 2013, Smart Datasoft
 * @license http://URL name 
 */

 
include_once(_PS_MODULE_DIR_.'revsliderprestashop/revprestashoploader.php');
include_once(_PS_MODULE_DIR_.'revsliderprestashop/revslider_admin.php');

class Revolutionslider_ajaxController extends ModuleAdminController 
{
    /**
     *
     * @var array
     */
    protected $_ajax_results;
    /**
     *
     * @var type 
     */
    protected $_ajax_stripslash;
    /**
     *
     * @var type 
     */
    protected $_filter_whitespace;
    /**
     *
     * @var Lushslider_model
     */
    protected $lushslider_model;
    /**
     * {@inheritdoc}
     */
    public function __construct() 
    {        
        $this->display_header = false;
        $this->display_footer = false;
        $this->content_only   = true;
        //$this->bindToAjaxRequest();        
        parent::__construct();
        $this->_ajax_results['error_on'] = 1; 
        // Let's include Lushslider Model
        
    }
    public function init()
    {        

        // Process POST | GET
        $this->initProcess();
    }
    /**
     * 
     * @throws Exception
     */
    public function initProcess()
    {

      
        $productAdmin = new RevSliderAdmin(_PS_MODULE_DIR_.'revsliderprestashop');

    }
    
    /**
     * 
     * @param boolean $post_method
     * @return boolean
     */
    protected function bindToAjaxRequest($post_method = false)
    {
        if(!$this->isXmlHttpRequest())
            die ('We Only Accept Ajax Request');
        // Also Restricted to POST method
        if($post_method)
        {
            if(!isset ($_SERVER['REQUEST_METHOD']) OR 'POST' != $_SERVER['REQUEST_METHOD'])
                die ('Only POST Request Method is allowed');
        }                        
        return TRUE;                 
    } /* Ends bindToAjaxRequest() */
    
}

