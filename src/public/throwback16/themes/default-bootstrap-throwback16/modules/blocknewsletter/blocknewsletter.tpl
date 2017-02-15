<!-- Footer Logo  -->
<div class="col-md-3">
    <img src="{$base_dir}/img/logo/logo-footer.png" class="footer-logo img-responsive" alt="Throwback logo"/>
</div> <!-- // Footer Logo -->


<div class="col-md-4">	

	<div class="row">
		<!-- Block Newsletter module-->
		<div class="col-md-8">

			<div id="newsletter_block_left" class="row block inline">
				<div class="block_content">
					<form action="{$link->getPageLink('index', null, null, null, false, null, true)|escape:'html':'UTF-8'}" method="post">
						<div class="news-footer">
							<i class="fa fa-envelope"></i>
							<input class="inputNew newsletter-input form-control" id="newsletter-input" type="text" name="email" size="18" value="{if isset($msg) && $msg}{$msg}{elseif isset($value) && $value}{$value}{else}{/if}" placeholder="{l s=' Newsletter ' mod='blocknewsletter'}"/>
							<input type="submit" value="OK" class="btn button-default" name="submitNewsletter" />
							<input type="hidden" name="action" value="0"/>
						</div>
					</form>
				</div>
				{hook h="displayBlockNewsletterBottom" from='blocknewsletter'}
			</div>
		</div>
		<!-- /Block Newsletter module-->
{strip}
{if isset($msg) && $msg}
{addJsDef msg_newsl=$msg|@addcslashes:'\''}
{/if}
{if isset($nw_error)}
{addJsDef nw_error=$nw_error}
{/if}
{addJsDefL name=placeholder_blocknewsletter}{l s='Enter your e-mail' mod='blocknewsletter' js=1}{/addJsDefL}
{if isset($msg) && $msg}
	{addJsDefL name=alert_blocknewsletter}{l s='Newsletter : %1$s' sprintf=$msg js=1 mod="blocknewsletter"}{/addJsDefL}
{/if}
{/strip}