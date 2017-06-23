
$(document).ready(function() {


$("#displaynewsletter").fancybox({
             'titlePosition'     : 'inside',
             'transitionIn'      : 'elastic',
             'transitionOut'     : 'elastic',
             'autoResize'        : 'false',
             'autoSize'          : 'false',
             'autoWidth '        : 'false',
             'minWidth'          : 395,
             'minHeight': 150,
         });

$.validate({
            lang : 'fr',
            modules : 'html5,sanitize,toggleDisabled,security',
            form : '#mc-embedded-subscribe-form'
    });

    /* mailchimps > form AJX */
    
    $('#mc-embedded-subscribe-form').submit(function(e) {
      var $this = $(this);
      $.ajax({
          type: "GET",
          url: "https://throwback-sneakers.us5.list-manage.com/subscribe/post-json?u=c868b5d04fd4025281ac0527f&amp;id=c85916a60a",
          // url: "https://ovh.us15.list-manage.com/subscribe/post-json?u=d56def1fdca3f61da060d5d2a&amp;id=2eca580371",
          data: $this.serialize(),
          dataType    : 'jsonp',
          jsonp       : 'c',
          contentType: "application/json; charset=utf-8",
          error       : function(err) { alert("Could not connect to the registration server."); },
          success     : function(data) {
                mce_success_cb(data);
            }
      });
      return false;
    });

});

/* mailchimps > Manage error message */


err_style = '#mc_embed_signup input.mce_inline_error{border-color:#6B0505;} #mc_embed_signup div.mce_inline_error{margin: 0 0 1em 0; padding: 5px 10px; background-color:#6B0505; font-weight: bold; z-index: 1; color:#fff;}';


function mce_success_cb(resp){
    $('#mce-success-response').hide();
    $('#mce-error-response').hide();
    if (resp.result=="success"){

        if (page_name=="my-account"){
            $('#mce-'+resp.result+'-response').show();
            // $('#mce-'+resp.result+'-response').css('color', 'green');
            
            $('#mc_embed_signup_header').hide();
            $('#mc_embed_signup .input-prepend').hide();
            $('#mc_embed_signup .btn').hide();

            $('#mce-'+resp.result+'-response').html(succes_creation);
            $('#mc-embedded-subscribe-form').each(function(){
                this.reset();
            });
        }
        else
             window.location=page_confirm;
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
                $('#mce-'+resp.result+'-response').show();
                $('#mce-'+resp.result+'-response').html(deja_client);            
            } else {
                err_id = 'mce_tmp_error_msg';
                html = '<div id="'+err_id+'" style="'+err_style+'"> '+msg+'</div>';
                
                var input_id = '#mc_embed_signup';
                var f = $(input_id);
                if (ftypes[index]=='address'){
                    input_id = '#mce-'+fnames[index]+'-addr1';
                    f = $(input_id).parent().parent().get(0);
                } else if (ftypes[index]=='date'){
                    input_id = '#mce-'+fnames[index]+'-month';
                    f = $(input_id).parent().parent().get(0);
                } else {
                    input_id = '#mce-'+fnames[index];
                    f = $().parent(input_id).get(0);
                }
                if (f){
                    $(f).append(html);
                    $(input_id).focus();
                } else {
                    $('#mce-'+resp.result+'-response').show();
                    $('#mce-'+resp.result+'-response').html(deja_client);
                }
            }
        } catch(e){
            $('#mce-'+resp.result+'-response').show();
            $('#mce-'+resp.result+'-response').html(deja_client);
        }
    }
}


