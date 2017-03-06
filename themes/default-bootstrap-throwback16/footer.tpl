
{if !isset($content_only) || !$content_only}
					</div><!-- #center_column -->
					{if isset($right_column_size) && !empty($right_column_size)}
						<div id="right_column" class="col-xs-12 col-sm-{$right_column_size|intval} column">{$HOOK_RIGHT_COLUMN}</div>
					{/if}
					</div><!-- .row -->
				</div><!-- #columns -->
			</div><!-- .columns-container -->
			{if isset($HOOK_FOOTER)}
				<!-- Footer -->
				<div class="clearfix"></div>
				<div class="footer-container">
					<footer id="footer"  class="container">
						{if {$smarty.get.controller} eq 'myaccount' or {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'identity' }
							<!-- footer simplified -->
							{include file="$tpl_dir./footer-simple.tpl"}
						{else}
							<!-- footer complete -->
							<div class="row">
								{$HOOK_FOOTER}
							</div>
						{/if}						
					</footer>
				</div><!-- #footer -->
			{/if}
		</div><!-- #page -->
{/if}

{include file="$tpl_dir./global.tpl"}
			
	</body>
</html>

<style type="text/css">

@media (max-width: 800px) {

#contact-link a {
	position:absolute;
	top:-50px;
	right:0px;
}

#social_block {
    right: 20%;
  position: absolute;
  top: -65px;
    
}

#block_contact_infos{
	position: absolute;
    top: 5px;
    width: 200px;
}

}



@media (max-width: 520px) {

 #contact-link a {
  border: none;
  text-shadow: none;
   position: absolute;
   top:-140px;
   right:10px;
}

#social_block {
    width: 50%;
    position: absolute;
    top: -160px;
    left:0px;   
}

 #block_contact_infos{
	position: absolute;
    top: 130px;
    width: 65%;
}

}

</style>