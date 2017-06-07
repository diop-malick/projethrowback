<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8 ie7"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9 ie8"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if gt IE 8]> <html class="no-js ie9"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<html{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}>
	<head>
		<meta charset="utf-8" />
		<title>{$meta_title|escape:'html':'UTF-8'}</title>
		{if isset($meta_description) AND $meta_description}
			<meta name="description" content="{$meta_description|escape:'html':'UTF-8'}" />
		{/if}
		{if isset($meta_keywords) AND $meta_keywords}
			<meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}" />
		{/if}
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow" />
		<meta name="viewport" content="width=device-width, minimum-scale=0.25, maximum-scale=1.6, initial-scale=1.0" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}" />
		{if isset($css_files)}
			{foreach from=$css_files key=css_uri item=media}
				{if $css_uri == 'lteIE9'}
					<!--[if lte IE 9]>
					{foreach from=$css_files[$css_uri] key=css_uriie9 item=mediaie9}
					<link rel="stylesheet" href="{$css_uriie9|escape:'html':'UTF-8'}" type="text/css" media="{$mediaie9|escape:'html':'UTF-8'}" />
					{/foreach}
					<![endif]-->
				{else}
					<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
				{/if}
			{/foreach}
		{/if}
		{if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
			{$js_def}
			{foreach from=$js_files item=js_uri}
			<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
			{/foreach}
		{/if}
		{$HOOK_HEADER}
		<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,600&amp;subset=latin,latin-ext" type="text/css" media="all" />
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<!--[if IE 8]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		<![endif]-->

		 <link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
		 <script type="text/javascript">
					var url_logo = "{$logo_url}";
					var url_logo_simple = "{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/logo/logo-simple.png";
		 </script>

		 {addJsDef page_confirm=$link->getCMSLink('21', 'confirmation-newsletter')}
		 {addJsDefL name='deja_client'}{l s='Vous êtes déjà abonné à notre newsletter'}{/addJsDefL}
		 {addJsDefL name='succes_creation'}{l s='Votre compte a été créé avec succès.'}{/addJsDefL}

	</head>
	<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if} class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{else} show-left-column{/if}{if $hide_right_column} hide-right-column{else} show-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso}">
	{if !isset($content_only) || !$content_only}
		{if isset($restricted_country_mode) && $restricted_country_mode}
			<div id="restricted-country">
				<p>{l s='You cannot place a new order from your country.'}{if isset($geolocation_country) && $geolocation_country} <span class="bold">{$geolocation_country|escape:'html':'UTF-8'}</span>{/if}</p>
			</div>
		{/if}
		<div id="page">

		<!-- Header simplified -->
		<!-- Hide comlete header in myaccount and -->
		{if {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'orderconfirmation' or
		({$smarty.get.controller} eq 'order' &&  ({$smarty.get.update} neq '1' && {$smarty.get.step} neq '0') ) }
		
		{*
		<pre>{$cart|var_dump} </pre>
		<pre>id_carrier : {$cart->id_carrier}</pre>
		<pre>id_address_delivery : {$cart->id_address_delivery}</pre>
		<pre>id_address_invoice : {$cart->id_address_invoice}</pre> 
		<pre>{$smarty.get.step} </pre>
		<pre>{$smarty.server.HTTP_HOST}</pre>
		<pre>{$smarty.server.REQUEST_URI}</pre>
		<pre>{$smarty.get.controller}</pre> 
		*}


		{else}
		<!-- Header complete -->
			<div class="header-container">

				<header id="header">
					{* {capture name='displayBanner'}{hook h='displayBanner'}{/capture}
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
					{/if} *}
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


					<!-- Mobile Search  -->
					<div class="clearfix"></div>
					<div class="col-xs-12 visible-xs-search-mobile" style="display:none; height: 50px; margin-top: 15px;">
						<form method="get" action="{$link->getPageLink('search', true, null, null, false, null, true)|escape:'html':'UTF-8'}" id="searchbox2">
							<div class="col-xs-12 text-center ">
								<label class="visible-sm" for="search_query_block">{l s='Rechercher un produit :' mod='blocksearch'}</label>
							</div>
							<div class="col-xs-12">
							<div class="block_content clearfix">
								<div class="conteneur">
									<input type="hidden" name="controller" value="search" />
									<input type="hidden" name="orderby" value="position" />
									<input type="hidden" name="orderway" value="desc" />
									<input class="search_query form-control grey" type="text" placeholder="Recherche" id="search_query_block" name="search_query" value="{$search_query|escape:'html':'UTF-8'|stripslashes}" autofocus/>
									<button type="submit" id="search_button" class="btn btn-default button button-small"><span><i class="icon-search"></i></span></button>
								</div>
							</div>
							</div>
						</form>
					</div>
					<!-- Mobile Menu  -->
					<div class="col-xs-12 col-sm-12 visible-xs visible-sm visible-xs-menu-mobile">
					{hook h='leftColumn' mod='blocktopmenu'}
					</div>

				</header>
			</div>
		<!-- end Header complete -->
		{/if}

			<!-- SLIDER  -->
			<div class="container-fluid">
			<div id="slider_row" class="row">
					{capture name='displayTopColumn'}{hook h='displayTopColumn'}{/capture}
					{if $smarty.capture.displayTopColumn}
						<div id="top_column" class="center_column col-xs-12 col-sm-12">{$smarty.capture.displayTopColumn}</div>
					{/if}
			</div>
			</div>

			<div class="columns-container">
				<div id="columns" class="container">
					{if $page_name !='index' && $page_name !='pagenotfound' && $page_name !='category'}
						{include file="$tpl_dir./breadcrumb.tpl"}
					{/if}


					<!-- on réinitialise les éléments flottants qui suivent pour les ramener dans le flux normal, et éviter qu'ils viennent recouvrir les éléments précédents.  -->
					<div class="clearfix"></div>

					<div class="row">
						{if isset($left_column_size) && !empty($left_column_size)}
						<div id="left_column" class="column col-xs-12 col-sm-12 col-md-{$left_column_size|intval}">{$HOOK_LEFT_COLUMN}</div>


						{if {$smarty.get.controller} eq 'authentication'}
							<div id="center_column" class="center_column col-xs-12 col-sm-12 col-md-12">
						{else}
							{/if}
							{if isset($left_column_size) && isset($right_column_size)}{assign var='cols' value=(12 - $left_column_size - $right_column_size)}{else}{assign var='cols' value=12}{/if}
							<div id="center_column" class="center_column col-xs-12 col-sm-12 col-md-{$cols|intval}">
						{/if}
	{/if}
