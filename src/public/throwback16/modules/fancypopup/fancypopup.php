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

class fancypopup extends Module
{
	public function __construct()
	{
		$this->name = 'fancypopup';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'Papa Babacar Ba';
		$this->need_instance = 0;
		$this->bootstrap = true;

		parent::__construct();

		$this->displayName = $this->l('Fancypopup by SNEcommerce');
		$this->description = $this->l('Improve your site visuals with an amazing fancypopup newsletter Box');
		$path = dirname(__FILE__);
		if (strpos(__FILE__, 'Module.php') !== false)
			$path .= '/../modules/'.$this->name;
		include_once $path.'/fancypopupClass.php';
	}

	public function install()
	{
		if (!parent::install() || !$this->registerHook('displayTopColumn') || !$this->registerHook('displayHome') || !$this->registerHook('displayHeader'))
			return false;

		$res = Db::getInstance()->execute(
			'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'fancypopup` (
			`id_fancypopup` int(10) unsigned NOT NULL auto_increment,
			`id_shop` int(10) unsigned NOT NULL ,
			PRIMARY KEY (`id_fancypopup`))
			ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8'
		);

		if ($res)
			$res &= Db::getInstance()->execute(
				'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'fancypopup_lang` (
				`id_fancypopup` int(10) unsigned NOT NULL,
				`id_lang` int(10) unsigned NOT NULL,
				`fancypopup_paragraph` text NOT NULL,
				PRIMARY KEY (`id_fancypopup`, `id_lang`))
				ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8'
			);	
		Configuration::updateValue('fancypopup_BOX_WIDTH', (int)640);
		Configuration::updateValue('fancypopup_BOX_HEIGHT', (int)420);
		Configuration::updateValue('fancypopup_SHOW_TIME', (int)10);
		Configuration::updateValue('fancypopup_BTN_COLOR', "#000");
		Configuration::updateValue('fancypopup_IMAGE_COVER', 'fancypopup_img_1.jpg');	
		Configuration::updateValue('fancypopup_ONLY_HOME', 0);
			
		if ($res)
			foreach (Shop::getShops(false) as $shop)
				$res &= $this->createExamplefancypopup($shop['id_shop']);

		if (!$res)
			$res &= $this->uninstall();

		return (bool)$res;
	}

	private function createExamplefancypopup($id_shop)
	{
		$fancypopup = new fancypopupClass();
		$fancypopup->id_shop = (int)$id_shop;
		foreach (Language::getLanguages(false) as $lang)
		{
			$fancypopup->fancypopup_paragraph[$lang['id_lang']] = '<div id="fancypopup_popup" style="">
				<div class="fancypopup-newsletter">
					<form action="{$base_dir}" method="POST">
						<img class="fancypopup-img" alt="newsletter" src="modules/fancypopup/img/'.Configuration::get('fancypopup_IMAGE_COVER').'" />	
						<div class="fancypopup-content">							
							<h1>Bienvenue sur Throwback Sneakers</h1>
							<label for="newsletter">Inscrivez-vous à notre newsletter et recevez en exclusivité toutes nos actualités, nos dernières offres et promotions. Ne ratez plus nos réassorts et l\'arrivée de nouveautés!.</label>
							<input type="text" name="email" title="Je m\'inscris" class="fancypopup-email" placeholder="Saisissez votre email...">
							<span class="fancypopup-msg" />
							<button class="fancypopup-btn-newsletter" name="submitNewsletter" type="submit" title="Je m\'inscris">
								<span><span>Je m\'inscris </span> </span>
							</button>
							<input type="hidden" name="action" value="0">
						</div>
					</form>
				</div>
			</div>';
		}

		return $fancypopup->add();
	}

	public function uninstall()
	{
		$res = Db::getInstance()->execute('DROP TABLE IF EXISTS `'._DB_PREFIX_.'fancypopup`');
		$res &= Db::getInstance()->execute('DROP TABLE IF EXISTS `'._DB_PREFIX_.'fancypopup_lang`');

		if ($res == 0 || !parent::uninstall())
			return false;

		return true;
	}

