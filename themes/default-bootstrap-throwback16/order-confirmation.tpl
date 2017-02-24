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

{capture name=path}{l s='Order confirmation'}{/capture}

<h1 class="page-heading">{l s='Order confirmation'}</h1>

{assign var='current_step' value='confirmation'}
{include file="$tpl_dir./order-steps.tpl"}

{include file="$tpl_dir./errors.tpl"}

{$HOOK_ORDER_CONFIRMATION}
{$HOOK_PAYMENT_RETURN}
{if $is_guest}
	<p>{l s='Your order ID is:'} <span class="bold">{$id_order_formatted}</span> . {l s='Your order ID has been sent via email.'}</p>
    <p class="cart_navigation exclusive">
	<a class="button-exclusive btn btn-default" href="{$link->getPageLink('guest-tracking', true, NULL, "id_order={$reference_order|urlencode}&email={$email|urlencode}")|escape:'html':'UTF-8'}" title="{l s='Follow my order'}"><i class="icon-chevron-left"></i>{l s='Follow my order'}</a>
    </p>
{else}
<p class="cart_navigation exclusive">
	<a class="button-exclusive btn btn-default" href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Go to your order history page'}"><i class="icon-chevron-left"></i>{l s='View your order history'}</a>
</p>

{foreach $products as $product}
          <div id="product_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product line_product_{$product.id_product}">
							<div class="col-md-2 img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$product.product_name|escape:'html':'UTF-8'}" {if isset($smallSize)}width="{$smallSize.width}" height="{$smallSize.height}" {/if} /></a>
							</div>

							<div class="col-md-9">
								<p class="product-name"><a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.product_name|escape:'html':'UTF-8'}</a></p>
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
											<span class="size_line">{$product.product_quantity}</span>
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
											<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.product_price_wt}</span>
										{else}
						               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price}</span>
										{/if}
										{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}
										<span class="price-percent-reduction small">
											{if !$priceDisplay}
					            				{if isset($product.reduction_type) && $product.reduction_type == 'amount'}
					                    			{assign var='priceReduction' value=($product.product_price_wt - $product.price_without_specific_price)}
					                    			{assign var='symbol' value=$currency->sign}
					                    		{else}
					                    			{assign var='priceReduction' value=(($product.price_without_specific_price - $product.product_price_wt)/$product.price_without_specific_price) * 100 * -1}
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
								<span class="label{if $product.product_quantity_in_stock <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.product_quantity_in_stock <= 0} label-warning{else} label-success{/if}">{if $product.product_quantity_in_stock <= 0}{if isset($product.allow_oosp) && $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{l s='Disponible'}{else}{l s='In Stock'}{/if}{/if}</span>
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
{/if}
