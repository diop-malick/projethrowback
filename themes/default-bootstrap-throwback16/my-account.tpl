
{capture name=path}{l s='My account'}{/capture}

<div class="my-account-selfcare">

    <!--
    <div class="row">
            <h1 class="page-heading text-center">{l s='Bienvenue dans votre espace personnel'}</h1>
    </div>
    -->
    <h3 class="page-subheading text-center">{l s='Bienvenue dans votre espace personnel'}</h3>


    <!-- BEGIN ============= MAILCHIMPS PROCESS ========= -->
    <!-- <p>processMailchimpsInscription : {$processMailchimpsInscription}</p> -->
    <!-- <p>{$cookie->customer_firstname|escape:'html':'UTF-8'}</p> -->
    <!-- <p>{$cookie->customer_lastname|escape:'html':'UTF-8'}</p> -->
    <!-- <p>{$cookie->email|escape:'html':'UTF-8'}</p> -->
    {if isset($processMailchimpsInscription) && $processMailchimpsInscription}
        {addJsDef processMailchimpsInscription=$processMailchimpsInscription}
        {addJsDef customer_firstname=$cookie->customer_firstname}
        {addJsDef customer_lastname=$cookie->customer_lastname}
        {addJsDef email=$cookie->email}
    {/if}
    <p class=mailchimpsResponse></p>
    <div class="text-center">
        <span class="response" id="mce-error-response" style="display:none; color:red;"></span>
        <span class="response" id="mce-success-response" style="display:none; color:green;"></span>
    </div>
    <!-- END ============= MAILCHIMPS PROCESS ========= -->


    <!--
    {if isset($account_created)}
    	<p class="alert alert-success">
    		{l s='Your account has been created.'}
    	</p>
    {/if}
    -->

    <!-- TODO : DELETE  with CSS  -->
    <!-- <p class=" info-account">{l s='Welcome to your account. Here you can manage all of your personal information and orders.'}</p> -->

    <div class="container">
    <div class="row addresses-lists">
    	<div class="col-xs-12 col-sm-6 col-md-12">
    		<ul class="myaccount-link-list">

                <div class="myacount-block-container">
	                <li class="col-sm-6">
	                	<a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}" title="{l s='Information'}">
	                		<div class="contenu">
				                <span><i class="icon-user"></i></span>
				                <span>{l s='My personal information'}</span>
			                </div>
		                </a>
	                </li>
                </div>


                {if $has_customer_an_address}
                <div class="myacount-block-container">
	                <li class="col-sm-6">
	                    <a href="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" title="{l s='Add my first address'}">
	                    	<div class="contenu">
			                    <span><i class="icon-building"></i></span>
			                    <span>{l s='Add my first address'}</span>
			                </div>
	                    </a>
	                </li>
                </div>

                {else}
                <div class="myacount-block-container">
                	<li class="col-sm-6">
                		<a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}" title="{l s='Addresses'}">
                			<div class="contenu">
                				<span><i class="icon-building"></i></span>
                				<span>{l s='My addresses'}</span>
                			</div>
                		</a>
                	</li>
                </div>
                 {/if}

                <div class="myacount-block-container">
	                <li class="col-sm-6">
	                	<a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Orders'}">
	                		<div class="contenu">
	                			<span><i class="icon-list-ol"></i></span>
	                			<span>{l s='Order history and details'}</span>
	                		</div>
	                	</a>
	                </li>
	            </div>
                {if $returnAllowed}
                <div class="myacount-block-container">
                    <li>
                    	<a href="{$link->getPageLink('order-follow', true)|escape:'html':'UTF-8'}" title="{l s='Merchandise returns'}">
                    		<div class="contenu">
                    			<span><i class="icon-refresh"></i></span>
                    			<br >
                    			<span>{l s='My merchandise returns'}</span>
                    		</div>
                    	</a>
                    </li>
                </div>
                {/if}

                <div class="myacount-block-container">
                	<li class="col-sm-6">
                		<a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}&action=newsletter" title="{l s='Information'}">
                			<div class="contenu">
                				<span><i class="fa fa-envelope"></i></span>
                				<span>{l s='Newsletter'}</span>
                			</div>
                		</a>
                	</li>
                </div>
            </ul>
    	</div>
    {if $voucherAllowed || isset($HOOK_CUSTOMER_ACCOUNT) && $HOOK_CUSTOMER_ACCOUNT !=''}
    	<div class="col-xs-12 col-sm-6 col-lg-4">
            <ul class="myaccount-link-list">
                {if $voucherAllowed}
                    <li><a href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}" title="{l s='Vouchers'}"><i class="icon-barcode"></i><span>{l s='My vouchers'}</span></a></li>
                {/if}
                {$HOOK_CUSTOMER_ACCOUNT}
            </ul>
        </div>
    {/if}
    </div>
    
    {* ==================== 
    <ul class="footer_links clearfix">
    <li><a class="button-exclusive" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{l s='Home'}"><span id="retour-accueil"><i><&nbsp;</i> {l s='Home'}</span></a></li>
    </ul>
    ================= *}
    
    <a class="button-exclusive" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{l s='Home'}">
        <button type="submit" class="button redirect_home btn btn-default button-medium pull-left">
                <span>
                    <i class="icon-chevron-left left"></i>
                    {l s='Home'}                
                </span>
        </button>
    </a>
</div>

</div> <!-- // my acount-self care -->
