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
		},fancypopup_SHOW_TIME * 1000);
	}
    
	
	$('.fancypopup-btn-newsletter').on('click',function(){
		$.ajax({
			method: "POST",
			url: fancypopup_MODULE_PATH + "subscribe.php",
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
	

	// mailchimps inscription - TODO : copy from my-account.js

	
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