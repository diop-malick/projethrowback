{if isset($products) && $products}
	{*define number of products per line in other page for desktop*}
	{if $page_name !='index' && $page_name !='product'}
		{assign var='nbItemsPerLine' value=4}
		{assign var='nbItemsPerLineTablet' value=2}
		{assign var='nbItemsPerLineMobile' value=3}
	{else}
		{assign var='nbItemsPerLine' value=4}
		{assign var='nbItemsPerLineTablet' value=3}
		{assign var='nbItemsPerLineMobile' value=2}
	{/if}
	{*define numbers of product per line in other page for tablet*}
	{assign var='nbLi' value=$products|@count}
	{math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
	{math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
	<!-- Products list -->
	<ul{if isset($id) && $id} id="{$id}"{else} id="product_list"{/if} class="product_list grid row{if isset($class) && $class} {$class}{/if}">
	{foreach from=$products item=product name=products}

{* <pre>{$product|print_r}</pre> *}
{* <pre>{$categories_custom|print_r}</pre> *}

{* 
{assign var=filterDeadStock value=''}
{if $smarty.get.controller eq 'newproducts'}
						{assign var=categories_custom value=Product::getProductCategoriesFull($product.id_product)}
						{foreach from=$categories_custom item=secondaryCategory}
											{if $secondaryCategory.name eq 'Adidas'}
													{assign var=filterDeadStock value='Adidas'}
													
													{break}
											{/if}
							{/foreach}

{/if}
{if ($smarty.get.controller eq 'newproducts') and isset($filterDeadStock) and ($filterDeadStock eq 'Adidas')}
<li><pre>{$filterDeadStock}</pre></li>
{else}
<li><pre>{$filterDeadStock}</pre></li> 
*}

		{* LIMIT product to show to 12 *}
		{if $smarty.get.controller eq 'index' and $smarty.foreach.products.iteration == 13}
			{break}
		{/if}

		{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
		{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
		{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
		{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
		{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
		{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
		<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-6 col-sm-6 col-md-3{else} col-xs-6 col-sm-6 col-md-3{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
			<div class="product-container" itemscope itemtype="https://schema.org/Product">
				
				<div class="row text-right">
					<h5 itemprop="name">
						{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
						<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
							{$product.name|escape:'html':'UTF-8'}
						</a>
					</h5>
					{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
					{if $smarty.capture.displayProductListReviews}
						<div class="hook-reviews">
						{hook h='displayProductListReviews' product=$product}
						</div>
					{/if}
					
					{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
					<div class="content_price">
						{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
							{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
								{hook h="displayProductPriceBlock" product=$product type="old_price"}
								<span class="old-price product-price">
									{displayWtPrice p=$product.price_without_reduction}
								</span>
								{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
								{if $product.specific_prices.reduction_type == 'percentage'}
									
								{/if}
							{/if}

							{hook h="displayProductPriceBlock" product=$product type='before_price'}
							
								<!-- PVE la plus petite -->
								{if isset($groups) && $groups}
								{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
									{if ($group.group_type == 'radio')}
										{foreach from=$group.name_price key=id_attribute item=group_attribute}
											{if $group_attribute > 0} 
												<span class="pve_petite">{l s='A partir de '}</span>
												{break}
											{/if}	
										{/foreach}
									{/if}
								{/foreach}
								{/if}

							<span class="price product-price">
								{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
							</span>

							<!-- FLAG chrono -->
							{* get chrono caracteristique value *}
							{foreach from=$product.features item=feature}
									{if $feature.name eq 'Type de produit'}
										{if isset($feature.value)}
											{assign var=comingsoonvalue value=$feature.value}
										{/if}
									{/if}
							{/foreach}
							<!-- FLAG Comming soon --> 
							{* comingsoon without date *}
							{if isset($comingsoonvalue) && $comingsoonvalue eq 'comingsoon'}
								{addJsDef comingsoonvalue=$comingsoonvalue}
								<img src="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/icones/chrono.png"/>
							<!-- FLAG New -->
							<!-- FLAG Comming soon -->
							{elseif $product.date_add > $smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
								<img src="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/icones/chrono.png"/>
							<!-- show new flag if date_add is not after now -->
							{elseif isset($product.new) && $product.new == 1}
								<img src="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/icones/new.png"/>
							{/if}
							{hook h="displayProductPriceBlock" product=$product type="price"}
							{hook h="displayProductPriceBlock" product=$product type="unit_price"}
							{hook h="displayProductPriceBlock" product=$product type='after_price'}
						{/if}
					</div>
					{/if}

					<div class="product-flags">
						{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
							{if isset($product.online_only) && $product.online_only}
								<span class="online_only">{l s='Online only'}</span>
							{/if}
						{/if}
						{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
							{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
								<span class="discount">{l s='Reduced price!'}</span>
							{/if}
					</div>
					
				</div>
				
					
				<div class="row">
					<div class="product-image-container">
						<a class="default product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
							<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
						</a>

						<a class="qv product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
							<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default_qv')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" itemprop="image" />
						</a>

						<!-- quick view prestashop // TODO - DELETE -->
						{if isset($quick_view) && $quick_view}
							<div class="quick-view-wrapper-mobile">
							<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
								<i class="icon-eye-open"></i>
							</a>
						</div>
						<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
							<span>{l s='Quick view'}</span>
						</a>
						{/if}
						<!-- // quick view prestashop -->

						<div class="clearfix"></div>

						{* todo - DELETE - check if ist really need *}
						{if isset($product.new) && $product.new == 1}
							
						{/if}
						{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
							
						{/if}
					</div>
					{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
					{hook h="displayProductPriceBlock" product=$product type="weight"}
				</div>

							<div class="row qv-additionnal-info">
			{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
							<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
								<div class="row">
									<div class="col-md-6">
										<span class="qv-reference">{$product.reference|upper}</span>
									</div>
									<div class="col-md-6" >
										<span class="qv-dispo">
										{if ({$comingsoonvalue} neq 'comingsoon') && ($product.date_add < $smarty.now|date_format:'%Y-%m-%d %H:%M:%S')}
											{if $product.quantity > 0}
												{* show if default declinaison quantity > 0 *}
												{l s='In Stock'}
											{else}
												{* show availability msg only if at leat one of declinaison have quantity > 0 *}
												{if isset($groups) && $groups}
												{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
													{if ($group.group_type == 'radio' || $group.group_type == 'select')}
														{foreach from=$group.attributes_quantity key=id_attribute item=group_attribute}
															{if $group_attribute > 0} 
																{l s='In Stock'}
																{break}
															{/if}	
														{/foreach}
													{/if}
												{/foreach}
												{/if}
											{/if}
										{/if}
										</span>
									</div>
								</div>

								{* <pre>{$groups[$product.id_product]|print_r}</pre> *}
								
								{if isset($groups) && $groups}
								<div class="row qv-size">
									<ul class="text-center">
										{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
											{if ($group.group_type == 'radio')}
													{foreach from=$group.attributes key=id_attribute item=group_attribute}
													<li {if ( isset($id_attribute) && $group.attributes_quantity[$id_attribute] <=0 )  } class="li_attribute_list disabled" {/if}>
														<a href="{$product.link|escape:'html':'UTF-8'}">
																{assign var=size_keywords value=" / "|explode:$group_attribute}																
																<span class="size-list">
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
																</span>
														</a>
													</li>
													{/foreach}
											{/if}
										{/foreach}
									</ul>
								</div>
								{/if}
							</div>
						{/if}
				</div><!-- .product-container> -->
			</div><!-- .product-container> -->

		</li>

{* {/if}  *}
{* end test filter deadstock *}

		{* REINITIALISATION *}
		{* reset comming soon value *}
		{assign var=comingsoonvalue value=''}

	{/foreach}
	</ul>
{addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
{addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
{addJsDef comparator_max_item=$comparator_max_item}
{addJsDef comparedProductsIds=$compared_products}

{/if}
