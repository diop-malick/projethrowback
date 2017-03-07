<?php

class IdentityController extends IdentityControllerCore
{


	/**
	* syncMailchimp
	*
	* Mailchimp API 3.0 – PHP subscription / unsubscription
	* add and update list members
	* @link https://rudrastyh.com/api/mailchimp-subscription.html
	* @link http://stackoverflow.com/questions/30481979/adding-subscribers-to-a-list-using-mailchimps-api-v3
	*/
    protected function updateMailchimpSubscriber( $email, $status, $list_id, $api_key, $merge_fields = array('FNAME' => '','LNAME' => '') )
    {
        var_dump("MALICK updateMailchimpSubscriber");

        $data = array(
            'apikey'        => $api_key,
            'email_address' => $email,
            'status'        => $status,
            'merge_fields'  => $merge_fields
        );

        $memberId = md5(strtolower($data['email_address']));
        $dataCenter = substr($api_key,strpos($api_key,'-')+1);
        $url = 'https://' . $dataCenter . '.api.mailchimp.com/3.0/lists/' . $list_id . '/members/' . $memberId;


		// initialize cURL connection
        $mch_api = curl_init($url); 
     
        curl_setopt($mch_api, CURLOPT_USERPWD, 'user:' . $api_key);
        curl_setopt($mch_api, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
        // curl_setopt($mch_api, CURLOPT_USERAGENT, 'PHP-MCAPI/2.0');
        curl_setopt($mch_api, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($mch_api, CURLOPT_CUSTOMREQUEST, 'PUT');
        curl_setopt($mch_api, CURLOPT_TIMEOUT, 10);
        // curl_setopt($mch_api, CURLOPT_POST, true);
        curl_setopt($mch_api, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($mch_api, CURLOPT_POSTFIELDS, json_encode($data) );
     
        $result = curl_exec($mch_api);
        $httpCode = curl_getinfo($mch_api, CURLINFO_HTTP_CODE);
        curl_close($mch_api);

        return $result;
    }

        /**
     * Start forms process
     * @see FrontController::postProcess()
     */
    public function postProcess()
    {
        $origin_newsletter = (bool)$this->customer->newsletter;

        if (Tools::isSubmit('submitIdentity')) {
            $email = trim(Tools::getValue('email'));

            if (Tools::getValue('months') != '' && Tools::getValue('days') != '' && Tools::getValue('years') != '') {
                $this->customer->birthday = (int)Tools::getValue('years').'-'.(int)Tools::getValue('months').'-'.(int)Tools::getValue('days');
            } elseif (Tools::getValue('months') == '' && Tools::getValue('days') == '' && Tools::getValue('years') == '') {
                $this->customer->birthday = null;
            } else {
                $this->errors[] = Tools::displayError('Invalid date of birth.');
            }

            if (Tools::getIsset('old_passwd')) {
                $old_passwd = trim(Tools::getValue('old_passwd'));
            }

            if (!Validate::isEmail($email)) {
                $this->errors[] = Tools::displayError('This email address is not valid');
            } elseif ($this->customer->email != $email && Customer::customerExists($email, true)) {
                $this->errors[] = Tools::displayError('An account using this email address has already been registered.');
            } elseif (!Tools::getIsset('old_passwd') || (Tools::encrypt($old_passwd) != $this->context->cookie->passwd)) {
                $this->errors[] = Tools::displayError('The password you entered is incorrect.');
            } elseif (Tools::getValue('passwd') != Tools::getValue('confirmation')) {
                $this->errors[] = Tools::displayError('The password and confirmation do not match.');
            } else {
                $prev_id_default_group = $this->customer->id_default_group;

                // Merge all errors of this file and of the Object Model
                $this->errors = array_merge($this->errors, $this->customer->validateController());
            }

            if (!count($this->errors)) {
                $this->customer->id_default_group = (int)$prev_id_default_group;
                $this->customer->firstname = Tools::ucwords($this->customer->firstname);

                if (Configuration::get('PS_B2B_ENABLE')) {
                    $this->customer->website = Tools::getValue('website'); // force update of website, even if box is empty, this allows user to remove the website
                    $this->customer->company = Tools::getValue('company');
                }

                if (!Tools::getIsset('newsletter')) {
                    $this->customer->newsletter = 0;
                } elseif (!$origin_newsletter && Tools::getIsset('newsletter')) {
                    if ($module_newsletter = Module::getInstanceByName('blocknewsletter')) {
                        /** @var Blocknewsletter $module_newsletter */
                        if ($module_newsletter->active) {
                            $module_newsletter->confirmSubscription($this->customer->email);
                        }
                    }
                }

                if (!Tools::getIsset('optin')) {
                    $this->customer->optin = 0;
                }
                if (Tools::getValue('passwd')) {
                    $this->context->cookie->passwd = $this->customer->passwd;
                }
                if ($this->customer->update()) {
                    $this->context->cookie->customer_lastname = $this->customer->lastname;
                    $this->context->cookie->customer_firstname = $this->customer->firstname;
                    $this->context->smarty->assign('confirmation', 1);
                } else {
                    $this->errors[] = Tools::displayError('The information cannot be updated.');
                }

                // overrides > BEGIN - update mailchimps status
                            
                $mce_origin_newletter = $origin_newsletter;
                $mce_current_newletter = Tools::getIsset('newsletter');

                if ($mce_origin_newletter  != $mce_current_newletter) {
                    
                    // STATUS > "subscribed" or "unsubscribed" or "cleaned" or "pending"

                    // subscribed ==> unsubscribed
                    if ($mce_origin_newletter && !$mce_current_newletter) {
                        $mce_status = 'unsubscribed';
                        var_dump('subscribed ==> unsubscribed');
                    } 
                    // unsubscribed ==> subscribed
                    elseif (!$mce_origin_newletter && $mce_current_newletter) {
                        $mce_status = 'pending';
                        var_dump('unsubscribed ==> subscribed');
                    }

                    $mce_email = $this->customer->email;
                    $mce_list_id = '2eca580371';
                    $mce_api_key = 'bc44fc2b7f5e8f8f1c5c92130f3491cb-us15';
                    $mce_merge_fields = array(
                            'FNAME' => $this->customer->firstname,
                            'LNAME' => $this->customer->lastname
                    );

                    $mce_result = $this->updateMailchimpSubscriber($mce_email, $mce_status, $mce_list_id, $mce_api_key, $mce_merge_fields );
                    // PrestaShopLogger::addLog($mce_result, 1);                  
                }

                // overrides > END - update mailchimps status
                // Tools::redirect('index.php?controller=identity');
            }
        } else {
            $_POST = array_map('stripslashes', $this->customer->getFields());
        }

        return $this->customer;
    }

}
