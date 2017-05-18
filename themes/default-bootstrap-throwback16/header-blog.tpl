{if !isset($content_only) || !$content_only}
		
		{if isset($css_files)}
			{foreach from=$css_files key=css_uri item=media}
				<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
			{/foreach}
		{/if}

		{if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
			{$js_def}
			{foreach from=$js_files item=js_uri}
			<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
			{/foreach}
		{/if}

		<!-- {$HOOK_HEADER} -->

		<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,600&amp;subset=latin,latin-ext" type="text/css" media="all" />		
		<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>

		<!-- Header complete -->
			<div class="header-container">

				<header id="header">
					
					{capture name='displayBanner'}{hook h='displayBanner'}{/capture}
					{if $smarty.capture.displayBanner}
						<div class="banner">
							<div class="container-fluid">
								<div class="row">
									<div class="container">
										{$smarty.capture.displayBanner}
									</div>
								</div>
							</div>
						</div>
					{/if}

					{capture name='displayNav'}{hook h='displayNav'}{/capture}
					{if $smarty.capture.displayNav}
						<div class="nav">
							<div class="container-fluid">
								<div class="row">
									<div class="container">
										<nav>{$smarty.capture.displayNav}</nav>
									</div>
								</div>
							</div>
						</div>
					{/if}

					<!-- Logo TOP  on mobile device -->
					<div class="clearfix"></div>
					<div class="visible-xs visible-sm">
						<div class="container-fluid">
							<div id="header_logo" class="col-xs-12 col-sm-12 logo-header">
								<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
									<img class="logo img-responsive logo-throwback" 
									{* rc="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/logo/logo.png"  *}
									src="{$logo_url}"
									alt="{$shop_name|escape:'html':'UTF-8'}"/>
								</a>
							</div>
						</div>
					</div>
					
					<!-- /Logo TOP -->
					<div class="clearfix"></div>

					<div>
						<div class="container-fluid">
						<!-- row Header(search + logo + cart) + row Menu -->
								{if isset($HOOK_TOP)}{$HOOK_TOP}{/if}
						</div>
					</div>

				</header>
			</div>
		<!-- end Header complete -->
		
{/if}
