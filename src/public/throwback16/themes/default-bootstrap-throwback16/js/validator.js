(function($, window) {
        
        window.applyValidation = function(validateOnBlur, forms, messagePosition, xtraModule) {
            
            if( !forms )
                forms = 'form';
            if( !messagePosition )
                messagePosition = 'top';

            $.validate({
                form : forms,
                language : {
                    requiredFields: 'Du måste bocka för denna'
                },
                validateOnBlur : validateOnBlur,
                errorMessagePosition : messagePosition,
                scrollToTopOnError : true,
                lang : 'fr',
                sanitizeAll : 'trim', // only used on form C
                // borderColorOnError : 'purple',
                modules : 'security, location, sweden, file,' +
                ' uk, brazil poland' +( xtraModule ? ','+xtraModule:''),
                onModulesLoaded: function() {
                    $('#country-suggestions').suggestCountry();
                    $('#swedish-county-suggestions').suggestSwedishCounty();
                    $('#password').displayPasswordStrength();
                },
                onValidate : function($f) {

                    console.log('about to validate form '+$f.attr('id'));

                    var $callbackInput = $('#callback');
                    if( $callbackInput.val() == 1 ) {
                        return {
                            element : $callbackInput,
                            message : 'This validation was made in a callback'
                        };
                    }
                },
                onError : function($form) {
                    alert('Invalid '+$form.attr('id'));
                },
                onSuccess : function($form) {
                    alert('Valid '+$form.attr('id'));
                    return false;
                }
            });
        };

        window.applyValidation(true, '#create-account_form', $('#error-container'), 'sanitize');
       
        $('input')
                .on('beforeValidation', function() {
                    console.log("hell");
                })
                .on('validation', function(evt, isValid) {
                    var validationResult = '';
                    if( isValid === null ) {
                        validationResult = 'not validated';
                    } else if( isValid ) {
                        validationResult = 'VALID';
                    } else {
                        validationResult = 'INVALID';
                    }
                    console.log('Input '+this.name+' is '+validationResult);
                });

    })(jQuery, window);