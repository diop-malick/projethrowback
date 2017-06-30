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
    
	
	$('.fancypopup-btn-newsletter').on('click',function(e){
		e.preventDefault();
		var $this = $(this);
		/*
		$.ajax({
			method: "POST",
			url: fancypopup_MODULE_PATH + "subscribe.php",
			data: { action: 0, email: $('.fancypopup-email').val(), }
		})
		*/
		 $.ajax({
          type: "GET", // GET & url for json slightly different
          // url: "https://throwback-sneakers.us5.list-manage.com/subscribe/post-json?u=c868b5d04fd4025281ac0527f&amp;id=c85916a60a",
          url: "https://ovh.us15.list-manage.com/subscribe/post-json?u=d56def1fdca3f61da060d5d2a&amp;id=2eca580371",
          data: { "EMAIL" : $('.fancypopup-email').val() },
          dataType    : 'jsonp',
          jsonp       : 'c',
          contentType: "application/json; charset=utf-8" ,
		   error       : function(err) { alert("Could not connect to the registration server."); },
            success     : function(data) { mce_success_cb(data); }
     	 });
		  /*
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
		*/
	});


	err_style = '#mc_embed_signup input.mce_inline_error{border-color:#6B0505;} #mc_embed_signup div.mce_inline_error{margin: 0 0 1em 0; padding: 5px 10px; background-color:#6B0505; font-weight: bold; z-index: 1; color:#fff;}';


function mce_success_cb(resp){
    $('#fc-success-response').hide();
    $('#fc-error-response').hide();
    if (resp.result=="success"){
        $.ajax({
              type: 'GET',
              url: baseDir + 'modules/myAjax/ajax.php',
              data: 'method=myMethod',
              dataType: 'json',
              success: function(json) {

                $.each(json, function(index, value) {
                        console.log(value);                      
                });
                
              }
            });

            window.location=page_confirm;
        $('#fc-'+resp.result+'-response').show();
        // $('#fc-'+resp.result+'-response').css('color', 'green');
        
        $('#mc_embed_signup_header').hide();
        $('#mc_embed_signup .input-prepend').hide();
        $('#mc_embed_signup .btn').hide();

        $('#fc-'+resp.result+'-response').html(resp.msg);
        $('#mc-embedded-subscribe-form').each(function(){
            this.reset();
        });
    } else {
        var index = -1;
        var msg;
        try {
            var parts = resp.msg.split(' - ',2);
            if (parts[1]==undefined){
                msg = resp.msg;
            } else {
                i = parseInt(parts[0]);
                if (i.toString() == parts[0]){
                    index = parts[0];
                    msg = parts[1];
                } else {
                    index = -1;
                    msg = resp.msg;
                }
            }
        } catch(e){
            index = -1;
            msg = resp.msg;
        }
        try{
            if (index== -1){
                $('#fc-'+resp.result+'-response').show();
                $('#fc-'+resp.result+'-response').html(deja_client);          
            } else {
                err_id = 'fc_tmp_error_msg';
                html = '<div id="'+err_id+'" style="'+err_style+'"> '+msg+'</div>';
                
                var input_id = '#mc_embed_signup';
                var f = $(input_id);
                if (ftypes[index]=='address'){
                    input_id = '#fc-'+fnames[index]+'-addr1';
                    f = $(input_id).parent().parent().get(0);
                } else if (ftypes[index]=='date'){
                    input_id = '#fc-'+fnames[index]+'-month';
                    f = $(input_id).parent().parent().get(0);
                } else {
                    input_id = '#fc-'+fnames[index];
                    f = $().parent(input_id).get(0);
                }
                if (f){
                    $(f).append(html);
                    $(input_id).focus();
                } else {
                    $('#fc-'+resp.result+'-response').show();
                    $('#fc-'+resp.result+'-response').html(msg);
                }
            }
        } catch(e){
            $('#fc-'+resp.result+'-response').show();
            $('#fc-'+resp.result+'-response').html(msg);
        }
    }
}

	

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