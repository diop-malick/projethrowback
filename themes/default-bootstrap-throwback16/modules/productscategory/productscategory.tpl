
{if count($categoryProducts) > 0 && $categoryProducts !== false}
<section class="row page-product-box blockproductscategory">
	
	<h3 class="productscategory_h3 page-product-heading">
		{* {if $categoryProducts|@count == 1}
			{l s='%s other product in the same category:' sprintf=[$categoryProducts|@count] mod='productscategory'}
		{else}
			{l s='%s other products in the same category:' sprintf=[$categoryProducts|@count] mod='productscategory'}
		{/if} *}
		{l s='Vous aimerez également'}
	</h3>

	<!-- <div class="block products_block accessories-block clearfix"> -->
	<div id="productscategory_list" class=" block products_block clearfix">
		<div class="block_content">
			<ul id="bxslider1" class="bxslider clearfix">
			{foreach from=$categoryProducts item='categoryProduct' name=categoryProduct}
				<li class="product-box item ajax_block_product{if $smarty.foreach.categoryProduct.first} first_item{elseif $smarty.foreach.categoryProduct.last} last_item{else} item{/if}">
					
				<div class="row text-right s_title_block">
					<!-- PRODUCT NAME -->
					<h5 itemprop="name" class="product-name">
						<a href="{$link->getProductLink($categoryProduct.id_product, $categoryProduct.link_rewrite, $categoryProduct.category, $categoryProduct.ean13)|escape:'html':'UTF-8'}" title="{$categoryProduct.name|htmlspecialchars}">{$categoryProduct.name|truncate:14:'...'|escape:'html':'UTF-8'}</a>
					</h5>
					<!-- PRODUCT PRICE  -->
					{if $ProdDisplayPrice && $categoryProduct.show_price == 1 && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
						<div class="content_price">
						<p class="price_display">
						{if isset($categoryProduct.specific_prices) && $categoryProduct.specific_prices
						&& ($categoryProduct.displayed_price|number_format:2 !== $categoryProduct.price_without_reduction|number_format:2)}

							<span class="old-price">{displayWtPrice p=$categoryProduct.price_without_reduction}</span>
							<br>
							<span class="price special-price">{convertPrice price=$categoryProduct.displayed_price}</span>
							<!-- {if $categoryProduct.specific_prices.reduction && $categoryProduct.specific_prices.reduction_type == 'percentage'}
								<span class="price-percent-reduction small">-{$categoryProduct.specific_prices.reduction * 100}%</span>
							{/if} -->
						{else}
							<span class="price">{convertPrice price=$categoryProduct.displayed_price}</span>
						{/if}
						</p>
										<!-- FALG chrono -->
                                            {* get chrono caracteristique value *}
                                            {foreach from=$categoryProduct.features item=feature}
                                                    {if $feature.name eq 'Type de produit'}
                                                        {if isset($feature.value)}
                                                            {assign var=comingsoonvalue value=$feature.value}
                                                        {/if}
                                                    {/if}
                                            {/foreach}
                                            <!-- FALG Comming soon --> 
                                            {* comingsoon without date *}
                                            {if $comingsoonvalue eq 'comingsoon'}
                                                {addJsDef comingsoonvalue=$comingsoonvalue}
                                                <i class="material-icons" style="font-size:40px;color:rgb(214, 157, 50); margin-right:25px; display:inline-block;">schedule</i>
                                            <!-- FALG New -->
                                            <!-- FALG Comming soon -->
                                            {elseif $categoryProduct.date_add > $smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
                                                <img src="{$base_dir}/img/icones/chrono.png"/>
                                            <!-- show new flag if date_add is not after now -->
                                            {elseif isset($categoryProduct.new) && $categoryProduct.new == 1}
                                                <img src="{$base_dir}/img/icones/new.png"/>
                                            {/if}
                                            {* reset comming soon value *}
                                            {assign var=comingsoonvalue value=''}
						</div>



						{else}
						<br />
						{/if}



				</div>

				<div class="row product_desc">
					<a href="{$link->getProductLink($categoryProduct.id_product, $categoryProduct.link_rewrite, $categoryProduct.category, $categoryProduct.ean13)}" class="lnk_img product-image product_image" title="{$categoryProduct.name|htmlspecialchars}">

					<img src="{$link->getImageLink($categoryProduct.link_rewrite, $categoryProduct.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$categoryProduct.name|htmlspecialchars}" />

					</a>
				</div>

				<!-- bouton ajout panier -->

				<!-- <div class="clearfix" style="margin-top:5px">
						{if !$PS_CATALOG_MODE && ($categoryProduct.allow_oosp || $categoryProduct.quantity > 0)}
							<div class="no-print">
								<a class="exclusive button ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$categoryProduct.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}" data-id-product="{$categoryProduct.id_product|intval}" title="{l s='Add to cart' mod='productscategory'}">
									<span>{l s='Add to cart' mod='productscategory'}</span>
								</a>
							</div>
						{/if}
				</div> -->


				</li>
			{/foreach}
			</ul>
		</div>
	</div>
	<!-- </div> -->
</section>
{/if}
