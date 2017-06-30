 <div class="simplified-header">
    <div class="row vertical-center">
        <div class="col-sm-4 col-md-4 text-left vertical-center">
            <div class="row">
              <div class="col-xs-12 col-md-12 col-md-8">
                <span class="aide">{l s=' Besoin d\'aide'}</span>
              </div>
              {hook h='displayNav' mod='blockcontactinfos'}
            </div>
        </div>
        <div class="col-sm-4 col-md-4">
        <a href="{$base_dir_ssl}index.php" title="{$shop_name|escape:'html':'UTF-8'}">
                <img src="{$base_dir_ssl}img/logo/logo-simple.png" class="simplified-logo img-responsive" alt="Throwback logo"/>
        </a>
        </div>
        <div class="col-xs-4 col-sm-4 col-md-4 text-right secure">
            <span>
                <span >{l s='Votre espace sécurisée'}</span>
                <i class="fa fa-lock fa-3x right"></i>
            </span>
        </div>
    </div>
</div>
