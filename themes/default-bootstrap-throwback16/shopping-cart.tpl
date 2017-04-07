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
{* {include file="$tpl_dir./order-steps.tpl"} *}

{include file="$tpl_dir./errors.tpl"}

<p class="titre-panier">{l s='Mon panier'}</p>
{* <p id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
	{if !isset($empty) && !$PS_CATALOG_MODE}
		<span class="heading-counter" style="position:inherit;">{l s='Your shopping cart contains:'}
			<span id="summary_products_quantity" >{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
		</span>
	{/if}
</p>  *}

{if isset($empty)}
	{if isset($smarty.get.update) && $smarty.get.update =="1"}
		<script>window.location="{$link->getPageLink('order')}";</script>
	{else}
	
	<p class="panier-vide">{l s='Your shopping cart is empty.'}<br>
		{l s='Pour passer une commande, veuillez vous connecter et ajouter des articles dans votre panier.'}<br>
		{l s='Si vous ne disposez pas de compte throwback'} <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}"> {l s='créer votre compte'}</a> {l s='rapidement!'} 
	</p>
	<div class"redirect_home">
		<a href="{$base_dir}" class=" btn btn-dark text-center"><i class="icon-chevron-left left"></i> <span class="text-shoping">{l s='Continuer mon shopping'}</span></a>
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
						{* {$product|print_r} *}  
						{assign var="productId" value=$product.id_product}
						{assign var="attributes" value=$product.attributes_small}
						{assign var="split_size" value=","|explode:$attributes}

						{if isset($split_size[0]) }
								{assign var="sizing" value=$split_size[0]|trim}
						{/if}
						
						{if isset($split_size[1]) }
								{assign var="coloring" value=$split_size[1]|trim}
						{/if}
						
						{* {$combinations[$product.id_product]|print_r}  *} 

						{$attributeCombinaison[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $combinations[$product.id_product]}

						{$qtyAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.quantity_available}

						{$qtyLimitedAvailable[$product.id_product|cat:"_"|cat:$product.id_product_attribute|cat:"_"|cat:($product.id_customization|intval)|cat:"_"|cat:($product.id_address_delivery|intval)] = $product.stock_quantity}

				<div class="row row_line_product line_product_{$product.id_product}" id="product_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}">


							<div class="col-xs-3 col-md-3  img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">
								{* <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" {if isset($smallSize)}width="{$smallSize.width}" height="{$smallSize.height}" {/if} /> *}
								{* change product image format : from small_default_to_home default *}
								<img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" class="img-responsive" />
								</a>
							</div>

							<div class="col-xs-9 col-md-9 ">								
								<div class="row">
									<div class="col-xs-10 col-md-11">

										<p class="product-name product_title text-right-mobile">
											<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.name|escape:'html':'UTF-8'}
											</a>
										</p>
									</div>

									<!--<br><br>-->
									<div class="col-xs-2 col-md-1 ">
										<div class="row">	
											<div class="col-md-6 col-xs-6 text-right edit" style="padding:0;">
												<a id="edit-{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}" title="Modifier l'article" href="javascript:void(0)"><i class="fa fa-pencil-square-o icone-update icone-active" aria-hidden="true"></i></a>
											</div>
											<div class="col-md-6 col-xs-6 text-left delete" style="padding:0;">
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

                                {* get LIMIT quantity caracteristique value , add disabled to btn *}
                                {* <pre>{$product|var_dump}}</pre> *}
                                {*
	                                            caractériqtique produit : 
	                                            id Quantité-Commandable / id: 11
	                                            id valeur  : 11
                                *}
                                {* <pre>{$product->quantity_available}</pre> *}
                                {* <pre>{$product.features|var_dump}}</pre> *}
                                {foreach from=$product.features item=feature}
                                    {if (isset($feature["id_feature"]) && $feature["id_feature"] eq '11') && $feature["id_feature_value"] eq '41'}
                                        {assign var=quantitylimitperorder value=1}
                                        {* </pre>limit : {$quantitylimitperorder}</pre> *}
                                        {* TODO - show before quantity *}
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
																			<!--<fieldset class="attribute_fieldset">-->
																				
																				{assign var="groupName" value="group_"|cat:$productId|cat:"_"|cat:$product.id_product_attribute}
																				 
																				<div class="attribute_list">
																					
																					{if ($group.group_type == 'radio')}
																						<ul>
																						<span class="btn" style="display: inherit;">
																							{foreach from=$group.attributes key=id_attribute item=group_attribute}
																								

																								<li {if ( $group.attributes_quantity[$id_attribute] <=0 )  } class="li_attribute_list disabled" {/if}>

																									<label for="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}-{$id_attribute}">
																									<input type="radio" id="{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval}-{$id_attribute}" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" 
																									{if ($group_attribute == $sizing)} checked="checked"{/if} />
																									{assign var=someVar value=" "|explode:$group_attribute}
																									{$someVar[0]|escape:'html':'UTF-8'} {if isset($someVar[1])}<sup>{$someVar[1]|escape:'html':'UTF-8'}</sup> {/if}
																									</label>
																								</li>
																								{* <pre>{$id_attribute}</pre> *}
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
																			<!--</fieldset>-->
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

											<div class="col-md-3 col-xs-3">
												{if $product.cart_quantity}
													<div class = "row">
														<div class="col-md-6 col-xs-6 text-right text-right-mobile hidden-xs">
																<label class="label-attribute ">{l s='Quantité'}</label>
														</div>
														<div class="col-md-6 col-xs-6">
																<div class="current_qty_{$product.id_product}_{$product.id_product_attribute}_{$product.id_customization|intval}_{$product.id_address_delivery|intval} size_line">
																	{$product.cart_quantity}
																</div>
														</div>
													</div>
													
												{/if}
											</div>

											

											<div class="col-md-3 col-xs-3">
												{if isset($sizing) && $sizing}
													<div class = "row">
														<div class="col-md-6 col-xs-6 text-right text-right-mobile hidden-xs">
															<label class="label-attribute">{l s='Taille'}</label>
														</div>
														<div class="col-md-6 col-xs-6">
															<div class="size_line">
																
																	{assign var=someVar value=" "|explode:$sizing}
																	{$someVar[0]|escape:'html':'UTF-8'} {if isset($someVar[1])}<sup>{$someVar[1]|escape:'html':'UTF-8'}</sup> {/if}

																
																	{* <pre>{$product->attributes}</pre> *}
																	{* <pre>{$product->attributes_small}</pre> *}
																	{* <pre>{$product->stock_quantity}</pre> *}

															</div>
														</div>
													</div>
												{/if}
											</div>

											<div class="col-md-3 col-xs-3">
												{if isset($coloring)}
													<div class = "row">
														<div class="col-md-6 col-xs-6 text-right text-right-mobile hidden-xs">
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

											<div class="col-md-3 col-xs-3">
												{if !$priceDisplay}
													<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if} price product-price price-prod">{convertPrice price=$product.price_wt}</span>
												{else}
								               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if} price product-price price-prod">{convertPrice price=$product.price}</span>
												{/if}
												{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}
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
						<div class="row line_product">
								<div class="col-md-8 col-xs-8">
									<p class="command-product-name total">{l s='Total'|upper}</p>
								</div>

								<div class="col-md-4 col-xs-4 text-right total">
										{if $use_taxes}
										<span class="price-line" id="total_price">{displayPrice price=$total_price}</span>
										{else}
										<span class="price-line" id="total_price">{displayPrice price=$total_price_without_tax}</span>
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
						<div class="col-md-12 cart_navigation">	
						
							<a href="{$base_dir}" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'}">
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

{/strip}
{/if}
