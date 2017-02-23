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
{if !$opc}
	{capture name=path}{l s='Shipping:'}{/capture}
	{assign var='current_step' value='shipping'}
	{assign var="back_order_page" value="order.php"}
	<div id="carrier_area">
		<h1 class="page-heading">{l s='Shipping:'}</h1>
		{include file="$tpl_dir./order-steps.tpl"}
		{include file="$tpl_dir./errors.tpl"}
		<form id="form" action="{$link->getPageLink('order', true, NULL, "{if $multi_shipping}multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}" method="post" name="carrier_area">
{else}
	<div id="carrier_area" class="opc-main-block">
		<h1 class="page-heading step-num"><span>2</span> {l s='Delivery methods'}</h1>
			<div id="opc_delivery_methods" class="opc-main-block">
				<div id="opc_delivery_methods-overlay" class="opc-overlay" style="display: none;"></div>
{/if}
<div class="container clearfix">
	<div class="row no-gutter">
		<div class="order_carrier_content box col-sm-8 col-md-9 no-gutter">
			{if isset($virtual_cart) && $virtual_cart}
				<input id="input_virtual_carrier" class="hidden" type="hidden" name="id_carrier" value="0" />
		        <p class="alert alert-warning">{l s='No carrier is needed for this order.'}</p>
			{else}
				<div id="HOOK_BEFORECARRIER">
					{if isset($carriers) && isset($HOOK_BEFORECARRIER)}
						{$HOOK_BEFORECARRIER}
					{/if}
				</div>
				{if isset($isVirtualCart) && $isVirtualCart}
					<p class="alert alert-warning">{l s='No carrier is needed for this order.'}</p>
				{else}
					<div class="delivery_options_address" id="tabs">
						{if isset($delivery_option_list)}
							{foreach $delivery_option_list as $id_address => $option_list}
								
								<ul class="resp-tabs-list tab">
					      			{foreach $option_list as $key => $option}
						      			<li>
						      				<span class="name">
												{if $option.unique_carrier}
													{foreach $option.carrier_list as $carrier}
														<strong>{$carrier.instance->name|escape:'htmlall':'UTF-8'}</strong>
													{/foreach}
												{/if}
											</span>
											<span class="delivery_option_price">												
												{if $option.total_price_with_tax && !$option.is_free && (!isset($free_shipping) || (isset($free_shipping) && !$free_shipping))}
													<span class="delivery_option_price">
														{if $use_taxes == 1}
															{if $priceDisplay == 1}
																{convertPrice price=$option.total_price_without_tax}{if $display_tax_label} {l s='(tax excl.)'}{/if}
															{else}
																{convertPrice price=$option.total_price_with_tax}{if $display_tax_label} {l s='(tax incl.)'}{/if}
															{/if}
														{else}
															{convertPrice price=$option.total_price_without_tax}
														{/if}
													</span>
												{else}
													<span class="delivery_option_price free">
														{l s='Free'}
													</span>
												{/if}											
											<span class="delivery_option_radio hidden">
												<input id="delivery_option_{$id_address|intval}_{$option@index}" class="delivery_option_radio" type="radio" name="delivery_option[{$id_address|intval}]" data-key="{$key}" data-id_address="{$id_address|intval}" value="{$key}"/>
											</span>
						      			</li>
							      	{/foreach}							      	
					      		</ul>
								<div class="delivery_options resp-tabs-container tab">									
									{foreach $option_list as $key => $option name=options}
										<div class="delivery_option {if ($option@index % 2)}alternate_{/if}item">
											<div>
												{if $smarty.foreach.options.iteration == 1}
													<p style="color:#ec4040">
														<i class="fa fa-warning"></i> Attention, avec ce mode de livraison vous ne pourrez pas sélectionner le paiement Paypal à l’étape suivante!
													</p>
													<br>
													<p>Où nous trouver</p>													
													<div class="clearfix">
		             									<div id="map" style="width:100%;height:18em;background:#ececec;float:left;max-width:36em;margin:0 12px 12px 0" ></div>
		             									<p style="line-height: 1.5em" class="shop-info">
															<strong>Adresse :</strong><br>
															67 rue de Belleville 75019 Paris<br><br>
															<strong>Horaires :</strong><br>														
															Du Mardi au Vendredi de 11H à 13H30 / de 15H à 19H30<br>
															Samedi de 11H à 19H30<br>
															Dimanche 14h - 19H<br><br>
															<strong>Tel :</strong> +33(0)9 50 64 02 96<br><br>
														</p>
														<p>
															{if $option.unique_carrier}													
																{if isset($carrier.instance->delay[$cookie->id_lang])}
																	<strong>{l s='Delivery time:'}</strong>&nbsp;{$carrier.instance->delay[$cookie->id_lang]|escape:'htmlall':'UTF-8'}
																{/if}
															{/if}
														</p>
													</div>
												{elseif $smarty.foreach.options.iteration == 2}													
													<div class="addresses clearfix">
														<p style="color:#ec4040">
															<i class="fa fa-warning"></i> Attention, avec ce mode de livraison vous ne pourrez pas sélectionner le paiement en magasin à l’étape suivante!
														</p>
														<br>
														<div class="row hidden">
															<div class="col-xs-12 col-sm-6">
																<div class="address_delivery select form-group selector1">
																	<label for="id_address_delivery">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
																	<select name="id_address_delivery" id="id_address_delivery" class="address_select form-control">
																		{foreach from=$addresses key=k item=address}
																			<option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
																				{$address.alias|escape:'html':'UTF-8'}
																			</option>
																			{break}
																		{/foreach}
																	</select>
																</div>																
															</div>
														</div> <!-- end row -->
														<br>
														<div class="row addresses">															
															<div class="col-sm-12" {if $cart->isVirtualCart()} style="display:none;"{/if}>
																<span class="waitimage"></span>
																<ul class="address item box" id="address_delivery">
																
																</ul>
															</div>															
														</div> <!-- end row -->														
														<hr>
														<h3>Livraison recommandée</h3>
														<p><strong>Si vous souhaitez recevoir vos produits dans les 48h, cochez cette case</strong></p>
														<div class="checkbox">
															<label for="recyclable">
																<input type="checkbox" name="expresso" id="expresso" value="1"/>
																+ X € d'achat à rajouter à vos frais.
															</label>
														</div>
													</div> <!-- end addresses -->													
													<div id="address" class="hidden clearfix"></div>
												{elseif $smarty.foreach.options.iteration == 3}													
													<div class="addresses clearfix">
														<p style="color:#ec4040">
															<i class="fa fa-warning"></i> Attention, avec ce mode de livraison vous ne pourrez pas sélectionner le paiement en magasin à l’étape suivante!
														</p>
														<br>
														{if $addresses|@count gt 1}
															<div class="row">
																<div class="col-xs-12 col-sm-6">
																	<div class="address_delivery select form-group selector1">
																		<label for="id_address_delivery">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
																		<select name="id_address_delivery" id="id_address_delivery" class="address_select form-control">
																			{foreach from=$addresses key=k item=address name=addresses}
																				{if $smarty.foreach.addresses.iteration > 1}
																					<option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
																						{$address.alias|escape:'html':'UTF-8'}
																					</option>
																					{if $smarty.foreach.addresses.iteration == 3}
																						{assign var=maxAddresses value=true}
																						{break}
																					{/if}
																				{/if }
																			{/foreach}
																		</select><span class="waitimage"></span>
																	</div>																
																</div>
															</div> <!-- end row -->
															<br>
															<div class="row addresses">
																<div class="col-sm-12" {if $cart->isVirtualCart()} style="display:none;"{/if}>
																	<ul class="address item box" id="address_delivery">
																	
																	</ul>
																</div>
															</div> <!-- end row -->
														{else}
															<div class="row none">
																<div class="col-sm-12" {if $cart->isVirtualCart()} style="display:none;"{/if}>						<span class="waitimage"></span>		
																	<ul style="padding: 24px" class="address item box" id="address_delivery">
																		Aucune adresse secondaire à afficher
																	</ul>
																</div>																
															</div> <!-- end row -->
														{/if}
														<p class="address_add submit {if $maxAddresses}hidden{/if}" style="text-align: right">
															<a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="button button-small btn btn-default">
																<span>{l s='Add a new address'}<i class="icon-chevron-right right"></i></span>
															</a>
														</p>
														<hr>
														<h3>Livraison recommandée</h3>
														<p><strong>Si vous souhaitez recevoir vos produits dans les 48h, cochez cette case</strong></p>
														<div class="checkbox">
															<label for="recyclable">
																<input type="checkbox" name="expresso" id="expresso" value="1"/>
																+ X € d'achat à rajouter à vos frais.
															</label>
														</div>
													</div> <!-- end addresses -->													
													<div id="address" class="hidden clearfix"></div>
												{else}
													{if !$advanced_payment_api && ((!empty($delivery_option) && (!isset($isVirtualCart) || !$isVirtualCart)) OR $delivery->id || $invoice->id) && !$opc}
														<div class="order_delivery clearfix row">
															{if !isset($formattedAddresses) || (count($formattedAddresses.invoice) == 0 && count($formattedAddresses.delivery) == 0) || (count($formattedAddresses.invoice.formated) == 0 && count($formattedAddresses.delivery.formated) == 0)}
																{if $delivery->id}
																	<div class="col-xs-12 col-sm-6"{if $cart->isVirtualCart()} style="display: none;"{/if}>
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
																	<div class="col-xs-12 col-sm-6"{if $k == 'delivery' && $cart->isVirtualCart()} style="display: none;"{/if}>
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
										        {/if}
												{if !$option.unique_carrier}
													<table class="delivery_option_carrier{if isset($delivery_option[$id_address]) && $delivery_option[$id_address] == $key} selected{/if} resume table table-bordered{if $option.unique_carrier} hide{/if}">
														<tr>
															{if !$option.unique_carrier}
																<td rowspan="{$option.carrier_list|@count}" class="delivery_option_radio first_item">
																	<input id="delivery_option_{$id_address|intval}_{$option@index}" class="delivery_option_radio" type="radio" name="delivery_option[{$id_address|intval}]" data-key="{$key}" data-id_address="{$id_address|intval}" value="{$key}"{if isset($delivery_option[$id_address]) && $delivery_option[$id_address] == $key} checked="checked"{/if} />
																</td>
															{/if}
															{assign var="first" value=current($option.carrier_list)}
															<td class="delivery_option_logo{if $first.product_list[0].carrier_list[0] eq 0} hide{/if}">
																{if $first.logo}
																	<img class="order_carrier_logo" src="{$first.logo|escape:'htmlall':'UTF-8'}" alt="{$first.instance->name|escape:'htmlall':'UTF-8'}"/>
																{elseif !$option.unique_carrier}
																	{$first.instance->name|escape:'htmlall':'UTF-8'}
																{/if}
															</td>
															<td class="{if $option.unique_carrier}first_item{/if}{if $first.product_list[0].carrier_list[0] eq 0} hide{/if}">
																<input type="hidden" value="{$first.instance->id|intval}" name="id_carrier" />
																{if isset($first.instance->delay[$cookie->id_lang])}
																	<i class="icon-info-sign"></i>
																	{strip}
																		{$first.instance->delay[$cookie->id_lang]|escape:'htmlall':'UTF-8'}
																		&nbsp;
																		{if count($first.product_list) <= 1}
																			({l s='For this product:'}
																		{else}
																			({l s='For these products:'}
																		{/if}
																	{/strip}
																	{foreach $first.product_list as $product}
																		{if $product@index == 4}
																			<acronym title="
																		{/if}
																		{strip}
																			{if $product@index >= 4}
																				{$product.name|escape:'htmlall':'UTF-8'}
																				{if isset($product.attributes) && $product.attributes}
																					{$product.attributes|escape:'htmlall':'UTF-8'}
																				{/if}
																				{if !$product@last}
																					,&nbsp;
																				{else}
																					">&hellip;</acronym>)
																				{/if}
																			{else}
																				{$product.name|escape:'htmlall':'UTF-8'}
																				{if isset($product.attributes) && $product.attributes}
																					{$product.attributes|escape:'htmlall':'UTF-8'}
																				{/if}
																				{if !$product@last}
																					,&nbsp;
																				{else}
																					)
																				{/if}
																			{/if}
																		{/strip}
																	{/foreach}
																{/if}
															</td>
															<td rowspan="{$option.carrier_list|@count}" class="delivery_option_price">
																<div class="delivery_option_price">
																	{if $option.total_price_with_tax && !$option.is_free && (!isset($free_shipping) || (isset($free_shipping) && !$free_shipping))}
																		{if $use_taxes == 1}
																			{if $priceDisplay == 1}
																				{convertPrice price=$option.total_price_without_tax}{if $display_tax_label} {l s='(tax excl.)'}{/if}
																			{else}
																				{convertPrice price=$option.total_price_with_tax}{if $display_tax_label} {l s='(tax incl.)'}{/if}
																			{/if}
																		{else}
																			{convertPrice price=$option.total_price_without_tax}
																		{/if}
																	{else}
																		{l s='Free'}
																	{/if}
																</div>
															</td>
														</tr>
														{foreach $option.carrier_list as $carrier}
															{if $carrier@iteration != 1}
															<tr>
																<td class="delivery_option_logo{if $carrier.product_list[0].carrier_list[0] eq 0} hide{/if}">
																	{if $carrier.logo}
																		<img class="order_carrier_logo" src="{$carrier.logo|escape:'htmlall':'UTF-8'}" alt="{$carrier.instance->name|escape:'htmlall':'UTF-8'}"/>
																	{elseif !$option.unique_carrier}
																		{$carrier.instance->name|escape:'htmlall':'UTF-8'}
																	{/if}
																</td>
																<td class="{if $option.unique_carrier} first_item{/if}{if $carrier.product_list[0].carrier_list[0] eq 0} hide{/if}">
																	<input type="hidden" value="{$first.instance->id|intval}" name="id_carrier" />
																	{if isset($carrier.instance->delay[$cookie->id_lang])}
																		<i class="icon-info-sign"></i>
																		{strip}
																			{$carrier.instance->delay[$cookie->id_lang]|escape:'htmlall':'UTF-8'}
																			&nbsp;
																			{if count($first.product_list) <= 1}
																				({l s='For this product:'}
																			{else}
																				({l s='For these products:'}
																			{/if}
																		{/strip}
																		{foreach $carrier.product_list as $product}
																			{if $product@index == 4}
																				<acronym title="
																			{/if}
																			{strip}
																				{if $product@index >= 4}
																					{$product.name|escape:'htmlall':'UTF-8'}
																					{if isset($product.attributes) && $product.attributes}
																						{$product.attributes|escape:'htmlall':'UTF-8'}
																					{/if}
																					{if !$product@last}
																						,&nbsp;
																					{else}
																						">&hellip;</acronym>)
																					{/if}
																				{else}
																					{$product.name|escape:'htmlall':'UTF-8'}
																					{if isset($product.attributes) && $product.attributes}
																						{$product.attributes|escape:'htmlall':'UTF-8'}
																					{/if}
																					{if !$product@last}
																						,&nbsp;
																					{else}
																						)
																					{/if}
																				{/if}
																			{/strip}
																		{/foreach}
																	{/if}
																</td>
															</tr>
															{/if}
														{/foreach}
													</table>
												{/if}
											</div>
										</div> <!-- end delivery_option -->
									{/foreach}
								</div> <!-- end delivery_options -->
								<div class="hook_extracarrier" id="HOOK_EXTRACARRIER_{$id_address}">
									{if isset($HOOK_EXTRACARRIER_ADDR) &&  isset($HOOK_EXTRACARRIER_ADDR.$id_address)}{$HOOK_EXTRACARRIER_ADDR.$id_address}{/if}
								</div>
								{foreachelse}
									{assign var='errors' value=' '|explode:''}
									<p class="alert alert-warning" id="noCarrierWarning">
										{foreach $cart->getDeliveryAddressesWithoutCarriers(true, $errors) as $address}
											{if empty($address->alias)}
												{l s='No carriers available.'}
											{else}
												{assign var='flag_error_message' value=false}
												{foreach $errors as $error}
													{if $error == Carrier::SHIPPING_WEIGHT_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s): it is too heavy. Please amend your cart to lower its weight.'}
													{elseif $error == Carrier::SHIPPING_PRICE_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s). Please amend your cart.'}
													{elseif $error == Carrier::SHIPPING_SIZE_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s): its size does not fit. Please amend your cart to reduce its size.'}
													{/if}
												{/foreach}
												{if !$flag_error_message}
													{l s='No carriers available for the address "%s".' sprintf=$address->alias}
												{/if}
											{/if}
											{if !$address@last}
												<br />
											{/if}
										{foreachelse}
											{l s='No carriers available.'}
										{/foreach}
									</p>
								{/foreach}
							{/if}
						</div> <!-- end delivery_options_address -->
						<div id="extra_carrier" style="display: none;"></div>
						{if $opc}
							<p class="carrier_title">{l s='Leave a message'}</p>
							<div>
								<p>{l s='If you would like to add a comment about your order, please write it in the field below.'}</p>
								<textarea class="form-control" cols="120" rows="2" name="message" id="message">{strip}
									{if isset($oldMessage)}{$oldMessage|escape:'html':'UTF-8'}{/if}
								{/strip}</textarea>
							</div>
						{/if}
						{if $recyclablePackAllowed}
							<p class="carrier_title">{l s='Recyclable Packaging'}</p>
							<div class="checkbox recyclable">
								<label for="recyclable">
									<input type="checkbox" name="recyclable" id="recyclable" value="1"{if $recyclable == 1} checked="checked"{/if} />
									{l s='I would like to receive my order in recycled packaging.'}
								</label>
							</div>
						{/if}
						{if $giftAllowed}
							{if $opc}
								<hr style="" />
							{/if}
							<p class="carrier_title">{l s='Gift'}</p>
							<div class="checkbox gift">
								<input type="checkbox" name="gift" id="gift" value="1"{if $cart->gift == 1} checked="checked"{/if} />
								<label for="gift">
									{l s='I would like my order to be gift wrapped.'}
									{if $gift_wrapping_price > 0}
										&nbsp;<i>({l s='Additional cost of'}
										<span class="price" id="gift-price">
											{if $priceDisplay == 1}
												{convertPrice price=$total_wrapping_tax_exc_cost}
											{else}
												{convertPrice price=$total_wrapping_cost}
											{/if}
										</span>
										{if $use_taxes && $display_tax_label}
											{if $priceDisplay == 1}
												{l s='(tax excl.)'}
											{else}
												{l s='(tax incl.)'}
											{/if}
										{/if})
										</i>
									{/if}
								</label>
							</div>
							<p id="gift_div">
								<label for="gift_message">{l s='If you\'d like, you can add a note to the gift:'}</label>
								<textarea rows="2" cols="120" id="gift_message" class="form-control" name="gift_message">{$cart->gift_message|escape:'html':'UTF-8'}</textarea>
							</p>
						{/if}
						{/if}
					{/if}
					{if $conditions && $cms_id && (! isset($advanced_payment_api) || !$advanced_payment_api)}
						{if $opc}
							<hr style="" />
						{/if}
		                {if isset($override_tos_display) && $override_tos_display}
		                    {$override_tos_display}
		                {else}
		                    <div class="box hidden">
		                        <p class="checkbox">
		                            <input type="checkbox" name="cgv" id="cgv" value="1" checked {if $checkedTOS}checked="checked"{/if} />
		                            <label for="cgv">{l s='I agree to the terms of service and will adhere to them unconditionally.'}</label>
		                            <a href="{$link_conditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='(Read the Terms of Service)'}</a>
		                        </p>
		                    </div>
		                {/if}
					{/if}
				</div> <!-- end delivery_options_address -->
		{if !$opc}
				<div class="cart_navigation clearfix  col-sm-4 col-md-3 ">
					<input type="hidden" name="step" value="3" />
					<input type="hidden" name="back" value="{$back}" />
					{if !$is_guest}
						{if $back}
							<a href="{$link->getPageLink('order', true, NULL, "step=1&back={$back}{if $multi_shipping}&multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="button-exclusive btn btn-default hidden">
								<i class="icon-chevron-left"></i>
								{l s='Continue shopping'}
							</a>
						{else}
							<a href="{$link->getPageLink('order', true, NULL, "step=1{if $multi_shipping}&multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="button-exclusive btn btn-default hidden">
								<i class="icon-chevron-left"></i>
								{l s='Continue shopping'}
							</a>
						{/if}
					{else}
						<a href="{$link->getPageLink('order', true, NULL, "{if $multi_shipping}multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="button-exclusive btn btn-default hidden">
							<i class="icon-chevron-left"></i>
							{l s='Continue shopping'}
						</a>
					{/if}
					{if isset($virtual_cart) && $virtual_cart || (isset($delivery_option_list) && !empty($delivery_option_list))}
						<button type="submit" name="processCarrier" class="button btn btn-default standard-checkout button-medium">
							<span>
								{l s='Proceed to checkout'}
								<i class="icon-chevron-right right"></i>
							</span>
						</button>
					{/if}
				</div>
			</div>
		</div>
	</form>
{else}
	</div> <!-- end opc_delivery_methods -->
{/if}
</div> <!-- end carrier_area -->
{strip}
{if !$opc}
	{addJsDef orderProcess='order'}
	{if isset($virtual_cart) && !$virtual_cart && $giftAllowed && $cart->gift == 1}
		{addJsDef cart_gift=true}
	{else}
		{addJsDef cart_gift=false}
	{/if}
	{addJsDef orderUrl=$link->getPageLink("order", true)|escape:'quotes':'UTF-8'}
	{addJsDefL name=txtProduct}{l s='Product' js=1}{/addJsDefL}
	{addJsDefL name=txtProducts}{l s='Products' js=1}{/addJsDefL}
{/if}
{if $conditions}
	{addJsDefL name=msg_order_carrier}{l s='You must agree to the terms of service before continuing.' js=1}{/addJsDefL}
{/if}
{capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
{capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
{addJsDef addressUrl=$smarty.capture.addressUrl}
{capture}{'&multi-shipping=1'|urlencode}{/capture}
{addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
{capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
{addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
{addJsDef formatedAddressFieldsValuesList=$formatedAddressFieldsValuesList}
{addJsDef opc=$opc|boolval}
{capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
{addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
{addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<a class="btn btn-default" style="position:absolute;top:6px;right:12px;font-size:20px" href="{$smarty.capture.addressUrlAdd}" title="{l s='Update' js=1}"><span><i class="fa fa-edit"></i></span></a>{/capture}
{addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{if isset($idSelectedState)}
	{addJsDef idSelectedState=$idSelectedState}
{/if}
{if isset($idSelectedCountry)}
	{addJsDef idSelectedCountry=$idSelectedCountry}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{/strip}
<script>
	$('#tabs').easyResponsiveTabs({
	  type: 'accordion', //Types: default, vertical, accordion
	  width: 'auto', //auto or any width like 600px
	  fit: true, // 100% fit in a container
	  closed: 'accordion', // Start closed if in accordion view
	  tabidentify: 'tab', // The tab groups identifier
	  activate: function() {	  	
	  	$('input[type=radio]',this).trigger('click');
	  	initMap();
	  }
	});	
	$('input[type=radio]').click(function(event){
		$(this).attr("checked","checked");
		event.stopPropagation();		
	});
	function initMap(){
		if(document.getElementById('map')){
			var latLong = {
				lat: 48.873509 , lng: 2.382527
			};
			var center = {
				lat: 48.873499 , lng: 2.382627
			};
			var map = new google.maps.Map(document.getElementById('map'), {
			  center: center,
			  zoom: 20
			});
			var marker = new google.maps.Marker({
			  position: latLong,
			  map: map
			});
		}		
	}
	ajaxAddressSetup(); 
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDnIXYJYTobkgB_9Nr1AEeGn84d_KPM74c&callback=initMap&language=fr&region=SN" async defer></script>
