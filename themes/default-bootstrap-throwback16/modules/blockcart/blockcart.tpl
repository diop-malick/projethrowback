
			<!-- MODULE Block cart -->

								{if isset($blockcart_top) && $blockcart_top}
								<div id="mobil_blockcart" class="col-xs-6 col-sm-6 col-md-5  text-xs-center text-md-right">

									<div class="{if $PS_CATALOG_MODE} header_user_catalog{/if}">
									{/if}
										<div class="shopping_cart" id="picto_panier">
											<a href="{$link->getPageLink($order_process, true, NULL, 'step=0')|escape:'html':'UTF-8'}" title="{l s='View my shopping cart' mod='blockcart'}" rel="nofollow">
												<span class="panier hidden-xs">{l s='Cart' mod='blockcart'}</span>
												<span class="ajax_cart_quantity{if $cart_qties == 0} unvisible{/if}">({$cart_qties})</span>
												<span class="ajax_cart_product_txt{if $cart_qties != 1} unvisible{/if}">{l s='' mod='blockcart'}</span>
												<span class="ajax_cart_product_txt_s{if $cart_qties < 2} unvisible{/if}">{l s='' mod='blockcart'}</span>
												<span class="ajax_cart_total{if $cart_qties == 0} unvisible{/if}">
													{if $cart_qties > 0}
														{if $priceDisplay == 1}
															{assign var='blockcart_cart_flag' value='Cart::BOTH_WITHOUT_SHIPPING'|constant}
															{convertPrice price=$cart->getOrderTotal(false, $blockcart_cart_flag)}
														{else}
															{assign var='blockcart_cart_flag' value='Cart::BOTH_WITHOUT_SHIPPING'|constant}
															{convertPrice price=$cart->getOrderTotal(true, $blockcart_cart_flag)}
														{/if}
													{/if}
												</span>
												<span  class="ajax_cart_no_product{if $cart_qties > 0} unvisible{/if}">
												{* <span class="hidden-xs">{l s='(0)' mod='blockcart'}</span> *}
												<span class="panier_vide">{l s='(0)' mod='blockcart'}</span>
												</span>
												</span>
												<span class="icon-fix"><i class="material-icons shopping-cart"></i></span>


												{if $ajax_allowed && isset($blockcart_top) && !$blockcart_top}
													<span class="block_cart_expand{if !isset($colapseExpandStatus) || (isset($colapseExpandStatus) && $colapseExpandStatus eq 'expanded')} unvisible{/if}">&nbsp;</span>
													<span class="block_cart_collapse{if isset($colapseExpandStatus) && $colapseExpandStatus eq 'collapsed'} unvisible{/if}">&nbsp;</span>
												{/if}
											</a>
											{if !$PS_CATALOG_MODE}
												<div class="cart_block block exclusive">
													<div class="block_content">
														<!-- block list of products -->
														<div class="cart_block_list{if isset($blockcart_top) && !$blockcart_top}{if isset($colapseExpandStatus) && $colapseExpandStatus eq 'expanded' || !$ajax_allowed || !isset($colapseExpandStatus)} expanded{else} collapsed unvisible{/if}{/if}">
															{if $products}
																<dl class="products">
																	{foreach from=$products item='product' name='myLoop'}
																		{assign var='productId' value=$product.id_product}
																		{assign var='productAttributeId' value=$product.id_product_attribute}
																		<dt data-id="cart_block_product_{$product.id_product|intval}_{if $product.id_product_attribute}{$product.id_product_attribute|intval}{else}0{/if}_{if $product.id_address_delivery}{$product.id_address_delivery|intval}{else}0{/if}" class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if}">
																			<a class="cart-images" href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category)|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'cart_default')}" alt="{$product.name|escape:'html':'UTF-8'}" /></a>
																			<div class="cart-info">
																				<div class="product-name">
																					<span class="quantity-formated"><span class="quantity">{$product.cart_quantity}</span>&nbsp;x&nbsp;</span><a class="cart_block_product_name" href="{$link->getProductLink($product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute)|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}">{$product.name|truncate:13:'...'|escape:'html':'UTF-8'}</a>
																				</div>
																				{if isset($product.attributes_small)}
																					<div class="product-atributes">
																						<a href="{$link->getProductLink($product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute)|escape:'html':'UTF-8'}" title="{l s='Product detail' mod='blockcart'}">{$product.attributes_small}</a>
																					</div>
																				{/if}
																				<span class="price">
																					{if !isset($product.is_gift) || !$product.is_gift}
																						{if $priceDisplay == $smarty.const.PS_TAX_EXC}{displayWtPrice p="`$product.total`"}{else}{displayWtPrice p="`$product.total_wt`"}{/if}
									                                                    <div class="hookDisplayProductPriceBlock-price">
									                                                        {hook h="displayProductPriceBlock" product=$product type="price" from="blockcart"}
									                                                    </div>
																					{else}
																						{l s='Free!' mod='blockcart'}
																					{/if}
																				</span>
																			</div>
																			<span class="remove_link">
																				{if !isset($customizedDatas.$productId.$productAttributeId) && (!isset($product.is_gift) || !$product.is_gift)}
