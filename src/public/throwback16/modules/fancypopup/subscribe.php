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

require_once('../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');


class fancypopup extends Module
{
	public $GUEST_NOT_REGISTERED = 0;
	public $CUSTOMER_REGISTERED = 1;
	public $CUSTOMER_NOT_REGISTERED = 0;
	public $GUEST_REGISTERED = 1;
	public function __construct()
	{//print_r($_REQUEST);die();

		if (empty($_REQUEST['email']) || !Validate::isEmail($_REQUEST['email']))
			echo json_encode(array("message" => $this->error = $this->l('« Merci de saisir une adresse email valide.'),"code" => 0));
		/* Subscription */
		else if ($_REQUEST['action'] == '0')
		{
			$register_status = $this->isNewsletterRegistered($_REQUEST['email']);
			if ($register_status > 0)
				echo json_encode(array("message" => $this->error = $this->l('Vous êtes déjà abonné à notre newsletter.'),"code" => 0));
		
			$email = pSQL($_REQUEST['email']);
			if (!$this->isRegistered($register_status))
			{
				if (Configuration::get('NW_VERIFICATION_EMAIL'))
				{
					// create an unactive entry in the newsletter database
					if ($register_status == $this->GUEST_NOT_REGISTERED)
						$this->registerGuest($email, false);
		
					if (!$token = $this->getToken($email, $register_status))
						return json_encode(array("message" => $this->error = $this->l('Une erreur s\'est produite durant l\'inscription.'),"code" => 0));
		
					$this->sendVerificationEmail($email, $token);
		
					echo json_encode(array("message" => $this->error = $this->l('Un email de vérification vous a été envoyé à votre boîte.'),"code" => 0));
				}
				else
				{	
					if ($this->register($email, $register_status))
					{
						$this->sendConfirmationEmail($email);
						echo json_encode(array("message" => $this->error = $this->l('Inscription à la newsletter réussie!'),"code" => 1));
						die();
					}
					else
					{
						echo $this->error = $this->l('Une erreur s\'est produite durant l\'inscription.');
						die();
					}
					
				}
			}
		}
	}
	
	protected function sendConfirmationEmail($email)		
	{	
		$subject = 'Confirmation d\'inscription à notre newsletter';
		$data = array('{lastname}'  => 'Jobs' ,  '{firstname}'  => 'Steve' );
 
		return Mail::Send(Context::getContext()->language->id, 'newsletter', $subject , $data, $email, NULL, NULL, NULL, NULL, NULL,_PS_MAIL_DIR_,false,Context::getContext()->shop->id);
	}
	
	protected function isNewsletterRegistered($customer_email)
	{
		$sql = 'SELECT `email`
				FROM '._DB_PREFIX_.'newsletter
				WHERE `email` = \''.pSQL($customer_email).'\'
				AND id_shop = '.Context::getContext()->shop->id;
		
		
		if (Db::getInstance()->getRow($sql))
			return $this->GUEST_REGISTERED;

		$sql = 'SELECT `newsletter`
				FROM '._DB_PREFIX_.'customer
				WHERE `email` = \''.pSQL($customer_email).'\'
				AND id_shop = '.Context::getContext()->shop->id;

		if (!$registered = Db::getInstance()->getRow($sql))
			return $this->GUEST_NOT_REGISTERED;

		if ($registered['newsletter'] == '1')
			return $this->CUSTOMER_REGISTERED;

		return $this->CUSTOMER_NOT_REGISTERED;
	}
	
	protected function isRegistered($register_status)
	{
		return in_array(
			$register_status,
			array($this->GUEST_REGISTERED, $this->CUSTOMER_REGISTERED)
		);
	}
	
	protected function register($email, $register_status)
	{
		if ($register_status == $this->GUEST_NOT_REGISTERED)
			return $this->registerGuest($email);

		if ($register_status == $this->CUSTOMER_NOT_REGISTERED)
			return $this->registerUser($email);

		return false;
	}
	
	protected function registerUser($email)
	{
		$sql = 'UPDATE '._DB_PREFIX_.'customer
				SET `newsletter` = 1, newsletter_date_add = NOW(), `ip_registration_newsletter` = \''.pSQL(Tools::getRemoteAddr()).'\'
				WHERE `email` = \''.pSQL($email).'\'
				AND id_shop = '.Context::getContext()->shop->id;

		return Db::getInstance()->execute($sql);
	}
	
	protected function sendVerificationEmail($email, $token)
	{
		$verif_url = Context::getContext()->link->getModuleLink(
			'blocknewsletter', 'verification', array(
				'token' => $token,
			)
		);

		return Mail::Send(Context::getContext()->language->id, 'newsletter_verif', Mail::l('Email verification', $this->context->language->id), array('{verif_url}' => $verif_url), $email, null, null, null, null, null,_PS_MAIL_DIR_, false, Context::getContext()->shop->id);
	}

	protected function registerGuest($email, $active = true)
	{
		$sql = 'INSERT INTO '._DB_PREFIX_.'newsletter (id_shop, id_shop_group, email, newsletter_date_add, ip_registration_newsletter, http_referer, active)
				VALUES
				('.Context::getContext()->shop->id.',
				'.Context::getContext()->shop->id_shop_group.',
				\''.pSQL($email).'\',
				NOW(),
				\''.pSQL(Tools::getRemoteAddr()).'\',
				(
					SELECT c.http_referer
					FROM '._DB_PREFIX_.'connections c
					WHERE c.id_guest = '.(int)Context::getContext()->customer->id.'
					ORDER BY c.date_add DESC LIMIT 1
				),
				'.(int)$active.'
				)';

		return Db::getInstance()->execute($sql);
	}
	
}

$fancypopupValidator = new fancypopup();
