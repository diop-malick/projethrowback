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

{* Assign a value to 'current_step' to display current style *}
{capture name="url_back"}
{if isset($back) && $back}back={$back}{/if}
{/capture}

{if !isset($multi_shipping)}
	{assign var='multi_shipping' value='0'}
{/if}

{if !$opc && ((!isset($back) || empty($back)) || (isset($back) && preg_match("/[&?]step=/", $back)))}
<!-- Steps -->
<div class="wrapper">
<ul class="step clearfix" id="order_step">
	<li class="{if $current_step=='summary'}step_current {elseif $current_step=='login'}step_done_last step_done{else}{if $current_step=='confirmation' || $current_step=='payment' || $current_step=='shipping' || $current_step=='login'}step_done{else}step_todo{/if}{/if} first">
		{if  $current_step=='payment' || $current_step=='shipping' || $current_step=='login'}
			<a href="{$link->getPageLink('order', true, NULL, "{$smarty.capture.url_back}&step=0")|escape:'html':'UTF-8'}">
				<em class="num-step">01</em><em class="hidden-xs point-step">.</em>
				{* {l s='Summary'} *}
				<em class="hidden-xs">{l s='Panier'}</em>
			</a>
		{elseif  $current_step=='confirmation'}
			<a><em class="num-step">01</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Panier'}</em></a>
		{else}
			<span><em class="num-step">01</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Panier'}</em></span>
		{/if}
	</li>
	<li class="{if $current_step=='login'}step_current{elseif $current_step=='shipping'}step_done step_done_last{else}{if $current_step=='confirmation' || $current_step=='payment' || $current_step=='shipping' }step_done{else}step_todo{/if}{/if} second">			
		{if $current_step=='confirmation' || $current_step=='payment' || $current_step=='shipping'}
			<a><em class="num-step">02</em><em class="point-step hidden-xs">.</em> <em class="hidden-xs">{l s='Sign in'}</em></a>
		{else}
			<span><em class="num-step">02</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Sign in'}</em></span>
		{/if}
	</li>
	<li class="{if $current_step=='shipping'}step_current{elseif $current_step=='payment'}step_done step_done_last{else}{if $current_step=='confirmation' || $current_step=='payment' }step_done{else}step_todo{/if}{/if} third">
		{if $current_step=='payment'}
		<a href="{$link->getPageLink('order', true, NULL, "{$smarty.capture.url_back}&step=1")|escape:'html':'UTF-8'}">
			<em class="num-step">03</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Shipping'}</em>
		</a>
		{elseif  $current_step=='confirmation'}
			<a><em class="num-step">03</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Shipping'}</em></a>
		{else}
			<span><em class="num-step">03</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Shipping'}</em></span>
		{/if}
	</li>
	<li class="{if $current_step=='payment'}step_current{else}{if $current_step=='confirmation'}step_done step_done_last{else}step_todo{/if}{/if} four">		
		{if  $current_step=='confirmation'}
			<a><em class="num-step">04</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Payment'}</em></a>
		{else}
			<span><em class="num-step">04</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Payment'}</em></span>
		{/if}	
	</li>
	<li id="step_end" class="{if $current_step=='confirmation'}step_current{else}step_todo{/if} last">
		<span><em class="num-step">05</em><em class="hidden-xs point-step">.</em> <em class="hidden-xs">{l s='Confirmation'}</em></span>
	</li>
</ul>
</div>
<!-- /Steps -->
{/if}