<a class="ajax_cart_block_remove_link" href="{$link->getPageLink('cart', true, NULL, "delete=1&id_product={$product.id_product|intval}&ipa={$product.id_product_attribute|intval}&id_address_delivery={$product.id_address_delivery|intval}&token={$static_token}")|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='remove this product from my cart' mod='blockcart'}">&nbsp;</a>
																				{/if}
																			</span>
																		</dt>
																		{if isset($product.attributes_small)}
																			<dd data-id="cart_block_combination_of_{$product.id_product|intval}{if $product.id_product_attribute}_{$product.id_product_attribute|intval}{/if}_{$product.id_address_delivery|intval}" class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if}">
																		{/if}
																		<!-- Customizable datas -->
																		{if isset($customizedDatas.$productId.$productAttributeId[$product.id_address_delivery])}
																			{if !isset($product.attributes_small)}
																				<dd data-id="cart_block_combination_of_{$product.id_product|intval}_{if $product.id_product_attribute}{$product.id_product_attribute|intval}{else}0{/if}_{if $product.id_address_delivery}{$product.id_address_delivery|intval}{else}0{/if}" class="{if $smarty.foreach.myLoop.first}first_item{elseif $smarty.foreach.myLoop.last}last_item{else}item{/if}">
																			{/if}
																			<ul class="cart_block_customizations" data-id="customization_{$productId}_{$productAttributeId}">
																				{foreach from=$customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] key='id_customization' item='customization' name='customizations'}
																					<li name="customization">
																						<div data-id="deleteCustomizableProduct_{$id_customization|intval}_{$product.id_product|intval}_{$product.id_product_attribute|intval}_{$product.id_address_delivery|intval}" class="deleteCustomizableProduct">
																							<a class="ajax_cart_block_remove_link" href="{$link->getPageLink('cart', true, NULL, "delete=1&id_product={$product.id_product|intval}&ipa={$product.id_product_attribute|intval}&id_customization={$id_customization|intval}&token={$static_token}")|escape:'html':'UTF-8'}" rel="nofollow">&nbsp;</a>
																						</div>
																						{if isset($customization.datas.$CUSTOMIZE_TEXTFIELD.0)}
																							{$customization.datas.$CUSTOMIZE_TEXTFIELD.0.value|replace:"<br />":" "|truncate:28:'...'|escape:'html':'UTF-8'}
																						{else}
																							{l s='Customization #%d:' sprintf=$id_customization|intval mod='blockcart'}
																						{/if}
																					</li>
																				{/foreach}
																			</ul>
																			{if !isset($product.attributes_small)}</dd>{/if}
																		{/if}
																		{if isset($product.attributes_small)}</dd>{/if}
																	{/foreach}
																</dl>
															{/if}
															<p class="cart_block_no_products{if $products} unvisible{/if}">
																{l s='No products' mod='blockcart'}
															</p>
															{if $discounts|@count > 0}
																<table class="vouchers{if $discounts|@count == 0} unvisible{/if}">
																	{foreach from=$discounts item=discount}
																		{if $discount.value_real > 0}
																			<tr class="bloc_cart_voucher" data-id="bloc_cart_voucher_{$discount.id_discount|intval}">
																				<td class="quantity">1x</td>
																				<td class="name" title="{$discount.description}">
																					{$discount.name|truncate:18:'...'|escape:'html':'UTF-8'}
																				</td>
																				<td class="price">
																					-{if $priceDisplay == 1}{convertPrice price=$discount.value_tax_exc}{else}{convertPrice price=$discount.value_real}{/if}
																				</td>
																				<td class="delete">
																					{if strlen($discount.code)}
																						<a class="delete_voucher" href="{$link->getPageLink("$order_process", true)}?deleteDiscount={$discount.id_discount|intval}" title="{l s='Delete' mod='blockcart'}" rel="nofollow">
																							<i class="icon-remove-sign"></i>
																						</a>
																					{/if}
																				</td>
																			</tr>
																		{/if}
																	{/foreach}
																</table>
															{/if}
															{assign var='free_ship' value=count($cart->getDeliveryAddressesWithoutCarriers(true, $errors))}
															<div class="cart-prices">

																{if $show_wrapping}
																	<div class="cart-prices-line">
																		{assign var='cart_flag' value='Cart::ONLY_WRAPPING'|constant}
																		<span class="price cart_block_wrapping_cost">
																			{if $priceDisplay == 1}
																				{convertPrice price=$cart->getOrderTotal(false, $cart_flag)}{else}{convertPrice price=$cart->getOrderTotal(true, $cart_flag)}
																			{/if}
																		</span>
																		<span>
																			{l s='Wrapping' mod='blockcart'}
																		</span>
																   </div>
																{/if}
																{if $show_tax && isset($tax_cost)}
																	<div class="cart-prices-line">
																		<span class="price cart_block_tax_cost ajax_cart_tax_cost">{$tax_cost}</span>
																		<span>{l s='Tax' mod='blockcart'}</span>
																	</div>
																{/if}
																<div class="cart-prices-line last-line">
																	<span class="price cart_block_total ajax_block_cart_total">
																		{if isset($blockcart_cart_flag)}
																			{convertPrice price=$cart->getOrderTotal(false, $blockcart_cart_flag)}
																		{else}
																			{convertPrice price=$cart->getOrderTotal()}
																		{/if}
																	</span>
																	<span>{l s='Total :' mod='blockcart'}</span>&nbsp;
																</div>
																{if $use_taxes && $display_tax_label && $show_tax}
																	<p>
																	{if $priceDisplay == 0}
																		{l s='Prices are tax included' mod='blockcart'}
																	{elseif $priceDisplay == 1}
																		{l s='Prices are tax excluded' mod='blockcart'}
																	{/if}
																	</p>
																{/if}
															</div>
															<p class="cart-buttons">
																<a id="button_order_cart" class="btn btn-default button button-small" href="{$link->getPageLink($order_process, true, NULL, 'step=0')|escape:'html':'UTF-8'}" title="{l s='Check out' mod='blockcart'}" rel="nofollow">
																	<span>
																		{l s='Check out' mod='blockcart'}<i class="icon-chevron-right right"></i>
																	</span>
																</a>
															</p>
														</div>
													</div>
												</div><!-- .cart_block -->
											{/if}
										</div><!-- .shopping_cart -->
									{if isset($blockcart_top) && $blockcart_top}
									</div>

								</div>

								</div>
							<!-- //  MODULE Block cart -->
							</div><!-- // ROW UserInfo + Cart -->
							</div><!-- // COL UserInfo + Cart -->
							</div> <!-- // container -->
							</div > <!-- // Row HEADER -->
				{/if}

				{counter name=active_overlay assign=active_overlay}
				{if !$PS_CATALOG_MODE && $active_overlay == 1}
					<div id="layer_cart">
						<div class="clearfix">
							<div class="layer_cart_product col-xs-12 col-sm-12 col-md-12">
								<span class="cross" title="{l s='Close window' mod='blockcart'}"></span>
								<span class="title">
									<i class="icon-check"></i>{l s='Product successfully added to your shopping cart' mod='blockcart'}
								</span>
								<div class="product-image-container layer_cart_img hidden-xs">
								</div>
								<div class="layer_cart_product_info hidden-xs">
									<span id="layer_cart_product_title" class="product-name"></span>
									<strong id="size_choice" class="dark">{l s='Size' mod='blockcart'}&nbsp;:</strong>
									<span id="layer_cart_product_attributes"></span>
									<div>
										<strong class="dark">{l s='Quantity' mod='blockcart'}&nbsp;:</strong>
										<span id="layer_cart_product_quantity"></span>
									</div>

										<div class="disponible">
											<span class="dispo_info">{l s='In Stock' mod='blockcart'}
											</span>
										</div>


									<div>
										<strong class="dark">{l s='Total' mod='blockcart'}&nbsp;:</strong>
										<span id="layer_cart_product_price"></span>
									</div>
								</div>
								<div class="button-container">
									<div class = "row">
									<div class="col-md-6 col-sm-6 col-xs-12">
											<p class="cart_navigation clearfix">
												<a href="{$smarty.server.REQUEST_URI}" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'} ">
													<i><</i>{l s='Continuer mon shopping' mod='blockcart'}
												</a>
											</p>

										</div>
										<div class="col-md-6 col-sm-6 col-xs-12">
											<a class="btn btn-default button button-medium"	href="{$link->getPageLink($order_process, true, NULL, 'step=0')|escape:'html':'UTF-8'}" title="{l s='Proceed to checkout' mod='blockcart'}" rel="nofollow">
												<span>
													{l s='Proceed to checkout' mod='blockcart'}<i>&nbsp;></i>
												</span>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="crossseling"></div>
					</div> <!-- #layer_cart -->
					<div class="layer_cart_overlay">
					</div>
				{/if}
				{strip}
				{addJsDef CUSTOMIZE_TEXTFIELD=$CUSTOMIZE_TEXTFIELD}
				{addJsDef img_dir=$img_dir|escape:'quotes':'UTF-8'}
				{addJsDef generated_date=$smarty.now|intval}
				{addJsDef ajax_allowed=$ajax_allowed|boolval}
				{addJsDef hasDeliveryAddress=(isset($cart->id_address_delivery) && $cart->id_address_delivery)}

				{addJsDefL name=customizationIdMessage}{l s='Customization #' mod='blockcart' js=1}{/addJsDefL}
				{addJsDefL name=removingLinkText}{l s='remove this product from my cart' mod='blockcart' js=1}{/addJsDefL}
				{addJsDefL name=freeShippingTranslation}{l s='Free shipping!' mod='blockcart' js=1}{/addJsDefL}
				{addJsDefL name=freeProductTranslation}{l s='Free!' mod='blockcart' js=1}{/addJsDefL}
				{addJsDefL name=delete_txt}{l s='Delete' mod='blockcart' js=1}{/addJsDefL}
				{addJsDefL name=toBeDetermined}{l s='To be determined' mod='blockcart' js=1}{/addJsDefL}
				{/strip}
