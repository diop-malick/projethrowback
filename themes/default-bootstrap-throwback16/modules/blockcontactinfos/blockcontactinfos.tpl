<!-- MODULE Block contact infos -->

<div class="col-md-4">
<section id="block_contact_infos" class="footer-block">
	<div>
        {if $blockcontactinfos_address != ''}
			<i class="icon-map-marker"></i>
			<span>&nbsp;{$blockcontactinfos_address|escape:'html':'UTF-8'}</span>
        {/if}
        &nbsp;
        {if $blockcontactinfos_phone != ''}
            <i class="icon-phone"></i> 
            <span>&nbsp;{$blockcontactinfos_phone|escape:'html':'UTF-8'}</span>
        {/if}
    </div>
</section> <!-- // MODULE Block contact infos -->
</div>
