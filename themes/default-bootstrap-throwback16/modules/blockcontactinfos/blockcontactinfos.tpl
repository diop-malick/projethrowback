
<!-- MODULE Block contact infos -->

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
</section> <!-- // MODULE Block contact infos -->
</div>
