<div class="delivery_option item col-xs-12 col-md-6" style="display: flex; flex-direction: column;">
<div class="box">	
	<h3 class="page-subheading">{$mycarrername}</h3>

	<ul>

		<!-- RADIO CHECKBOX -->										
		<li>
			<span class="delivery_option_radio">
				<input id="delivery_option_{$id_address|intval}_{$option@index}" class="delivery_option_radio" type="radio" name="delivery_option[{$id_address|intval}]" data-key="{$key}" data-id_address="{$id_address|intval}" value="{$key}"/>
			</span>

			<!-- LOGO -->
			<span class="delivery_option_logo">
				{foreach $option.carrier_list as $carrier}
				{if $carrier.logo}
				<img class="order_carrier_logo" src="{$carrier.logo|escape:'htmlall':'UTF-8'}" alt="{$carrier.instance->name|escape:'htmlall':'UTF-8'}"/>
				{elseif !$option.unique_carrier}
				{$carrier.instance->name|escape:'htmlall':'UTF-8'}
				{if !$carrier@last} - {/if}
				{/if}
				{/foreach}
			</span>
		</li>
		<!-- DELAI LIVRAISON -->
		<li>
			<span>
				{if $option.unique_carrier}
				{if isset($carrier.instance->delay[$cookie->id_lang])}
				{* {l s='Delivery time:'}&nbsp; *}
				{$carrier.instance->delay[$cookie->id_lang]|escape:'htmlall':'UTF-8'}
				{/if}
				{/if}
			</span>
		</li>
		<!-- PRIX-->
		<li>
			{if $option.total_price_with_tax && !$option.is_free && (!isset($free_shipping) || (isset($free_shipping) && !$free_shipping))}
			<span class="delivery_option_price">
				{if $use_taxes == 1}
					{if $priceDisplay == 1}
					{convertPrice price=$option.total_price_without_tax}{if $display_tax_label} {l s='(tax excl.)'}{/if}
					{else}
					{convertPrice price=$option.total_price_with_tax}{if $display_tax_label} {l s='(tax incl.)'}{/if}
					{/if}
				{else}
					{convertPrice price=$option.total_price_without_tax}
				{/if}
			</span>
			{else}
			<span class="delivery_option_price free">
				{l s='Free'}
			</span>
			{/if}
		</li>
	</ul>
</div>
</div> <!-- end delivery_option -->	