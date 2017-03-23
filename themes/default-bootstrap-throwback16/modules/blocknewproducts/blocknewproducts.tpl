{* SNE - 2017 *}


<!-- MODULE Block new products -->
<section class=" row page-product-box">
    <h4 class="title_block">
          {if {$smarty.get.controller} eq 'order'}
            {l s='Découvrez nos nouveautés' mod='blocknewproducts'}
          {else}{l s='New products' mod='blocknewproducts'}
          {/if}
            <!-- <a href="{$link->getPageLink('new-products')|escape:'html'}" title="{l s='New products' mod='blocknewproducts'}">{l s='New products' mod='blocknewproducts'}
            </a> -->
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
                                        <div class="row text-right s_title_block">
                                            <!-- FALG chrono -->
                                            {* get chrono caracteristique value *}
                                            {foreach from=$accessory.features item=feature}
                                                    {if $feature.name eq 'comingsoon'}
                                                        {if isset($feature.value)}
                                                            {assign var=comingsoonvalue value=$feature.value}
                                                        {/if}
                                                    {/if}
                                            {/foreach}
                                            <!-- FALG Comming soon --> 
                                            {* comingsoon without date *}
                                            {if $comingsoonvalue eq 'yes'}
                                                {addJsDef comingsoonvalue=$comingsoonvalue}
                                                <i class="material-icons" style="font-size:40px;color:rgb(214, 157, 50); margin-right:25px; display:inline-block;">schedule</i>
                                            <!-- FALG New -->
                                            <!-- FALG Comming soon -->
                                            {elseif $accessory.date_add > $smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
                                                <img src="{$base_dir}/img/icones/chrono.png"/>
                                            <!-- show new flag if date_add is not after now -->
                                            {elseif isset($accessory.new) && $accessory.new == 1}
                                                <img src="{$base_dir}/img/icones/new.png"/>
                                            {/if}
                                            {* reset comming soon value *}
                                            {assign var=comingsoonvalue value=''}
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
