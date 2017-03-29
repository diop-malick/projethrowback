$(document).ready(function() {

    /*************************************** My account ***************************/
    if ((typeof processMailchimpsInscription !== 'undefined') && processMailchimpsInscription === '1') {
        // console.log('Data to submit' + email + ' - ' + customer_firstname + ' - ' + customer_lastname);

        $.ajax({
            type: "GET",
            url: "https://ovh.us15.list-manage.com/subscribe/post-json?u=d56def1fdca3f61da060d5d2a&amp;id=2eca580371",
            data: {
                "EMAIL": email,
                "FNAME": customer_firstname,
                "LNAME": customer_firstname
            },
            dataType: 'jsonp',
            jsonp: 'c',
            contentType: "application/json; charset=utf-8",
            error       : function(err) { alert("Could not connect to the registration server."); },
            success     : function(data) { mce_success_cb(data); }
        });

    }

});

/***************************************  functions ***************************/

/* mailchimps > Manage error message */
function mce_success_cb(resp){
    $('#mce-success-response').hide();
    $('#mce-error-response').hide();
    if (resp.result=="success"){
        $('#mce-'+resp.result+'-response').show();
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
                $('#mce-'+resp.result+'-response').html(msg);            
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
                    $('#mce-'+resp.result+'-response').html(msg);
                }
            }
        } catch(e){
            $('#mce-'+resp.result+'-response').show();
            $('#mce-'+resp.result+'-response').html(msg);
        }
    }
}
