
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
						{if {$smarty.get.controller} eq 'myaccount' or {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'identity' or {$smarty.get.controller} eq 'order-confirmation' or (({$smarty.get.controller} eq 'order') && ( ({$smarty.get.step} eq '1') or ({$smarty.get.step} eq '2')))}
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
