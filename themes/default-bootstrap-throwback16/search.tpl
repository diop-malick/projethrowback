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

{capture name=path}{l s='Search'}{/capture}

<h1
{if isset($instant_search) && $instant_search}id="instant_search_results"{/if}
class="page-heading {if !isset($instant_search) || (isset($instant_search) && !$instant_search)} product-listing{/if}">

  {if $nbProducts > 0}
      {if isset($search_query) && $search_query }

        {if !empty($alias) && ($alias != $search_query) }
          {l s='Aucun article ne correspond à la recherche : '}{$search_query|escape:'html':'UTF-8'}<br/>
          <span class="lighter">{l s='Nous vous proposons cependant une recherche avec le terme : '}"{$alias|escape:'html':'UTF-8'}"({l s='%d results have been found.' sprintf=$nbProducts|intval})</span>
         {else}
              {l s='Search'}:
              {$search_query|escape:'html':'UTF-8'} ({l s='%d results have been found.' sprintf=$nbProducts|intval})
          {/if}
        {elseif $search_tag}{l s='Search'}&nbsp;{$search_tag|escape:'html':'UTF-8'}
        {elseif $ref}{l s='Search'}&nbsp;{$ref|escape:'html':'UTF-8'}
        {/if}

    {/if}
    {if isset($instant_search) && $instant_search}
        <a href="#" class="close">
            {l s='Return to the previous page'}
        </a>

    {/if}
</h1>

{include file="$tpl_dir./errors.tpl"}
{if !$nbProducts}
	<!--<p class="alert alert-warning">
		{if isset($search_query) && $search_query}
			{l s='No results were found for your search'}&nbsp;"{if isset($search_query)}{$search_query|escape:'html':'UTF-8'}{/if}"
		{elseif isset($search_tag) && $search_tag}
			{l s='No results were found for your search'}&nbsp;"{$search_tag|escape:'html':'UTF-8'}"
		{else}
			{l s='Please enter a search keyword'}
		{/if}
	</p>
-->
<p class=title_zero_result_page>{l s='Aucune correspondance pour votre recherche : '}"{if isset($search_query) && $search_query }{$search_query|escape:'html':'UTF-8'}{/if}" </p>
  {hook h="DisplaySearch"}

{else}
	{if isset($instant_search) && $instant_search}
        <p class="alert alert-info">
            {if $nbProducts == 1}{l s='%d result has been found.' sprintf=$nbProducts|intval}{else}{l s='%d results have been found.' sprintf=$nbProducts|intval}{/if}
        </p>
    {/if}
    <div class="content_sortPagiBar">
        <div class="sortPagiBar clearfix {if isset($instant_search) && $instant_search} instant_search{/if}">
            {include file="$tpl_dir./product-sort.tpl"}
            {if !isset($instant_search) || (isset($instant_search) && !$instant_search)}
                {include file="./nbr-product-page.tpl"}
            {/if}
        </div>
    	<div class="top-pagination-content clearfix">
            {include file="./product-compare.tpl"}
            {if !isset($instant_search) || (isset($instant_search) && !$instant_search)}
                {include file="$tpl_dir./pagination.tpl" no_follow=1}
            {/if}
        </div>
	</div>
	{include file="$tpl_dir./product-list.tpl" products=$search_products}
    <div class="content_sortPagiBar">
    	<div class="bottom-pagination-content clearfix">
        	{include file="./product-compare.tpl"}
        	{if !isset($instant_search) || (isset($instant_search) && !$instant_search)}
                {include file="$tpl_dir./pagination.tpl" paginationId='bottom' no_follow=1}
            {/if}
        </div>
    </div>
{/if}