	private function initForm()
	{
		$languages = Language::getLanguages(false);
		foreach ($languages as $k => $language)
			$languages[$k]['is_default'] = (int)$language['id_lang'] == Configuration::get('PS_LANG_DEFAULT');

		$helper = new HelperForm();
		$helper->module = $this;
		$helper->name_controller = 'fancypopup';
		$helper->identifier = $this->identifier;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->languages = $languages;
		$helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;
		$helper->default_form_language = (int)Configuration::get('PS_LANG_DEFAULT');
		$helper->allow_employee_form_lang = true;
		$helper->toolbar_scroll = true;
		$helper->toolbar_btn = $this->initToolbar();
		$helper->title = $this->displayName;
		$helper->submit_action = 'submitUpdatefancypopup';

		$file = dirname(__FILE__).'/img/fancypopup_img_'.(int)$this->context->shop->id.'.jpg';
		$logo = (file_exists($file) ? '<img src="'.$this->_path.'img/fancypopup_img_'.(int)$this->context->shop->id.'.jpg">' : '');

		$this->fields_form[0]['form'] = array(
			'tinymce' => true,
			'legend' => array(
				'title' => $this->displayName,
				'image' => $this->_path.'logo.png'
			),
			'submit' => array(
				'name' => 'submitUpdatefancypopup',
				'title' => $this->l('Enregistrer'),
				'class' => 'button pull-right'
			),
			'input' => array(
				array(
				  'type'      => 'switch',                              
				  'label'     => $this->l('Afficher uniquement sur la page d\'accueil'),        
				  'desc'      => $this->l('Désactiver pour afficher sur toutes les pages de la boutique :D.'),   
				  'name'      => 'fancypopup_ONLY_HOME',                                                               
				  'values'    => array(                                
					array(
					  'id'    => 'active_on',
					  'value' => 1,                                     
					  'label' => $this->l('Enabled')                   
					),
					array(
					  'id'    => 'active_off',
					  'value' => 0,
					  'label' => $this->l('Disabled')
					)
				  ),
				),
				array(
					'type' => 'text',
					'label' => $this->l('Hauteur maximale'),
					'name' => 'fancypopup_BOX_HEIGHT',
					'size' => 33,
					'suffix' => 'px',				
				),
				array(
					'type' => 'text',
					'label' => $this->l('Largeur maximale'),
					'name' => 'fancypopup_BOX_WIDTH',
					'size' => 33,
					'suffix' => 'px',	
				),
				array(
					'type' => 'text',
					'label' => $this->l('Temps d\'attente'),
					'name' => 'fancypopup_SHOW_TIME',
					'size' => 33,
					'suffix' => 'secondes',
				),
				array(
					'type' => 'color',
					'label' => $this->l('Couleur du bouton'),
					'name' => 'fancypopup_BTN_COLOR',
					'size' => 33,
				),
				array(
					'type' => 'textarea',
					'label' => $this->l('Texte d\'accroche'),
					'name' => 'fancypopup_paragraph',
					'lang' => true,
					'autoload_rte' => true,
					'desc' => $this->l('Descrivez votre offre newsletter.'),
					'cols' => 60,
					'rows' => 30
				),
				array(
					'type' => 'file',
					'label' => $this->l('Image d\'accroche'),
					'name' => 'body_fancypopup_img',
					'display_image' => true,
					'image' => $logo,
					'delete_url' => 'index.php?tab=AdminModules&configure='.$this->name.'&token='.Tools::getAdminTokenLite('AdminModules').'&deletefancypopupImage=1'
				),
			)
		);

		return $helper;
	}

	private function initToolbar()
	{
		$this->toolbar_btn['save'] = array(
			'href' => '#',
			'desc' => $this->l('Enregistrer')
		);

		return $this->toolbar_btn;
	}

