<!-- COL UserInfo + Cart -->
<div id ="user_info" class="col-xs-6 col-sm-6 col-md-4 pull-right" >
	<!-- ROW UserInfo + Cart -->
	<div class="row" id ="user_info_cart">

		<!-- MODULE Block UserInfo  NAV  -->
		<div class="col-xs-6 col-sm-6 col-md-7 text-right header_user_info">
		   <div class="dropdown">
			{if $is_logged}
				<button class="dropbtn">
					<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">

				      			<span class="hidden-xs">{l s='Bonjour' mod='blockuserinfo'} {$cookie->customer_firstname}</span>
								<span class="icon-fix"><i class="material-icons">person</i></span>		      			
				      </a>
			    </button>
			    <div class="dropdown-content pull-right">
			      		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account text-left" rel="nofollow">
			      			<span>{l s='Mon compte' mod='blockuserinfo'}</span>
			      		</a>

						<a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}" title="{l s='Addresses'} " class="text-left">
                				<span>{l s='Mes adresses' mod='blockuserinfo'}</span>
                		</a>

                		<a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Orders'}" class="text-left">
	                			<span>{l s='Mes commandes' mod='blockuserinfo'}</span>
	                	</a>

	                	<a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}?action=newsletter" title="{l s='Information'}" class="text-left">
                				<span>{l s='Newsletter'}</span>
                		</a>

						<a class="logout text-left" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log me out' mod='blockuserinfo'}">

						{l s='Sign out' mod='blockuserinfo'}
						</a>
			    </div>
			{else}
			<button class="dropbtn">

				<a href="javascript:void(0)">
					<span class="hidden-xs">{l s='My espace' mod='blockuserinfo'}</span>
					<span class="icon-fix"><i class="material-icons">person</i></span>		      			
				</a>
			</button>

		    	<div class="dropdown-content dropdown-menu">
					<a class="login" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log in to your customer account' mod='blockuserinfo'}">
						{l s='Sign in' mod='blockuserinfo'}
					</a>

					<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">
			      			<span>{l s='Sign up' mod='blockuserinfo'}</span>
			      		</a>
				</div>
			{/if}
			</div>
		</div>
		<!-- // MODULE Block UserInfo NAV -->
