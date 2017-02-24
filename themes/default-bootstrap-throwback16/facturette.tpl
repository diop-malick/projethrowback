{*
* 2007-2016 PrestaShop
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
*  @copyright  2007-2016 PrestaShop SA
*  @version  Release: $Revision$
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div class="row commande_title text-center">
	<div class="col-md-12">
		{l s='VOTRE COMMANDE'}
	</div>
</div>
<div class="row commande_body">
	{foreach $products as $product}		
		{assign var=name value=(isset($product.name))?$product.name:$product.product_name}
		{assign var=total value=(isset($product.total))?$product.total:$product.total_price}
		<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande">
			<div class="col-md-8">
				<p class="command-product-name">{$name|escape:'html':'UTF-8'}</p>
			</div>

			<div class="col-md-4 text-right">
					{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$total}{/if}
			</div>
		</div>
	{/foreach}
	{if isset($shipping_costs) }
		<div class="row line_product">
			<div class="col-md-8">
				<p class="command-product-name total"><span>{l s='Frais de port'|upper}</span></p>
			</div>
			<div class="col-md-4 text-right total">
				{if $shipping_costs > 0}
					<span id="total_price">{displayPrice price=$shipping_costs}</span>
				{else}
					<span id="total_price" style="color:#40ec40">GRATUIT</span>
				{/if}		
			</div>
		</div>
	{/if}
	<div class="row line_product">
		<div class="col-md-8">
			<p class="command-product-name total"><span>{l s='Total'|upper}</span></p>
		</div>
		<div class="col-md-4 text-right total">
			{if $use_taxes}
				<span id="total_price">{displayPrice price=$total_price}</span>
			{else}
				<span id="total_price">{displayPrice price=$total_price_without_tax}</span>
			{/if}
		</div>
	</div>
</div>
<div class="row text-center">	
	{if isset($virtual_cart) && $virtual_cart || (isset($delivery_option_list) && !empty($delivery_option_list))}
		<input type="hidden" name="step" value="3" />
		<input type="hidden" name="back" value="{$back}" />
		<button disabled type="submit" name="processCarrier" style="width:100%;display: block" class="button btn btn-default standard-checkout button-medium  commande_button">
			<span>
				{l s='Valider la livraison'}
				<i class="icon-chevron-right right"></i>
			</span>
		</button>
	{/if}
</div>			