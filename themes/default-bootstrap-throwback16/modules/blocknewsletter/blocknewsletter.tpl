<!-- Footer Logo  -->
<div class="col-md-3">
    <img src="{$base_dir}/img/logo/logo-footer.png" class="footer-logo img-responsive" alt="Throwback logo"/>
</div> <!-- // Footer Logo -->


<!-- Block Newsletter module-->
<!-- <div style="display:none">
	<div id="mc_embed_signup" class="row">
    		<div class="thumbnail center well well-lg text-center">
    		<div id="mc_embed_signup_header">
                <h2>Newsletter</h2>               
                <p>Abonnez vous à notre newletter </p>
            </div>    
                <form id="mc-embedded-subscribe-form">
                    <div class="input-prepend">
                        <input class="inputNew newsletter-input form-control required email" id="newsletter-input" type="text" name="EMAIL" size="18" value="" placeholder="{l s=' Newsletter ' mod='blocknewsletter'}"/>
                    </div>
                    <br />
					<div class="text-center">
						<span class="response" id="mce-error-response" style="display:none; color:red;"></span>
						<span class="response" id="mce-success-response" style="display:none; color:green;"></span>
					</div>
                    <input type="submit" value="S'inscrire" class="btn btn-large btn-default button-medium" />
              </form>
            </div>    
	</div>
</div> -->
<!-- Block Newsletter module-->

<!-- Newletter fancyBox -->

<script type="text/javascript">
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
            // 'type': 'iframe',
            // 'width': 250,
            // 'height': '90%',
         });
     });
     </script>



<div class="col-md-4">	
	<div class="row">
		
		<div class="col-md-8">

			<div id="newsletter_block_left" class=" block inline">
				<div class="block_content">
					
                    <!-- Link to Trigger the modal NEWLETTER -->
					<!-- <div id="contact-link" class="text-center">
						<a id="displaynewsletter" href="#mc_embed_signup" title="{l s='Newsletter' mod='blockcontact'}">
						<i class="fa fa-envelope"></i>{l s=' Newsletter' mod='blocknewletter'}
						</a>
					</div> -->

                    <!-- NEWLETTER -->
                            
                            <form id="mc-embedded-subscribe-form">
                                <div class="news-footer">
                                    <i class="fa fa-envelope"></i>
                                    <input class="inputNew newsletter-input form-control required email" id="newsletter-input" type="text" name="EMAIL" size="18" placeholder="{l s=' Newsletter ' mod='blocknewsletter'}" data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}" required />
                                    <span class="glyphicon glyphicon-remove-circle"></span>
                                    <input type="submit" value="OK" class="btn button-default" name="submitNewsletter"  />              
                                    <input type="hidden" name="action" value="0"/>
                                </div>
                            </form>
                            <div class="row">
                                <span class="response" id="mce-error-response" style="display:none; color:red"></span>
                                <span class="response" id="mce-success-response" style="display:none; color:green"></span>
                            </div>

				</div>
			</div>
		</div>	

<script>

    $.validate({
            lang : 'fr',
            modules : 'file,html5,sanitize,toggleDisabled,security',
            form : '#mc-embedded-subscribe-form'
    });

</script>