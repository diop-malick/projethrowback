 <div class="simplified-header">
    <div class="row vertical-center">
        <div class="col-sm-4 col-md-4 text-left vertical-center">
            <div class="row">
              <div class="col-md-8">
                <span class="aide">{l s=' Besoin d\'aide'}</span>
              </div>
              {hook h='displayNav' mod='blockcontactinfos'}
            </div>
        </div>
        <div class="col-sm-4 col-md-4">
        <a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
                <img src="{$base_dir}/img/logo/logo-simple.png" class="simplified-logo img-responsive" alt="Throwback logo"/>
        </a>
        </div>
        <div class="col-sm-4 col-md-4 text-right">
            <span>
                <span>{l s='Votre espace sécurisée'}</span>
                <!-- <i class="icon-lock"></i> -->
                <i class="fa fa-lock fa-3x right"></i>
            </span>
        </div>
    </div>
</div>
