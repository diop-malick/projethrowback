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
<div class="row commande_body body_facturette">
	<div  class="detail-articles">
		<button class="accordion"> {l s='DÉTAILS DES ARTICLES'}</button>
			<div class="panel panel2">
				{assign var="total_reduction" value=0}
				{foreach $products as $product}

					{* {($product.reduction_formatted|intval)|var_dump} *}
					{$total_reduction=$total_reduction+($product.reduction_formatted|intval)}

					{assign var=name value=(isset($product.name))?$product.name:$product.product_name}
					{assign var=total value=(isset($product.total))?$product.total:$product.total_price}
					{assign var="attributes" value=(isset($product.attributes_small))?$product.attributes_small:$product.product_name}
					{assign var="quantity" value=(isset($product.cart_quantity))?$product.cart_quantity:$product.product_quantity}
					

					{if {$smarty.get.controller} eq orderconfirmation }
					

						{assign var="split_size" value="-"|explode:$attributes}

						{if isset($split_size[0]) }
							{assign var="name" value=$split_size[0]|trim}
						{/if}
								
						{assign var="sizing_ini" value=":"|explode:$split_size[1]}
						{assign var="color_ini" value=":"|explode:$split_size[2]}
						
						{if isset($sizing_ini[1]) }
								{assign var="sizing" value=$sizing_ini[1]|trim}
						{/if}

						{if isset($color_ini[1]) }
								{assign var="color" value=$sizing_ini[2]|trim}
						{/if}

					{elseif {$smarty.get.controller} eq 'order'}

						{assign var="split_size" value=","|explode:$attributes}
						{*
							{if isset($split_size[0]) }
								{assign var="sizing" value=$split_size[0]|trim}
							{/if}
								
							{if isset($split_size[1]) }
								{assign var="color" value=$split_size[1]|trim}
							{/if}
						*}

						{if isset($split_size[1]) }
								{assign var="sizing" value=$split_size[1]|trim}

								{if isset($split_size[0]) }
									{assign var="color" value=$split_size[0]|trim}
								{else}
									{assign var="color" value=null}
								{/if}

						{else}
								{assign var="sizing" value=$split_size[0]|trim}
								{assign var="color" value=null}
						{/if}

					{/if}
					
					<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande facturette-tc">
						<div class="col-md-8 col-xs-6">
							<span class="command-product-name">{$name|escape:'html':'UTF-8'}</span>
						</div>

						<div class="col-md-4 text-right col-xs-6">
								{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$total}{/if}
						</div>
					</div>

					<div class="row attributes">
						<div class="col-md-12 no-padding">
							{if isset($color)}
								{l s='Couleur'}: {$color}
								&nbsp;&nbsp;
							{/if} 
								
							{if isset($sizing) && $sizing}
								{assign var=someVar value=" "|explode:$sizing}
								{l s='Taille'}: {if (isset($someVar[0])) } {$someVar[0]|escape:'html':'UTF-8'} {/if} {if isset($someVar[1])}<sup>{$someVar[1]|escape:'html':'UTF-8'}</sup> {/if}
								&nbsp;&nbsp;
							{/if}
								
							{l s='Quantité'}: {$quantity}
						</div>
						
					</div>
					<br>
				{/foreach}
			</div>
	</div>
	{if isset($shippingCost) }
		<div class="row line_product">
			<div class="col-md-8 col-xs-6">
				<p class="command-product-name total"><span>{l s='FRAIS DE PORT'}</span></p>
			</div>
			<div class="col-md-4 col-xs-6 text-right total">
				{if $shippingCost > 0}
					<span id="total_price">{displayPrice price=$shippingCost}</span>
				{else}
					<span id="total_price" style="color:#40ec40">{l s='GRATUIT'}</span>
				{/if}		
			</div>			
		</div>
		<br>
	{else}
		{assign var=shippingCost value=0}
	{/if}
	
	{if $total_reduction }
	<div class="row line_product">
			<div class="col-md-8 col-xs-6">
				<p class="command-product-name total"><span>{l s='RÉDUCTION'}</span></p>
			</div>
			<div class="col-md-4 col-xs-6 text-right total">
					<span id="total_price">{$total_reduction} {$currency->sign}</span>
			</div>			
	</div>
	<br>
	{/if}

	{if $total_discounts_tax_exc }
	<div class="row line_product">
			<div class="col-md-8 col-xs-6">
				<p class="command-product-name total"><span>{l s='Total vouchers'}</span></p>
			</div>
			<div class="col-md-4 col-xs-6 text-right total">
					<span id="total_price">
					{if $use_taxes && $priceDisplay == 0}
						{assign var='total_discounts_negative' value=$total_discounts * -1}
					{else}
						{assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
					{/if}
						{displayPrice price=$total_discounts_negative}</span>
			</div>			
	</div>
	<br>
	{/if}

	<div class="row line_product">
		<div class="col-md-8 col-xs-6">
			<p class="command-product-name total"><span>{l s='Total'|upper}</span></p>
		</div>
		<div class="col-md-4 col-xs-6 text-right total">			
			<span id="total_price">{displayPrice price=$total_products_wt+$shippingCost+$total_discounts_negative}</span>			
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
		 <br>
		 <strong>{$livraison->delay}</strong>
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
							{$adresse->postcode} {$adresse->city} <br>
							{$adresse->country}	
						</div>
				 	</div>
			{/if}
	</div>	
{/if}
<br>
{if $current_step == "confirmation"}
<div class="row commande_title text-center">
		<div class="col-md-12">
			{l s='VOTRE PAIEMENT'}
		</div>
	</div>
	<div class="row commande_body">
		 {l s='Carte bancaire'}
	</div>	
{/if}
<div class="row text-center processService">
	{if $current_step == "shipping"}

		<input type="hidden" name="step" value="3" />
		<input type="hidden" name="back" value="{$back}" />
		<button disabled type="submit" name="processCarrier" style="width:100%;display: block" class="button btn btn-default standard-checkout button-medium commande_button">
			<span>
				{l s='Valider la livraison'}
				<i class="icon-chevron-right right"></i>
			</span>
		</button>
	{else if $current_step == "payment"}
	<form action="{$link->getModuleLink('cashondelivery', 'validation', [], true)|escape:'html'}" method="post">
	<input type="hidden" name="confirm" value="1" />
		<button type="submit" name="processPayment"  style="width:100%;display: block" class="button btn btn-default buttonpayment standard-checkout button-medium hidden  commande_button">
			<span>
				{l s='Valider le paiement'}
				<i class="icon-chevron-right right"></i>
			</span>
		</button>
	</form>
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
