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
{include file="$tpl_dir./errors.tpl"}
{if isset($category)}
	{if $category->id AND $category->active}
    	{addJsDef is_categorie=1}
    	<div class="row filter-line">

				<div class="container-fluid">
				
				        <div class="col-md-3 categ-name">
							<h3 class="page-heading{if (isset($subcategories) && !$products) || (isset($subcategories) && $products) || !isset($subcategories) && $products} product-listing{/if}">
								<span class="cat-name">{$category->name|escape:'html':'UTF-8'}{if isset($categoryNameComplement)}{$categoryNameComplement|escape:'html':'UTF-8'} ({$nb_products}){/if}
								</span>
							</h3>
					        
				        </div>

				        <div class="col-md-9 pull-right">
				        	{hook h="categoryTop"}
				        </div>
				</div>
		</div><!-- // row  -->

		{if isset($subcategories)}
        {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
		<!-- Subcategories -->
		<div id="subcategories">
			<p class="subcategory-heading">{l s='Subcategories'}</p>
			<ul class="clearfix">
			{foreach from=$subcategories item=subcategory}
				<li>
                	<div class="subcategory-image">
						<a href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}" title="{$subcategory.name|escape:'html':'UTF-8'}" class="img">
						{if $subcategory.id_image}
							<img class="replace-2x" src="{$link->getCatImageLink($subcategory.link_rewrite, $subcategory.id_image, 'medium_default')|escape:'html':'UTF-8'}" alt="{$subcategory.name|escape:'html':'UTF-8'}" width="{$mediumSize.width}" height="{$mediumSize.height}" />
						{else}
							<img class="replace-2x" src="{$img_cat_dir}{$lang_iso}-default-medium_default.jpg" alt="{$subcategory.name|escape:'html':'UTF-8'}" width="{$mediumSize.width}" height="{$mediumSize.height}" />
						{/if}
					</a>
                   	</div>
					<h5><a class="subcategory-name" href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}">{$subcategory.name|truncate:25:'...'|escape:'html':'UTF-8'}</a></h5>
					{if $subcategory.description}
						<div class="cat_desc">{$subcategory.description}</div>
					{/if}
				</li>
			{/foreach}
			</ul>
		</div>
        {/if}
		{/if}
       
		{if $products}
			<div class="row">
			{include file="$tpl_dir./breadcrumb.tpl"}
			<div class="content_sortPagiBar clearfix col-md-6 col-sm-6">
            	<div class="sortPagiBar clearfix">
            		{include file="./product-sort.tpl"}
                	{include file="./nbr-product-page.tpl"}
				</div>
                <div class="top-pagination-content clearfix">
                	{include file="./product-compare.tpl"}
					{include file="$tpl_dir./pagination.tpl"}
                </div>
			</div>
			</div>
			{include file="./product-list.tpl" products=$products}
			<div class="content_sortPagiBar">
				<div class="bottom-pagination-content clearfix">
					{include file="./product-compare.tpl" paginationId='bottom'}
                    {include file="./pagination.tpl" paginationId='bottom'}
				</div>
			</div>
		{/if}
	{elseif $category->id}
		<p class="alert ">{l s='This category is currently unavailable.'}</p>
	{/if}
{/if}
