
<!-- MODULE Block contact infos -->
{* {if {$smarty.get.controller} eq 'authentication' or ( ({$smarty.get.controller} eq 'order') && ( ({$smarty.get.step} eq '1') or ({$smarty.get.step} eq '2')  ) ) } *}
{if {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'orderconfirmation' or ({$smarty.get.controller} eq 'order' &&  ((!isset($smarty.get.step) or {$smarty.get.step} neq '0')) ) }
    <div class="col-md-9 col-sm-9 col-xs-12">
    <section id="block_contact_infos" class="footer-block">
            {if $blockcontactinfos_phone != ''}
                <i class="icon-phone"></i>
                <span>&nbsp;{$blockcontactinfos_phone|escape:'html':'UTF-8'}</span>
            {/if}
    </section> 
    </div>

{else}

    <div class="col-xs-10 col-sm-8 col-md-8 block_contact_infos">
    <section id="block_contact_infos" class="footer-block">
    	<div class="row">
    		<div class="col-lg-5 col-md-12 col-sm-12 col-xs-12 text-xs-left">
            {if $blockcontactinfos_address != ''}
    			<i class="icon-map-marker"></i>
    			<span>&nbsp;{$blockcontactinfos_address|escape:'html':'UTF-8'}</span>
            {/if}
            &nbsp;
            {if $blockcontactinfos_phone != ''}
    			</div>
    			<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 text-xs-left">

                <i class="icon-phone"></i>
                <span>&nbsp;{$blockcontactinfos_phone|escape:'html':'UTF-8'}</span>
            {/if}
    		</div>
        </div>
    </section>
    </div>

{/if}
<!-- // MODULE Block contact infos -->
