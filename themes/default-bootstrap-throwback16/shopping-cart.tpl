{*
* 2017 SNE
*
*  @author Abdou Khadre
*}

{capture name=path}{l s='Your shopping cart'}{/capture}


{if isset($account_created)}
	<p class="alert alert-success">
		{l s='Your account has been created.'}
	</p>
{/if}

{assign var='current_step' value='summary'}

{include file="$tpl_dir./errors.tpl"}

{if !isset($smarty.get.step) }
	<script>window.location="{$link->getPageLink('order')}?step=0";</script>
{/if}

<p class="titre-panier ">{l s='Mon panier'}</p>

{if isset($empty)}
	{if isset($smarty.get.update) && $smarty.get.update =="1"}
		<script>window.location="{$link->getPageLink('order')}?step=0";</script>
	{else}

	<p class="panier-vide">{l s='Your shopping cart is empty.'}<br>
		{l s='Pour passer une commande, veuillez vous connecter et ajouter des articles dans votre panier.'}<br>
		{l s='Si vous ne disposez pas de compte throwback'} <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}"> {l s='créer votre compte'}</a> {l s='rapidement!'} 
	</p>
	<div class"redirect_home">

		<a href="{$base_dir}index.php" class=" btn btn-dark text-center"><i class="icon-chevron-left left"></i> <span class="text-shoping">{l s='Continuer mon shopping'}</span></a>

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


		<div class="row">
			<div class="col-xs-12 col-md-8">
					{assign var='odd' value=0}
					{assign var='have_non_virtual_products' value=false}
					{foreach $products as $product}
						{assign var="productId" value=$product.id_product}
						{assign var="attributes" value=$product.attributes_small}
						{assign var="split_size" value=","|explode:$attributes}

						{* <pre>{$attributes|print_r}</pre>
						<pre>{$split_size[0]|print_r}</pre>
						<pre>{$split_size[1]|print_r}</pre> *}
						{*
							{if isset($split_size[0]) }
									{assign var="sizing" value=$split_size[0]|trim}
							{/if}

							{if isset($split_size[1]) }
									{assign var="coloring" value=$split_size[1]|trim}
									{else}
									{assign var="coloring" value=null}
							{/if}
						*}
						{if isset($split_size[1]) }
								{assign var="sizing" value=$split_size[1]|trim}

								{if isset($split_size[0]) }
									{assign var="coloring" value=$split_size[0]|trim}
								{else}
									{assign var="coloring" value=null}
								{/if}

						{else}
								{assign var="sizing" value=$split_size[0]|trim}
								{assign var="coloring" value=null}
						{/if}

						{$attributeCombinaison[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $combinations[$product.id_product]}

						{$qtyAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.quantity_available}

						{$qtyLimitedAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.stock_quantity}

				<div class="row row_line_product line_product_{$product.id_product}" id="product_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}">


							<div class="col-xs-12 col-sm-3 col-md-3  img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">
								{* change product image format : from small_default_to_home default *}
								<img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" class="img-responsive" />
								</a>
							</div>


							<div class="col-xs-12 col-sm-9 col-md-9 product-attribute-line">								

								<div class="row">
									<div class="col-xs-9 col-sm-10 col-md-11">

										<p class="product-name product_title">
											<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.name|escape:'html':'UTF-8'}
											</a>
										</p>
									</div>

										{* Disable Edit option if color is set *}
										{assign var=isColorAttribute value=false}
										{if isset($groups)}
											{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
																				{if $group.attributes|@count}
																					{if ($group.group_type == 'color') || ($group.group_type == 'select')}
																							{assign var=isColorAttribute value=true}
																					{/if}
																				{/if}
											{/foreach}
										{/if}

									<div class="col-xs-3 col-sm-2 col-md-1 ">
									{* <div class="row"><pre>{$isColorAttribute}</pre></div> *}
										<div class="row">
											{if $isColorAttribute ==! 1}
												<div class="col-md-6 col-xs-6 text-md-right text-xs-center edit" style="padding:0;">
													<a id="edit-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" title="Modifier l'article" class="edit_a"><i class="fa fa-pencil-square-o icone-update icone-active" aria-hidden="true"></i></a>
												</div>
											{else}
													<div class="col-md-6 col-xs-6 text-md-right text-xs-center edit" style="padding:0;">
													{* <a class="edit_a" style="pointer-events: none; cursor: default;"><i class="fa fa-pencil-square-o icone-update" aria-hidden="true"></i></a> *}
												</div>
											{/if}
											<div class="col-md-6 col-xs-6 text-md-left text-xs-center delete" style="padding:0;">
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
                                {foreach from=$product.features item=feature}
                                    {if (isset($feature["id_feature"]) && $feature["id_feature"] eq '11') && $feature["id_feature_value"] eq '41'}
                                        {assign var=quantitylimitperorder value=1}
                                    {/if}
                                 {/foreach}

								<div class="row">

									<div class="col-md-12 col-xs-12 product_attributes line_attributes clearfix">

										{addJsDef quantityAvailable=$product.quantity_available}
										<div class="row">

											<div class="col-md-4 col-xs-12">
												<p id="quantity_wanted_p" class="quantity_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
													<label>{l s='Quantité'}</label><br>
													<input type="text" readonly min="1" name="qty" id="quantity_wanted_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="text" value="{$product.cart_quantity}" />
													<a href="#" data-field-qty="qty" id="down-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="btn btn-default button-minus product_quantity_down {if isset($quantitylimitperorder) && $quantitylimitperorder==1}disabled{/if}">
														<span><i class="icon-minus"></i></span>
													</a>
													<a href="#" data-field-qty="qty" id="up-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" class="btn btn-default button-plus product_quantity_up {if isset($quantitylimitperorder) && $quantitylimitperorder==1}disabled{/if}">
														<span><i class="icon-plus"></i></span>
													</a>
												</p>
											</div>

											<div class="col-md-8 col-xs-12">
												<div class="attributes_to_modify_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
														<div class="row">
															{if isset($groups) && $groups}
															<div class="customattributes groups-attribute">
																<div id="attributes">
																	<div class="attribute_list custom-attribute">
																		{if isset($groups[$product.id_product]) && $groups[$product.id_product]}
																		<label class="attribute_label" >{l s='Taille'}</label>
																		{/if}
																		{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
																			{if $group.attributes|@count}

																				{assign var="groupName" value="group_"|cat:$productId|cat:"_"|cat:$product.id_product_attribute}

																				<div class="attribute_list">

																				{if ($group.group_type == 'select')}
																				
																					<select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="form-control attribute_select no-print">
																						{foreach from=$group.attributes key=id_attribute item=group_attribute}
																							<option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
																						{/foreach}
																					</select>	
																				
																				{elseif ($group.group_type == 'radio')}
																						<ul>
																						<span class="btn" style="display: inherit;">
																							{foreach from=$group.attributes key=id_attribute item=group_attribute}


																								<li {if ( $group.attributes_quantity[$id_attribute] <=0 )  } class="li_attribute_list disabled" {/if}>

																									<label for="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}-{$id_attribute}">
																									<input type="radio" id="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}-{$id_attribute}" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}"
																									{if ($group_attribute == $sizing)} checked="checked"{/if} />																									

																									{assign var=size_keywords value=" / "|explode:$group_attribute}

																									<span class="hide_size eu_size" {if $lang_iso=='fr'} style="display: inline;" {else} style="display: none;" {/if}>
																										{if isset($size_keywords[0])}
																											{assign var=size_keywords_eu_trimed value=$size_keywords[0]|trim}
																											{assign var=size_keywords_eu value=" "|explode:$size_keywords_eu_trimed}
																											{assign var=size_keywords_eu_sup value="."|explode:$size_keywords_eu[1]}
																											{$size_keywords_eu_sup[0]|escape:'html':'UTF-8'}
																											{if isset($size_keywords_eu_sup[1])}<sup>{$size_keywords_eu_sup[1]|escape:'html':'UTF-8'}</sup> {/if}
																										{/if}
																									</span>

																									<span class="hide_size us_size" {if $lang_iso=='en'} style="display: inline;" {else} style="display: none;" {/if}>
																										{if isset($size_keywords[1])}
																											{assign var=size_keywords_us_trimed value=$size_keywords[1]|trim}
																											{assign var=size_keywords_us value=" "|explode:$size_keywords_us_trimed}
																											{$size_keywords_us[1]|escape:'html':'UTF-8'}
																										{/if}
																									</span>

																              		<span class="hide_size uk_size" style="display: none;">
																              			{if isset($size_keywords[2])}
																											{assign var=size_keywords_uk_trimed value=$size_keywords[2]|trim}
																											{assign var=size_keywords_uk value=" "|explode:$size_keywords_uk_trimed}
																											{$size_keywords_uk[1]|escape:'html':'UTF-8'}
																										{/if}
																              		</span>

																              		<span class="hide_size cm_size" style="display: none;">
																              			{if isset($size_keywords[3])}
																											{assign var=size_keywords_cm_trimed value=$size_keywords[3]|trim}
																											{assign var=size_keywords_cm value=" "|explode:$size_keywords_cm_trimed}
																											{$size_keywords_cm[0]|substr:0:-2|escape:'html':'UTF-8'}
																										{/if}
																              		</span> 

																									

																									</label>


																								</li>
																							{/foreach}
																						</ul>
																						</span>
																						{* <pre>{$product|var_dump}</pre> *}

																					{* todo color not allowed *}
																					{* {elseif ($group.group_type == 'color')}
																						<div class="defautColor_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
																						<input type="hidden" name="color_default" value="{$group.default|intval}" />
																						</div> *}

																					{/if}

																				</div> <!-- end attribute_list -->
																			{/if}
																		{/foreach}

																	</div>
																</div>
																<div class="combinaison_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
																		<input type="hidden" name="combinaison_default" value="" />
																</div>
															</div>
															{/if}
														</div>
													</div>
												</div>
										</div>
										<div class="row vertical-center attributes_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">

											<div class="col-md-3 col-xs-12">
												{if $product.cart_quantity}
													<div class = "row">
														<div class="col-sm-6 col-md-6 col-xs-12 text-sm-right text-md-right text-lg-right">
																<label class="label-attribute ">{l s='Quantité'}</label>
														</div>
														<div class="col-md-6 col-sm-6 col-xs-12">
																<div class="current_qty_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} size_line">
																	{$product.cart_quantity}
																</div>
														</div>
													</div>

												{/if}
											</div>



											<div class="col-md-3 col-xs-12">
												{if isset($sizing) && $sizing}
													<div class = "row">
														<div class="col-md-6 col-sm-6 col-xs-12 text-sm-right text-md-right text-lg-right">
															<label class="label-attribute">{l s='Taille'}</label>
														</div>
														<div class="col-md-6 col-sm-6 col-xs-12">
															<div class="size_line">
															{assign var=size_keywords value=" / "|explode:$sizing}
															{if {$size_keywords|@count} == 1}
																{$size_keywords[0]|escape:'html':'UTF-8'}
															{else}
																{if $lang_iso=='fr'}
																		{if isset($size_keywords[0])}
																					{assign var=size_keywords_eu_trimed value=$size_keywords[0]|trim}
																					{assign var=size_keywords_eu value=" "|explode:$size_keywords_eu_trimed}
																					{assign var=size_keywords_eu_sup value="."|explode:$size_keywords_eu[1]}
																					{$size_keywords_eu_sup[0]|escape:'html':'UTF-8'}
																					{if isset($size_keywords_eu_sup[1])}<sup>{$size_keywords_eu_sup[1]|escape:'html':'UTF-8'}</sup> {/if}
																		{/if}
																{else}
																		{if isset($size_keywords[1])}
																					{assign var=size_keywords_us_trimed value=$size_keywords[1]|trim}
																					{assign var=size_keywords_us value=" "|explode:$size_keywords_us_trimed}
																					{$size_keywords_us[1]|escape:'html':'UTF-8'}
																		{/if}
																{/if}																	
															{/if}														
															</div>
														</div>
													</div>
												{/if}
											</div>

											<div class="col-md-3 col-xs-12">
												{if isset($coloring)}
													<div class = "row">
														<div class="col-md-6 col-xs-6 text-right hidden-xs">
																<label class="label-attribute">{l s='Couleur'}</label>
														</div>
														<div class="col-md-6 col-xs-6">
																<div class="size_line">
																	{$coloring}
																</div>
														</div>
													</div>
												{/if}
											</div>

											<div class="col-md-3 col-xs-12">
												{if !$priceDisplay}
													<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if} price product-price price-prod">{convertPrice price=$product.price_wt}</span>
												{else}
								               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if} price product-price price-prod">{convertPrice price=$product.price}</span>
												{/if}
												{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}

												{* 													
												<span class="reduction-text price product-price price-prod">
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
													*}

													<span class="old-price">{convertPrice price=$product.price_without_specific_price}</span>

												{/if}
											</div>
										</div>
										{* end row atributes *}

									</div>
								<!-- loader -->
									<div id="spin_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}">
									</div>

								</div>
								<div class="row">
									<div class="col-md-12 col-xs-12 margin-top-10">
										<span class="{if isset($product.available_now) && $product.available_now}dispo-text{else}dispo-text{/if}">{if $product.quantity_available <= 0}{if isset($product.allow_oosp) && $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='Disponible'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{l s='Disponible'}{else}{l s='Disponible'}{/if}{/if}
										</span>
									</div>
								</div>
								<div class="row buttons_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" style="display: none">
										<div class="col-md-6 col-xs-6 text-right">
											<button class="btn disabled buttons_modify buttons_modify_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} update_line" type="submit">
											<span>{l s='VALIDER'}</span>
											</button>
										</div>
										<div class="col-md-6 col-xs-6">
											<button class="buttons_modify buttons_cancel_line_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} cancel-line" type="submit">
											<span>{l s='ANNULER'}</span>
											</button>
										</div>


								</div>
							</div>


						</div>

						{* RESET limit quantity *}
						{if isset($quantitylimitperorder)}
							{assign var=quantitylimitperorder value=""}
						{/if}

					{/foreach}

					{* ********************************************************
								GESTION DES BONS DE REDUCTION
								********************************************************* *}
								{if $use_taxes}
								{if $priceDisplay}
									<tr class="row scart_total_price">
										<td rowspan="{$rowspan_total}" colspan="3" id="cart_voucher" class="cart_voucher">
											{if $voucherAllowed}
											<form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}?step=0{/if}" method="post" id="voucher">
												<fieldset>
													<h4>{l s='Vouchers'}</h4>
													<input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
													<input type="hidden" name="submitDiscount" />
													<button type="submit" name="submitAddDiscount" class="button btn btn-default button-small"><span>{l s='OK'}</span></button>
												</fieldset>
											</form>
											{if $displayVouchers}
											<p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
											<div id="display_cart_vouchers">
												{foreach $displayVouchers as $voucher}
												{if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br />
												{/foreach}
											</div>
											{/if}
											{/if}
										</td>
									                    {* 
	                    <td colspan="{$col_span_subtotal}" class="text-right">{if $display_tax_label}{l s='Total products (tax excl.)'}{else}{l s='Total products'}{/if}</td>
	                    <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td>
	                    *}
	                 </tr>
                	{else}
		                  <tr class="cart_total_price">
		                  	<td rowspan="{$rowspan_total}" colspan="2" id="cart_voucher" class="cart_voucher">
		                  		{if $voucherAllowed}
		                  		<div class="row line_product" style="margin-left: 0;">
			                  		<form class=""  action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}?step=0{/if}" method="post" id="voucher">
			                  			<fieldset>
			                  			<div class="row" style="margin-top: 10px;">
			                  			<div class="col-xs-12 col-md-7 text-md-right" style="padding-right: 0;">
			                  				<h5>{l s='Vouchers'}</h5>	
			                  				</div>                  				
				                  				<div class="col-xs-9 col-md-4 text-md-right" style="padding-right: 0;">
					                  				<input type="text" style="" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
					                  				<input type="hidden" name="submitDiscount" />
					                  			</div>
					                  			<div class="col-xs-3 col-md-1 text-md-left" style="padding: 0;">
					                  				<button style="" type="submit" name="submitAddDiscount" class="button btn btn-default button-small"><span>{l s='OK'}</span></button>
					                  			</div>
			                  				</div>
			                  			</fieldset>
			                  			
			                  		</form>
			                  		{if $displayVouchers}
				                  		<p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
				                  		<div id="display_cart_vouchers">
				                  			{foreach $displayVouchers as $voucher}
				                  			{if $voucher.code != ''}
				                  				<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">
				                  					{$voucher.code|escape:'html':'UTF-8'}
				                  				</span> - 
				                  			{/if}
				                  			{$voucher.name}<br />
				                  			{/foreach}
				                  		</div>
			                  		{/if}
			                  		</div>
		                  		{/if}
		                  	</td>
		                    {* 
		                    <td colspan="{$col_span_subtotal}" class="text-right">{if $display_tax_label}{l s='Total products (tax incl.)'}{else}{l s='Total products'}{/if}</td>
		                    <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products_wt}</td> 
		                    *}
		                  </tr>
                  {/if}
                  {else}
                  <tr class="cart_total_price">
                  	<td rowspan="{$rowspan_total}" colspan="2" id="cart_voucher" class="cart_voucher">
                  		{if $voucherAllowed}
                  		<form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher">
                  			<fieldset>
                  				<h4>{l s='Vouchers'}</h4>
                  				<input type="text" class="discount_name form-control" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
                  				<input type="hidden" name="submitDiscount" />
                  				<button type="submit" name="submitAddDiscount" class="button btn btn-default button-small">
                  					<span>{l s='OK'}</span>
                  				</button>
                  			</fieldset>
                  		</form>
                  		{if $displayVouchers}
                  		<p id="title" class="title-offers">{l s='Take advantage of our exclusive offers:'}</p>
                  		<div id="display_cart_vouchers">
                  			{foreach $displayVouchers as $voucher}
                  			{if $voucher.code != ''}<span class="voucher_name" data-code="{$voucher.code|escape:'html':'UTF-8'}">{$voucher.code|escape:'html':'UTF-8'}</span> - {/if}{$voucher.name}<br />
                  			{/foreach}
                  		</div>
                  		{/if}
                  		{/if}
                  	</td>
                {* 
                <td colspan="{$col_span_subtotal}" class="text-right">{l s='Total products'}</td>
                <td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td> 
                *}
              </tr>
              {/if}
              

				</div>



