<?php
/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
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
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class PasswordController extends PasswordControllerCore
{
	
	public function changeLink($token , $id_customer , $statut , $link_secure=null){
		
		$data = $link_secure ?  array('link_active' => $statut , 'link_secure' => pSQL($link_secure) ) : array('link_active' => $statut );
        $where = 'secure_key = \''.pSQL($token).'\' AND id_customer = '.(int)$id_customer;
        Db::getInstance()->update('customer' , $data ,$where);
	}

    public function postProcess()
    {
        
        if (Tools::isSubmit('email')) {
            if (!($email = trim(Tools::getValue('email'))) || !Validate::isEmail($email)) {
                $this->errors[] = Tools::displayError('Invalid email address.');
            } else {
                $customer = new Customer();
                $customer->getByemail($email);
                if (!Validate::isLoadedObject($customer)) {
                    $this->errors[] = Tools::displayError('There is no account registered for this email address.');
                } elseif (!$customer->active) {
                    $this->errors[] = Tools::displayError('You cannot regenerate the password for this account.');
                } elseif ((strtotime($customer->last_passwd_gen.'+'.($min_time = (int)Configuration::get('PS_PASSWD_TIME_FRONT')).' minutes') - time()) > 0) {
                    $this->errors[] = sprintf(Tools::displayError('You can regenerate your password only every %d minute(s)'), (int)$min_time);
                } else {
                	$link_secure = md5(uniqid(rand(), true));
                	
                    $mail_params = array(
                        '{email}' => $customer->email,
                        '{lastname}' => $customer->lastname,
                        '{firstname}' => $customer->firstname,
                        '{url}' => $this->context->link->getPageLink('password', true, null, 'token='.$customer->secure_key.'&id_customer='.(int)$customer->id.'&link='.$link_secure)
                    );
                    if (Mail::Send($this->context->language->id, 'password_query', Mail::l('Password query confirmation'), $mail_params, $customer->email, $customer->firstname.' '.$customer->lastname)) {

                       $this->changeLink($customer->secure_key , (int)$customer->id , 0 , $link_secure);

                        $this->context->smarty->assign(array('confirmation' => 2, 'customer_email' => $customer->email));
                    } else {
                        $this->errors[] = Tools::displayError('An error occurred while sending the email.');
                    }
                }
            }
        }
        elseif(Tools::isSubmit('email_exist')){
            if (!($email = trim(Tools::getValue('email_exist'))) || !Validate::isEmail($email)) 
                $this->errors[] = Tools::displayError('Invalid email address.');
            elseif( !($new_pwd = Tools::getValue('new_password')) || !($confirm_password = Tools::getValue('confirm_password')) || ($new_pwd != $confirm_password) )
                $this->errors[] = Tools::displayError('We cannot regenerate your password with the data you\'ve submitted.');
            else {

                    $token = Tools::getValue('ct_token'); 
                    $id_customer = Tools::getValue('ct_id');
                    $email_bd = Db::getInstance()->getValue('SELECT `email` FROM '._DB_PREFIX_.'customer c WHERE c.`secure_key` = \''.pSQL($token).'\' AND c.id_customer = '.(int)$id_customer);
                    if($email_bd != $email)
                         $this->errors[] = Tools::displayError('We cannot regenerate your password with the data you\'ve submitted.');
                    else{
                            $customer = new Customer();
                            $customer->getByemail($email_bd);

                            if (!Validate::isLoadedObject($customer)) {
                                $this->errors[] = Tools::displayError('Customer account not found');
                            } elseif (!$customer->active) {
                                $this->errors[] = Tools::displayError('You cannot regenerate the password for this account.');
                            } elseif ((strtotime($customer->last_passwd_gen.'+'.(int)Configuration::get('PS_PASSWD_TIME_FRONT').' minutes') - time()) > 0) {
                                Tools::redirect('index.php?controller=authentication&error_regen_pwd');
                            } else {
                                $customer->passwd = Tools::encrypt($new_pwd);
                                $customer->last_passwd_gen = date('Y-m-d H:i:s', time());
                                if ($customer->update()) {
                                    Hook::exec('actionPasswordRenew', array('customer' => $customer, 'password' => $new_pwd));
                                    Tools::redirect('index.php?controller=authentication&back=my-account&generate=1');
                                }
                            }

                     }
                    
                    }
        }
        
         elseif (($token = Tools::getValue('token')) && ($id_customer = (int)Tools::getValue('id_customer')) && ($link_secure = Tools::getValue('link'))) {

            $email = Db::getInstance()->getValue('SELECT `email` FROM '._DB_PREFIX_.'customer c WHERE c.`secure_key` = \''.pSQL($token).'\' AND c.id_customer = '.(int)$id_customer.' AND c.link_active = 0 AND c.link_secure = \''.pSQL($link_secure).'\'' );
            if ($email) {
                $customer = new Customer();
                $customer->getByemail($email);
                if (!Validate::isLoadedObject($customer)) {
                    $this->errors[] = Tools::displayError('Customer account not found');
                } elseif (!$customer->active) {
                    $this->errors[] = Tools::displayError('You cannot regenerate the password for this account.');
                } elseif ((strtotime($customer->last_passwd_gen.'+'.($min_time = (int)Configuration::get('PS_PASSWD_TIME_FRONT')).' minutes') - time()) > 0) {
                    //Tools::redirect('index.php?controller=authentication&error_regen_pwd');
                    $this->errors[] = Tools::displayError("Le lien n'est plus valable");
                } else {
                			$this->changeLink($token , $id_customer , 1);
                            $this->context->smarty->assign(array('confirmation' => 1, 'customer_email' => $customer->email));
                }
            } else {
              		 $this->errors[] = Tools::displayError("Le lien n'est pas valable.");
            }
        } 
        elseif (Tools::getValue('token') || Tools::getValue('id_customer')) {
            $this->errors[] = Tools::displayError('We cannot regenerate your password with the data you\'ve submitted.');
        }
        
    }

}
