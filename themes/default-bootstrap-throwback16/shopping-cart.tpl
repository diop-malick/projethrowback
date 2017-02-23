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
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{capture name=path}{l s='Your shopping cart'}{/capture}
<!--
<h1 id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
	{if !isset($empty) && !$PS_CATALOG_MODE}
		<span class="heading-counter">{l s='Your shopping cart contains:'}
			<span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
		</span>
	{/if}
</h1>
-->
{if isset($account_created)}
	<p class="alert alert-success">
		{l s='Your account has been created.'}
	</p>
{/if}
{*
{assign var='current_step' value='summary'}
{include file="$tpl_dir./order-steps.tpl"}
*}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
	<p class="alert alert-warning">{l s='Your shopping cart is empty.'}</p>
{elseif $PS_CATALOG_MODE}
	<p class="alert alert-warning">{l s='This store has not accepted your new order.'}</p>
{else}
	<p id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</p>
	{if isset($lastProductAdded) AND $lastProductAdded}
		<div class="cart_last_product">
			<div class="cart_last_product_header">
				<div class="left">{l s='Last product added'}</div>
			</div>
			<a class="cart_last_product_img" href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, $lastProductAdded.id_shop)|escape:'html':'UTF-8'}">
				<img src="{$link->getImageLink($lastProductAdded.link_rewrite, $lastProductAdded.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$lastProductAdded.name|escape:'html':'UTF-8'}"/>
			</a>
			<div class="cart_last_product_content">
				<p class="product-name">
					<a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
						{$lastProductAdded.name|escape:'html':'UTF-8'}
					</a>
				</p>
				{if isset($lastProductAdded.attributes) && $lastProductAdded.attributes}
					<small>
						<a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
							{$lastProductAdded.attributes|escape:'html':'UTF-8'}
						</a>
					</small>
				{/if}
			</div>
		</div>
	{/if}
	{assign var='total_discounts_num' value="{if $total_discounts != 0}1{else}0{/if}"}
	{assign var='use_show_taxes' value="{if $use_taxes && $show_taxes}2{else}0{/if}"}
	{assign var='total_wrapping_taxes_num' value="{if $total_wrapping != 0}1{else}0{/if}"}
	{* eu-legal *}
	{hook h="displayBeforeShoppingCartBlock"}
	<div id="order-detail-content" class="table_block table-responsive">
		<div class="row">
				<div class="col-md-9">
					{assign var='odd' value=0}
					{assign var='have_non_virtual_products' value=false}
					{foreach $products as $product}
						
						
						<div id="product_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product line_product_{$product.id_product}">
							<div class="col-md-2 img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" {if isset($smallSize)}width="{$smallSize.width}" height="{$smallSize.height}" {/if} /></a>
							</div>

							<div class="col-md-9">
								<p class="product-name"><a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.name|escape:'html':'UTF-8'}</a></p>
								<br><br>

								<div class="row">

									<div class="col-md-3">

										<p id="quantity_wanted_p" class="quantity_{$product.id_product}" style="display: none">
											<label>{l s='Quantity'}</label><br>
											<input type="number" min="1" name="qty" id="quantity_wanted" class="text" value="" />
											<a href="#" data-field-qty="qty" class="btn btn-default button-minus product_quantity_down">
												<img src="{$base_dir}/img/icones/size_down.png"/>
											</a>
											<a href="#" data-field-qty="qty" class="btn btn-default button-plus product_quantity_up">
												<img src="{$base_dir}/img/icones/size_up.png"/>
											</a>
										</p>
										<p class="attributes_line_{$product.id_product}">
											<label>{l s='Quantity'}</label>
											<span class="size_line">{$product.cart_quantity}</span>
										</p>
									</div>

									<div class="col-md-5">
											<div class="attributes_to_modify_{$product.id_product}" style="display: none">
												<div class="row">
														<div id="attributes">
															<div class="attribute_list">
																<label class="attribute_label" >{l s='Taille'}</label>
																<ul>
																	<li>
																			<input type="radio" class="attribute_radio" name="" value=""  />
																			<span>S</span>
																	</li>

																	<li>
																			<input type="radio" class="attribute_radio" name="" value=""  />
																			<span>S</span>
																	</li>

																	<li>
																			<input type="radio" class="attribute_radio" name="" value=""  />
																			<span>S</span>
																	</li>
																</ul>
															</div>
														</div>
												</div>
											</div>

											<p class="attributes_line_{$product.id_product}">
												<label>{l s='Taille'}</label>
												<span class="size_line">S</span>
											</p>
									</div>

									<div class="col-md-4">
										{if !$priceDisplay}
											<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price_wt}</span>
										{else}
						               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price}</span>
										{/if}
										{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}
										<span class="price-percent-reduction small">
											{if !$priceDisplay}
					            				{if isset($product.reduction_type) && $product.reduction_type == 'amount'}
					                    			{assign var='priceReduction' value=($product.price_wt - $product.price_without_specific_price)}
					                    			{assign var='symbol' value=$currency->sign}
					                    		{else}
					                    			{assign var='priceReduction' value=(($product.price_without_specific_price - $product.price_wt)/$product.price_without_specific_price) * 100 * -1}
					                    			{assign var='symbol' value='%'}
					                    		{/if}
											{else}
												{if isset($product.reduction_type) && $product.reduction_type == 'amount'}
													{assign var='priceReduction' value=($product.price - $product.price_without_specific_price)}
													{assign var='symbol' value=$currency->sign}
												{else}
													{assign var='priceReduction' value=(($product.price_without_specific_price - $product.price)/$product.price_without_specific_price) * -100}
													{assign var='symbol' value='%'}
												{/if}
											{/if}
											{if $symbol == '%'}
												&nbsp;{$priceReduction|string_format:"%.2f"|regex_replace:"/[^\d]0+$/":""}{$symbol}&nbsp;
											{else}
												&nbsp;{convertPrice price=$priceReduction}&nbsp;
											{/if}
										</span>
										<span class="old-price">{convertPrice price=$product.price_without_specific_price}</span>
										
										{/if}
									</div>

								</div>
								<span class="label{if $product.quantity_available <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity_available <= 0} label-warning{else} label-success{/if}">{if $product.quantity_available <= 0}{if isset($product.allow_oosp) && $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{l s='Disponible'}{else}{l s='In Stock'}{/if}{/if}</span>
							</div>

							<div class="col-md-1">
								<div class="row">
									<!--
									<div class="col-md-6 edit">
										<a href="{$product.id_product}" title="Modifier l'article" href="javascript:void(0)"><i class="fa fa-pencil-square-o fa-2x icone-active" aria-hidden="true"></i></a>
									</div>
									-->
									<div class="col-md-12">
										<a
											id="{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}"
											class="cart_quantity_delete"
											href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization=0&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
											rel="nofollow"
											title="{l s='Delete'}">
											X
										</a>
									</div>
								</div>
							</div>
						</div>
					{/foreach}
				</div>

				

				<div class="col-md-3">
					<div class="row commande_title text-center">
						<div class="col-md-12">
							{l s='VOTRE COMMANDE'}
						</div>
					</div>
					<div class="row commande_body">
						{foreach $products as $product}
						<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande">
								<div class="col-md-8">
									<p class="command-product-name">{$product.name|escape:'html':'UTF-8'}</p>
								</div>

								<div class="col-md-4 text-right">
										{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$product.total}{/if}
								</div>
						</div>
						{/foreach}

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
					<div class="row commande_button text-center">
						<div class="col-md-12">	
							{if !$opc}
								<a  href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')|escape:'html':'UTF-8'}{else}{$link->getPageLink('order', true, NULL, 'step=1')|escape:'html':'UTF-8'}{/if}"  title="{l s='Proceed to checkout'}">
									<span class="text_valid_commande">{l s='Valider mon panier'} <i class="icon-chevron-right right"></i></span>
								</a>
							{/if}
						</div>
					</div>

					<div class="row text-center">
						<div class="col-md-12">	
						<p class="cart_navigation clearfix">
							<a href="{if (isset($smarty.server.HTTP_REFERER) && ($smarty.server.HTTP_REFERER == $link->getPageLink('order', true) || $smarty.server.HTTP_REFERER == $link->getPageLink('order-opc', true) || strstr($smarty.server.HTTP_REFERER, 'step='))) || !isset($smarty.server.HTTP_REFERER)}{$link->getPageLink('index')}{else}{$smarty.server.HTTP_REFERER|escape:'html':'UTF-8'|secureReferrer}{/if}" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'}">
							<i class="icon-chevron-left"></i>{l s='Continuer mon shopping'}
						</a>
						</p>
						</div>
					</div>
				</div>

		</div>
	</div> <!-- end order-detail-content -->

	{if $show_option_allow_separate_package}
	<p>
		<label for="allow_seperated_package" class="checkbox inline">
			<input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off"/>
			{l s='Send available products first'}
		</label>
	</p>
	{/if}

	{* Define the style if it doesn't exist in the PrestaShop version*}
	{* Will be deleted for 1.5 version and more *}
	<!--
	{if !isset($addresses_style)}
		{$addresses_style.company = 'address_company'}
		{$addresses_style.vat_number = 'address_company'}
		{$addresses_style.firstname = 'address_name'}
		{$addresses_style.lastname = 'address_name'}
		{$addresses_style.address1 = 'address_address1'}
		{$addresses_style.address2 = 'address_address2'}
		{$addresses_style.city = 'address_city'}
		{$addresses_style.country = 'address_country'}
		{$addresses_style.phone = 'address_phone'}
		{$addresses_style.phone_mobile = 'address_phone_mobile'}
		{$addresses_style.alias = 'address_title'}
	{/if}
	{if !$advanced_payment_api && ((!empty($delivery_option) && (!isset($isVirtualCart) || !$isVirtualCart)) OR $delivery->id || $invoice->id) && !$opc}
		<div class="order_delivery clearfix row">
			{if !isset($formattedAddresses) || (count($formattedAddresses.invoice) == 0 && count($formattedAddresses.delivery) == 0) || (count($formattedAddresses.invoice.formated) == 0 && count($formattedAddresses.delivery.formated) == 0)}
				{if $delivery->id}
					<div class="col-xs-12 col-sm-6"{if !$have_non_virtual_products} style="display: none;"{/if}>
						<ul id="delivery_address" class="address item box">
							<li><h3 class="page-subheading">{l s='Delivery address'}&nbsp;<span class="address_alias">({$delivery->alias})</span></h3></li>
							{if $delivery->company}<li class="address_company">{$delivery->company|escape:'html':'UTF-8'}</li>{/if}
							<li class="address_name">{$delivery->firstname|escape:'html':'UTF-8'} {$delivery->lastname|escape:'html':'UTF-8'}</li>
							<li class="address_address1">{$delivery->address1|escape:'html':'UTF-8'}</li>
							{if $delivery->address2}<li class="address_address2">{$delivery->address2|escape:'html':'UTF-8'}</li>{/if}
							<li class="address_city">{$delivery->postcode|escape:'html':'UTF-8'} {$delivery->city|escape:'html':'UTF-8'}</li>
							<li class="address_country">{$delivery->country|escape:'html':'UTF-8'} {if $delivery_state}({$delivery_state|escape:'html':'UTF-8'}){/if}</li>
						</ul>
					</div>
				{/if}
				{if $invoice->id}
					<div class="col-xs-12 col-sm-6">
						<ul id="invoice_address" class="address alternate_item box">
							<li><h3 class="page-subheading">{l s='Invoice address'}&nbsp;<span class="address_alias">({$invoice->alias})</span></h3></li>
							{if $invoice->company}<li class="address_company">{$invoice->company|escape:'html':'UTF-8'}</li>{/if}
							<li class="address_name">{$invoice->firstname|escape:'html':'UTF-8'} {$invoice->lastname|escape:'html':'UTF-8'}</li>
							<li class="address_address1">{$invoice->address1|escape:'html':'UTF-8'}</li>
							{if $invoice->address2}<li class="address_address2">{$invoice->address2|escape:'html':'UTF-8'}</li>{/if}
							<li class="address_city">{$invoice->postcode|escape:'html':'UTF-8'} {$invoice->city|escape:'html':'UTF-8'}</li>
							<li class="address_country">{$invoice->country|escape:'html':'UTF-8'} {if $invoice_state}({$invoice_state|escape:'html':'UTF-8'}){/if}</li>
						</ul>
					</div>
				{/if}
			{else}
				{foreach from=$formattedAddresses key=k item=address}
					<div class="col-xs-12 col-sm-6"{if $k == 'delivery' && !$have_non_virtual_products} style="display: none;"{/if}>
						<ul class="address {if $address@last}last_item{elseif $address@first}first_item{/if} {if $address@index % 2}alternate_item{else}item{/if} box">
							<li>
								<h3 class="page-subheading">
									{if $k eq 'invoice'}
										{l s='Invoice address'}
									{elseif $k eq 'delivery' && $delivery->id}
										{l s='Delivery address'}
									{/if}
									{if isset($address.object.alias)}
										<span class="address_alias">({$address.object.alias})</span>
									{/if}
								</h3>
							</li>
							{foreach $address.ordered as $pattern}
								{assign var=addressKey value=" "|explode:$pattern}
								{assign var=addedli value=false}
								{foreach from=$addressKey item=key name=foo}
								{$key_str = $key|regex_replace:AddressFormat::_CLEANING_REGEX_:""}
									{if isset($address.formated[$key_str]) && !empty($address.formated[$key_str])}
										{if (!$addedli)}
											{$addedli = true}
											<li><span class="{if isset($addresses_style[$key_str])}{$addresses_style[$key_str]}{/if}">
										{/if}
										{$address.formated[$key_str]|escape:'html':'UTF-8'}
									{/if}
									{if ($smarty.foreach.foo.last && $addedli)}
										</span></li>
									{/if}
								{/foreach}
							{/foreach}
						</ul>
					</div>
				{/foreach}
			{/if}
		</div>
	{/if}
	
	<div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>
	
	<div class="clear"></div>
	<div class="cart_navigation_extra">
		<div id="HOOK_SHOPPING_CART_EXTRA">{if isset($HOOK_SHOPPING_CART_EXTRA)}{$HOOK_SHOPPING_CART_EXTRA}{/if}</div>
	</div>
	-->
{strip}
{addJsDef deliveryAddress=$cart->id_address_delivery|intval}
{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
{/strip}
{/if}

<script src="http://bootboxjs.com/bootbox.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" data-semver="3.1.1" data-require="bootstrap-css" />
<script>
		    $( document ).ready(function() {
			   $( ".edit a" ).on( "click", function(e) {
			   		e.preventDefault();
			   		var line = $(this).attr('href');
			   		$( ".attributes_line_"+line ).hide();
			   		$( ".quantity_"+line ).show();
			   		$( ".attributes_to_modify_"+line ).show();

			   			$( ".buttons_cancel_line_"+line ).on( "click", function(e) {
			   		e.preventDefault();
			   		$( ".attributes_line_"+line ).show();
			   		$( ".quantity_"+line ).hide();
			   		$( ".attributes_to_modify_"+line ).hide();
			   			});
			   });

			   
		    });
		
    </script>

