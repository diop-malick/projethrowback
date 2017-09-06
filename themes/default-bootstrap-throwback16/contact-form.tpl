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
{if isset($confirmation)}
	<p class="alert alert-success">{l s='Your message has been successfully sent to our team.'}</p>
	<ul class="footer_links clearfix">
		<li>
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}index.php{else}{$base_dir}index.php{/if}">
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
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}index.php{else}{$base_dir}index.php{/if}">
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
			<h2>{l s='send a message'}</h2>
			<div class="clearfix">
				<div class="col-xs-12 col-md-12">
					 <div class="row">
						<div class="col-xs-12 col-md-4">
							<div class="row">
										<div class="col-xs-12 col-md-4 padding-class text-left-mobile text-right">
											<label for="email">{l s='Email address'}</label>
										</div>
										<div class="col-xs-12 col-md-8 padding-class">
											{if isset($customerThread.email)}
												<input class="form-control grey margin-selector" type="text" id="email" name="from" value="{$customerThread.email|escape:'html':'UTF-8'}" readonly="readonly" />
											{else}
												<input class="form-control grey validate margin-selector" type="text" id="email" name="from" data-validate="isEmail" value="{$email|escape:'html':'UTF-8'}" />
											{/if}
										</div>
							</div>
								
						</div>
						<div class="col-xs-12 col-md-4">
								<div class="form-group selector1">
									<div class="row">
											<div class="col-xs-12 col-md-2 objet padding-class text-left-mobile text-right">
												<label for="id_contact">{l s='Subject Heading'}</label>
											</div>
											<div class="col-xs-12 col-md-8 padding-class">
											
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
													<select id="id_contact" class="form-control margin-selector" name="id_contact">
														<option value="0">{l s='-- Choose --'}</option>
														{foreach from=$contacts item=contact}
															<option value="{$contact.id_contact|intval}"{if isset($smarty.request.id_contact) && $smarty.request.id_contact == $contact.id_contact} selected="selected"{/if}>{$contact.name|escape:'html':'UTF-8'}</option>
														{/foreach}
													</select>
												</div>
												{/if}
										</div>
									</div>
						</div>

					<div class="col-xs-12 col-md-4">	
					
							<div class="form-group selector1">
								<div class="row">
									<div class="col-xs-12 col-md-5 padding-class text-left-mobile text-right">
										<label>{l s='Numéro comande'}</label>
									</div>
									<div class="col-xs-12 col-md-7 padding-class">
										<input class="form-control grey margin-selector" type="text" name="id_order" id="id_order" value="{if isset($customerThread.id_order) && $customerThread.id_order|intval > 0}{$customerThread.id_order|intval}{else}{if isset($smarty.post.id_order) && !empty($smarty.post.id_order)}{$smarty.post.id_order|escape:'html':'UTF-8'}{/if}{/if}" />
									</div>
								</div>
							</div>
					
					</div>
						
					</div> <!-- end row -->
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

			<h2>{l s='Ou nous contacter'}</h2>
			<div class="row adresse-contact">
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
						
							<strong>{l s='Horaires'}</strong>								
							<br>
							{l s='Du Mardi au Vendredi de 11H à 13h30 / de 15H à 19H30'}
							<br>
							{l s='Le Samedi de 11H à 19H30'}
							<br>
							{l s='Dimanche de 14H à 19H'}
					</p>
				</div>
				
			</div>
			<p class="link-condition">
				{l s='Vous pouvez consulter nos pages services pour en savoir plus sur nos'}
				 <a href="{$link->getCMSLink('7', 'conditions-de-livraison')|escape:'html'}">{l s='conditions de livraisons'}</a>, {l s='nos'} <a href="{$link->getCMSLink('8', 'conditions-de-paiement')|escape:'html'}">{l s='conditions de paiement'}</a> et nos conditions de <a href="{$link->getCMSLink('11', 'retours-et-remboursements')|escape:'html'}">{l s='retours et remboursements'}</a>
			</p>
		</fieldset>
	</form>
	
{/if}
{addJsDefL name='contact_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='contact_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
