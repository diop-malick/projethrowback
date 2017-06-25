{if $MENU != ''}
<!-- Menu Horizontal -->
<div class="row" id ="top_menu_row">

	{if $page_name == 'index'}
	<div id="block_top_menu" class="sf-contener sf-contener_opacity clearfix col-lg-12">
	{else}
	<div id="block_top_menu" class="sf-contener clearfix col-lg-12">
	{/if}

		<div class="cat-title hidden-xs">{l s="Menu" mod="blocktopmenu"}</div>

			<ul class="sf-menu clearfix menu-content">
			{$MENU}
			{if $MENU_SEARCH}
				<li class="sf-search noBack" style="float:right">
					<form id="searchbox" action="{$link->getPageLink('search')|escape:'html':'UTF-8'}" method="get">
						<p>
							<input type="hidden" name="controller" value="search" />
							<input type="hidden" value="position" name="orderby"/>
							<input type="hidden" value="desc" name="orderway"/>
							<input type="text" name="search_query" value="{if isset($smarty.get.search_query)}{$smarty.get.search_query|escape:'html':'UTF-8'}{/if}" />
						</p>
					</form>
				</li>
			{/if}
		</ul>
	</div>
</div>
<!--// Menu Horizontal -->
{/if}
{strip}
{if isset($smarty.server.HTTP_HOST) && $smarty.server.HTTP_HOST}
{addJsDef baseDir=$smarty.server.HTTP_HOST|escape:'html':'UTF-8'}
{/if}
{/strip}
