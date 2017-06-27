
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

{if isset($confirmation) && $confirmation}
        <script>window.location="{$link->getPageLink('my-account', true)}?action=update";</script>
    {else}

<!--{$smarty.get.action}-->
<div class="row my-account-selfcare">
    <div class="box">
    <!--
        <h1 class="row text-center page-heading ">
            {l s='Your personal information'}
        </h1>
    -->
    <h3 class="page-subheading text-xs-center">{l s='Your personal information'}
    <span class="">&nbsp:&nbsp{l s='vous devez renseigner votre mot de passe pour enregistrer vos modifications'}</span></h3>
        <!-- INFO text -->

        <div class="text-center">
            <!-- FIELD ERROR -->
            {include file="$tpl_dir./errors.tpl"}
                <p class="info-title">
                    {l s=''}
                </p>

        </div>

        <!-- FORM -->
        
        <form action="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" method="post" class="form-horizontal std" id="form_data">

        <!-- <div class="container"> -->
        <div class="row vertical-center ">
            <div class="col-md-4 hidden-xs text-center">
                <h4 class="title-identity"  {if ( (isset($smarty.get.action) && $smarty.get.action =="newsletter") || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} class="grise" {/if}>{l s='Vos Information de connexion'}</h4>
            </div>
            <div class="col-md-8 col-xs-12">
            		<div class="row form-group">
                            <label for="email" class="col-md-4 col-xs-12 text-xs-left text-right control-label">
                                {l s='Numero client'}
                            </label>
                            <div class="col-md-8 col-xs-12 num-client">
                               {$cookie->id_customer}
                            </div>
                    </div>

                    <div class="row form-group">
                            <label for="email" class="col-md-4 col-xs-12 text-xs-left text-right control-label required">
                                {l s='E-mail address'}
                            </label>
                            <div class="col-md-8 col-xs-12">
                                <input class="is_required validate form-control" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) ) } readonly {else}    data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}" required {/if}
                                 type="email" name="email" id="email" value="{$smarty.post.email}"  />
                            </div>
                    </div>

                    <div class="row required form-group">
                            <label for="old_passwd" class="col-md-4 col-xs-12 text-xs-left text-right required">
                                {l s='Current Password'}
                            </label>
                            <div class="col-md-8 col-xs-12">
                                <input class="is_required validate form-control" type="password" data-validation="check_password" data-validation-error-msg="{l s='Votre mot de passe doit comporter entre 6 et 12 caractères, et doit comprendre au moins un chiffre.'}" name="old_passwd" id="old_passwd" required />
                            </div>
                    </div>
                    <div class="row required form-group">
                            <label for="passwd" class="col-md-4 col-xs-12 text-xs-left text-right">
                                {l s='New Password'}
                            </label>
                            <div class="col-md-8 col-xs-12">
                                 <input class="is_required validate form-control" type="password" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} readonly {else} data-validation="check_password" data-validation-error-msg="{l s='Votre mot de passe doit comporter entre 6 et 12 caractères, et doit comprendre au moins un chiffre.'}" data-validation-optional="true" {/if} name="passwd" id="passwd" />
                            </div>
                    </div>
                    <div class="row required form-group">
                            <label for="confirmation" class="col-md-4 col-xs-12 text-xs-left text-right">
                                {l s='Confirmation'}
                            </label>
                            <div class="col-md-8 col-xs-12">
                                <input class="is_required validate form-control" type="password" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} readonly {else} data-validation-confirm="passwd" data-validation="confirmation" data-validation-error-msg="{l s='Mot de passe non conforme à la première saisie.'}" {/if} name="confirmation" id="confirmation" />
                            </div>
                    </div>

            </div>
        </div>

        <!-- </div>  -->
        <!-- // container -->

        <div class="row vertical-center">
            <div class="col-md-4 hidden-xs text-center">
                <h4 class="title-identity" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || isset($smarty.post.newsletter_page) )} class="grise" {/if}>{l s='Votre identité'}</h4>
            </div>
            <div class="col-md-8 col-xs-12">
            <!-- <div class="row"> -->
                    <div class="row">
                        <label class="col-md-4 col-xs-12 text-xs-left text-right required">{l s='Civilité'}</label>
                        <div class="col-md-8 col-xs-12">
                            <select id="id_gender" name="id_gender" class="is_required validate select_title" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} disabled {else} data-validation="required" data-validation-error-msg="{l s='Merci de sélectionner votre civilité.'}" {/if}>
                                            <option value="">{l s='Choisir la civilité'}</option>
                            {foreach from=$genders key=k item=gender}
                                <option value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id} selected="selected"{/if}>{$gender->name}</option>
                            {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="row required form-group">
                        <label for="firstname" class="col-md-4 col-xs-12 text-xs-left text-right required control-label">
                            {l s='First name'}
                        </label>
                        <div class="col-md-8 col-xs-12">
                        <input class="is_required validate form-control" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} readonly {else} data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un prénom valide.'}" type="text" id="firstname" {/if} name="firstname" value="{$smarty.post.firstname}" />
                        </div>
                    </div>

                    <div class="row required form-group">
                        <label for="lastname" class="col-md-4 col-xs-12 text-xs-left text-right required control-label">
                            {l s='Last name'}
                        </label>
                        <div class="col-md-8 col-xs-12">
                        <input class="is_required validate form-control" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} readonly {else} data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un nom valide.'}" {/if} type="text" name="lastname" id="lastname" value="{$smarty.post.lastname}" />
                        </div>
                    </div>

                    <div class="row form-group">
                        <label class="col-md-4 col-xs-12 text-xs-left text-right">{l s='Date of Birth'}</label>
                        <div class="col-md-8 col-xs-12">
                        <div class="row select-date">
                            <div class="col-md-4 col-xs-4">
                                <select name="days" id="days" class="select_title" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} disabled {/if} >
                                    <option value="">{l s='Jour'}</option>
                                    {foreach from=$days item=v}
                                        <option value="{$v}" {if ($sl_day == $v)}selected="selected"{/if}>{$v}&nbsp;&nbsp;</option>
                                    {/foreach}
                                </select>
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
                            </div>
                            <div class="col-md-4 col-xs-4">
                                <select id="months" name="months" class="select_title" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} disabled {/if} >
                                    <option value="">{l s='Mois'}</option>
                                    {foreach from=$months key=k item=v}
                                        <option value="{$k}" {if ($sl_month == $k)}selected="selected"{/if}>{l s=$v}&nbsp;</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-md-4 col-xs-4">
                                <select id="years" name="years" class="select_title" {if ( isset($smarty.get.action) && $smarty.get.action =="newsletter" || ( isset($smarty.post.newsletter_page) && $smarty.post.newsletter_page ) )} disabled {/if} >
                                    <option value="">{l s='Année'}</option>
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

        <div class="row vertical-center">
            <div class="col-md-4 hidden-xs text-center">
                <h4 class="title-identity">{l s='Newletter'}</h4>
            </div>
            <div class="col-md-8 col-xs-12">
                <div class="row">
                    <label class="col-md-4 col-xs-12 text-xs-left text-right">
                                {l s='Inscription à la newletter'}
                    </label>
                <div class="col-md-8 col-xs-12">
                    {if isset($newsletter) && $newsletter}
                    <span style="font-family:pt_sansregular,Arial,Verdana,Helvetica,sans-serif;color:#978d8d;font-size:100%;">
                      {l s='Devenez Client Privilégié grâce à votre adresse email ! Recevez toutes les bonnes affaires et les offres exclusives en vous inscrivant gratuitement à notre Newsletter!'}
                    </span>
                        <div class="checkbox"
                            <label for="newsletter">
                                <input type="checkbox" id="newsletter" name="newsletter" value="1" {if isset($smarty.post.newsletter) && $smarty.post.newsletter == 1} checked="checked"{/if}/>
                                {l s='Sign up for our newsletter!'}
                                {if isset($required_fields) && array_key_exists('newsletter', $field_required)}
                                  <sup> *</sup>
                                {/if}
                        </div>
                    {/if}
                    </div>
                </div>
            </div>
        </div>

        {if isset($HOOK_CUSTOMER_IDENTITY_FORM)}
        <div class="row">
    		{$HOOK_CUSTOMER_IDENTITY_FORM}
        </div>
    	{/if}
        <input type="hidden" name="newsletter_page" value = '{if (isset($smarty.get.action) && $smarty.get.action =="newsletter")} "newsletter" {/if}' >

        <div class="row">
            <div class="col-md-12 text-center">
                <fieldset>
                            <div class="form-group">
                                <button type="submit" name="submitIdentity" class="btn btn-default button button-medium">
                                    <span>{l s='Save'}<i > ></i></span>
                                </button>
                            </div>
                </fieldset>
            </div>
        </div>

        </form> <!-- .std -->
        {/if}


</div> <!-- // Box -->
<div>

            <a class="button-exclusive" href="{$link->getPageLink('my-account', true)}">
                <span>
                    <i ><&nbsp;</i>{l s='Retour'}
                </span>
            </a>
</div>
<div class="row">
  <div class="col-md-12 text-center">
    <i class="reglement">{l s='Conformément à la loi "Informatique et Libertés", vous disposez d’un droit d’accès et de rectification aux données vous concernant, et d’opposition à leur traitement. Pour en savoir plus cliquez'}&nbsp;
      <a href="{$link->getCMSLink('14', 'donnees-personnelles-et-cookies')|escape:'html'}" target="_blank">ICI.<a>
      </i>
      </div>
</div>
</div> <!-- // my-account-selfcare -->



<script>

    $.validate({
            lang : 'fr',
            modules : 'file,html5,sanitize,toggleDisabled,security',
            form : '#form_data'
    });

</script>
