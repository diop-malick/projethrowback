<!-- Footer Logo  -->
<div class="col-md-3">
    <img src="{$base_dir}/img/logo/logo-footer.png" class="footer-logo img-responsive" alt="Throwback logo"/>
</div> <!-- // Footer Logo -->


<!-- Block Newsletter module-->
<div style="display:none">
	<div id="mc_embed_signup" class=" block inline">
		<form id="mc-embedded-subscribe-form">
			<div class="news-footer">
						<i class="fa fa-envelope fa-3x"></i>
						<input class="inputNew newsletter-input form-control required email" id="newsletter-input" type="text" name="EMAIL" size="18" value="" placeholder="{l s=' Newsletter ' mod='blocknewsletter'}"/>
						<!-- <span class="glyphicon glyphicon-remove-circle"></span> -->
						<!-- <input type="submit" value="OK" class="btn button-default" name="submitNewsletter" /> -->
						<br>
						<span class="response" id="mce-error-response" style="display:none"></span>
						<span class="response" id="mce-success-response" style="display:none"></span>
						<br>
							<!-- <input type="hidden" name="action" value="0"/> -->
							<!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
					    <div style="position: absolute; left: -5000px;" aria-hidden="true">
					    	<input type="text" name="b_d56def1fdca3f61da060d5d2a_2eca580371" tabindex="-1" value="">
					    </div>
					    <div class="clear">
					    <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button"></div>
			</div>
		</form>					
	</div>
</div>
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
             'minWidth'          : 350,
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
					<div id="contact-link" class="text-center">
						<a id="displaynewsletter" href="#mc_embed_signup" title="{l s='Newsletter' mod='blockcontact'}">
						<i class="fa fa-envelope"></i>{l s=' Newsletter' mod='blocknewletter'}
						</a>
					</div>
				</div>
			</div>
		</div>		