	public function getContent()
	{
		$this->_html = '';
		$this->postProcess();

		$helper = $this->initForm();

		$id_shop = (int)$this->context->shop->id;
		$fancypopup = fancypopupClass::getByIdShop($id_shop);

		if (!$fancypopup) //if fancypopup do not exist for this shop => create a new example
			$this->createExamplefancypopup($id_shop);

		foreach ($this->fields_form[0]['form']['input'] as $input) //fill all form fields
		{
			if ($input['name'] == 'body_fancypopup_img' || $input['name'] == 'fancypopup_BOX_HEIGHT' || $input['name'] == 'PADDING_BOTTOM' || $input['name'] == 'fancypopup_IMAGE_COVER' || $input['name'] == 'fancypopup_BOX_WIDTH' || $input['name'] == 'fancypopup_SHOW_TIME' || $input['name'] == 'fancypopup_BTN_COLOR')
			{
				//do nothing
			}
			else
			{
				$helper->fields_value[$input['name']] = $fancypopup->{$input['name']};
			}			
		}

		$file = dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg';
		$helper->fields_value['body_fancypopup_img']['image'] = (file_exists($file) ? '<img src="'.$this->_path.'img/fancypopup_img_'.(int)$id_shop.'.jpg">' : '');
		if ($helper->fields_value['body_fancypopup_img'] && file_exists($file))
			$helper->fields_value['body_fancypopup_img']['size'] = filesize($file) / 1000;
			
		$helper->fields_value['fancypopup_BOX_WIDTH'] = Configuration::get('fancypopup_BOX_WIDTH');	
		$helper->fields_value['fancypopup_IMAGE_COVER'] = Configuration::get('fancypopup_IMAGE_COVER');
		$helper->fields_value['fancypopup_BOX_HEIGHT'] = Configuration::get('fancypopup_BOX_HEIGHT');
		$helper->fields_value['PADDING_BOTTOM'] = Configuration::get('PADDING_BOTTOM');
		$helper->fields_value['fancypopup_SHOW_TIME'] = Configuration::get('fancypopup_SHOW_TIME');
		$helper->fields_value['fancypopup_BTN_COLOR'] = Configuration::get('fancypopup_BTN_COLOR');
		$helper->fields_value['fancypopup_ONLY_HOME'] = Configuration::get('fancypopup_ONLY_HOME');

		$this->_html .= $helper->generateForm($this->fields_form);

		return $this->_html;
	}

