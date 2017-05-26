
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
				<div class="text-copyright">
								&copy; 2009-2017 ALL RIGHTS RESERVED
				</div>
				<div class="footer-container">
					<footer id="footer"  class="container">
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
												<a href="http://ovh.us15.list-manage.com/unsubscribe?u=d56def1fdca3f61da060d5d2a&id=2eca580371" class="link-deconnexion">{l s='Se désabonner'}</a>
											 </div>
										</div>
								{/if}
								
							</div>
						{/if}

						<div class="clearfix"></div>
						<div id="textSEO" class="container">

							{if ({$smarty.get.controller} eq 'index' or {$smarty.get.controller} eq 'cms'  or {$smarty.get.controller} eq 'search' or ({$smarty.get.controller} eq 'order' AND (int)Tools::getValue('step') == 0 )) AND {$lang_iso} eq 'fr'}
								{l s='La marque Throwback Sneakers a été créée par et pour des passionnés de la culture Sneaker.  
									  Notre site Internet créé en 2009 a évolué dans cette direction pour permettre de proposer des produits
									   forts et emblématiques aux passionnés, mêlant nouveautés Retro, innovation et produits "Deadstock".
										Les sneakers sont bien plus que des chaussures de sport, elles sont devenues un 
										incontournable du look sportif, élégant et détendu. Des baskets Nike aux tennis Adidas découvrez notre sélection de sneakers.
										Throwback Sneakers est un site marchand mais nous vous invitons également à suivre et partager nos articles, discussions et analyses
										autour de la sneakers à la fois sur notre page Facebook et notre blog.'}
							{elseif ({$smarty.get.controller} eq 'index' or {$smarty.get.controller} eq 'cms'  or {$smarty.get.controller} eq 'search' or ({$smarty.get.controller} eq 'order' AND (int)Tools::getValue('step') == 0 )) AND {$lang_iso} eq 'en'}
								
									{l s='Throwback Sneakers is a universe created by and for Sneaker Culture fans.
										Our website created in 2009 has evolved in this direction to allow to offer selected and emblematic products to sneakerheads combining Retro, new innovations and "Deadstock" items.										
                                        The sneakers are much more than sport footwear, they are now are now considered as essentials in the area of elegant and casual look.
										Throwback Sneakers is an online shop but we also invite you to follow and share our articles, analyzes and discussions around sneakers on both our Facebook page and blog.'}
								
							{elseif {$smarty.get.controller} eq 'newproducts' AND {$lang_iso} eq 'fr'}
								{l s='Ça vient d\'arriver ! Les Nouveautés sont à l\'honneur sur Throwback Sneaker. Retrouvez toutes les nouveautés des plus grandes marques: Adidas Originals, Nike, Puma New Balance, Asics, Le Coq Sportif. Profitez sans plus tarder de la livraison gratuite en France !'}
							{elseif {$smarty.get.controller} eq 'newproducts' AND {$lang_iso} eq 'en'}
							    {l s='Just arrived ! Throwback Sneakers continuously expand her collection with innovative products that are high in demand. Find out what\'s new from the biggest brands: Adidas Originals, Nike, Puma New Balance, Asics, Le Coq Sportif. Take advantage of free delivery in France!'}
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
			{if $page_name == 'index' }
				<script>
					$(document).ready(function(){
						$( ".slidelink a" ).on('click touchstart', function (e) {
							e.preventDefault();
							window.location.href = $(this).attr('href');
						});
					});
				</script>
			{/if}
	</body>
</html>
