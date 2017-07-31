{include file="$tpl_dir./errors.tpl"}
{if $errors|@count == 0}
	{if !isset($priceDisplayPrecision)}
		{assign var='priceDisplayPrecision' value=2}
	{/if}
	{if !$priceDisplay || $priceDisplay == 2}
		{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, 6)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
	{elseif $priceDisplay == 1}
		{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, 6)}
		{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
	{/if}

	{foreach from=$features item=feature}
								{if $feature.name eq 'Type de produit'}
											{if isset($feature.value)}
												{assign var=comingsoontplvalue value=$feature.value}
											{/if}
										{/if}
	{/foreach}

						{* <pre>{$product->category}</pre> *}
					{* <pre>{$smarty.get.id_product}</pre> *}
					
					{* <pre>{$product|print_r}</pre> *}

<div itemscope itemtype="https://schema.org/Product">
	<meta itemprop="url" content="{$link->getProductLink($product)}">

	<div class="primary_block row">

		{if isset($adminActionDisplay) && $adminActionDisplay}
			<div id="admin-action" class="container">
				<p class="alert alert-info">{l s='This product is not visible to your customers.'}
					<input type="hidden" id="admin-action-product-id" value="{$product->id}" />
					<a id="publish_button" class="btn btn-default button button-small" href="#">
						<span>{l s='Publish'}</span>
					</a>
					<a id="lnk_view" class="btn btn-default button button-small" href="#">
						<span>{l s='Back'}</span>
					</a>
				</p>
				<p id="admin-action-result"></p>
			</div>
		{/if}
		{if isset($confirmation) && $confirmation}
			<p class="confirmation">
				{$confirmation}
			</p>
		{/if}


		{* ============================================================================ 
		ENTËTE MOBILE 
		=================================================================+============= *}
		<div class="pb-mobile-column visible-xs col-xs-12">
			<div class="col-xs-12">
				<h1 class="product_name" itemprop="name"> {$product->name|truncate:42:"":true:true|escape:'html':'UTF-8'} </h1>
			</div>
			<div class="col-xs-12" style="margin-top: 10px; margin-bottom: 10px;">
							<p id="product_reference"{if empty($product->reference) || !$product->reference} style="display: none;"{/if}>
								{l s='Ref '}
								<span class="editable" itemprop="sku"{if !empty($product->reference) && $product->reference} content="{$product->reference}"{/if}>{if !isset($groups)}{$product->reference|escape:'html':'UTF-8'}{/if}</span>
							</p>
			</div>
			<div class="col-xs-3 text-xs-left" style="margin-top: 10px">
			{if $product->category != 'accessoires'}
					<section>
								{assign var=categories_custom value=Product::getProductCategoriesFull($smarty.get.id_product)}
							{foreach from=$categories_custom item=secondaryCategory}
											{if $secondaryCategory.name eq 'Femme'}
													{assign var=gendertype value='Femme'}
											{elseif $secondaryCategory.name eq 'Enfant'}
												{assign var=gendertype value='Enfant'}
											{/if}
							{/foreach}
								<ul class="gender-label-group inline 
										{if $product->category == 'Femme'} women
										{elseif (isset($gendertype) and $gendertype eq 'Femme')} women
										{elseif $product->category == 'Enfant'} kids
										{elseif (isset($gendertype) and $gendertype eq 'Enfant')} kids
										{else} men {/if}">
											<li class="gender-label"><a class="men" title="Men"><i class="gender-icon gender-icon-male"></i></a></li>
											<li class="gender-label"><a class="women" title="Women"><i class="gender-icon gender-icon-female"></i></a></li>
											<li class="gender-label"><a class="kids" title="Kids"><i class="gender-icon gender-icon-kids"></i></a></li>
										</ul>
						</section>
						{/if}
				</div>

				<div class="col-xs-3 text-xs-left" style="margin-top: 10px">
						<!-- FLAG chrono -->
						{* comingsoon without date *}
						{if isset($product->date_add) && $product->date_add < $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' }
							{if isset($comingsoontplvalue) && $comingsoontplvalue eq 'comingsoon'}							
								<span id="chrono_without_date"></span>
									<i class="material-icons" style="font-size:30px;color:rgb(214, 157, 50);">schedule</i>
								</span>
							<!-- FALG New -->
							{elseif $product->new && $product->new == 1 && ($product->quantity > 0) && $product->available_for_order }
								<img src="{$base_dir_ssl}img/icones/new.png"/>
							{/if}
						{/if}
				</div>
				<div class=" col-xs-6 content_prices text-xs-right" style="margin-top: 10px">
							{if $product->show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
								<!-- prices -->
								<div>
									<p class="our_price_display" itemprop="offers" itemscope itemtype="https://schema.org/Offer">{strip}
										{if $product->quantity > 0}<link itemprop="availability" href="https://schema.org/InStock"/>{/if}
										{if $priceDisplay >= 0 && $priceDisplay <= 2}

										{* PVE plus petite *}
                   {foreach from=$combinations key=id_combinaison item=group_combinations}
                     {if $group_combinations.price > 0}
                       <span class ="pve_petite "id="minimal_pve_price">{l s='A partir de '}</span><br class="pve_petite"/>
                       {break}
                     {/if}                      
                   {/foreach}

											<span id="our_price_display" class="price" itemprop="price" content="{$productPrice}">{convertPrice price=$productPrice|floatval}</span>
											<!-- {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
												{if $priceDisplay == 1} {l s='tax excl.'}{else} {l s='tax incl.'}{/if}
											{/if} -->
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{hook h="displayProductPriceBlock" product=$product type="price"}
										{/if}
									{/strip}</p>
									<p id="reduction_percent" {if $productPriceWithoutReduction <= 0 || !$product->specificPrice || $product->specificPrice.reduction_type != 'percentage'} style="display:none;"{/if}>{strip}
										<span id="reduction_percent_display">
											{if $product->specificPrice && $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}
										</span>
									{/strip}</p>
									<p id="reduction_amount" {if $productPriceWithoutReduction <= 0 || !$product->specificPrice || $product->specificPrice.reduction_type != 'amount' || $product->specificPrice.reduction|floatval ==0} style="display:none"{/if}>{strip}
										<span id="reduction_amount_display">
										{if $product->specificPrice && $product->specificPrice.reduction_type == 'amount' && $product->specificPrice.reduction|floatval !=0}
											-{convertPrice price=$productPriceWithoutReduction|floatval-$productPrice|floatval}
										{/if}
										</span>
									{/strip}</p>
									<p id="old_price"{if (!$product->specificPrice || !$product->specificPrice.reduction)} class="hidden"{/if}>{strip}
										{if $priceDisplay >= 0 && $priceDisplay <= 2}
											{hook h="displayProductPriceBlock" product=$product type="old_price"}
											<span id="old_price_display"><span class="price">{if $productPriceWithoutReduction > $productPrice}{convertPrice price=$productPriceWithoutReduction|floatval}{/if}</span>{if $productPriceWithoutReduction > $productPrice && $tax_enabled && $display_tax_label == 1} {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}{/if}</span>
										{/if}
									{/strip}</p>
									{if $priceDisplay == 2}
										<br />
										<span id="pretaxe_price">{strip}
											<span id="pretaxe_price_display">{convertPrice price=$product->getPrice(false, $smarty.const.NULL)}</span> {l s='tax excl.'}
										{/strip}</span>
									{/if}
								</div> <!-- end prices -->
								{if $packItems|@count && $productPrice < $product->getNoPackPrice()}
									<p class="pack_price">{l s='Instead of'} <span style="text-decoration: line-through;">{convertPrice price=$product->getNoPackPrice()}</span></p>
								{/if}
								{if $product->ecotax != 0}
									<p class="price-ecotax">{l s='Including'} <span id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for ecotax'}
										{if $product->specificPrice && $product->specificPrice.reduction}
										<br />{l s='(not impacted by the discount)'}
										{/if}
									</p>
								{/if}
								{if !empty($product->unity) && $product->unit_price_ratio > 0.000000}
									{math equation="pprice / punit_price" pprice=$productPrice  punit_price=$product->unit_price_ratio assign=unit_price}
									<p class="unit-price"><span id="unit_price_display">{convertPrice price=$unit_price}</span> {l s='per'} {$product->unity|escape:'html':'UTF-8'}</p>
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
								{/if}
							{/if} {*close if for show price*}
							{hook h="displayProductPriceBlock" product=$product type="weight" hook_origin='product_sheet'}
	                        {hook h="displayProductPriceBlock" product=$product type="after_price"}

						</div> <!-- end content_prices -->

		</div>  {* end pb_mobile-colum *}
		<div class="clearfix"></div>


		{* ============================================================================ 
		BLOCK LEFT 
		=================================================================+============= *}
		<div class="pb-left-column col-xs-12 col-sm-12 col-md-7">
			<!-- product img-->
			<div id="image-block" class="clearfix">
				{if $product->on_sale}
					<span class="sale-box no-print">
						<span class="sale-label">{l s='Sale!'}</span>
					</span>
				{elseif $product->specificPrice && $product->specificPrice.reduction && $productPriceWithoutReduction > $productPrice}
					<span class="discount">{l s='Reduced price!'}</span>
				{/if}
				{if $have_image}
					<span id="view_full_size">
						{if $jqZoomEnabled && $have_image && !$content_only}
							<a class="jqzoom" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" rel="gal1" href="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|escape:'html':'UTF-8'}">
								<img itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}"/>
							</a>
						{else}
							<img id="bigpic" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}"/>
							{if !$content_only}
								<span class="span_link no-print pull-right hidden-xs hidden-sm">
								<!-- {l s='View larger'} -->
								</span>
							{/if}
						{/if}
					</span>
				{else}
					<span id="view_full_size">
						<img itemprop="image" src="{$img_prod_dir}{$lang_iso}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width}" height="{$largeSize.height}"/>
						{if !$content_only}
							<span class="span_link">
								{l s='View larger'}
							</span>
						{/if}
					</span>
				{/if}
			</div> <!-- end image-block -->
			{if isset($images) && count($images) > 0}
				<!-- thumbnails -->
				<div id="views_block" class="clearfix {if isset($images) && count($images) < 2}hidden{/if}">
					{if isset($images) && count($images) > 2}
						<!-- <span class="view_scroll_spacer"> -->
							<a id="view_scroll_left" class="" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
								{l s='Previous'}
							</a>
						<!-- </span> -->
					{/if}
					<div id="thumbs_list">
						<ul id="thumbs_list_frame">
						{if isset($images)}
							{foreach from=$images item=image name=thumbnails}
								{assign var=imageIds value="`$product->id`-`$image.id_image`"}
								{if !empty($image.legend)}
									{assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
								{else}
									{assign var=imageTitle value=$product->name|escape:'html':'UTF-8'}
								{/if}
								<li id="thumbnail_{$image.id_image}"{if $smarty.foreach.thumbnails.last} class="last"{/if}>
									<a{if $jqZoomEnabled && $have_image && !$content_only} href="javascript:void(0);" rel="{literal}{{/literal}gallery: 'gal1', smallimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'large_default')|escape:'html':'UTF-8'}',largeimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}'{literal}}{/literal}"{else} href="{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}"	data-fancybox-group="other-views" class="fancybox{if $image.id_image == $cover.id_image} shown{/if}"{/if} title="{$imageTitle}">
										<img class="img-responsive" id="thumb_{$image.id_image}" src="{$link->getImageLink($product->link_rewrite, $imageIds, 'cart_default')|escape:'html':'UTF-8'}" alt="{$imageTitle}" title="{$imageTitle}"{if isset($cartSize)} height="{$cartSize.height}" width="{$cartSize.width}"{/if} itemprop="image" />
									</a>
								</li>
							{/foreach}
						{/if}
						</ul>
					</div> <!-- end thumbs_list -->
					{if isset($images) && count($images) > 2}
						<a id="view_scroll_right" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
							{l s='Next'}
						</a>
					{/if}
				</div> <!-- end views-block -->
				<!-- end thumbnails -->
			{/if}
			{if isset($images) && count($images) > 1}
				<p class="resetimg clear no-print">
					<span id="wrapResetImages" style="display: none;">
						<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" data-id="resetImages">
							<i class="icon-repeat"></i>
							{l s='Display all pictures'}
						</a>
					</span>
				</p>
			{/if}

			<div class="col-xs-12 visible-xs">
				<!-- short_description_block -->
						{if $product->description}
						<div id="short_description_block">
							{if $product->description_short}
								<div id="short_description_content" class="rte align_justify" itemprop="description"><h1 class="titre_description" itemprop="name">{$product->name|escape:'html':'UTF-8'}</h1>{$product->description}</div>
							{/if}
						</div>
						{/if}
				</div>

		</div> <!-- end pb-left-column -->
		<!-- end left infos-->

		<!-- right  -->
		<div class="pb-my-right-column col-xs-12 col-sm-12 col-md-5">

			{if ($product->show_price && !isset($restricted_country_mode)) || isset($groups) || $product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}

			<!-- FORM -->
			<!-- add to cart form-->
			<form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">

				<div id="rigth-row-1" class="row">
					<!-- TITRE  -->
					<div class="col-xs-12 col-sm-8 col-md-8 text-left text-xs-left hidden-xs">
							<!-- NAME -->
							<h1 class="product_name" itemprop="name"> {$product->name|truncate:42:"":true:true|escape:'html':'UTF-8'} </h1>
					</div>

					<!-- PRICE  -->
					<div class="content_prices hidden-xs col-xs-12 col-sm-4  col-md-4 text-right text-xs-right">
						<div class="content_prices">
							{if $product->show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
								<!-- prices -->
								<div>
									<p class="our_price_display" itemprop="offers" itemscope itemtype="https://schema.org/Offer">{strip}
										{if $product->quantity > 0}<link itemprop="availability" href="https://schema.org/InStock"/>{/if}
										{if $priceDisplay >= 0 && $priceDisplay <= 2}

                   {* PVE plus petire *}
                   {* <pre>{$combinations|print_r}</pre> *}
                   {foreach from=$combinations key=id_combinaison item=group_combinations}
                       {* <pre>{$group_combinations.price}</pre> *}
                       {* <pre>{$group_combinations.specific_price}</pre> *}
                     {if $group_combinations.price > 0}
                       <span class ="pve_petite "id="minimal_pve_price">{l s='A partir de '}</span><br class="pve_petite"/>
                       {break}
                     {/if}											
                   {/foreach}

											<span id="our_price_display" class="price" itemprop="price" content="{$productPrice}">{convertPrice price=$productPrice|floatval}</span>
											<!-- {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
												{if $priceDisplay == 1} {l s='tax excl.'}{else} {l s='tax incl.'}{/if}
											{/if} -->
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{hook h="displayProductPriceBlock" product=$product type="price"}
										{/if}
									{/strip}</p>
									<p id="reduction_percent" {if $productPriceWithoutReduction <= 0 || !$product->specificPrice || $product->specificPrice.reduction_type != 'percentage'} style="display:none;"{/if}>{strip}
										<span id="reduction_percent_display">
											{if $product->specificPrice && $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}
										</span>
									{/strip}</p>
									<p id="reduction_amount" {if $productPriceWithoutReduction <= 0 || !$product->specificPrice || $product->specificPrice.reduction_type != 'amount' || $product->specificPrice.reduction|floatval ==0} style="display:none"{/if}>{strip}
										<span id="reduction_amount_display">
										{if $product->specificPrice && $product->specificPrice.reduction_type == 'amount' && $product->specificPrice.reduction|floatval !=0}
											-{convertPrice price=$productPriceWithoutReduction|floatval-$productPrice|floatval}
										{/if}
										</span>
									{/strip}</p>
									<p id="old_price"{if (!$product->specificPrice || !$product->specificPrice.reduction)} class="hidden"{/if}>{strip}
										{if $priceDisplay >= 0 && $priceDisplay <= 2}
											{hook h="displayProductPriceBlock" product=$product type="old_price"}
											<span id="old_price_display"><span class="price">{if $productPriceWithoutReduction > $productPrice}{convertPrice price=$productPriceWithoutReduction|floatval}{/if}</span>{if $productPriceWithoutReduction > $productPrice && $tax_enabled && $display_tax_label == 1} {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}{/if}</span>
										{/if}
									{/strip}</p>
									{if $priceDisplay == 2}
										<br />
										<span id="pretaxe_price">{strip}
											<span id="pretaxe_price_display">{convertPrice price=$product->getPrice(false, $smarty.const.NULL)}</span> {l s='tax excl.'}
										{/strip}</span>
									{/if}
								</div> <!-- end prices -->
								{if $packItems|@count && $productPrice < $product->getNoPackPrice()}
									<p class="pack_price">{l s='Instead of'} <span style="text-decoration: line-through;">{convertPrice price=$product->getNoPackPrice()}</span></p>
								{/if}
								{if $product->ecotax != 0}
									<p class="price-ecotax">{l s='Including'} <span id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for ecotax'}
										{if $product->specificPrice && $product->specificPrice.reduction}
										<br />{l s='(not impacted by the discount)'}
										{/if}
									</p>
								{/if}
								{if !empty($product->unity) && $product->unit_price_ratio > 0.000000}
									{math equation="pprice / punit_price" pprice=$productPrice  punit_price=$product->unit_price_ratio assign=unit_price}
									<p class="unit-price"><span id="unit_price_display">{convertPrice price=$unit_price}</span> {l s='per'} {$product->unity|escape:'html':'UTF-8'}</p>
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
								{/if}
							{/if} {* close if for show price *}
							{hook h="displayProductPriceBlock" product=$product type="weight" hook_origin='product_sheet'}
	                        {hook h="displayProductPriceBlock" product=$product type="after_price"}

						</div> <!-- end content_prices -->

						<!-- FALG chrono -->
						{* get chrono caracteristique value *}
						
						{* comingsoon without date *}
						{if isset($product->date_add) && $product->date_add < $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' }
							{if isset($comingsoontplvalue) && $comingsoontplvalue == 'comingsoon'}
								<span id="chrono_without_date" class="hidden-xs">
									<i class="material-icons" style="font-size:40px;color:rgb(214, 157, 50);">schedule</i>
								</span>
							<!-- FALG New -->
							{elseif $product->new && $product->new == 1 && ($product->quantity > 0) && $product->available_for_order }
								<img class="hidden-xs" src="{$base_dir_ssl}img/icones/new.png"/>

							{/if}
						{/if}


					</div>
					<!-- // PRICE  -->
				</div> <!-- // rigth-row-1 -->

				<div class="row hidden-xs">
					<div class="col-md-12 col-xs-12">
						<hr style="border-color: #dbdbdb;">
					</div>
				</div>

				<div class="clear"></div>

				<div id="rigth-row-2" class="row hidden-xs">
					<div class="col-md-12">
							<!-- REFERENCE -->
							<p id="product_reference"{if empty($product->reference) || !$product->reference} style="display: none;"{/if}>
								{l s='Ref '}
								<span class="editable" itemprop="sku"{if !empty($product->reference) && $product->reference} content="{$product->reference}"{/if}>{if !isset($groups)}{$product->reference|escape:'html':'UTF-8'}{/if}</span>
							</p>
					</div>
				</div> <!-- // rigth-row-2 -->

				<!-- rigth-row-3 -->
				<div id="rigth-row-3" class="row">

					<div class="col-md-12 text-left">
					<!-- quantity wanted -->

						<!-- Flag GENRE -->	
						{* LINK - http://nemops.com/prestashop-all-product-categories/#.WWkfY3UpxQI *}
						{* <pre>{$product->category}</pre>				 *}
						{if $product->category != 'accessoires'}
							{* GET product ID *}
							{assign var=categories_custom value=Product::getProductCategoriesFull($smarty.get.id_product)}
							{foreach from=$categories_custom item=secondaryCategory}
											{if $secondaryCategory.name eq 'Femme'}
													{assign var=gendertype value='Femme'}
													{break}
											{elseif $secondaryCategory.name eq 'Enfant'}
												{assign var=gendertype value='Enfant'}
												{break}
											{/if}
							{/foreach}							
							{if isset($gendertype) and $gendertype eq 'Femme'}
								{if isset($groups)}
									{foreach from=$groups key=id_attribute_group item=group}
										{if $group.attributes|@count}
											{if ($group.group_type == 'radio')}
												{foreach from=$group.attributes key=id_attribute item=group_attribute} 
													{assign var=gender_size_keywords value=" / "|explode:$group_attribute}
													{assign var=gender_size_keywords_eu_trimed value=$gender_size_keywords[0]|trim}
													{assign var=gender_size_keywords_eu value=" "|explode:$gender_size_keywords_eu_trimed}
													{assign var=gender_size_keywords_eu_sup value="."|explode:$gender_size_keywords_eu[1]}													
													{if ($gender_size_keywords_eu[1]|intval > 40 )}
														{assign var=gendertype_unisexe value='unisexe'}
														{break}
													{/if}
												{/foreach}
											{/if}
										{/if}
									{/foreach}
								{/if}
							{/if}
							{* <pre>{$gendertype}</pre> *}
							<div class="row hidden-xs">
								<div class="col-md-12 col-xs-12">
									<section>
										<ul class="gender-label-group inline 
												{if isset($gendertype_unisexe) and $gendertype_unisexe eq 'unisexe'} men women
												{elseif isset($gendertype) and $gendertype eq 'Femme'} women
												{elseif (isset($gendertype) and $gendertype eq 'Enfant')} kids
												{else} men {/if}">
											<li class="gender-label"><a class="men" title="Men"><i class="gender-icon gender-icon-male"></i></a></li>
											<li class="gender-label"><a class="women" title="Women"><i class="gender-icon gender-icon-female"></i></a></li>
											<li class="gender-label"><a class="kids" title="Kids"><i class="gender-icon gender-icon-kids"></i></a></li>
										</ul>
									</section>
								</div>
							</div>
						{/if}

					<div class="row">
						<!-- QUANTITY  -->
						<div class="col-xs-12 col-sm-6 col-md-6">
							{if !$PS_CATALOG_MODE}
									<div id="quantity_wanted_p"{if !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
											<div class="row">
												<label class="col-xs-4 col-sm-5" for="quantity_wanted" style="margin-left:0">{l s='Quantity'}</label>
												<div class="col-xs-8 col-sm-7">
													<input type="text" readonly name="qty" id="quantity_wanted" class="text" value="{if isset($quantityBackup)}{$quantityBackup|intval}{else}{if $product->minimal_quantity > 1}{$product->minimal_quantity}{else}1{/if}{/if}" />
													<a href="#" data-field-qty="qty" class="btn btn-default button-minus product_quantity_down">
														<span><i class="icon-minus"></i></span>
													</a>
													<a href="#" data-field-qty="qty" class="btn btn-default button-plus product_quantity_up">
														<span><i class="icon-plus"></i></span>
													</a>
												</div>
											</div>
									</div>
									<!-- STOCK AVAILABILITY -->
									<div class="row">
										{if ($display_qties == 1 && !$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && $product->available_for_order)}
										<p id="pQuantityAvailable"{if $product->quantity <= 0} style="display: none;"{/if}>
											<span class="availability_quantity_value">{l s='Disponible'}</span>
											{* <span id="quantityAvailable">{$product->quantity|intval}</span>
											<span {if $product->quantity > 1} style="display: none;"{/if} id="quantityAvailableTxt">{l s='Item'}</span>
											<span {if $product->quantity == 1} style="display: none;"{/if} id="quantityAvailableTxtMultiple">{l s='Items'}</span> *}

											<!-- Message stock Limit et épuisé -->
											<span id="min_quantity_message">
												<span class="availability_quantity_value info_quantity">
												</span>
											</span>
										</p>
										{/if}
										<!-- availability or doesntExist -->
										{if isset($groups)}
											{foreach from=$groups key=id_attribute_group item=group}
																				{if $group.attributes|@count}
																					{if ($group.group_type == 'color')}
																							{assign var=isColorAttribute value=true}
																					{/if}
																				{/if}
											{/foreach}
										{/if}
										{if isset($isColorAttribute) && $isColorAttribute == 1}
										{*
											<p id="availability_statut" style="margin-left: 5px; margin-top: 10px; padding: 3px 8px 4px;" {if !$PS_STOCK_MANAGEMENT || ($product->quantity <= 0 && !$product->available_later && $allow_oosp) || ($product->quantity > 0 && !$product->available_now) || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
											<span id="availability_value" style="color: #e4752b !important;">
												{if $product->quantity <= 0}
													{if $PS_STOCK_MANAGEMENT && $allow_oosp}{$product->available_later}
													{else}
														{l s='This product is no longer in stock'}
													{/if}
												{elseif $PS_STOCK_MANAGEMENT}{$product->available_now}
												{/if}
											</span>
										</p>
										*}
										{/if}
										
										
										


										<!-- MESSAGE DELIVERY in France -->
										{* TODO | test localization & product price*}
										{if $productPrice >= 100}
										<p id ="fMessage"> {l s='Livraison gratuite (en europe)'} </p>
										{/if}


									</div>
							{/if}
						</div>
						<!-- // QUANTITY  -->

						<!-- ATTRIBUTS  -->
					<div class="col-xs-10 col-sm-6 product_attributes clearfix">
						{if isset($groups)}
							<div id="attributes">
								{foreach from=$groups key=id_attribute_group item=group}
									{if $group.attributes|@count}
										<fieldset class="row attribute_fieldset">
										<label class=" attribute_label" {if $group.group_type != 'color' && $group.group_type != 'radio'}for="group_{$id_attribute_group|intval}"{/if}>{$group.name|escape:'html':'UTF-8'}&nbsp;
										</label>
										{assign var="groupName" value="group_$id_attribute_group"}

										<div class="attribute_list ">

											{if ($group.group_type == 'select')}
													<select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="form-control attribute_select no-print">
														{foreach from=$group.attributes key=id_attribute item=group_attribute}
															<option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
														{/foreach}
													</select>

													<!-- COLOR  -->
											{elseif ($group.group_type == 'color')}
													<ul id="color_to_pick_list" class="clearfix">
														{assign var="default_colorpicker" value=""}
														{foreach from=$group.attributes key=id_attribute item=group_attribute}
															{assign var='img_color_exists' value=file_exists($col_img_dir|cat:$id_attribute|cat:'.jpg')}
															<li{if $group.default == $id_attribute} class="selected"{/if}>
																<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
																	{if $img_color_exists}
																		<img src="{$img_col_dir}{$id_attribute|intval}.jpg" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" width="20" height="20" />
																	{/if}
																</a>
															</li>
															{if ($group.default == $id_attribute)}
																{$default_colorpicker = $id_attribute}
															{/if}
														{/foreach}
													</ul>
													<input type="hidden" class="color_pick_hidden" name="{$groupName|escape:'html':'UTF-8'}" value="{$default_colorpicker|intval}" />

											<!-- TAILLE  -->
											{elseif ($group.group_type == 'radio')}

														{* SIZE CONVERTER *}
														<div class="size-converter-wrapper row-fluid" id="size-converter-wrapper">
															<a class="btn text-center white-bg" id="size-converter-eu" href="#product_tabs_options">EU</a>
															<a class="btn text-center white-bg" id="size-converter-us" href="#product_tabs_options">US</a>
															<a class="btn text-center white-bg" id="size-converter-uk" href="#product_tabs_options">UK</a>
															<a class="btn text-center white-bg" id="size-converter-cm" href="#product_tabs_options">CM</a>
															
															{if $product->category == 'puma'}
																{assign var="sizetable_brand" value='22'}
															{elseif $product->category == 'adidas'}
																{assign var="sizetable_brand" value='23'}
															{elseif $product->category == 'nike'}
																{assign var="sizetable_brand" value='24'}
															{elseif $product->category == 'asics'}
																 {assign var="sizetable_brand" value='25'}
																 {else}
																 	{assign var="sizetable_brand" value='26'}
															{/if}
															{* <a class="sizeTable-iframe" href="index.php?id_cms={$sizetable_brand}&controller=cms&content_only=1">{l s='Size Table'}</a>
															</a> *}
														</div>
														<ul>
															<span class="btn" id="btn-attributes-size"> <!-- to disable attributes for comming soon -->															
																{foreach from=$group.attributes key=id_attribute item=group_attribute}																
																<li>
																	<label for="radio_{$id_attribute|intval}">
																		<input type="radio" id="radio_{$id_attribute|intval}" class="attribute_radio hidden" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" />		

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
															</span>
														</ul>
												{/if}
											</div> <!-- end attribute_list -->
										</fieldset>
									{/if}
								{/foreach}
							</div> <!-- end attributes -->
						{/if}
					</div> <!-- end product_attributes -->
				</div>

					</div>
				</div>
				<!-- // rigth-row-3 -->

				{* rigth-row-4 *}
				{* minimal quantity wanted *}






			{*<div class="row"> *}

				<!-- rigth-row-5 -->
				<div id="rigth-row-5" class="row">

					<div class="col-md-offset-6 col-md-6 text-left">
					<!-- hidden datas -->
					<p class="hidden">
						<input type="hidden" name="token" value="{$static_token}" />
						<input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
						<input type="hidden" name="add" value="1" />
						<input type="hidden" name="id_product_attribute" id="idCombination" value="" />
					</p>

					<!-- box Chrno -->
					{if $product->available_for_order && isset($product->date_add) && $product->date_add > $smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
					{* Available in *}
					<div class="row text-center">{l s='Produit disponible dans'}</div>
						<div class="row box-cart-chrono" id="availability_date" >
							<script type="text/javascript">
							    var available_date = "{$product->date_add|date_format:'%Y-%m-%d %H:%M:%S'}";
							    var current_date = "{$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}";
							</script>
							<div class="panel panel-default">
							    <div class="panel-body">
							    	{* <span id="clock"> *}
							    	{* CHORNO *}
							    	
									<span id="timer">
									  <span id="days"></span><span class="chronounity">j</span>
									  <span id="hours"></span><span class="chronounity">h</span>
									  <span id="minutes"></span><span class="chronounity">m</span>
									  <span id="seconds"></span><span class="chronounity">s</span>
									</span>
							    	{* <img src="{$base_dir_ssl}img/icones/chrono.png"/> *}
							    </div>
							</div>
						</div>
					{/if}

					<div class="clearfix"></div>

					<!-- Cart button -->
					<!-- <div class="box-info-product"> -->
					<!-- TODO - delete corresponding css -->
					{if $product->available_for_order && isset($product->date_add) && $product->date_add < $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' && ! isset($comingsoontplvalue)}
						<div class="row box-cart-bottom">
							<div {if !$product->available_for_order || (isset($restricted_country_mode) && $restricted_country_mode) || $PS_CATALOG_MODE} class="unvisible"{/if} >
							{if $product->quantity}
								<p id="add_to_cart" class="buttons_bottom_block no-print">
									<button type="submit" name="Submit" class="btn exclusive">
										<i class="material-icons shopping-cart" style="color:#fff; margin-top: -10px; margin-right: .625rem; line-height: inherit;"></i>
										<span>{l s='Add to cart'}</span>

									</button>
								</p>
							{/if}
							</div>
							<div class="info"></div>
							{if isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS}{$HOOK_PRODUCT_ACTIONS}{/if}
						</div> <!-- end box-cart-bottom -->
					{/if}
					<!-- </div>  --><!-- end box-info-product -->

					</div> <!-- end col -->
				</div>
				<!-- // rigth-row-4 -->

			</form> <!-- // end FORM -->

			{/if}

		</div>

	</div> <!-- end primary_block -->

	{if !$content_only}
	{if (isset($quantity_discounts) && count($quantity_discounts) > 0)}
			<!-- quantity discount -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Volume discounts'}</h3>
				<div id="quantityDiscount">
					<table class="std table-product-discounts">
						<thead>
							<tr>
								<th>{l s='Quantity'}</th>
								<th>{if $display_discount_price}{l s='Price'}{else}{l s='Discount'}{/if}</th>
								<th>{l s='You Save'}</th>
							</tr>
						</thead>
						<tbody>
						{foreach from=$quantity_discounts item='quantity_discount' name='quantity_discounts'}
							{if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
								{$realDiscountPrice=$productPriceWithoutReduction|floatval-$quantity_discount.real_value|floatval}
							{else}
								{$realDiscountPrice=$productPriceWithoutReduction|floatval-($productPriceWithoutReduction*$quantity_discount.reduction)|floatval}
							{/if}
							<tr id="quantityDiscount_{$quantity_discount.id_product_attribute}" class="quantityDiscount_{$quantity_discount.id_product_attribute}" data-real-discount-value="{convertPrice price = $realDiscountPrice}" data-discount-type="{$quantity_discount.reduction_type}" data-discount="{$quantity_discount.real_value|floatval}" data-discount-quantity="{$quantity_discount.quantity|intval}">
								<td>
									{$quantity_discount.quantity|intval}
								</td>
								<td>
									{if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
										{if $display_discount_price}
											{if $quantity_discount.reduction_tax == 0 && !$quantity_discount.price}
												{convertPrice price = $productPriceWithoutReduction|floatval-($productPriceWithoutReduction*$quantity_discount.reduction_with_tax)|floatval}
											{else}
												{convertPrice price=$productPriceWithoutReduction|floatval-$quantity_discount.real_value|floatval}
											{/if}
										{else}
											{convertPrice price=$quantity_discount.real_value|floatval}
										{/if}
									{else}
										{if $display_discount_price}
											{if $quantity_discount.reduction_tax == 0}
												{convertPrice price = $productPriceWithoutReduction|floatval-($productPriceWithoutReduction*$quantity_discount.reduction_with_tax)|floatval}
											{else}
												{convertPrice price = $productPriceWithoutReduction|floatval-($productPriceWithoutReduction*$quantity_discount.reduction)|floatval}
											{/if}
										{else}
											{$quantity_discount.real_value|floatval}%
										{/if}
									{/if}
								</td>
								<td>
									<span>{l s='Up to'}</span>
									{if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
										{$discountPrice=$productPriceWithoutReduction|floatval-$quantity_discount.real_value|floatval}
									{else}
										{$discountPrice=$productPriceWithoutReduction|floatval-($productPriceWithoutReduction*$quantity_discount.reduction)|floatval}
									{/if}
									{$discountPrice=$discountPrice * $quantity_discount.quantity}
									{$qtyProductPrice=$productPriceWithoutReduction|floatval * $quantity_discount.quantity}
									{convertPrice price=$qtyProductPrice - $discountPrice}
								</td>
							</tr>
						{/foreach}
						</tbody>
					</table>
				</div>
			</section>
		{/if}

		{if isset($packItems) && $packItems|@count > 0}
		<section id="blockpack">
			<h3 class="page-product-heading">{l s='Pack content'}</h3>
			{include file="$tpl_dir./product-list.tpl" products=$packItems}
		</section>
		{/if}
		{if (isset($HOOK_PRODUCT_TAB) && $HOOK_PRODUCT_TAB) || (isset($HOOK_PRODUCT_TAB_CONTENT) && $HOOK_PRODUCT_TAB_CONTENT)}
		<!--HOOK_PRODUCT_TAB -->
		<section class="page-product-box">
			{$HOOK_PRODUCT_TAB}
			{if isset($HOOK_PRODUCT_TAB_CONTENT) && $HOOK_PRODUCT_TAB_CONTENT}{$HOOK_PRODUCT_TAB_CONTENT}{/if}
		</section>
		<!--end HOOK_PRODUCT_TAB -->
		{/if}




		<!-- CMS page  -->
		

		{assign var=cms_content_17 value=CMS::getCMSContent(17, intval($cookie->id_lang), true)}
		{assign var=cms_content_18 value=CMS::getCMSContent(18, intval($cookie->id_lang), true)}


		<div class="row">
			<div class="tabbable col-xs-12 col-md-6" id="tabbable_product">
				<!-- FEATURES from `ps_feature_lang` table -->
				<!-- genre : 10 | Sortie : 8  | Modèle originale : 9 -->
				<div class="col-row" id="table_social_media">
					<section>
						<ul id="idTab2" class="bullet">
							{foreach from=$features item=feature}
									{if $feature.id_feature eq "8"}
										<li>
										{if isset($feature.value)}
												<span>{$feature.name|escape:'html':'UTF-8'}</span>
												<span>{$feature.value|escape:'html':'UTF-8'}</span>
										{/if}
										</li>
									{/if}
									{if $feature.id_feature eq "9"}
										<li>
										{if isset($feature.value)}
												<span>{$feature.name|escape:'html':'UTF-8'}</span>
												<span>{$feature.value|escape:'html':'UTF-8'}</span>
										{/if}
										</li>
									{/if}
							{/foreach}
						</ul>
					</section>
				<!-- social sharing -->
				<div data-easyshare data-easyshare-url="{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}">
				{if isset($HOOK_EXTRA_RIGHT) && $HOOK_EXTRA_RIGHT}{$HOOK_EXTRA_RIGHT}{/if}
			</div>
				</div>
				<!-- // FEATURES -->

				<!-- full description - -->
				<div class="col-row hidden-xs">
				<!-- short_description_block -->
						{if $product->description_short || $packItems|@count > 0}
						<div id="short_description_block">
							{if $product->description_short}
								<div id="short_description_content" class="rte align_justify" itemprop="description"><h1 class="titre_description" itemprop="name">{$product->name|escape:'html':'UTF-8'}</h1>{$product->description_short}</div>
							{/if}
						</div>
						{/if}
				</div>
				<!-- // full description -->

			</div>





		<!-- CMS page Acordion -->
			<div class="panel-group col-xs-12 col-md-6" id="accordion">
			    {if isset($product) && $product->description}
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse0">
			          <span class="pull-right"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
			          	{l s='Description'}
			          </a>
			        </h4>
			      </div>
			      <div id="collapse0" class="panel-collapse collapse in">
			        <div class="panel-body">
							<div  class="rte text-justify">{$product->description}</div>
			        </div>
			      </div>
			    </div>
			    {/if}


			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse2">
			          	<span class="pull-right"><i class="fa fa-caret-left" aria-hidden="true"></i></span>
			          	{l s='Livraison'}
			          </a>
			        </h4>
			      </div>
			      <div id="collapse2" class="panel-collapse collapse">
			        <div class="panel-body">{$cms_content_17.content}</div>
			      </div>
			    </div>
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse3">
			          	<span class="pull-right"><i class="fa fa-caret-left" aria-hidden="true"></i></span>
			          	{l s='Services'}
			          </a>
			        </h4>
			      </div>
			      <div id="collapse3" class="panel-collapse collapse">
			        <div class="panel-body">{$cms_content_18.content}</div>
			      </div>
			    </div>
			  </div>
		</div>

		<br />


		{if isset($accessories) && $accessories}
			<!--ZONE PUSH - Accessories -->
			<section class=" row page-product-box">
				<h3 class="page-product-heading">{l s='Vous aimerez également'}</h3>
				<div class="block products_block accessories-block clearfix">
					<div class="block_content">
						<ul id="bxslider" class="bxslider clearfix">
							{foreach from=$accessories item=accessory name=accessories_list}
								{if ($accessory.allow_oosp || $accessory.quantity_all_versions > 0 || $accessory.quantity > 0) && $accessory.available_for_order && !isset($restricted_country_mode)}
									{assign var='accessoryLink' value=$link->getProductLink($accessory.id_product, $accessory.link_rewrite, $accessory.category)}
									<li class="item product-box ajax_block_product{if $smarty.foreach.accessories_list.first} first_item{elseif $smarty.foreach.accessories_list.last} last_item{else} item{/if} product_accessories_description">

										<div class="row text-right s_title_block">
											<h5 class="product-name">
													<a href="{$accessoryLink|escape:'html':'UTF-8'}">
														{* {$accessory.name|truncate:30:'...':true|escape:'html':'UTF-8'} *}
														{$accessory.name|escape:'html':'UTF-8'}
													</a>
											</h5>
											{if $accessory.show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
											<span class="price">
													{if $priceDisplay != 1}
														{displayWtPrice p=$accessory.price}
													{else}
														{displayWtPrice p=$accessory.price_tax_exc}
													{/if}
													{hook h="displayProductPriceBlock" product=$accessory type="price"}
											</span>
											{/if}
											{hook h="displayProductPriceBlock" product=$accessory type="after_price"}
										</div>

										<div class="row product_desc">
											<a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{$accessory.legend|escape:'html':'UTF-8'}" class="product-image product_image">
												<img class="lazyOwl" src="{$link->getImageLink($accessory.link_rewrite, $accessory.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$accessory.legend|escape:'html':'UTF-8'}" width="{$homeSize.width}" height="{$homeSize.height}"/>
											</a>
											<div class="block_description">
												<a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{l s='More'}" class="product_description">
													{$accessory.description_short|strip_tags|truncate:25:'...'}
												</a>
											</div>
										</div>
										<!-- button ajout panier -->
										<!-- <div class="clearfix" style="margin-top:5px">
											{if !$PS_CATALOG_MODE && ($accessory.allow_oosp || $accessory.quantity > 0) && isset($add_prod_display) && $add_prod_display == 1}
												<div class="no-print">
													<a class="exclusive button ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$accessory.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}" data-id-product="{$accessory.id_product|intval}" title="{l s='Add to cart'}">
														<span>{l s='Add to cart'}</span>
													</a>
												</div>
											{/if}
										</div> -->
									</li>
								{/if}
							{/foreach}
						</ul>
					</div>
				</div>
			</section>
			<!--end Accessories -->
		{elseif isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}
			<!-- ZONE PUSH - Produit même catégorie -->
			{$HOOK_PRODUCT_FOOTER}
		{/if}



		<!-- description & features -->
		{if (isset($product) && $product->description) || (isset($features) && $features) || (isset($accessories) && $accessories) || (isset($HOOK_PRODUCT_TAB) && $HOOK_PRODUCT_TAB) || (isset($attachments) && $attachments) || isset($product) && $product->customizable}

			{if isset($product) && $product->customizable}

			<!--end Customization -->
			{/if}
		{/if}
	{/if}
</div> <!-- itemscope product wrapper -->
{strip}
{if isset($isColorAttribute) && $isColorAttribute == 1}
{addJsDef isColorAttribute=$isColorAttribute}
{/if}
{if isset($comingsoontplvalue) && $comingsoontplvalue eq 'comingsoon'}
{addJsDef comingsoonvalue=$comingsoontplvalue}
{/if}

{if isset($smarty.get.ad) && $smarty.get.ad}
	{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
	{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
{addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
{addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
{addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
{addJsDef attributesCombinations=$attributesCombinations}
{addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
{if isset($combinations) && $combinations}
	{addJsDef combinations=$combinations}
	{addJsDef combinationsFromController=$combinations}
	{addJsDef displayDiscountPrice=$display_discount_price}
	{addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
{/if}
{if isset($combinationImages) && $combinationImages}
	{addJsDef combinationImages=$combinationImages}
{/if}
{addJsDef customizationId=$id_customization}
{addJsDef customizationFields=$customizationFields}
{addJsDef default_eco_tax=$product->ecotax|floatval}
{addJsDef displayPrice=$priceDisplay|intval}
{addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
{if isset($cover.id_image_only)}
	{addJsDef idDefaultImage=$cover.id_image_only|intval}
{else}
	{addJsDef idDefaultImage=0}
{/if}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef img_prod_dir=$img_prod_dir}
{addJsDef id_product=$product->id|intval}
{addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
{addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
{addJsDef minimalQuantity=$product->minimal_quantity|intval}
{addJsDef noTaxForThisProduct=$no_tax|boolval}
{if isset($customer_group_without_tax)}
	{addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
{else}
	{addJsDef customerGroupWithoutTax=false}
{/if}
{if isset($group_reduction)}
	{addJsDef groupReduction=$group_reduction|floatval}
{else}
	{addJsDef groupReduction=false}
{/if}
{addJsDef oosHookJsCodeFunctions=Array()}
{addJsDef productHasAttributes=isset($groups)|boolval}
{addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
{addJsDef productPriceTaxIncluded=($product->getPriceWithoutReduct(false)|default:'null' - $product->ecotax * (1 + $ecotaxTax_rate / 100))|floatval}
{addJsDef productBasePriceTaxExcluded=($product->getPrice(false, null, 6, null, false, false) - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcl=($product->getPrice(false, null, 6, null, false, false)|floatval)}
{addJsDef productBasePriceTaxIncl=($product->getPrice(true, null, 6, null, false, false)|floatval)}
{addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
{addJsDef productAvailableForOrder=$product->available_for_order|boolval}
{addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
{addJsDef productPrice=$productPrice|floatval}
{addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
{addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
{addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
{if $product->specificPrice && $product->specificPrice|@count}
	{addJsDef product_specific_price=$product->specificPrice}
{else}
	{addJsDef product_specific_price=array()}
{/if}


{* =========================================  assign defined limited quantity variable to product.js  / 10 if limit is not defined in BO *}
{assign var=quantityLimitedAvailableTMP value=10}
{foreach from=$features item=feature}
	{if $feature.name eq 'Quantité-Commandable'}
		{if isset($feature.value)}
			{assign var=quantityLimitedAvailableTMP value=$feature.value}
		{/if}
	{/if}
{/foreach}
{addJsDef quantityLimitedAvailable=$quantityLimitedAvailableTMP}



{* =========================================  assign quantity variable to product.js   *}
{if $display_qties == 1 && $product->quantity}
	{addJsDef quantityAvailable=$product->quantity}
{else}
	{addJsDef quantityAvailable=0}
{/if}

{addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
	{addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
{else}
	{addJsDef reduction_percent=0}
{/if}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
	{addJsDef reduction_price=$product->specificPrice.reduction|floatval}
{else}
	{addJsDef reduction_price=0}
{/if}
{if $product->specificPrice && $product->specificPrice.price}
	{addJsDef specific_price=$product->specificPrice.price|floatval}
{else}
	{addJsDef specific_price=0}
{/if}
{addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
{addJsDef stock_management=$PS_STOCK_MANAGEMENT|intval}
{addJsDef taxRate=$tax_rate|floatval}
{addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
{addJsDefL name=stockepuise}{l s='Ce produit est momentanément en rupture de stock' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
{addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
{addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
{addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
{addJsDefL name='message_choice_attribute'}{l s='Merci de sélectionner une taille.'}{/addJsDefL}
{/strip}
{/if}