	public function postProcess()
	{
		$errors = '';
		$id_shop = (int)$this->context->shop->id;
		// Delete image retrocompat 1.5
		if (Tools::isSubmit('deletefancypopupImage') || Tools::isSubmit('deleteImage'))
		{
			if (!file_exists(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg'))
				$errors .= $this->displayError($this->l('This action cannot be made.'));
			else
			{
				unlink(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg');
				Configuration::updateValue('fancypopup_IMAGE_DISABLE', 1);
				$this->_clearCache('views/fancypopup.tpl');
				Tools::redirectAdmin('index.php?tab=AdminModules&configure='.$this->name.'&token='.Tools::getAdminToken('AdminModules'.(int)Tab::getIdFromClassName('AdminModules').(int)$this->context->employee->id));
			}
			$this->_html .= $errors;
		}

		if (Tools::isSubmit('submitUpdatefancypopup'))
		{
			$id_shop = (int)$this->context->shop->id;
			$fancypopup = fancypopupClass::getByIdShop($id_shop);
			$fancypopup->copyFromPost();
			if (empty($fancypopup->id_shop))
				$fancypopup->id_shop = (int)$id_shop;
			$fancypopup->save();
			
			/* fancypopup Settings */
			Configuration::updateValue('fancypopup_BOX_WIDTH', (int)Tools::getValue('fancypopup_BOX_WIDTH'));
			Configuration::updateValue('fancypopup_BOX_HEIGHT', (int)Tools::getValue('fancypopup_BOX_HEIGHT'));
			Configuration::updateValue('PADDING_BOTTOM', (int)Tools::getValue('PADDING_BOTTOM'));
			Configuration::updateValue('fancypopup_SHOW_TIME', (int)Tools::getValue('fancypopup_SHOW_TIME'));
			Configuration::updateValue('fancypopup_BTN_COLOR', Tools::getValue('fancypopup_BTN_COLOR'));
			Configuration::updateValue('fancypopup_IMAGE_COVER', (int)Tools::getValue('fancypopup_IMAGE_COVER'));
			Configuration::updateValue('fancypopup_ONLY_HOME', (int)Tools::getValue('fancypopup_ONLY_HOME'));
			
			
			/* upload the image */
			if (isset($_FILES['body_fancypopup_img']) && isset($_FILES['body_fancypopup_img']['tmp_name']) && !empty($_FILES['body_fancypopup_img']['tmp_name']))
			{
				Configuration::set('PS_IMAGE_GENERATION_METHOD', 1);
				if (file_exists(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg'))
					unlink(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg');
				if ($error = ImageManager::validateUpload($_FILES['body_fancypopup_img']))
					$errors .= $error;
				elseif (!($tmp_name = tempnam(_PS_TMP_IMG_DIR_, 'PS')) || !move_uploaded_file($_FILES['body_fancypopup_img']['tmp_name'], $tmp_name))
					return false;
				elseif (!ImageManager::resize($tmp_name, dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg'))
					$errors .= $this->displayError($this->l('An error occurred while attempting to upload the image.'));
				if (isset($tmp_name))
					unlink($tmp_name);
			}
			$this->_html .= $errors == '' ? $this->displayConfirmation($this->l('Settings updated successfully.')) : $errors;
			if (file_exists(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg'))
			{
				list($width, $height, $type, $attr) = getimagesize(dirname(__FILE__).'/img/fancypopup_img_'.(int)$id_shop.'.jpg');
				Configuration::updateValue('fancypopup_IMAGE_WIDTH', (int)round($width));
				Configuration::updateValue('fancypopup_IMAGE_HEIGHT', (int)round($height));
				Configuration::updateValue('fancypopup_IMAGE_DISABLE', 0);
			}
			$this->_clearCache('views/fancypopup.tpl');
			Tools::redirectAdmin('index.php?tab=AdminModules&configure='.$this->name.'&token='.Tools::getAdminToken('AdminModules'.(int)Tab::getIdFromClassName('AdminModules').(int)$this->context->employee->id));
		}

		return true;
	}

	public function hookdisplayTopColumn()
	{
		if(Configuration::get('fancypopup_ONLY_HOME') == 0){
			return $this->displayFancyPopup();
		}
	}
	
	public function hookdisplayHome()
	{
		if(Configuration::get('fancypopup_ONLY_HOME') == 1){
			return $this->displayFancyPopup();
		}
	}

	
	public function hookDisplayHeader()
	{
		$this->context->controller->addCSS(_PS_JS_DIR_.'jquery/plugins/fancybox/jquery.fancybox.css');
		$this->context->controller->addCSS(dirname(__FILE__).'/css/fancypopup.css');
		$this->context->controller->addJS(_PS_JS_DIR_.'jquery/plugins/fancybox/jquery.fancybox.js');
		$this->context->controller->addJS(dirname(__FILE__).'/js/fancypopup.js');
	}

	public function displayFancyPopup(){
		if (!$this->isCached('views/fancypopup.tpl', $this->getCacheId()))
		{
			$id_shop = (int)$this->context->shop->id;
			$fancypopup = fancypopupClass::getByIdShop($id_shop);
			if (!$fancypopup)
				return;
			$fancypopup = new fancypopupClass((int)$fancypopup->id, $this->context->language->id);
			if (!$fancypopup)
				return;
			$this->smarty->assign(
				array(						
					'fancypopup_paragraph' => $fancypopup->fancypopup_paragraph,
					'default_lang' => (int)$this->context->language->id,
					'fancypopup_cover' => Configuration::get('fancypopup_IMAGE_COVER'),
					'fancypopup_width' => Configuration::get('fancypopup_BOX_WIDTH'),
					'fancypopup_BOX_HEIGHT' => Configuration::get('fancypopup_BOX_HEIGHT'),
					'fancypopup_SHOW_TIME' => Configuration::get('fancypopup_SHOW_TIME'),
					'fancypopup_BTN_COLOR' => Configuration::get('fancypopup_BTN_COLOR'),
					'id_lang' => $this->context->language->id,
					'fancypopup_img' => !Configuration::get('fancypopup_IMAGE_DISABLE') && file_exists('modules/fancypopup/img/fancypopup_img_'.(int)$id_shop.'.jpg'),
					'module_path' => $this->_path,
				)
			);
		}

		return $this->display(__FILE__, 'views/fancypopup.tpl', $this->getCacheId());
	}
}