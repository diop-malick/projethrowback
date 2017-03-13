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
	<div  class="detail-articles">
		{if isset($livraison) }
			{$livraison->delay}
		{/if}

		<button class="accordion"> {l s='Détails des articles'|upper}</button>
			<div class="panel2">
				{foreach $products as $product}		
					{assign var=name value=(isset($product.name))?$product.name:$product.product_name}
					{assign var=total value=(isset($product.total))?$product.total:$product.total_price}
					{assign var="attributes" value=(isset($product.attributes_small))?$product.attributes_small:$product.product_name}
					{assign var="quantity" value=(isset($product.cart_quantity))?$product.cart_quantity:$product.product_quantity}
					{assign var="split_size" value=","|explode:$attributes}
					{assign var="sizing" value=$split_size[0]|trim}
					{assign var="color" value=$split_size[1]|trim}
					<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande facturette-tc">
						<div class="col-md-8">
							<span class="command-product-name">{$name|escape:'html':'UTF-8'}</span>
						</div>

						<div class="col-md-4 text-right">
								{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$total}{/if}
						</div>
					</div>

					<div class="row attributes">
						<div class="col-md-4 no-padding">
							{l s='Couleur'}: {$color}
						</div>
						<div class="col-md-4 no-padding">
							{l s='Taille'}: {$sizing}
						</div>
						<div class="col-md-4 no-padding">
							{l s='Quantité'}: {$quantity}
						</div>
					</div>
				{/foreach}
			</div>
	</div>
	{if isset($shippingCost) }
		<div class="row line_product">
			<div class="col-md-8">
				<p class="command-product-name total"><span>{l s='Frais de port'|upper}</span></p>
			</div>
			<div class="col-md-4 text-right total">
				{if $shippingCost > 0}
					<span id="total_price">{displayPrice price=$shippingCost}</span>
				{else}
					<span id="total_price" style="color:#40ec40">GRATUIT</span>
				{/if}		
			</div>			
		</div>
		<br>
	{else}
		{assign var=shippingCost value=0}
	{/if}
	<div class="row line_product">
		<div class="col-md-8">
			<p class="command-product-name total"><span>{l s='Total'|upper}</span></p>
		</div>
		<div class="col-md-4 text-right total">			
			<span id="total_price">{displayPrice price=$total_products_wt+$shippingCost}</span>			
		</div>
	</div>
</div>
<br>
{if isset($livraison) }
	<div class="row commande_title text-center">
		<div class="col-md-12">
			{l s='VOTRE LIVRAISON'}
		</div>
	</div>
	<div class="row commande_body">
		 {$livraison->name}
		 <hr>
		 	{if $livraison->name == 'Retrait en magasin'}
				 <div class="row">
				 		<div class="col-md-12">			
							TRHOWBACK SHOP		
						</div>
						<div class="col-md-12">			
							67 Rue de la Belleville		
						</div>
						<div class="col-md-12">			
							75020 Paris
						</div>
				 	</div>
			
			{else if isset($adresse) }
				 	<div class="row">
				 		<div class="col-md-12">			
							{$adresse->company} {$adresse->firstname} {$adresse->lastname}		
						</div>
						<div class="col-md-12">			
							{$adresse->address1} {$adresse->address2} {$adresse->other}		
						</div>
						<div class="col-md-12">			
							{$adresse->postcode} {$adresse->city} {$adresse->country}	
						</div>
				 	</div>
			{/if}
	</div>	
{/if}
<div class="row text-center processService">	
	{if $current_step == "shipping"}
		<input type="hidden" name="step" value="3" />
		<input type="hidden" name="back" value="{$back}" />
		<button disabled type="submit" name="processCarrier" style="width:100%;display: block" class="button btn btn-default standard-checkout button-medium  commande_button">
			<span>
				{l s='Valider la livraison'}
				<i class="icon-chevron-right right"></i>
			</span>
		</button>
	{else if $current_step == "payment"}
	<a href="{$link->getModuleLink('cashondelivery', 'validation', [], true)|escape:'html'}">
		<button disabled type="submit" name="processPayment"  style="width:100%;display: block" class="button btn btn-default standard-checkout button-medium  commande_button">
			<span>
				{l s='Payer et terminer'}
				<i class="icon-chevron-right right"></i>
			</span>
		</button>
	</a>
	{/if}
</div>	
<script type="text/javascript">
	var acc = document.getElementsByClassName("accordion");
	var i;
	for (i = 0; i < acc.length; i++) {
		acc[i].onclick = function(){
			    this.classList.toggle("active");
			    this.nextElementSibling.classList.toggle("show");
			    return false;
		}
	}
</script>		