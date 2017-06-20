
{capture name=path}{l s='Your addresses'}{/capture}

<div class="my-account-selfcare new-adress">
<div class="box">
	<h3 class="page-subheading">{if isset($smarty.get.id_address) && $smarty.get.id_address} {l s="Modification d'une adresse"}  {else} {l s='Ajouter une adresse'} {/if}</h3>
	<div class="text-center">
	<p class="info-title">
	{include file="$tpl_dir./errors.tpl"}
	</div>

	<div class="text-center">
	<form action="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" method="post" class="form-horizontal std" id="add_address">
		<!--h3 class="page-subheading">{if isset($id_address)}{l s='Your address'}{else}{l s='New address'}{/if}</h3-->
		{assign var="stateExist" value=false}
		{assign var="postCodeExist" value=false}
		{assign var="dniExist" value=false}
		{assign var="homePhoneExist" value=false}
		{assign var="mobilePhoneExist" value=false}
		{assign var="atLeastOneExists" value=false}

		{* {$ordered_adr_fields|var_dump} *}

		{assign var="tab" value=array_splice($ordered_adr_fields, 2, 1)}
		{assign var="tab2" value=array_splice($ordered_adr_fields, 0, 0, $tab)}

		{assign var="tab3" value=array_splice($ordered_adr_fields, 8, 1)}
		{assign var="tab4" value=array_splice($ordered_adr_fields, 6, 0, $tab3)}

	
		{if in_array("State:name" , $ordered_adr_fields)}
			{assign var="tab5" value=array_splice($ordered_adr_fields, 5, 1)}
			{assign var="tab6" value=array_splice($ordered_adr_fields, 8, 0, $tab5)}
		
		{/if}
		
		

		{assign var="tab_civility" value=array({l s='M.'}, {l s='Mme'})}


		{foreach from=$ordered_adr_fields item=field_name}
			 {if $field_name eq 'company'}
			 <div class="row required form-group">

			 <label for="select-civility" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Civilité'} </label>
				 <div class="col-md-8 col-xs-12">
				 
			 	 	<select id="select-civility" name="company" class="is_required validate select_title" data-validation="required" data-validation-error-msg="{l s='Merci de sélectionner votre civilité.'}">
					 <option value="">{l s='Choisir la civilité'}</option>
					 {if isset($address->company) && $address->company}
					 <option value="{$address->company}" selected="selected">{$address->company}</option>
					 {foreach from=$tab_civility item=civility}
					 {if isset($address->company) && $address->company!= $civility}
					 <option  value="{$civility}"  {if isset($smarty.post.company) && $smarty.post.company} selected="selected"{/if}>{$civility}</option>
					 {/if}
					 {/foreach}
					 {else}
					 {foreach from=$tab_civility item=civility}
					 <option  value="{$civility}" {if isset($smarty.post.company) && $smarty.post.company} selected="selected"{/if}>{$civility}</option>
					 {/foreach}
					 {/if}
			 </select>

			 </div>
		</div>
		{/if}

			{if $field_name eq 'firstname'}
				<div class="row required form-group">

					<label for="firstname" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='First name'} </label>
					<div class="col-md-8 col-xs-12">
						<input class="is_required validate form-control" data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un prénom valide.'}" type="text" name="firstname" id="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{else}{if isset($address->firstname)}{$address->firstname|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'lastname'}
				<div class="row required form-group">

					<label for="lastname" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Last name'} </label>
					<div class="col-md-8 col-xs-12">

					<input class="is_required validate form-control" data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un nom valide.'}" type="text" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{else}{if isset($address->lastname)}{$address->lastname|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}

			{if $field_name eq 'address1'}
				<div class="row required form-group">

					<label for="address1" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Numéro voie'} </label>
					<div class="col-md-8 col-xs-12">

					<input class="is_required validate form-control" data-validation="check_num_voie" data-validation-error-msg="{l s='Merci de saisir un nombre avec 5 chiffres maximum.'}" type="text" id="address1" name="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{else}{if isset($address->address1)}{$address->address1|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'address2'}
				<div class="row required form-group">

					<label for="address2" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Nom voie'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
					<div class="col-md-8 col-xs-12">

					<input class="validate form-control" data-validation="check_alpha_num" data-validation-error-msg="{l s='Merci de saisir une chaîne de caractère.'}" type="text" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{else}{if isset($address->address2)}{$address->address2|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'postcode'}
				{assign var="postCodeExist" value=true}
				<div class="row required postcode form-group unvisible">

					<label for="postcode" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Zip/Postal Code'} </label>
					<div class="col-md-8 col-xs-12">

					<input class="is_required validate form-control" data-validation="check_cp" data-validation-error-msg="{l s='Merci de saisir un code postal valide.'}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'city'}
				<div class="row required form-group">

					<label for="city" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='City'} </label>
					<div class="col-md-8 col-xs-12" id="ville">

					<input class="is_required validate form-control" data-validation="check_alpha_num" data-validation-error-msg="{l s='Merci de saisir une ville valide.'}" type="text" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{else}{if isset($address->city)}{$address->city|escape:'html':'UTF-8'}{/if}{/if}"  />
					</div>
				</div>
				{* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
			{/if}
			{if $field_name eq 'Country:name' || $field_name eq 'country' || $field_name eq 'Country:iso_code'}
				<div class="row required form-group">

					<label for="id_country" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Country'} </label>
					<div class="col-md-8 col-xs-12">

						<select id="id_country" class="select_title" data-validation="required" data-validation-error-msg="{l s='Merci de sélectionner votre pays.'}" name="id_country">

						{$countries_list}
						</select>
					</div>
				</div>
			{/if}
			
			{if $field_name eq 'State:name'}
				{assign var="stateExist" value=true}
				
				<div class="row required id_state form-group">
					<label for="id_state" class="col-md-4 col-xs-12 text-right required">{l s='State'} </label>
					<div class="col-md-8 col-xs-12">
						<select name="id_state" id="id_state" data-validation="required" class="select_title" data-validation-error-msg="{l s='Merci de sélectionner votre état.'}" >
							<option value="">{l s="Choisir l'etat"}</option>
						</select>
					</div>
				</div>
			{/if}

			{if $field_name eq 'phone_mobile'}
				{assign var="mobilePhoneExist" value=true}
				<div class="row form-group {if isset($one_phone_at_least) && $one_phone_at_least}required {/if}">
					<label for="phone_mobile" class="col-md-4 col-xs-12 text-xs-left text-right">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
					<div class="col-md-8 col-xs-12">
					<input class="validate form-control" data-validation="check_phone" data-validation-error-msg="{l s='Merci de saisir un numéro de téléphone valide. '}" data-validation-optional="true" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}" placeholder="Par ex : 0470707070" />
					</div>
				</div>
			{/if}
			{if ($field_name eq 'phone_mobile') || ($field_name eq 'phone_mobile') && !isset($atLeastOneExists) && isset($one_phone_at_least) && $one_phone_at_least}
				{assign var="atLeastOneExists" value=true}

			{/if}
		{/foreach}

		<!-- ERROR -->

		{if !$postCodeExist}
			<div class="required postcode form-group unvisible">
				<label class="required" for="postcode">{l s='Zip/Postal Code'}</label>
				<input class="is_required validate form-control" data-validate="{$address_validation.postcode.validate}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}" />
			</div>
		{/if}

		<!-- etats -->
		{if !$stateExist}
			<div class="row required id_state form-group unvisible">

				<label for="id_state" class="col-md-4 col-xs-12 text-right required">{l s='State'} </label>
				<div class="col-md-8 col-xs-12">

					<select name="id_state" id="id_state" class="select_title" data-validation="required" data-validation-optional="true" data-validation-error-msg="{l s='Merci de sélectionner votre état.'}">
						<option value="">-</option>
					</select>
				</div>
			</div>
		{/if}

		{if !$dniExist}
			<div class="required dni form-group unvisible">
				<label for="dni">{l s='Identification number'}</label>
				<input class="is_required form-control" data-validate="{$address_validation.dni.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}" />
				<span class="form_info">{l s='DNI / NIF / NIE'}</span>
			</div>
		{/if}
		<!-- end ERROR -->


		<div class="row form-group">
			<label for="other" class="col-md-4 col-xs-12 text-xs-left text-right">{l s='Complément adresse'}</label>
			<div class="col-md-8 col-xs-12">
			<textarea class="validate form-control" data-validation="length" data-validation-length="2-38" data-validation-error-msg="{l s='Merci de saisir une adresse valide. '}" data-validation-optional="true" id="other" name="other" cols="26" rows="3" >{if isset($smarty.post.other)}{$smarty.post.other}{else}{if isset($address->other)}{$address->other|escape:'html':'UTF-8'}{/if}{/if}</textarea>
			</div>
		</div>

		<!-- ERROR -->
		<div class="clearfix"></div>
		{if !$mobilePhoneExist}
			<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
				<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
				<input class="validate form-control" data-validate="{$address_validation.phone_mobile.validate}" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}" />
			</div>
		{/if}
		{if isset($one_phone_at_least) && $one_phone_at_least && !$atLeastOneExists}
			<p class="inline-infos required">{l s='You must register at least one phone number.'}</p>
		{/if}
		<!-- End Error -->


		<div class="row required form-group" id="adress_alias">

			<label for="alias" class="col-md-4 col-xs-12 text-right text-xs-left required">{l s='Please assign an address title for future reference.'} </label>
			<div class="col-md-8 col-xs-12">

			<input type="text" id="alias" class="is_required validate form-control" data-validate="{$address_validation.alias.validate}" name="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{elseif isset($address->alias)}{$address->alias|escape:'html':'UTF-8'}{elseif !$select_address}{l s='My address'}{/if}" />
			</div>
		</div>

		<div class="row">
			<p class="submit2">
				{if isset($id_address)}<input type="hidden" name="id_address" value="{$id_address|intval}" />{/if}
				{if isset($back)}<input type="hidden" name="back" value="{$back}" />{/if}
				{if isset($mod)}<input type="hidden" name="mod" value="{$mod}" />{/if}
				{if isset($select_address)}<input type="hidden" name="select_address" value="{$select_address|intval}" />{/if}
				<input type="hidden" name="token" value="{$token}" />
				<button type="submit" name="submitAddress" id="submitAddress" class="btn btn-default button button-medium">
					<span>
						{l s='Save'}
						<i class="icon-chevron-right right"></i>
					</span>
				</button>
			</p>
		</div>

	</form>
</div>
</div>
</div> <!-- end my-account-selfcare -->

<ul class="footer_links clearfix">
	<li>
		<a class="button-exclusive" href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">
			<span><i><</i> {l s='Back to your addresses'}</span>
		</a>
	</li>
</ul>
{strip}
{if isset($smarty.post.id_state) && $smarty.post.id_state}
	{addJsDef idSelectedState=$smarty.post.id_state|intval}
{elseif isset($address->id_state) && $address->id_state}
	{addJsDef idSelectedState=$address->id_state|intval}
{else}
	{addJsDef idSelectedState=false}
{/if}
{if isset($smarty.post.id_country) && $smarty.post.id_country}
	{addJsDef idSelectedCountry=$smarty.post.id_country|intval}
{elseif isset($address->id_country) && $address->id_country}
	{addJsDef idSelectedCountry=$address->id_country|intval}
{else}
	{addJsDef idSelectedCountry=false}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{/strip}
<script>

		$.validate({
				lang : 'fr',
				modules : 'file,html5,sanitize,toggleDisabled,security',
				form : '#add_address'
		});
		$("#select-civility").focus();

		$("#select-civility").change(function() {
			$("#company").val($(this).val());
		}).change(); // trigger once if needed

</script>