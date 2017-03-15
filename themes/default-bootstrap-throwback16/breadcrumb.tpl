
<!-- Hide breadcrump in myaccount  -->
{if {$smarty.get.controller} eq 'myaccount' or {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'cms'  or {$smarty.get.controller} eq 'identity' or {$smarty.get.controller} eq 'order' or {$smarty.get.controller} eq 'history' or {$smarty.get.controller} eq 'addresses' or {$smarty.get.controller} eq 'address'}

<!-- TODO -->
{else}



<!-- Breadcrumb -->
{if isset($smarty.capture.path)}{assign var='path' value=$smarty.capture.path}{/if}


<div class="breadcrumb clearfix" {if {$smarty.get.controller} eq 'product'}id="breadcrumb_product"{/if}>

	<a class="home" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{l s='Return to Home'}"><span>Home</span></a>
	{if isset($path) AND $path}
		<span class="navigation-pipe"{if isset($category) && isset($category->id_category) && $category->id_category == (int)Configuration::get('PS_ROOT_CATEGORY')} style="display:none;"{/if}>{$navigationPipe}</span>
		{if $path|strpos:'span' !== false}
        {if isset($smarty.get.search_query) && isset($smarty.get.results) && $smarty.get.results >= 1 && isset($smarty.server.HTTP_REFERER) && isset($page_name) && $page_name == "product"}
          {capture}{if isset($smarty.get.HTTP_REFERER) && $smarty.get.HTTP_REFERER}{$smarty.get.HTTP_REFERER}{elseif isset($smarty.server.HTTP_REFERER) && $smarty.server.HTTP_REFERER}{$smarty.server.HTTP_REFERER}{/if}{/capture}
          {assign var="split_size" value=$path|strip_tags}
          {assign var="split_size2" value="{$navigation-pipe}"|explode:$split_size}
          {assign var="product_name" value=$split_size2[({$split_size2|@count}) - 1]}

            <span class="navigation_page"><span>{l s='VOTRE RECHERCHE'}&nbsp;&nbsp;</span><span class="navigation-pipe">></span><span itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a itemprop="url" href="{$smarty.capture.default|escape:'html':'UTF-8'|secureReferrer|regex_replace:'/[\?|&]content_only=1/':''}" title="{$smarty.get.search_query|upper}" ><span itemprop="title">{$smarty.get.search_query|upper} ({$smarty.get.results} {l s='résultats'})</span></a></span>
            <span class="navigation-pipe">></span>
            {if isset($product_name) && $product_name}{$product_name}{/if}</span>

        {else}
		        <span class="navigation_page">{$path|@replace:'<a ': '<span class="breadcrumb_category" itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a itemprop="url" '|@replace:'data-gg="">': '><span class="breadcrumb_category" itemprop="title">'|@replace:'</a>': '</span></a></span>'}</span>
        {/if}
    {elseif {$smarty.get.controller} eq 'search'}
            <span class="navigation_page"><span>{l s='RECHERCHE'}</span><span class="navigation-pipe">{$navigationPipe|escape:'html':'UTF-8'}</span>
            <span itemprop="title">{$smarty.get.search_query|upper}</span>
    {else}
			{$path}
		{/if}
	{/if}
</div>
<!--{if isset($smarty.get.search_query) && isset($smarty.get.results) && $smarty.get.results > 1 && isset($smarty.server.HTTP_REFERER)}
<div class="pull-right">
	<strong>
		{capture}{if isset($smarty.get.HTTP_REFERER) && $smarty.get.HTTP_REFERER}{$smarty.get.HTTP_REFERER}{elseif isset($smarty.server.HTTP_REFERER) && $smarty.server.HTTP_REFERER}{$smarty.server.HTTP_REFERER}{/if}{/capture}
		<a href="{$smarty.capture.default|escape:'html':'UTF-8'|secureReferrer|regex_replace:'/[\?|&]content_only=1/':''}" name="back">
			<i class="icon-chevron-left left"></i> {l s='Back to Search results for "%s" (%d other results)' sprintf=[$smarty.get.search_query,$smarty.get.results]}
		</a>
	</strong>
</div>
{/if}
-->
<!-- /Breadcrumb -->

{/if}
