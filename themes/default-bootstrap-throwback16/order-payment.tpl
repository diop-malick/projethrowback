

{* custom thorwback - simple header *}
{* TODO - to move *}
<style type="text/css" media="screen">
	#order .columns-container , #password .columns-container  {
    margin-top: 0 !important;
  }
  #order #page{
  min-height: 92.5vh;
}
</style>
{include file="$tpl_dir./header-simple.tpl"}

{if !$opc}
	{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
	{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
	{capture name=path}{l s='Your payment method'}{/capture}
	
{else}
	<h1 class="page-heading step-num"><span>3</span> {l s='Please choose your payment method'}</h1>
{/if}

{if !$opc}
	{assign var='current_step' value='payment'}
	{include file="$tpl_dir./order-steps.tpl"}
	{include file="$tpl_dir./errors.tpl"}
{else}
	<div id="opc_payment_methods" class="opc-main-block">
		<div id="opc_payment_methods-overlay" class="opc-overlay" style="display: none;"></div>
	</div>
{/if}

{if $advanced_payment_api}
    {include file="$tpl_dir./order-payment-advanced.tpl"}
{else}
    {include file = "$tpl_dir./order-payment-classic.tpl"}
{/if}