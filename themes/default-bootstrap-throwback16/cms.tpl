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
{if isset($cms) && !isset($cms_category)}
	{if !$cms->active}
		<br />
		<div id="admin-action-cms">
			<p>
				<span>{l s='This CMS page is not visible to your customers.'}</span>
				<input type="hidden" id="admin-action-cms-id" value="{$cms->id}" />
				<input type="submit" value="{l s='Publish'}" name="publish_button" class="button btn btn-default"/>
				<input type="submit" value="{l s='Back'}" name="lnk_view" class="button btn btn-default"/>
			</p>
			<div class="clear" ></div>
			<p id="admin-action-result"></p>
		</div>
	{/if}
	<div class="rte{if $content_only} content_only{/if}">
		<!--{$cms->content} -->

				{assign var=cms_content_condition_livraison value=CMS::getCMSContent(7, true, true)}
				{assign var=cms_content_condition_paiement value=CMS::getCMSContent(8, true, true)}
				{assign var=cms_content_retour_remboursement value=CMS::getCMSContent(11, true, true)}
				{assign var=cms_content_mention_legale value=CMS::getCMSContent(12, true, true)}
				{assign var=cms_content_condition_cookie_et_donnees value=CMS::getCMSContent(14, true, true)}
				{assign var=cms_content_condition_de_vente value=CMS::getCMSContent(16, true, true)}
				{assign var=cms_active_tab value=(int)Tools::getValue('id_cms')}
				{assign var=cms_cat value=Tools::getFullPath(1, $cms->meta_title, 'CMS')}

				{if isset($cms->id_cms_category) && $cms->id_cms_category == 3}{assign var=cms_categorie value="Nos Services"}
				 {elseif isset($cms->id_cms_category) && $cms->id_cms_category == 4}{assign var=cms_categorie value="Liens légaux"}
				{/if}
				{if isset($cms_categorie) && $cms_categorie}
						<div class="container" >

							 <h1 class="title">{$cms_categorie}</h1>
						<!-- CMS page TABS -->
						<!-- <div id="tabs_container"> -->
						<div class="tabbable col-md-6" >
						   <ul class="nav nav-tabs nav-justified" role="tablist">
								 {if isset($cms->id_cms_category) && $cms->id_cms_category == 3}
						      <li {if isset($cms_active_tab) && ($cms_active_tab == 7)}class="active"{/if} ><a href="#tab1" data-toggle="tab">{l s='Conditions de Livraison'}</a></li>
						      <li {if isset($cms_active_tab) && ($cms_active_tab == 8)}class="active"{/if}><a href="#tab2" data-toggle="tab">{l s='Condition de Paiement'}</a></li>
						      <li {if isset($cms_active_tab) && ($cms_active_tab == 11)}class="active"{/if}><a href="#tab3" data-toggle="tab">{l s='Retour et Remboursements'}</a></li>
									{elseif isset($cms->id_cms_category) && $cms->id_cms_category == 4}
									<li {if isset($cms_active_tab) && ($cms_active_tab == 12)}class="active"{/if} ><a href="#tab1" data-toggle="tab">{l s='Mentions légales'}</a></li>
									<li {if isset($cms_active_tab) && ($cms_active_tab == 14)}class="active"{/if}><a href="#tab2" data-toggle="tab">{l s='Données personnelles et cookies'}</a></li>
									<li {if isset($cms_active_tab) && ($cms_active_tab == 16)}class="active"{/if}><a href="#tab3" data-toggle="tab">{l s='Conditions générales de vente'}</a></li>
									{/if}
							 </ul>
						<!-- Tab panes -->
							<div class="tab-content">
								 {if isset($cms->id_cms_category) && $cms->id_cms_category == 3}
							   <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 7)}active{/if}" id="tab1">{$cms_content_condition_livraison.content}</div>
							   <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 8)}active{/if}"id="tab2">{$cms_content_condition_paiement.content}</div>
							   <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 11)}active{/if}" id="tab3">{$cms_content_retour_remboursement.content}</div>
								 {elseif isset($cms->id_cms_category) && $cms->id_cms_category == 4}
								 <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 12)}active{/if}" id="tab1">{$cms_content_mention_legale.content}</div>
							   <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 14)}active{/if}"id="tab2">{$cms_content_condition_cookie_et_donnees.content}</div>
							   <div class="tab-pane {if isset($cms_active_tab) && ($cms_active_tab == 16)}active{/if}" id="tab3">{$cms_content_condition_de_vente.content}</div>
								 {/if}
							</div>
						</div>
			</div>
			<a class="btn btn-cms text-center" href="{$base_dir}">{l s='< CONTINUER VOTRE SHOPPING'}</a>
		{else}
		<div class="rte{if $content_only} content_only{/if}">
			{$cms->content}
		</div>
		{/if}
{elseif isset($cms_category)}
	<div class="block-cms">
		<h1><a href="{if $cms_category->id eq 1}{$base_dir}{else}{$link->getCMSCategoryLink($cms_category->id, $cms_category->link_rewrite)}{/if}">{$cms_category->name|escape:'html':'UTF-8'}</a></h1>
		{if $cms_category->description}
			<p>{$cms_category->description|escape:'html':'UTF-8'}</p>
		{/if}
		{if isset($sub_category) && !empty($sub_category)}
			<p class="title_block">{l s='List of sub categories in %s:' sprintf=$cms_category->name}</p>
			<ul class="bullet list-group">
				{foreach from=$sub_category item=subcategory}
					<li>
						<a class="list-group-item" href="{$link->getCMSCategoryLink($subcategory.id_cms_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}">{$subcategory.name|escape:'html':'UTF-8'}</a>
					</li>
				{/foreach}
			</ul>
		{/if}
		{if isset($cms_pages) && !empty($cms_pages)}
		<p class="title_block">{l s='List of pages in %s:' sprintf=$cms_category->name}</p>
			<ul class="bullet list-group">
				{foreach from=$cms_pages item=cmspages}
					<li>
						<a class="list-group-item" href="{$link->getCMSLink($cmspages.id_cms, $cmspages.link_rewrite)|escape:'html':'UTF-8'}">{$cmspages.meta_title|escape:'html':'UTF-8'}</a>
					</li>
				{/foreach}
			</ul>
		{/if}
	</div>
{else}
	<div class="alert alert-danger">
		{l s='This page does not exist.'}
	</div>
{/if}
<br />
{strip}
{if isset($smarty.get.ad) && $smarty.get.ad}
{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{/strip}
