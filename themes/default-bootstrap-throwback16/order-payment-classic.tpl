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
<div class="container clearfix">
<div class="row  clearfix">
<div class="paiement_block col-sm-9  clearfix">
<div id ="tabs">
    <ul id="HOOK_TOP_PAYMENT" class="resp-tabs-list tab">
        {$HOOK_TOP_PAYMENT}
    </ul>
    

    {if $HOOK_PAYMENT}        
        {if $opc}
            <div id="opc_payment_methods-content">
        {/if}

        <div id="HOOK_PAYMENT" class="resp-tabs-container tab">
            {$HOOK_PAYMENT}
        </div>
        {if $opc}
            </div> <!-- end opc_payment_methods-content -->
        {/if}
    {else}
        <p class="alert alert-warning">{l s='No payment modules have been installed.'}</p>
    {/if}
    
</div> <!-- end opc_payment_methods -->

</div>

<div class="cart_navigation clearfix  col-sm-3">
    {include file="$tpl_dir./facturette.tpl"}
</div>
</div>
</div>
<script>
$(document).ready(function(){
    $('#tabs').easyResponsiveTabs({
      type: 'accordion', //Types: default, vertical, accordion
      width: 'auto', //auto or any width like 600px
      fit: true, // 100% fit in a container
      closed: 'accordion', // Start closed if in accordion view
      tabidentify: 'tab', // The tab groups identifier
      activate: function() {    
         $('button.standard-checkout').removeAttr('disabled');
      }
    }); 
}); 
    
</script>