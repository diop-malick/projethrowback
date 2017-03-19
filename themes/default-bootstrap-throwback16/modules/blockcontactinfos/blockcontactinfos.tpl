
<!-- MODULE Block contact infos -->
{if {$smarty.get.controller} eq 'authentication' or ( ({$smarty.get.controller} eq 'order') && ( ({$smarty.get.step} eq '1') or ({$smarty.get.step} eq '2')  ) ) }

    <div class="col-md-9">
    <section id="block_contact_infos" class="footer-block">
            {if $blockcontactinfos_phone != ''}
                <i class="icon-phone"></i>
                <span>&nbsp;{$blockcontactinfos_phone|escape:'html':'UTF-8'}</span>
            {/if}
    </section> 
    </div>

{else}

    <div class="col-md-5">
    <section id="block_contact_infos" class="footer-block">
    	<div class="row">
    		<div class="col-md-7 col-xs-12">
            {if $blockcontactinfos_address != ''}
    			<i class="icon-map-marker"></i>
    			<span>&nbsp;{$blockcontactinfos_address|escape:'html':'UTF-8'}</span>
            {/if}
            &nbsp;
            {if $blockcontactinfos_phone != ''}
    			</div>
    			<div class="col-md-5 col-xs-12">

                <i class="icon-phone"></i>
                <span>&nbsp;{$blockcontactinfos_phone|escape:'html':'UTF-8'}</span>
            {/if}
    		</div>
        </div>
    </section>
    </div>

{/if}
<!-- // MODULE Block contact infos -->
