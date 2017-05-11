<div class="row header-top-row"> <!-- Row HEADER -->
	<div class="container">

		<div id ="menu_and_serach" class="col-xs-6 col-sm-6  col-md-4 ">
			<div class="row">

			{if $page_name == 'category' }
				<!-- menu verticale -->
				<div class="col-xs-6 col-sm-6 col-md-4 clearfix menu_vertical hidden-xs hidden-sm">
					<button type="button" id="toggleMenu" class="toggle_menu {if $page_name != 'category'}maxi{else}mini {/if}">
				      <i class="fa fa-bars"></i>
				    </button>
				    {* <pre>{$page_name}</pre> *}
				</div>
			{/if}

				<!-- /menu verticale -->
				<div class="col-xs-6 col-sm-4 col-md-4 clearfix menu_vertical_mobile visible-xs visible-sm">
					<button type="button" class="toggle_menu_mobile">
				      <i class="fa fa-bars"></i>
				    </button>
				</div>


				<!-- MODULE Block search TOP -->
				<div id="search_block_top" class="col-xs-6 col-sm-8 col-md-8 ">
					<form class="hidden-xs hidden-sm" id="searchbox" method="get" action="{$link->getPageLink('search', null, null, null, false, null, true)|escape:'html':'UTF-8'}" >
						<input type="hidden" name="controller" value="search" />
						<input type="hidden" name="orderby" value="position" />
						<input type="hidden" name="orderway" value="desc" />
						<input class="search_query form-control" type="search" id="search_query_top" name="search_query" placeholder="{l s='Search' mod='blocksearch'}" value="{$search_query|escape:'htmlall':'UTF-8'|stripslashes}" />
						<button type="submit" name="submit_search" class="btn btn-default button-search" id="test">
							<span>{l s='Search' mod='blocksearch'}</span>
						</button>

					</form>

					<div class="visible-xs visible-sm mobile-icon">
						<i class="fa fa-search fa-2x" aria-hidden="true"></i>
					</div>

				</div>
			</div>
			<!-- /MODULE Block search TOP -->
		</div>

		<!-- Logo TOP -->
		{* hide on mobile device *}
		<div class="hidden-xs hidden-sm">

			<div id="header_logo" class="col-md-4 col-sm-4 col-xs-4 logo-header">
					<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}index.php{else}{$base_dir}index.php{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
						<img class="logo img-responsive logo-throwback" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"/>

					</a>
			</div>
		</div>
		<!-- /Logo TOP -->
