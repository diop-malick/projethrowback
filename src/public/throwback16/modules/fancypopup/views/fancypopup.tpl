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
<style type="text/css">
	#fancypopup_popup{
		background: #4c4c4c;
		max-width: {$fancypopup_width}px;
		max-height: {$fancypopup_BOX_HEIGHT}px;
		padding: 15px 18px;
		background-size: cover;
		text-align:center;
	}
	.fancybox-skin{
		-webkit-border-radius: 0px;
		-moz-border-radius: 0px;
		border-radius: 0px;
	}
	.fancypopup-img{
		display: none;
	}
	.fancypopup-newsletter .fancypopup-email {
		height: 50px;
		line-height: 50px;
		width: 100%;
		color: #000;
		font-size: 100.67%;
		border: none;
		padding-top: 0px;
		padding-bottom: 0px;
		padding-left: 10px;
	}
	.fancypopup-newsletter label{
		font-weight: 300;
		margin-bottom: 12px;
		color: white;
	}
	.fancypopup-newsletter h1 {
		margin-top: -4px;
		font-weight: 900;
		text-transform: uppercase;
		color: #BD1E30;
		font-size: 26px;
		font-weight: bold;
		color: white;
	}
	.fancypopup-btn-newsletter{
		background-color: {$fancypopup_BTN_COLOR};
		color: white;
		border: none;
		font-size: 16px;
		padding: 13px;
		-webkit-border-radius: 3px;
		-moz-border-radius: 3px;
		-o-border-radius: 3px;
		-ms-border-radius: 3px;
		border-radius: 3px;
		-webkit-transition: .5s;
		-moz-transition: .4s;
		-o-transition: .5s;
		-ms-transition: .5s;
		transition: .5s;
		margin-top: 10px;
		display: block;
		width: 100%;
		opacity:0.8;
	}
	.fancypopup-btn-newsletter:hover,.fancypopup-btn-newsletter.hover,.fancypopup-btn-newsletter:active{		
		opacity:1;
	}
	.fancypopup-msg{
		margin: 10px 0;
		display: none;
		color:#000;
		font-weight: 900;
	}
	.fancypopup-msg.error{
		color:#ec4040;
	}
	.fancypopup-msg.success{
		color:#40ec40;
	}
	@media(min-width:550px){		
		#fancypopup_popup{
			width: 70vw
		}
		.fancypopup-newsletter h1 {
			font-size: 32px;
		}
	}
	@media(min-width:750px){
		#fancypopup_popup{
			width: 85vw
		}
		.fancypopup-newsletter h1 {
			font-size: 36px;
		}
		.fancypopup-img{
			display: inline-block;
			width: 35%;
			vertical-align: top;
		}
		.fancypopup-content{
			display: inline-block;
			width: 64%;
			padding: 0 6px;
		}
	}
</style>

<div style="display: none;">
{if $fancypopup_paragraph}
	{$fancypopup_paragraph}
{/if}
</div>
<script>
$(document).ready(function () {
	
	if(getCookie_popup("fancypopupCookie") != 1){
		$('html').append('<a class="fancybox" style="display:none" href="#fancypopup_popup"></a>');
		setTimeout(function(){
			$('.fancybox').fancybox({
				padding: 0,
				afterClose: function () {
					$('a[href="#fancypopup_popup"]').remove();
				}
			});
			$('a[href="#fancypopup_popup"]').trigger('click');
			cookieSession_popup();
		},{$fancypopup_SHOW_TIME} * 1000);
	}
    
	
	$('.fancypopup-btn-newsletter').on('click',function(){
		$.ajax({
			method: "POST",
			url: "{$module_path}subscribe.php",
			data: { action: 0, email: $('.fancypopup-email').val(), }
		})
		  .done(function( msg ) {		  	
			var obj = $.parseJSON(msg);
			if(obj.code != 1){
				if(obj.message){
					$('.fancypopup-msg').html(obj.message).removeClass('success').addClass('error').css('display','block').fadeIn(100).fadeOut(5000);
				}
				
			}else{
				if(obj.message){
					$('.fancypopup-msg').html(obj.message).removeClass('error').addClass('success').css('display','block').fadeIn(100).fadeOut(5000);
				}				
				setTimeout(function(){
					$.fancybox.close();
					//location = 'index.php?id_cms=6&controller=cms&id_lang=1';
				},7000);
			};
		});
		return false;
	})
	

	
	function cookieSession_popup() {
			var session_name = 'fancypopupCookie';
			var session_val = '1';
			var expire_date = new Date();
			expire_date.setMonth(expire_date.getMonth()+120);
			document.cookie = session_name + "=" + escape(session_val) +";path=/;" + ((expire_date==null)?"" : ("; expires=" + expire_date.toGMTString()))
		}
		
	function getCookie_popup(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for(var i=0; i<ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1);
			if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
		}
		return "";
	}
});
</script>
