
{capture name=path}
    <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">
        {l s='My account'}
    </a>
    <span class="navigation-pipe">
        {$navigationPipe}
    </span>
    <span class="navigation_page">
        {l s='Your personal information'}
    </span>
{/capture}

{include file="$tpl_dir./header-simple.tpl"}

<div class="row my-account-selfcare">
    <div class="box">
        <h1 class="row text-center page-heading ">
            {l s='Your personal information'}
        </h1>

        <!-- INFO text -->

        <div class="text-center">
            <!-- FIELD ERROR -->
            {include file="$tpl_dir./errors.tpl"}

            <!-- FIELD SUCESS -->
            {if isset($confirmation) && $confirmation}
                <p class="alert alert-success">
                    {l s='Your personal information has been successfully updated.'}
                    {if isset($pwd_changed)}<br />{l s='Your password has been sent to your email:'} {$email}{/if}
                </p>
            {else}
                <p class="info-title">
                    {l s=''}
                </p>
                
        </div>

        <!-- FORM -->

        <form action="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" method="post" class="form-horizontal std" id="form_data">
        
        <!-- <div class="container"> -->
        <div class="row vertical-center ">
            <div class="col-md-4 text-center">
                <h4>{l s='Vos Information de connexion'}</h4>
            </div>
            <div class="col-md-8 ">               
                    <div class="row form-group">
                            <label for="email" class="col-md-4 text-right control-label required">
                                {l s='E-mail address'}
                            </label>
                            <div class="col-md-8">
                                <input class="is_required validate form-control" data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}"
                                 type="email" name="email" id="email" value="{$smarty.post.email}" />  
                            </div>
                    </div>
               
                    <div class="row required form-group">
                            <label for="old_passwd" class="col-md-4 text-right">
                                {l s='Current Password'}
                            </label>
                            <div class="col-md-8">
                                <input class="is_required validate form-control" type="password" data-validation="strength" data-validation-strength="1" data-validation-error-msg="{l s='Votre mot de passe doit comporter entre 6 et 12 caractères, et doit comprendre au moins un chiffre.'}" data-validation-optional="true" name="old_passwd" id="old_passwd" />
                            </div>
                    </div>
                    <div class="row required form-group">
                            <label for="passwd" class="col-md-4 text-right">
                                {l s='New Password'}
                            </label>
                            <div class="col-md-8">
                                 <input class="col-md-8 is_required validate form-control" type="password" data-validation="strength" data-validation-strength="1" data-validation-error-msg="{l s='Votre mot de passe doit comporter entre 6 et 12 caractères, et doit comprendre au moins un chiffre.'}" data-validation-optional="true" name="passwd" id="passwd" />
                            </div>
                    </div>
                    <div class="row required form-group">
                            <label for="confirmation" class="col-md-4 text-right">
                                {l s='Confirmation'}
                            </label>
                            <div class="col-md-8">
                                <input class="col-md-8 is_required validate form-control" type="password" data-validation-confirm="passwd" data-validation="confirmation" data-validation-error-msg="{l s='Mot de passe non conforme à la première saisie.'}" name="confirmation" id="confirmation" />
                            </div>
                    </div>
                
            </div>           
        </div>
        
        <!-- </div>  -->
        <!-- // container -->

        <div class="row vertical-center">
            <div class="col-md-4 text-center">
                <h4>{l s='Votre identité'}</h4>
            </div>
            <div class="col-md-8">
            <!-- <div class="row"> -->
                    <div class="row">
                        <label class="col-md-4 text-right">&nbsp;&nbsp;{l s='Social title'}</label>
                        <div class="col-md-8">
                            <select id="id_gender" name="id_gender" class="is_required validate select_title" data-validation="required" data-validation-error-msg="{l s='Merci de sélectionner votre civilité.'}">
                                            <option value="">{l s='Choisir la civilité'}</option>
                            {foreach from=$genders key=k item=gender}
                                <option value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id} selected="selected"{/if}>{$gender->name}</option>
                            {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="row required form-group">
                        <label for="firstname" class="col-md-4 text-right required control-label">
                            {l s='First name'}
                        </label>
                        <div class="col-md-8">
                        <input class="is_required validate form-control" data-validation="length" data-validation-length="2-28" data-validation-error-msg="{l s='Merci de saisir un prénom valide.'}" type="text" id="firstname" name="firstname" value="{$smarty.post.firstname}" />
                        </div>
                    </div>

                    <div class="row required form-group">
                        <label for="lastname" class="col-md-4 text-right required control-label">
                            {l s='Last name'}
                        </label>
                        <div class="col-md-8">
                        <input class="is_required validate form-control" data-validation="length" data-validation-length="2-28" data-validation-error-msg="{l s='Merci de saisir un nom valide.'}" type="text" name="lastname" id="lastname" value="{$smarty.post.lastname}" />
                        </div>
                    </div>

                    <div class="row form-group">
                        <label class="col-md-4 text-right">
                            &nbsp;&nbsp;{l s='Date of Birth'}
                        </label>
                        <div class="col-md-8">
                        <div class="row">
                            <div class="col-xs-4">
                                <select name="days" id="days" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$days item=v}
                                        <option value="{$v}" {if ($sl_day == $v)}selected="selected"{/if}>{$v}&nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-xs-4">
                                {*
                                    {l s='January'}
                                    {l s='February'}
                                    {l s='March'}
                                    {l s='April'}
                                    {l s='May'}
                                    {l s='June'}
                                    {l s='July'}
                                    {l s='August'}
                                    {l s='September'}
                                    {l s='October'}
                                    {l s='November'}
                                    {l s='December'}
                                *}
                                <select id="months" name="months" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$months key=k item=v}
                                        <option value="{$k}" {if ($sl_month == $k)}selected="selected"{/if}>{l s=$v}&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-xs-4">
                                <select id="years" name="years" class="form-control">
                                    <option value="">-</option>
                                    {foreach from=$years item=v}
                                        <option value="{$v}" {if ($sl_year == $v)}selected="selected"{/if}>{$v}&nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- </div> -->
                <!-- end row -->
            </div>           
            <!-- end col -->           
        </div>
        <!-- end row -->

        <!-- <div class="row vertical-center">
            <div class="col-md-4 text-center">
                <h4>{l s='Vos Coordonnées'}</h4>
            </div>
            <div class="col-md-8">
                {l s='Adresse form'}
            </div>           
        </div> -->

        <div class="row vertical-center">             
            <div class="col-md-4 text-center">
                <h4>{l s='Newletter'}</h4>
            </div>
            <div class="col-md-8">
                <div class="row">
                <label class="col-md-4 text-right">
                            {l s='Inscription à la newletter'}
                </label>
                <div class="col-md-8">
                    {if isset($newsletter) && $newsletter}
                        <div class="checkbox">
                            <label for="newsletter">
                                <input type="checkbox" id="newsletter" name="newsletter" value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == 1} checked="checked"{/if}/>
                                {l s='Sign up for our newsletter!'}
                                {if isset($required_fields) && array_key_exists('newsletter', $field_required)}
                                  <sup> *</sup>
                                {/if}
                            </label>
                        </div>
                    {/if}

                    <!-- OPT-IN -->
                    <!-- {if isset($optin) && $optin}
                        <div class="checkbox">
                            <label for="optin">
                                <input type="checkbox" name="optin" id="optin" value="1" {if isset($smarty.post.optin) && $smarty.post.optin == 1} checked="checked"{/if}/>
                                {l s='Receive special offers from our partners!'}
                                {if isset($required_fields) && array_key_exists('optin', $field_required)}
                                  <sup> *</sup>
                                {/if}
                            </label>
                        </div>
                    {/if} -->
                    </div>
                </div>
            </div>
        </div>
                <!-- TODO - B2B  -->
    			<!-- {if $b2b_enable}
    				<h1 class="page-subheading">
    					{l s='Your company information'}
    				</h1>
    				<div class="form-group">
    					<label for="">{l s='Company'}</label>
    					<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}" />
    				</div>
    				<div class="form-group">
    					<label for="siret">{l s='SIRET'}</label>
    					<input type="text" class="form-control" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}" />
    				</div>
    				<div class="form-group">
    					<label for="ape">{l s='APE'}</label>
    					<input type="text" class="form-control" id="ape" name="ape" value="{if isset($smarty.post.ape)}{$smarty.post.ape}{/if}" />
    				</div>
    				<div class="form-group">
    					<label for="website">{l s='Website'}</label>
    					<input type="text" class="form-control" id="website" name="website" value="{if isset($smarty.post.website)}{$smarty.post.website}{/if}" />
    				</div>
    			{/if} -->

                
        {if isset($HOOK_CUSTOMER_IDENTITY_FORM)}
        <div class="row">          
    		{$HOOK_CUSTOMER_IDENTITY_FORM}
        </div>
    	{/if}

        <div class="row">
            <div class="col-md-6 pull-left">
                <ul class="footer_links clearfix">
                    <li>
                        <a class="btn btn-default button button-small" href="{$link->getPageLink('my-account', true)}">
                            <span>
                                <i class="icon-chevron-left"></i>{l s='Back to your account'}
                            </span>
                        </a>
                    </li>
                   
                </ul>
            </div>

            <div class="col-xs-6 text-right">
                <fieldset>
                            <div class="form-group">
                                <button type="submit" name="submitIdentity" class="btn btn-default button button-medium">
                                    <span>{l s='Save'}<i class="icon-chevron-right right"></i></span>
                                </button>
                            </div>
                </fieldset>
            </div>        
        </div>

        </form> <!-- .std -->
        {/if}

</div> <!-- // Box -->
</div> <!-- // my-account-selfcare -->



<script>
    $.validate({
            lang : 'fr',
            modules : 'file,html5,sanitize,toggleDisabled,security',
            form : '#form_data'
    });
    
    
</script>

