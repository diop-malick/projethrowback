<div class="row header-top-row"> <!-- Row HEADER -->
	<div class="container">

		<div class="col-md-4 col-xs-4">
			<div class="row">
				<!-- menu verticale -->
				<div class="col-md-4 col-xs-4 clearfix menu_vertical hidden">
					<button type="button" id="toggleMenu" class="toggle_menu {if $page_name == 'index'} maxi {else} mini {/if}">
				      <i class="fa fa-bars"></i>
				    </button>
				</div>
				<!-- /menu verticale -->

				<!-- MODULE Block search TOP -->
				<div id="search_block_top" class="col-md-8 col-xs-8">
					<form id="searchbox" method="get" action="{$link->getPageLink('search', null, null, null, false, null, true)|escape:'html':'UTF-8'}" >
						<input type="hidden" name="controller" value="search" />
						<input type="hidden" name="orderby" value="position" />
						<input type="hidden" name="orderway" value="desc" />
						<input class="search_query form-control" type="text" id="search_query_top" name="search_query" placeholder="{l s='Search' mod='blocksearch'}" value="{$search_query|escape:'htmlall':'UTF-8'|stripslashes}" />
						<button type="submit" name="submit_search" class="btn btn-default button-search" id="test">
							<span>{l s='Search' mod='blocksearch'}</span>
						</button>

					</form>
				</div>
			</div>
			<!-- /MODULE Block search TOP -->
		</div>

		<!-- Logo TOP -->
		<div id="header_logo" class="col-md-4 col-xs-4">
				<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
					<img class="logo img-responsive logo-throwback" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"/>
				</a>
		</div>
		<!-- /Logo TOP -->
