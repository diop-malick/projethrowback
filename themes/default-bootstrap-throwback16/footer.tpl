
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
						{* {if {$smarty.get.controller} eq 'myaccount' or {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'identity' or {$smarty.get.controller} eq 'order-confirmation' or (({$smarty.get.controller} eq 'order') && ( ({$smarty.get.step} eq '1') or ({$smarty.get.step} eq '2')))} *}
						{if {$smarty.get.controller} eq 'authentication' or {$smarty.get.controller} eq 'orderconfirmation' or ({$smarty.get.controller} eq 'order' &&  ((!isset($smarty.get.step) or {$smarty.get.step} neq '0')) ) }
							<!-- footer simplified -->
							<div class="row">
							{include file="$tpl_dir./footer-simple.tpl"}
							</div>
						{else}
							<!-- footer complete -->
							<div class="row">
								{$HOOK_FOOTER} 
								
								{if $logged && isset($newsletter) && $newsletter==1 }
										<div class="row">
											<div class="col-md-3 col-md-offset-9">
												<a href="http://ovh.us15.list-manage.com/unsubscribe?u=d56def1fdca3f61da060d5d2a&id=2eca580371" class="link-deconnexion">{l s='Se déconnecter'}</a>
											 </div>
										</div>
								{/if}
								
							</div>
						{/if}

						
						<div id="textSEO" class="container">
							{if {$smarty.get.controller} eq 'index' or {$smarty.get.controller} eq 'cms'  or {$smarty.get.controller} eq 'search' or ({$smarty.get.controller} eq 'order' AND (int)Tools::getValue('step') == 0 ) }
								{l s='La marque Throwback Sneakers a été créée par et pour des passionnés de la culture Sneaker.  
									  Notre site Internet créé en 2009 a évolué dans cette direction pour permettre de proposer des produits
									   forts et emblématiques aux passionnés, mêlant nouveautés Retro, innovation et produits "Deadstock".
										Les sneakers sont bien plus que des chaussures de sport, elles sont devenues un 
										incontournable du look sportif, élégant et détendu. Des baskets Nike aux tennis Adidas découvrez notre sélection de sneakers.
										Throwback Sneakers est un site marchand mais nous vous invitons également à suivre et partager nos articles, discussions et analyses
										autour de la sneakers à la fois sur notre page Facebook et notre blog.'}
							{elseif {$smarty.get.controller} eq 'category' or {$smarty.get.controller} eq 'product'  }
								{$category->description}
					
							{/if}
						</div> 
					</footer>

				</div><!-- #footer -->
			{/if}
		</div><!-- #page -->
{/if}

{include file="$tpl_dir./global.tpl"}

	</body>
</html>
