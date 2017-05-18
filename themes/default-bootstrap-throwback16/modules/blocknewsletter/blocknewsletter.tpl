<!-- Footer Logo  -->
<div class="col-sm-2 col-md-2 col-xs-12">
    <img src="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}img/logo/logo-footer.png" class="footer-logo img-responsive" alt="Throwback logo"/>
</div> <!-- // Footer Logo -->

<!-- Newletter fancyBox -->
<div class="col-sm-6 col-md-5 col-xs-12">	
	<div class="row">
		
		<div class="col-sm-8 col-md-8">

			<div id="newsletter_block_left" class="block inline">
				<div class="block_content">

                    <!-- NEWLETTER -->
                            
                            <form id="mc-embedded-subscribe-form">
                                <div class="news-footer">
                                    <i class="fa fa-envelope"></i>
                                    <input class="inputNew newsletter-input form-control required email" id="newsletter-input" type="text" name="EMAIL" size="18" placeholder="{l s=' Newsletter ' mod='blocknewsletter'}" data-validation="email" data-validation-error-msg="{l s='Adresse mail saisie incorrecte.'}" />
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
