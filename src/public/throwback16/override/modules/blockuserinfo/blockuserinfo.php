<?php

/*
* 04/02/2017
* Surcharge Module user info
* 
* Modify hook for display top
*/

if (!defined('_PS_VERSION_'))
	exit;

class BlockUserInfoOverride extends BlockUserInfo
{
	/**
	* Returns module content for header
	*
	* @param array $params Parameters
	* @return string Content
	*/
	public function hookDisplayTop($params)
	{
		if (!$this->active)
			return;

		$this->smarty->assign(array(
			'cart' => $this->context->cart,
			'cart_qties' => $this->context->cart->nbProducts(),
			'logged' => $this->context->customer->isLogged(),
			'customerName' => ($this->context->customer->logged ? $this->context->customer->firstname.' '.$this->context->customer->lastname : false),
			'firstName' => ($this->context->customer->logged ? $this->context->customer->firstname : false),
			'lastName' => ($this->context->customer->logged ? $this->context->customer->lastname : false),
			'order_process' => Configuration::get('PS_ORDER_PROCESS_TYPE') ? 'order-opc' : 'order'
		));
		return $this->display(__FILE__, 'blockuserinfo-top.tpl');		
	}

	public function hookDisplayNav($params)
	{
		return $this->display(__FILE__, 'blockuserinfo-nav.tpl');
	}
}

