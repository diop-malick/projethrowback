<?php
/*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_'))
	exit;

class PrestaCookie extends Module
{
	/* @var boolean error */
	protected $error = false;

	public function __construct()
	{
		$this->name = 'prestacookie';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'ModulesDen - Lapusanu Patriciu';
		$this->need_instance = 0;

		$this->bootstrap = true;
		parent::__construct();

		$this->displayName = $this->l('ModulesDen PrestaCookie (EU Cookie Law - Notification Banner)');
		$this->description = $this->l('Adds a notification banner warning the user about the site cookies.');
		$this->confirmUninstall = $this->l('Are you sure you want to delete all your links?');
		$this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
	}

	public function install()
	{
		if (!parent::install() || !$this->registerHook('header') || !$this->registerHook('footer'))
			return false;

		$success = Configuration::updateValue('cookie_bar_text', array('1' => 'Cookies help us deliver our services. By using our services, you agree to use our cookies.'));
		$success &= Configuration::updateValue('cookie_bar_link_text', array('1' => 'Learn More'));
		$success &= Configuration::updateValue('cookie_bar_link_url', array('1' => 'http://www.modulesden.com'));
		$success &= Configuration::updateValue('cookie_bar_button_color', '#1ea7ee');
		$success &= Configuration::updateValue('cookie_bar_bg_color', '#ffffff');
		$success &= Configuration::updateValue('cookie_pos', 0);
		$success &= Configuration::updateValue('cookie_bar_borderradius', 0);
		
		if (!$success)
		{
			parent::uninstall();

			return false;
		}
		
		return true;
	}

	public function uninstall()
	{
		if (!parent::uninstall() ||
			!Configuration::deleteByName('cookie_bar_text') ||
			!Configuration::deleteByName('cookie_bar_button_color') ||
			!Configuration::deleteByName('cookie_bar_bg_color') ||
			!Configuration::deleteByName('cookie_bar_link_url') ||
			!Configuration::deleteByName('cookie_pos') ||
			!Configuration::deleteByName('cookie_bar_borderradius') ||
			!Configuration::deleteByName('cookie_bar_link_text')
			
		)
			return false;

		return true;
	}

	public function hookFooter($params)
	{
		$this->smarty->assign(array(
			'cookie_bar_text' => Configuration::get('cookie_bar_text', $this->context->language->id),
			'cookie_bar_link_text' => Configuration::get('cookie_bar_link_text', $this->context->language->id),
			'cookie_bar_link_url' => Configuration::get('cookie_bar_link_url', $this->context->language->id),
			'cookie_bar_bg_color' => Configuration::get('cookie_bar_bg_color'),
			'cookie_bar_button_color' => Configuration::get('cookie_bar_button_color'),
			'cookie_pos' => Configuration::get('cookie_pos'),
			'cookie_bar_borderradius' => Configuration::get('cookie_bar_borderradius'),
		));

		return $this->display(__FILE__, 'prestacookie.tpl');
	}

	public function hookHeader($params)
	{
		$this->context->controller->addCSS($this->_path.'prestacookie.css', 'all');
	}

	public function getContent()
	{
		$this->_html = '';

		// Add a link
		if (Tools::isSubmit('submitLinkAdd') /* || Tools::isSubmit('updateprestacookie')*/)
		{
				if ($this->updateCookieBar())
					$this->_html .= $this->displayConfirmation($this->l('The Cookie Bar has been added.'));
				else
					$this->_html .= $this->displayError($this->l('An error occurred during Cookie Bar creation.'));
		}

		$this->_html .= $this->renderForm();

		return $this->_html;
	}

	public function renderForm()
	{
		$fields_form_1 = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('ModulesDen Cookie Bar Settings'),
					'icon' => 'icon-plus-sign-alt'
				),
				'input' => array(
					array(
						'type' => 'color',
						'label' => $this->l('Cookie Bar Color'),
						'name' => 'cookie_bar_bg_color'						
					),
					array(
						'type' => 'color',
						'label' => $this->l('Button Color'),
						'name' => 'cookie_bar_button_color'						
					),
					array(
						'type' => 'text',
						'label' => $this->l('Cookie Bar Text'),
						'name' => 'cookie_bar_text',
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Link text'),
						'name' => 'cookie_bar_link_text',
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Link URL'),
						'name' => 'cookie_bar_link_url',
						'lang' => true,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Cookie Bar Button Rounded Corners'),
						'name' => 'cookie_bar_borderradius',
						'suffix' => 'pixels',
						'desc' => $this->l('Set it to "0" to make the button corners normal(the button will be squared)')
					),
					array(
					  'type'      => 'radio',
					  'label'     => $this->l('Choose where to show your CookieBar'),
					  'desc'      => $this->l('On top of your website or on the bottom'),
					  'name'      => 'cookie_pos',
					  'required'  => true,
					  'is_bool'   => true,
					  'values'    => array(
						array(
						  'id'    => 'pos_top',
						  'value' => 1,
						  'label' => $this->l('Top')
						),
						array(
						  'id'    => 'pos_bot',
						  'value' => 0,
						  'label' => $this->l('Bottom')
						)
					  ),
					),

				),
				'submit' => array(
					'title' => $this->l('Save'),
					'name' => 'submitLinkAdd',
				)
			),
		);

		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$this->fields_form = array();

		$helper->identifier = 'id_prestacookie';
		$helper->submit_action = 'submit';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');

		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form_1));
	}

	public function getConfigFieldsValues()
	{
		$fields_values = array(
			//'url' => Tools::getValue('url'),
			'cookie_bar_button_color' => Configuration::get('cookie_bar_button_color'),
			'cookie_bar_bg_color' => Configuration::get('cookie_bar_bg_color'),
			'cookie_pos' => Configuration::get('cookie_pos'),
			'cookie_bar_borderradius' => Configuration::get('cookie_bar_borderradius'),
		);

		$languages = Language::getLanguages(false);

		foreach ($languages as $lang)
		{
			//$fields_values['text'][$lang['id_lang']] = Tools::getValue('text_'.(int)$lang['id_lang']);
			$fields_values['cookie_bar_text'][$lang['id_lang']] = Tools::getValue('cookie_bar_text', Configuration::get('cookie_bar_text', $lang['id_lang']));
			$fields_values['cookie_bar_link_text'][$lang['id_lang']] = Tools::getValue('cookie_bar_link_text', Configuration::get('cookie_bar_link_text', $lang['id_lang']));
			$fields_values['cookie_bar_link_url'][$lang['id_lang']] = Tools::getValue('cookie_bar_link_url', Configuration::get('cookie_bar_link_url', $lang['id_lang']));
		}

		return $fields_values;
	}
	
	public function updateCookieBar()
	{
		$languages = Language::getLanguages();
		//Update cookie Bar Text
		$result_cookie = array();
		foreach ($languages as $language)
			$result_cookie[$language['id_lang']] = Tools::getValue('cookie_bar_text_'.$language['id_lang']);
		if (!Configuration::updateValue('cookie_bar_text', $result_cookie))
			return false;
		
		//Update cookie Link Text
		$result_link_text = array();
		foreach ($languages as $language)
			$result_link_text[$language['id_lang']] = Tools::getValue('cookie_bar_link_text_'.$language['id_lang']);
		if (!Configuration::updateValue('cookie_bar_link_text', $result_link_text))
			return false;
		
		//Update cookie Link URl
		$result_url = array();
		foreach ($languages as $language)
			$result_url[$language['id_lang']] = Tools::getValue('cookie_bar_link_url_'.$language['id_lang']);
		if (!Configuration::updateValue('cookie_bar_link_url', $result_url))
			return false;
		
		//Update colors
		if (!Configuration::updateValue('cookie_bar_button_color', Tools::getValue('cookie_bar_button_color')))
			return false;
		
		if (!Configuration::updateValue('cookie_bar_bg_color', Tools::getValue('cookie_bar_bg_color')))
			return false;
		
		//Update Cookie Position	
		if (!Configuration::updateValue('cookie_pos', Tools::getValue('cookie_pos')))
			return false;	
			
		//Update Cookie Button Rounded corners	
		if (!Configuration::updateValue('cookie_bar_borderradius', Tools::getValue('cookie_bar_borderradius')))
			return false;	

		return true;
	}
}
