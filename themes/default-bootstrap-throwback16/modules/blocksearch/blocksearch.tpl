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

<!-- Block search module -->
<div id="search_block_left" class="block exclusive">
	{if {$smarty.get.controller} neq 'search'}
	<p class="title_block">{l s='Search' mod='blocksearch'}</p>
	{/if}
	<form method="get" action="{$link->getPageLink('search', true, null, null, false, null, true)|escape:'html':'UTF-8'}" id="searchbox2">
			{if {$smarty.get.controller} neq 'search'}
			<label for="search_query_block">{l s='Search products:' mod='blocksearch'}</label>
			{/if}

		<div class="block_content clearfix">
			<div class="conteneur">
				<div class="result_title">
				 <p>{l s='Nouvelle Recherche' mod='blocksearch'}</p>
				</div>

				<input type="hidden" name="controller" value="search" />
				<input type="hidden" name="orderby" value="position" />
				<input type="hidden" name="orderway" value="desc" />
				<input class="search_query form-control grey" type="text" id="search_query_block" name="search_query" value="{$search_query|escape:'htmlall':'UTF-8'|stripslashes}" autofocus/>
				<button type="submit" id="search_button" class="btn btn-default button button-small"><span><i class="icon-search"></i></span></button>
			</div>
			<hr>
			<div class="text_page_zero_result">
			<p>{l s='Nos conseils :' mod='blocksearch'}</p>
					<ul>
					<li>{l s='Vérifier l’orthographe de votre recherche' mod='blocksearch'}</li>
					<li>{l s='Eviter les caractères spéciaux' mod='blocksearch'}</li>
					<li>{l s='Saisissez un type de produit ou une marque' mod='blocksearch'}</li>
					<li>{l s='Utilisez des mots simples, plus généraux' mod='blocksearch'}</li>
					</ul>
			</div>
		</div>
	</form>
</div>
<!-- TODO | redirect_home | not used in csss, check and delete -->
<div class="redirect_home">
	<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}index.php{else}{$base_dir}index.php{/if}" class=" btn btn-dark text-center"><i class="icon-chevron-left left"></i> <span class="text-shoping">{l s='Continuer mon shopping' mod='blocksearch'}</span></a>
</div>

<!-- /Block search module -->
