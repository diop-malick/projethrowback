<!-- COL UserInfo + Cart -->
<div class="col-md-4 col-xs-4 pull-right">
	<!-- ROW UserInfo + Cart -->
	<div class="row">

		<!-- MODULE Block UserInfo  NAV  -->
		<div class="header_user_info col-md-6 col-xs-6 text-right">
		   <div class="dropdown">
			{if $is_logged}
				<button class="dropbtn">
					<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">
				      			 <span id="icone_mon_compte"><span  class="hidden-xs">{l s='Welcome' mod='blockuserinfo'} {$cookie->customer_firstname}</span>

				      				 <img class="hidden-xs" src="{$base_dir}/img/icones/icone-mon-compte-on.png"/>
											 <img class="visible-xs" src="{$base_dir}/img/icones/icone-Mon-compte_MOB.png"/>

				      			</span>
				      </a>
			    </button>
			    <div class="dropdown-content">
			      		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account text-left" rel="nofollow">
			      			<span>{l s='View my customer account' mod='blockuserinfo'}</span>
			      		</a>



						<a href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}" title="{l s='Addresses'} " class="text-left">
                				<span>{l s='My addresses'}</span>
                		</a>

                		<a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='Orders'}" class="text-left">
	                			<span>{l s='Order history and details'}</span>
	                	</a>

	                	<a href="{$link->getPageLink('identity', true)|escape:'html':'UTF-8'}&action=newsletter" title="{l s='Information'}" class="text-left">
                				<span>{l s='Newsletter'}</span>
                		</a>

						<a class="logout text-left" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log me out' mod='blockuserinfo'}">

						{l s='Sign out' mod='blockuserinfo'}
						</a>
			    </div>
			{else}
				<button class="dropbtn">
					<a href="javascript:void(0)">
						<span>
							<span  class="hidden-xs">{l s='My espace' mod='blockuserinfo'} <img src="{$base_dir}/img/icones/icone-mon-compte-off.png"/></span>
							 																			<img class="visible-xs" src="{$base_dir}/img/icones/icone-Mon-compte_MOB.png"/>
						</span>
					</a>
		    	</button>
		    	<div class="dropdown-content">
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
