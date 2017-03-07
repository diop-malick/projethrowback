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

<p class="titre-panier">{l s='Mon panier'}</p>
{if isset($empty)}
	{if isset($smarty.get.update) && $smarty.get.update =="1"}
		<script>window.location="{$link->getPageLink('order')}";</script>
	{else}
	
	<p class="panier-vide">{l s='Your shopping cart is empty.'}<br>
		{l s='Pour passer une commande, veuillez vous connecter et ajouter des articles dans votre panier.'}<br>
		Si vous ne disposez pas de compte throwback <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">créer votre compte</a> rapidement!
	</p>
	<div class"redirect_home">
		<a href="{$base_dir}" class=" btn btn-dark text-center">{l s='< CONTINUER VOTRE SHOPPING' mod='blocksearch'}</a>
	</div>
	{hook h="displayShoppingCartFooter"}
	{/if}

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
						{* {$product|print_r} *}  
						{assign var="productId" value=$product.id_product}
						{assign var="attributes" value=$product.attributes_small}
						{assign var="split_size" value=","|explode:$attributes}
						{assign var="sizing" value=$split_size[0]|trim}
						
						{* {$combinations[$product.id_product]|print_r}  *} 

						{$attributeCombinaison[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $combinations[$product.id_product]}

						{$qtyAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.quantity_available}

						{$qtyLimitedAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.stock_quantity}

				<form id="buy_block_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
						<div id="product_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product line_product_{$product.id_product}">
							<div class="col-md-2 img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" {if isset($smallSize)}width="{$smallSize.width}" height="{$smallSize.height}" {/if} /></a>
							</div>

							<div class="col-md-9">
								<p class="product-name"><a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.name|escape:'html':'UTF-8'}</a></p>
								<br><br>

								<div class="row">

									<div class="col-md-3">
									{addJsDef quantityAvailable=$product.quantity_available}
										<p id="quantity_wanted_p" class="quantity_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
											<label>{l s='Quantity'}</label><br>
											<input type="text" readonly min="1" name="qty" id="quantity_wanted_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="text" value="{$product.cart_quantity}" />
											<a href="#" data-field-qty="qty" id="down-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="btn btn-default button-minus product_quantity_down">
												<span><i class="icon-minus"></i></span>
											</a>
											<a href="#" data-field-qty="qty" id="up-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="btn btn-default button-plus product_quantity_up">
												<span><i class="icon-plus"></i></span>
											</a>
										</p>
										<p class="attributes_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
											<label>{l s='Quantity'}</label>
											<span class="current_qty_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} size_line">{$product.cart_quantity}</span>
										</p>
									</div>

									<div class="col-md-5">
											<div class="attributes_to_modify_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
												<div class="row">
													{if isset($groups)}
													<div class="customattributes">
														<div id="attributes">
															<div class="attribute_list">
																<label class="attribute_label" >{l s='Taille'}</label>
																{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
																	{if $group.attributes|@count}
																	<!--<fieldset class="attribute_fieldset">-->
																		
																		{assign var="groupName" value="group_"|cat:$productId|cat:"_"|cat:$product.id_product_attribute}
																		 
																		<div class="attribute_list">
																			<span class="btn">
																			{if ($group.group_type == 'radio')}
																				<ul>
																					{foreach from=$group.attributes key=id_attribute item=group_attribute}
																						
																						<li>
																							<label for="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
																							<input type="radio" id="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" 
																							{if ($group_attribute == $sizing)} checked="checked"{/if} />
																							{$group_attribute|escape:'html':'UTF-8'}

																							</label>
																						</li>
																					{/foreach}
																				</ul>
																			{elseif ($group.group_type == 'color')}
																				<div class="defautColor_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
																				<input type="hidden" name="color_default" value="{$group.default|intval}" />
																				</div>
																			{/if}
																		</div> <!-- end attribute_list -->
																	<!--</fieldset>-->
																	{/if}
																{/foreach}
																</span>
															</div>
														</div>
														<div class="combinaison_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
																<input type="hidden" name="combinaison_default" value="" />
														</div>
													</div>
													{/if}
												</div>
											</div>

											<p class="attributes_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
												<label>{l s='Taille'}</label>
												<span class="size_line">
													{$sizing}
												</span>
											</p>
									</div>

									<div class="col-md-4">
										{if !$priceDisplay}
											<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price_wt}</span>
										{else}
						               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price}</span>
										{/if}
										{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}
										<span class="reduction-text">
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
								<div class="row">
									<div class="col-md-12 margin-top-10">
										<span class="{if isset($product.available_now) && $product.available_now}dispo-text{else}not-dispo-text{/if}">{if $product.quantity_available <= 0}{if isset($product.allow_oosp) && $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{l s='Disponible'}{else}{l s='In Stock'}{/if}{/if}
										</span>
									</div>
								</div>
								<div class="row buttons_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
										<div class="col-md-6 text-right">
											<button class="buttons_modify buttons_modify_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} update_line" type="submit">
											<span>{l s='VALIDER'}</span>
											</button>
										</div>
										<div class="col-md-6">
											<button class="buttons_modify buttons_cancel_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} cancel-line" type="submit">
											<span>{l s='ANNULER'}</span>
											</button>
										</div>
								</div>
							</div>

							<div class="col-md-1">
								<div class="row">
									
									<div class="col-md-6 edit">
										<a id="edit-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" title="Modifier l'article" href="javascript:void(0)"><i class="fa fa-pencil-square-o icone-update icone-active" aria-hidden="true"></i></a>
									</div>
									
									<div class="col-md-6 delete">
										<a
											id="del-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}"
											class="cart_quantity_delete"
											href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$product.id_customization|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
											rel="nofollow"
											title="{l s='Delete'}">
											X
										</a>
									</div>
								</div>
							</div>
						</div>
						
					</form>		
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
						<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande">
								<div class="col-md-8">
									<p class="command-product-name">{$product.name|escape:'html':'UTF-8'}</p>
								</div>

								<div class="col-md-4 text-right">
									<span id="total_product_price_{$product.id_product}_{$product.id_product_attribute}_0">
										{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$product.total}{/if}
									</span>
								</div>
						</div>
					
																
														
						{/foreach}
						<input type="hidden" class="my" name="price_add" value="" />
						<input type="hidden" class="you" name="total_add" value="" />
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
							<a href="{$base_dir}" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'}">
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


	<div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>
	
{strip}
{addJsDef deliveryAddress=$cart->id_address_delivery|intval}
{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}


{addJsDef allowBuyWhenOutOfStock=false}
<!-- assign quantity variable to product.js   -->

{addJsDef quantityAvailable=$qtyAvailable}
{addJsDef quantityLimitedAvailable=$qtyLimitedAvailable}
{addJsDef attributesCombinations=$attributeCombinaison}
{addJsDef linkCarte=$link->getPageLink('order')}

{/strip}
{/if}

<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" data-semver="3.1.1" data-require="bootstrap-css" />
