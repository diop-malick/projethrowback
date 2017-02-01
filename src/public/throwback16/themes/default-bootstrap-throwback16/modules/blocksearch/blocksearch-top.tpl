<!-- Block search module TOP -->
<div id="search_block_top" class="col-sm-3 clearfix">
 	<button type="button" id="toggleMenu" class="toggle_menu maxi">
      <i class="fa fa-bars"></i>
    </button>
	<form id="searchbox" method="get" action="{$link->getPageLink('search', null, null, null, false, null, true)|escape:'html':'UTF-8'}" >
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
		<input class="search_query form-control" type="text" id="search_query_top" name="search_query" placeholder="{l s='Search' mod='blocksearch'}" value="{$search_query|escape:'htmlall':'UTF-8'|stripslashes}" />
		<button type="submit" name="submit_search" class="btn btn-default button-search">
			<span>{l s='Search' mod='blocksearch'}</span>
		</button>
	</form>	
</div>
<!-- /Block search module TOP -->

<!-- Logo TOP -->
	<div id="header_logo">
		<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
			<img class="logo img-responsive logo-throwback" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"{if isset($logo_image_width) && $logo_image_width} width="{$logo_image_width}"{/if}{if isset($logo_image_height) && $logo_image_height} height="{$logo_image_height}"{/if}/>
		</a>
	</div>
<!-- /Logo TOP -->