{* **********************************************************
* FACTURETTE
*************************************************************** *}
				<div class="col-md-4 col-xs-12">
					<div class="row commande_title text-center">
						<div class="col-md-12 col-xs-12">
							{l s='VOTRE COMMANDE'}
						</div>
					</div>
					<div class="row commande_body">
						{foreach $products as $product}
						<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande">
								<div class="col-md-8 col-xs-8">
									<p class="command-product-name">{$product.name|escape:'html':'UTF-8'}</p>
								</div>

								<div class="col-md-4 col-xs-4 text-right">
									<span class="price-line" id="total_product_price_{$product.id_product}_{$product.id_product_attribute}_0">
										{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$product.total}{/if}
									</span>
								</div>
						</div>
						{/foreach}

						<input type="hidden" class="my" name="price_add" value="" />
						<input type="hidden" class="you" name="total_add" value="" />

						{* BON DE REDUCTION*}
						{if $voucherAllowed}
							<div class="row line_product">
								<div class="col-lg-8 col-md-7 col-xs-8">
									<p class="command-product-name total">									
											{* 
											{if $display_tax_label}
												{if $use_taxes && $priceDisplay == 0}
													{l s='Total vouchers (tax incl.)'}
												{else}
													{l s='Total vouchers (tax excl.)'}
												{/if}
											{else} 
											*}
												{l s='Total vouchers'}
											{* 
											{/if} 
											*}
										</p>
								</div>
								<div class="col-lg-4 col-md-5 col-xs-4 text-right total">										
									<span class="price-line" id="total_price">
										{if $use_taxes && $priceDisplay == 0}
											{assign var='total_discounts_negative' value=$total_discounts * -1}
										{else}
											{assign var='total_discounts_negative' value=$total_discounts_tax_exc * -1}
										{/if}
											{displayPrice price=$total_discounts_negative}
								</div>
							</div>
							<br>
						{/if}

						<div class="row line_product">
								<div class="col-md-8 col-xs-8">
									<p class="command-product-name total">{l s='Total'|upper}</p>
								</div>
								{* frais de livraison *}
								{if isset($shippingCost)}
										{assign var=frais_livraison value=$shippingCost}
									{else}
											{assign var=frais_livraison value=0}
									{/if}
								<div class="col-md-4 col-xs-4 text-right total">
										{if $use_taxes}
										<span class="price-line" id="total_price">{displayPrice price=$total_price-$frais_livraison}</span>
										{else}
										<span class="price-line" id="total_price">{displayPrice price=$total_price_without_tax-$frais_livraison}</span>
										{/if}
								</div>
						</div>


							{* ********************************************************
								somme à atteindre pour la gratuité de la livraison
							********************************************************* *}
							<div class="row text-center" id="rest_shipping_message" {if $total_price >= 100}	style="display: none;"{/if}>
								<hr style="width: 90%; border-color: #dbdbdb;">
								<div class="col-xs-12">
									<p style="color:#40ec40">
									<span class="price-line" id="rest_shipping_message_total_price">{displayPrice price=100-($total_price-$frais_livraison)}</span>
									{l s=' restant pour obtenir la livraison gratuite'}
									</p>
								</div>
							</div>
							<div class="row line_product" id="free_shipping_message" {if $total_price < 100}	style="display: none;"{/if}>
								<hr style="width: 90%; border-color: #dbdbdb;">
								{* <div class="col-xs-12"> <p id ="fMessage"> {l s='Livraison gratuite (en europe)'} </p> </div> *}
								<div class="col-md-8 col-xs-6">
									<p class="command-product-name total"><span>{l s='FRAIS DE PORT'}</span></p>
								</div>
								<div class="col-md-4 col-xs-6 text-right total">
										<span id="total_price" style="color:#40ec40">GRATUIT</span>
								</div>		
							</div>						

					{* END DIV FIRST BLOC *}
					</div>

							{* ********************************************************
								BOUTON COMMANDER
							********************************************************* *}					
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
						<div class="col-md-12 cart_navigation">

							<a href="{$base_dir}index.php" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'}">
								<i class="icon-chevron-left"></i>{l s='Continuer mon shopping'}
							</a>

						</div>
					</div>
				</div>

		</div>

	




	{if $show_option_allow_separate_package}
	<p>
		<label for="allow_seperated_package" class="checkbox inline">
			<input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off"/>
			{l s='Send available products first'}
		</label>
	</p>
	{/if}

	{* Define the style if it doesn't exist in the PrestaShop version
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
{addJsDefL name='message_delete'}{l s='Êtes-vous sûre de vouloir supprimer ce produit ?'}{/addJsDefL}

{/strip}
{/if}
