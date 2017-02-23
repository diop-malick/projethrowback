{* SNE - 2017 *}


<!-- MODULE Block new products -->
<section class="page-product-box">
    <h4 class="title_block">
            <a href="{$link->getPageLink('new-products')|escape:'html'}" title="{l s='New products' mod='blocknewproducts'}">{l s='New products' mod='blocknewproducts'}</a>
    </h4>
    <div class="block products_block accessories-block clearfix">
                    <div class="block_content">
                        <ul id="bxslider" class="bxslider clearfix">
                            {foreach from=$new_products item=accessory name=accessories_list}
                                {if ($accessory.allow_oosp || $accessory.quantity_all_versions > 0 || $accessory.quantity > 0) && $accessory.available_for_order && !isset($restricted_country_mode)}
                                    {assign var='accessoryLink' value=$link->getProductLink($accessory.id_product, $accessory.link_rewrite, $accessory.category)}
                                    <li class="item product-box ajax_block_product{if $smarty.foreach.accessories_list.first} first_item{elseif $smarty.foreach.accessories_list.last} last_item{else} item{/if} product_accessories_description">

                                        <div class="row text-right s_title_block">
                                            <h5 class="product-name">
                                                    <a href="{$accessoryLink|escape:'html':'UTF-8'}">
                                                        {$accessory.name|truncate:20:'...':true|escape:'html':'UTF-8'}
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

<!-- 
<div id="new-products_block_right" class="block products_block">
	<h4 class="title_block">
    	<a href="{$link->getPageLink('new-products')|escape:'html'}" title="{l s='New products' mod='blocknewproducts'}">{l s='New products' mod='blocknewproducts'}</a>
    </h4>
    <div class="block_content products-block">
        {if $new_products !== false}
            <ul class="products">
                {foreach from=$new_products item=newproduct name=myLoop}
                    <li class="clearfix">
                        <a class="products-block-image" href="{$newproduct.link|escape:'html'}" title="{$newproduct.legend|escape:html:'UTF-8'}"><img class="replace-2x img-responsive" src="{$link->getImageLink($newproduct.link_rewrite, $newproduct.id_image, 'small_default')|escape:'html'}" alt="{$newproduct.name|escape:html:'UTF-8'}" /></a>
                        <div class="product-content">
                        	<h5>
                            	<a class="product-name" href="{$newproduct.link|escape:'html'}" title="{$newproduct.name|escape:html:'UTF-8'}">{$newproduct.name|strip_tags|escape:html:'UTF-8'}</a>
                            </h5>
                        	<p class="product-description">{$newproduct.description_short|strip_tags:'UTF-8'|truncate:75:'...'}</p>
                            {if (!$PS_CATALOG_MODE AND ((isset($newproduct.show_price) && $newproduct.show_price) || (isset($newproduct.available_for_order) && $newproduct.available_for_order)))}
                            	{if isset($newproduct.show_price) && $newproduct.show_price && !isset($restricted_country_mode)}
                                    <div class="price-box">
                                        <span class="price">
                                        	{if !$priceDisplay}{convertPrice price=$newproduct.price}{else}{convertPrice price=$newproduct.price_tax_exc}{/if}
                                        </span>
                                        {hook h="displayProductPriceBlock" product=$newproduct type="price"}
                                    </div>
                                {/if}
                            {/if}
                        </div>
                    </li>
                {/foreach}
            </ul>
            <div>
                <a href="{$link->getPageLink('new-products')|escape:'html'}" title="{l s='All new products' mod='blocknewproducts'}" class="btn btn-default button button-small"><span>{l s='All new products' mod='blocknewproducts'}<i class="icon-chevron-right right"></i></span></a>
            </div>
        {else}
        	<p>&raquo; {l s='Do not allow new products at this time.' mod='blocknewproducts'}</p>
        {/if}
    </div>
</div> 
-->



<!-- /MODULE Block new products -->