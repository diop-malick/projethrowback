<!-- MODULE Block contact infos -->

<section id="block_contact_infos" class="footer-block col-md-4">
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


<!-- Footer Logo  -->
<div class="col-md-3">
    <!-- <img src="{$base_dir}/img/logo/logo-footer.png" class="footer-logo img-responsive" alt="Throwback logo"/> -->
</div> <!-- // Footer Logo -->