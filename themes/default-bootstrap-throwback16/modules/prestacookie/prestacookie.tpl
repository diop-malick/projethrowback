{*
* 2007-2014 PrestaShop
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
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<div class="modulesden-cookies-bar" style="background-color:{$cookie_bar_bg_color};{if $cookie_pos == 0}bottom:0{else}top:0{/if};display:none;">
	<div class="row">
		<div class="col-lg-12">
			<p>{$cookie_bar_text}
				{* <a href="{$cookie_bar_link_url}">{$cookie_bar_link_text}</a> *}
				<a href="{$link->getCMSLink('14', 'donnees-personnelles-et-cookies')|escape:'html'}">{$cookie_bar_link_text}</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button style="background-color:{$cookie_bar_button_color} !important;color: rgb(249, 249, 249);border-radius:{$cookie_bar_borderradius}px;-moz-border-radius:{$cookie_bar_borderradius}px;-webkit-border-radius:{$cookie_bar_borderradius}px;-o-border-radius:{$cookie_bar_borderradius}px;-ms-border-radius:{$cookie_bar_borderradius}px;" type="button" class="btn cookie-btn">{l s='Accepter' mod='prestacookie'}</button>
			</p>
		</div>
	</div>
</div>

<script>
    $(document).ready(function() {
		// expands and contracts the inner box
        var window_width = $(window).width();
        $('.modulesden-cookies-bar').width(window_width);
		$('.cookie-btn').on('click',function(){
			cookieSession();
			$('.modulesden-cookies-bar').fadeOut('900');
		})
		if(getCookie("cookieBar") != 1){
			setTimeout(function(){ $('.modulesden-cookies-bar').fadeIn('900'); }, 2000);
			 
		}
		//alert(getCookie("cookieBar"));
		
		function cookieSession() {
			var session_name = 'cookieBar';
			var session_val = '1';
			var expire_date = new Date();
			expire_date.setMonth(expire_date.getMonth()+3);
			document.cookie = session_name + "=" + escape(session_val) +";path=/;" + ((expire_date==null)?"" : ("; expires=" + expire_date.toGMTString()))
		}
		
		function getCookie(cname) {
			var name = cname + "=";
			var ca = document.cookie.split(';');
			for(var i=0; i<ca.length; i++) {
				var c = ca[i];
				while (c.charAt(0)==' ') c = c.substring(1);
				if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
			}
			return "";
		}
    })
</script>