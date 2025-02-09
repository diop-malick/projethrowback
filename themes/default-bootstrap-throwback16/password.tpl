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

{capture name=path}<a href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" title="{l s='Authentication'}" rel="nofollow">{l s='Authentication'}</a><span class="navigation-pipe">{$navigationPipe}</span>{l s='Forgot your password'}{/capture}
<div class="box">
<h1 class="page-subheading">{l s='Forgot your password?'}</h1>

{include file="$tpl_dir./errors.tpl"}

{if isset($confirmation) && $confirmation == 1}
<!--
<p class="alert alert-success">{l s='Your password has been successfully reset and a confirmation has been sent to your email address:'} {if isset($customer_email)}{$customer_email|escape:'html':'UTF-8'|stripslashes}{/if}</p>
-->
	<form action="{$request_uri}" method="post" class="std" id="form_newpassword">
	<fieldset>
		<div class="form-group row">
			<label for="email" class="col-md-4 text-right">{l s='Email address'}</label>
			<div class="col-md-8">
				<input class="form-control" type="email" id="email" name="email_exist" data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}" required value="{if isset($smarty.post.email)}{$smarty.post.email|escape:'html':'UTF-8'|stripslashes}{/if}" />
			</div>
		</div>
		<div class="form-group row">
			<label for="email" class="col-md-4 text-right">{l s='Nouveau mot de passe'}</label>
			<div class="col-md-8">
				<input class="form-control" type="password" id="pwd" name="new_password"  data-validation="check_password" data-validation-error-msg="{l s='Votre mot de passe doit comporter entre 6 et 12 caractères.'}" required />
			</div>
		</div>
		<div class="form-group row">
			<label for="email" class="col-md-4 text-right">{l s='Confirmation'}</label>
			<div class="col-md-8">
				<input class="form-control" type="password" id="confirm_password" name="confirm_password" data-validation-confirm="new_password" data-validation="confirmation" data-validation-error-msg="{l s='Mot de passe non conforme à la première saisie.'}" required/>
			</div>
		</div>
		<p class="submit text-center">
			<input type="hidden" name="ct_token" value="{$smarty.get.token}">
			<input type="hidden" name="ct_id" value="{$smarty.get.id_customer}">
            <button type="submit" class="btn btn-default button button-medium"><span>{l s='Retrieve Password'}<i class="icon-chevron-right right"></i></span></button>
		</p>
	</fieldset>
</form>

{elseif isset($confirmation) && $confirmation == 2}
<p class="alert alert-success">{l s='A confirmation email has been sent to your address:'} {if isset($customer_email)}{$customer_email|escape:'html':'UTF-8'|stripslashes}{/if}</p>
{else}
<!--<p>{l s='Please enter the email address you used to register. We will then send you a new password. '}</p>-->
<form action="{$request_uri|escape:'html':'UTF-8'}" method="post" class="std" id="form_forgotpassword">
	<fieldset>
		<div class="form-group">
			<label for="email">{l s='Email address'}</label>
			<input class="form-control" type="email" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|escape:'html':'UTF-8'|stripslashes}{/if}" data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}" required />
		</div>
		<p class="submit">
            <button type="submit" class="btn btn-default button button-medium"><span>{l s='Retrieve Password'}<i class="icon-chevron-right right"></i></span></button>
		</p>
	</fieldset>
</form>
{/if}
</div>
<!--
<ul class="clearfix footer_links">
	<li><a class="btn btn-default button button-small" href="{$link->getPageLink('authentication')|escape:'html':'UTF-8'}" title="{l s='Back to Login'}" rel="nofollow"><span><i class="icon-chevron-left"></i>{l s='Back to Login'}</span></a></li>
</ul>
-->
<a class="button-exclusive" href="{$link->getPageLink('authentication')|escape:'html':'UTF-8'}" title="{l s='Back to Login'}" title="{l s='Back to Login'}" rel="nofollow">
    <span> <i ><&nbsp;</i>{l s='Back to Login'} </span>
</a>

<script>
    $.validate({
            lang : 'fr',
            modules : 'file,html5,sanitize,toggleDisabled,security',
    });
</script>