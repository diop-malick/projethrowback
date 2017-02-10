
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
				<div class="footer-container">
					<footer id="footer"  class="container">
						{if {$smarty.get.controller} eq 'myaccount' or {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'identity'}
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
			<script type="text/javascript" src="{$base_dir}themes/default-bootstrap-throwback16/css/menu/define.js"></script>
		{if $page_name == 'index'}
			<script type="text/javascript">
				var url_logo = "{$logo_url}";
				var url_logo_simple = "{$base_dir}img/logo/logo-simple.png";
			</script>
			<script type="text/javascript" src="{$base_dir}themes/default-bootstrap-throwback16/css/menu/home.js"></script>
			
		{elseif $page_name == 'category'}
			<script type="text/javascript" src="{$base_dir}themes/default-bootstrap-throwback16/css/menu/category.js"></script>
		{/if}
	</body>
</html>