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
{capture name=path}{l s='Contact'}{/capture}
{*
<h1 class="page-heading bottom-indent">
	{l s='Customer service'} - {if isset($customerThread) && $customerThread}{l s='Your reply'}{else}{l s='Contact us'}{/if}
</h1>
*}
{if isset($confirmation)}
	<p class="alert alert-success">{l s='Your message has been successfully sent to our team.'}</p>
	<ul class="footer_links clearfix">
		<li>
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
				<span>
					<i class="icon-chevron-left"></i>{l s='Home'}
				</span>
			</a>
		</li>
	</ul>
{elseif isset($alreadySent)}
	<p class="alert alert-warning">{l s='Your message has already been sent.'}</p>
	<ul class="footer_links clearfix">
		<li>
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
				<span>
					<i class="icon-chevron-left"></i>{l s='Home'}
				</span>
			</a>
		</li>
	</ul>
{else}
	{include file="$tpl_dir./errors.tpl"}
	<h1 class="text-center">{l s="Besoin d'aide ?"}</h1>
	<form action="{$request_uri}" method="post" class="contact-form-box" enctype="multipart/form-data">
		<fieldset>
			<h3 class="page-subheading">{l s='send a message'}</h3>
			<div class="clearfix">
				<div class="col-xs-12 col-md-12">
					 <div class="row">
						<div class="col-xs-12 col-md-4">
							<div class="row">
										<div class="col-xs-12 col-md-4 padding-class">
											<label for="email">{l s='Email address'}</label>
										</div>
										<div class="col-xs-12 col-md-8">
											{if isset($customerThread.email)}
												<input class="form-control grey" type="text" id="email" name="from" value="{$customerThread.email|escape:'html':'UTF-8'}" readonly="readonly" />
											{else}
												<input class="form-control grey validate" type="text" id="email" name="from" data-validate="isEmail" value="{$email|escape:'html':'UTF-8'}" />
											{/if}
										</div>
							</div>
								
						</div>
						<div class="col-xs-12 col-md-4">
								<div class="form-group selector1">
									<div class="row">
											<div class="col-xs-12 col-md-3">
												<label for="id_contact">{l s='Subject Heading'}</label>
											</div>
											<div class="col-xs-12 col-md-9">
											
												{if isset($customerThread.id_contact) && $customerThread.id_contact && $contacts|count}
														{assign var=flag value=true}
														{foreach from=$contacts item=contact}
															{if $contact.id_contact == $customerThread.id_contact}
																<input type="text" class="form-control" id="contact_name" name="contact_name" value="{$contact.name|escape:'html':'UTF-8'}" readonly="readonly" />
																<input type="hidden" name="id_contact" value="{$contact.id_contact|intval}" />
																{$flag=false}
															{/if}
														{/foreach}
														{if $flag && isset($contacts.0.id_contact)}
																<input type="text" class="form-control" id="contact_name" name="contact_name" value="{$contacts.0.name|escape:'html':'UTF-8'}" readonly="readonly" />
																<input type="hidden" name="id_contact" value="{$contacts.0.id_contact|intval}" />
														{/if}
												</div>
												{else}
													<select id="id_contact" class="form-control" name="id_contact">
														<option value="0">{l s='-- Choose --'}</option>
														{foreach from=$contacts item=contact}
															<option value="{$contact.id_contact|intval}"{if isset($smarty.request.id_contact) && $smarty.request.id_contact == $contact.id_contact} selected="selected"{/if}>{$contact.name|escape:'html':'UTF-8'}</option>
														{/foreach}
													</select>
												</div>
												
												{*
													<p id="desc_contact0" class="desc_contact{if isset($smarty.request.id_contact)} unvisible{/if}">&nbsp;</p>
													{foreach from=$contacts item=contact}
														<p id="desc_contact{$contact.id_contact|intval}" class="desc_contact contact-title{if !isset($smarty.request.id_contact) || $smarty.request.id_contact|intval != $contact.id_contact|intval} unvisible{/if}">
															<i class="icon-comment-alt"></i>{$contact.description|escape:'html':'UTF-8'}
														</p>
													{/foreach}
												*}
												{/if}
										</div>
									</div>
						</div>

					<div class="col-xs-12 col-md-4">	
					
							<div class="form-group selector1">
								<div class="col-xs-12 col-md-5">
									<label>{l s='Numéro comande'}</label>
								</div>
								<div class="col-xs-12 col-md-7">
									<input class="form-control grey" type="text" name="id_order" id="id_order" value="{if isset($customerThread.id_order) && $customerThread.id_order|intval > 0}{$customerThread.id_order|intval}{else}{if isset($smarty.post.id_order) && !empty($smarty.post.id_order)}{$smarty.post.id_order|escape:'html':'UTF-8'}{/if}{/if}" />
								</div>
								
							</div>
					
					</div>
						
					</div> <!-- end row -->
					
					{*
					{if $fileupload == 1}
						<p class="form-group">
							<label for="fileUpload">{l s='Attach File'}</label>
							<input type="hidden" name="MAX_FILE_SIZE" value="{if isset($max_upload_size) && $max_upload_size}{$max_upload_size|intval}{else}2000000{/if}" />
							<input type="file" name="fileUpload" id="fileUpload" class="form-control" />
						</p>
					{/if}
					*}
				</div>
				<div class="col-xs-12 col-md-12 padding-class">
					<div class="form-group">
						<!--<label for="message">{l s='Message'}</label>-->
						<textarea class="form-control" id="message" placeholder="Votre message" name="message">{if isset($message)}{$message|escape:'html':'UTF-8'|stripslashes}{/if}</textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-md-12">
					<div class="submit">
						<button type="submit" name="submitMessage" id="submitMessage" class="button btn btn-default button-medium"><span>{l s='Send'}<i class="icon-chevron-right right"></i></span></button>
					</div>
				</div>
			</div>
		</fieldset>
	</form>
	<h2>{l s='Ou nous contacter'}</h2>
	<div class="row">
		<div class="col-xs-12 col-md-4">
			<p class="shop-info">
				<strong>{l s='Par téléphone'}</strong><br>
					 +33(0)9 50 64 02 96
					<br>
					{l s="Prix d'un appel local"}
			</p>
		</div>
		<div class="col-xs-12 col-md-4">
			<p class="shop-info">
				<strong>{l s='Par courrier'}</strong>
					<br>
					75019, 67 rue de Belleville 75019 
					<br>
					Paris, France
			</p>
		</div>
		<div class="col-xs-12 col-md-4">
			<p class="shop-info">
				
					<strong>{l s='Horaires'}</strong><br>
					{l s='Le lundi de 14H à 19H'}								
					<br>
					{l s='Du mardi au vendredi de 11H à 19H00'}
					<br>
					{l s='Le samedi de 10h - 19H'}
			</p>
		</div>
		
	</div>
	<p class="link-condition">
		Vous pouvez consulter nos pages services pour en savoir plus sur nos <a href="{$link->getCMSLink('7', 'conditions-de-livraison')|escape:'html'}">conditions de livraisons</a>, nos <a href="{$link->getCMSLink('8', 'conditions-de-paiement')|escape:'html'}">conditions de paiment</a> et nos conditions de <a href="{$link->getCMSLink('11', 'retours-et-remboursements')|escape:'html'}">retours et remboursements</a>
	</p>
{/if}
{addJsDefL name='contact_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='contact_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
