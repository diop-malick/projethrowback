 <div class="simplified-header">
    <div class="row vertical-center">
        <div class="col-md-3 text-left vertical-center">
            <span>
                <span>{l s='Aide'}</span>
            </span>
        </div>
        <div class="col-md-6">
        <a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
            <!-- <div class="center-block"> -->
                <img src="{$base_dir}/img/logo/logo-simple.png" class="simplified-logo img-responsive" alt="Throwback logo"/>
            <!-- </div> -->
        </a>
        </div>
        <div class="col-md-3 text-right">
            <span>
                <span>{l s='Votre espace sécurisée'}</span>
                <!-- <i class="icon-lock"></i> -->
                <i class="fa fa-lock fa-3x right"></i>
            </span>
        </div>
    </div>
</div>    