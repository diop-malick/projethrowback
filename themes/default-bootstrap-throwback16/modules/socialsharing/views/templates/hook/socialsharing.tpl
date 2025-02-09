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
{if $PS_SC_TWITTER || $PS_SC_FACEBOOK || $PS_SC_GOOGLE || $PS_SC_PINTEREST}
	
	<p class="socialsharing_product list-inline no-print">
		{if $PS_SC_TWITTER}
			<button data-easyshare-button="twitter" data-easyshare-tweet-text="" data-type="twitter" type="button" class="btn btn-default btn-twitter social-sharing btn-rs">
				<i class="icon-twitter icone-rs"></i> {* {l s="Tweet" mod='socialsharing'} *}
				<!-- <img src="{$link->getMediaLink("`$module_dir`img/twitter.gif")}" alt="Tweet" /> -->
			</button>
		{/if}
		{if $PS_SC_FACEBOOK}
			<button data-easyshare-button="facebook" data-type="facebook" type="button" class="btn btn-default btn-facebook social-sharing btn-rs">
				<i class="icon-facebook icone-rs"></i> {* {l s="Share" mod='socialsharing'} *}
				<!-- <img src="{$link->getMediaLink("`$module_dir`img/facebook.gif")}" alt="Facebook Like" /> -->
			</button>
		{/if}
		{if $PS_SC_GOOGLE}
			<button data-easyshare-button="google" data-type="google-plus" type="button" class="btn btn-default btn-google-plus social-sharing btn-rs">
				<i class="icon-google-plus icone-rs"></i> <!--{l s="Google+" mod='socialsharing'}-->
				<!-- <img src="{$link->getMediaLink("`$module_dir`img/google.gif")}" alt="Google Plus" /> -->
			</button>
		{/if}
		{if $PS_SC_PINTEREST}
			<button data-easyshare-button="pinterest" data-type="pinterest" type="button" class="btn btn-default btn-pinterest social-sharing btn-rs">
				<i class="icon-pinterest icone-rs"></i> {* {l s="Pinterest" mod='socialsharing'} *}
				<!-- <img src="{$link->getMediaLink("`$module_dir`img/pinterest.gif")}" alt="Pinterest" /> -->
			</button>
		{/if}
		
	</p>

{/if}
