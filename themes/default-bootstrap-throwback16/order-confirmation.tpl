{*
* TODO - moveto css file
*}

<style type="text/css" media="screen">
	#order-confirmation .columns-container , #password .columns-container  {
    margin-top: 0 !important;
  }
  #order-confirmation #page{
  min-height: 92.5vh;
}
</style>


{include file="$tpl_dir./header-simple.tpl"}

{* {capture name=path}{l s='Order confirmation'}{/capture} *}

{assign var='current_step' value='confirmation'}
{include file="$tpl_dir./order-steps.tpl"}

{* <h2>{l s='Order confirmation'}</h2> *}
{include file="$tpl_dir./errors.tpl"}

<div class="col-sm-9">

	{$HOOK_ORDER_CONFIRMATION}
	{$HOOK_PAYMENT_RETURN}
	{if $is_guest}
		<p>{l s='Your order ID is:'} <span class="bold">{$id_order_formatted}</span> . {l s='Your order ID has been sent via email.'}</p>
	    <p class="cart_navigation exclusive">
		<a class="button-exclusive btn btn-default" href="{$link->getPageLink('guest-tracking', true, NULL, "id_order={$reference_order|urlencode}&email={$email|urlencode}")|escape:'html':'UTF-8'}" title="{l s='Follow my order'}"><i class="icon-chevron-left"></i>{l s='Follow my order'}</a>
	    </p>
	{else}
		<p class="cart_navigation exclusive">
			<a class="button-exclusive btn btn-default" href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Go to your order history page'}"><i class="icon-chevron-left"></i>{l s='View your order history'}</a>
		</p>		
	{/if}
</div>
<div class="cart_navigation clearfix  col-sm-3">
	{include file="$tpl_dir./facturette.tpl"}
</div>
