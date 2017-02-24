$(document).ready(function() {
/*************************************** Authentification ***************************/
    $.formUtils.addValidator({
      name : 'check_password',
      validatorFunction : function(value) {
        return value.length >= 6 && value.length <= 24;
      }
    });
    $.formUtils.addValidator({
      name : 'check_name',
      validatorFunction : function(value) {
        var regex = /^[a-zA-Zéèïçà^îù¨ê-]+[ \-']?[[a-zA-Zéèïçà^îù¨ê-]+$/;
        return ( (value.length >= 2 && value.length <= 28) && (regex.test(value))) 
      }
    });

    /*************************************** Infos perso ***************************/
    

    /*************************************** Adress ***************************/
    
    $.formUtils.addValidator({
      name : 'check_num_voie',
      validatorFunction : function(value) {
        return ( (value.length >= 1 && value.length <= 5) && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_alpha_num',
      validatorFunction : function(value) {
        return ( (value.length >= 2 && value.length <= 38) && (value.toString().match(/^[A-Za-z0-9éèïçà^îù¨-ê-]+$/)))  
      }
    });
    $.formUtils.addValidator({
      name : 'check_phone',
      validatorFunction : function(value) {
        start = value.substr(0, 2);
		var array = ["01", "02", "03", "04", "05", "06", "07", "09"];
		return ( value.length == 10  && (parseFloat(value) == parseInt(value)) && !isNaN(value) && array.indexOf(start) >= 0) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_cp',
      validatorFunction : function(value) {
        return ( value.length == 5  && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
      }
    });
    
});