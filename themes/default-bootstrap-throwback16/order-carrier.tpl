{if !$opc}
	{capture name=path}{l s='Shipping:'}{/capture}
	{assign var='current_step' value='shipping'}
	{assign var="back_order_page" value="order.php"}
	<div id="carrier_area">		
		{include file="$tpl_dir./order-steps.tpl"}
		{include file="$tpl_dir./errors.tpl"}
		<form id="form" action="{$link->getPageLink('order', true, NULL, "{if $multi_shipping}multi-shipping={$multi_shipping}{/if}")|escape:'html':'UTF-8'}" method="post" name="carrier_area">
{else}
	<div id="carrier_area" class="opc-main-block">
		<h1 class="page-heading step-num"><span>2</span> {l s='Delivery methods'}</h1>
			<div id="opc_delivery_methods" class="opc-main-block">
				<div id="opc_delivery_methods-overlay" class="opc-overlay" style="display: none;"></div>
{/if}
<div class="container clearfix">
<h1>{l s='Choisissez votre lieu de livraison'}</h1>
	<div class="row">
		<div class="order_carrier_content col-sm-9">
			{if isset($virtual_cart) && $virtual_cart}
				<input id="input_virtual_carrier" class="hidden" type="hidden" name="id_carrier" value="0" />
		        <p class="alert alert-warning">{l s='No carrier is needed for this order.'}</p>
			{else}
				<div id="HOOK_BEFORECARRIER">
					{if isset($carriers) && isset($HOOK_BEFORECARRIER)}
						{$HOOK_BEFORECARRIER}
					{/if}
				</div>
				{if isset($isVirtualCart) && $isVirtualCart}
					<p class="alert alert-warning">{l s='No carrier is needed for this order.'}</p>
				{else}
				<div class="row delivery_options_address panel-group" id="accordion">			    
{*********************************************************
Retrait en Magansin / id transporteur = 50
@ author:         Babacar
@ maintainer:     Malick
**********************************************************}
			    <div class="panel panel-default">
			    	<div class="panel-heading">
			    		<h4 class="panel-title">
			    			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse0">
			    				<span class="resp-arrow"></span>
			    				<span class="delivery_option_name">{l s='Retrait en magasin'}</span>			          
			    			</a>
			    			<span class="delivery_option_price free">{l s='Free'}</span>
			    		</h4>
			    	</div>
			      <div id="collapse0" class="panel-collapse collapse">
			        <div class="panel-body delivery_options">
			        <div class="delivery_options_address">
						{if isset($delivery_option_list)}
							{foreach $delivery_option_list as $id_address => $option_list}
					          	<div class="delivery_options resp-tabs-container tab">									
									{foreach $option_list as $key => $option name=options}
										

											{if $option.unique_carrier}
												{foreach $option.carrier_list as $carrier}
													{assign var=mycarrername value=$carrier.instance->name}
													{assign var=mycarrierid value=$carrier.instance->id}

													{if $mycarrername == 'Retrait en magasin'}
													<div class="delivery_option item">											
														<span class="delivery_option_radio hidden">
															<input id="delivery_option_{$id_address|intval}_{$option@index}" class="delivery_option_radio" type="radio" name="delivery_option[{$id_address|intval}]" data-key="{$key}" data-id_address="{$id_address|intval}" value="{$key}"/>
														</span>
														<p>{l s='Où nous trouver'}</p>													
														<div class="clearfix">
			             									<div id="map" ></div>
			             									<p class="shop-info">
																<strong>{l s='Adresse :'}</strong>
																<br>
																67 rue de Belleville 75019 Paris
																<br><br>
																<strong>{l s='Horaires :'}</strong><br>
																{l s='Du Mardi au Vendredi de 11H à 13H30 / de 15H à 19H30'}								
																<br>
																{l s='Samedi de 11H à 19H30'}
																<br>
																{l s='Dimanche 14h - 19H'}
																<br><br>
																<strong>{l s='Tel :'}</strong> +33(0)9 50 64 02 96<br><br>
															</p>
															<p>
																{if $option.unique_carrier}													
																	{if isset($carrier.instance->delay[$cookie->id_lang])}
																		<strong>{l s='Delivery time:'}</strong>&nbsp;{$carrier.instance->delay[$cookie->id_lang]|escape:'htmlall':'UTF-8'}
																	{/if}
																{/if}
															</p>
															<select name="id_address_delivery" id="id_address_delivery" class="address_select form-control hidden">						
																<option value="rem">Retrait en magasin</option>																
															</select>
														</div>
														</div> <!-- end delivery_option item -->
													{/if}														
													{break}
												{/foreach}													
											{/if}
											
										
									{/foreach}
								</div> <!-- end delivery_options -->
							{/foreach}
						{/if}
					</div> <!-- end delivery_options_address -->

			      </div> <!-- end panel body -->
			      </div> <!-- end panel-collapse -->
			    </div> <!-- end panel-default -->

{*********************************************************
Livraison à domicile 
@ author:         Babacar
@ maintainer:     Malick
**********************************************************}
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse2">
			          	<span class="resp-arrow"></span>			          	
			          	<span class="delivery_option_name">{l s='À votre domicile'}</span>
			          </a>
			          <span class="delivery_option_price free">{l s=''}</span>
			        </h4>
			      </div>
			      <div id="collapse2" class="panel-collapse collapse">
			        <div class="panel-body delivery_options">

			        	<div class="row" style="color:#ec4040">
							<i class="fa fa-warning"></i> Avec ce mode de livraison vous ne pourrez pas sélectionner le paiement en magasin à l’étape suivante!
						</div>
						<br>

			        	<div class="delivery_options_address">
			        			<div class="delivery_options resp-tabs-container tab">
			        				<div class="delivery_option item  resp-tab-content tab resp-tab-content-active">
			        					<div class="addresses clearfix">
			        						{* Adresses INFO *}
			        						<div class="row addresses">
			        							<div class="col-sm-12" {if $cart->isVirtualCart()} style="display:none;"{/if}>
			        								<span class="waitimage"></span>
			        								<ul class="address item box {if !isset($addresses) || (isset($addresses) && $addresses|@count lt 2)}hidden{/if}" id="address_delivery">

			        								</ul>
			        							</div>
			        						</div>
											
											{* Adresses ADD *}
											{if !isset($addresses)}
											<div class="row none">
													<div class="col-sm-12">															
														<p class="address_add submit" style="text-align: center">
															<a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="button button-small btn btn-default">
																<span>Ajouter votre première adresse<i class="icon-chevron-right right"></i></span>
															</a>
														</p>	
													</div>																
												</div>
											{/if}
												
											
										</div> <!-- end addresses -->
									</div> <!-- end delivery_option -->
								</div> <!-- end delivery_options -->
							</div> <!-- end delivery_options_address -->

						<div class="delivery_options_address">
							{if isset($delivery_option_list)}
								{foreach $delivery_option_list as $id_address => $option_list}
						          	<div class="delivery_options resp-tabs-container tab">									
										{foreach $option_list as $key => $option name=options}
										<div class="delivery_option item  resp-tab-content tab resp-tab-content-active">

											<div>
												{if $option.unique_carrier}
														{foreach $option.carrier_list as $carrier}														
															{assign var=mycarrername value=$carrier.instance->name}
															{assign var=mycarrierid value=$carrier.instance->id}
															{break}
														{/foreach}													
												{/if}

												{*********************************************************
												Livraison STANDARS / id transporteur = 55
												@ author:         Babacar
												@ maintainer:     Malick
												**********************************************************}
												{if $mycarrername == 'Livraison par Colissimo'}
												{include file="$tpl_dir./order-carrier-adresses.tpl"}
														
												{*********************************************************
												Livraison RECOMMENDE
												@ author:         Babacar
												@ maintainer:     Malick
												**********************************************************}
												{elseif $mycarrername == 'Livraison par Colissimo A/R'}
												{include file="$tpl_dir./order-carrier-adresses.tpl"}

												{/if}

											</div>

										</div> <!-- end delivery_option -->											
										{/foreach}
									</div> <!-- end delivery_options -->
								{/foreach}
							{/if}
						</div> <!-- end delivery_options_address -->			        	

			        </div>
			      </div>
			    </div>

{*********************************************************
Livraison À une autre adresse
@ author:         Babacar
@ maintainer:     Malick
**********************************************************}			    
			    <div class="panel panel-default">
			    	<div class="panel-heading">
			    		<h4 class="panel-title">
			    			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse3">
			    				<span class="resp-arrow"></span>			    				
			    				<span class="delivery_option_name">{l s='À une autre adresse'}</span>
			    			</a>
			    			<span class="delivery_option_price free">{l s=''}</span>
			    		</h4>
			    	</div>
			      <div id="collapse3" class="panel-collapse collapse">
			        <div class="panel-body delivery_options">
			        	
						<div class="delivery_options_address">
			        			<div class="delivery_options resp-tabs-container tab">
			        				<div class="delivery_option item  resp-tab-content resp-tab-content-active tab">
			        					<div class="addresses clearfix">
														<p style="color:#ec4040">
															<i class="fa fa-warning"></i> Attention, avec ce mode de livraison vous ne pourrez pas sélectionner le paiement en magasin à l’étape suivante!
														</p>
														<br>
														{* Adresses selector *}
			        										{* TODO - check delete virtual cart	code *}
														<div class="row address {if !isset($addresses) || (isset($addresses) && $addresses|@count lt 2)}hidden{/if}">
															<div class="col-xs-12 col-sm-6">
																<div class="address_delivery select form-group selector1">
																	<label for="id_address_delivery">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
																	<select name="id_address_delivery" id="id_address_delivery" class="address_select form-control">
																		{if isset($addresses) && $addresses|@count gt 1}
																			{foreach from=$addresses key=k item=address name=addresses}
																				{if $smarty.foreach.addresses.iteration > 1}
																					<option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
																						{$address.alias|escape:'html':'UTF-8'}
																					</option>
																					{if $smarty.foreach.addresses.iteration == 3}
																						{assign var=maxAddresses value=true}
																						{break}
																					{/if}
																				{/if }
																			{/foreach}
																		{/if}
																	</select>
																</div>																
															</div>																	
														</div> <!-- end row -->
														{* end Adresses selector *}

														<br>
														<div class="row addresses">
															<div class="col-sm-12" {if $cart->isVirtualCart()} style="display:none;"{/if}>
																<span class="waitimage"></span>
																<ul class="address item box {if !isset($addresses) || (isset($addresses) && $addresses|@count lt 2)}hidden{/if}" id="address_delivery">
																
																</ul>
															</div>
														</div> <!-- end row -->
														
															<div class="row {if !isset($addresses) || (isset($addresses) && $addresses|@count lt 2)}none{/if}">
																															
															</div> <!-- end row -->
																								
														<p class="address_add submit {if isset($addresses) && $addresses|@count gt 2}hidden{/if}" style="text-align: center">
															<a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Add'}" class="button button-small btn btn-default">
																<span>Ajouter une adresse secondaire<i class="icon-chevron-right right"></i></span>
															</a>
														</p>
													</div> <!-- end addresses -->													
													<div id="address" class="hidden clearfix"></div>

									</div> <!-- end delivery_option -->
								</div> <!-- end delivery_options -->
							</div> <!-- end delivery_options_address -->

						<div class="delivery_options_address">
							{if isset($delivery_option_list)}
								{foreach $delivery_option_list as $id_address => $option_list}
						          	<div class="delivery_options">	

										{foreach $option_list as $key => $option name=options}
										<div class="delivery_option item">												
												{if $option.unique_carrier}
														{foreach $option.carrier_list as $carrier}														
															{assign var=mycarrername value=$carrier.instance->name}
															{assign var=mycarrierid value=$carrier.instance->id}
															{break}
														{/foreach}													
												{/if}

												{*********************************************************
												Livraison STANDARS / id transporteur = 55
												@ author:         Babacar
												@ maintainer:     Malick
												**********************************************************}
												{if $mycarrername == 'Livraison par Colissimo'}
													{include file="$tpl_dir./order-carrier-adresses.tpl"}

														
												{*********************************************************
												Livraison RECOMMENDE
												@ author:         Babacar
												@ maintainer:     Malick
												**********************************************************}
												{elseif $mycarrername == 'Livraison par Colissimo A/R'}
													{include file="$tpl_dir./order-carrier-adresses.tpl"}
														
												{/if}

										</div> <!-- end delivery_option -->											
										{/foreach}
									</div> <!-- end delivery_options -->
								{/foreach}
							{/if}
						</div> <!-- end delivery_options_address -->
			        </div> <!-- end panel-body --> 
			      </div> <!-- end collapse -->
			    </div> <!-- end Panel -->



		</div> <!-- end row delivery_options_address -->

					<div class="delivery_options_address" id="tabs">
						{if isset($delivery_option_list)}
							{foreach $delivery_option_list as $id_address => $option_list}
								<div class="hook_extracarrier" id="HOOK_EXTRACARRIER_{$id_address}">
									{if isset($HOOK_EXTRACARRIER_ADDR) &&  isset($HOOK_EXTRACARRIER_ADDR.$id_address)}{$HOOK_EXTRACARRIER_ADDR.$id_address}{/if}
								</div>
								{foreachelse}
									{assign var='errors' value=' '|explode:''}
									<p class="alert alert-warning" id="noCarrierWarning">
										{foreach $cart->getDeliveryAddressesWithoutCarriers(true, $errors) as $address}
											{if empty($address->alias)}
												{l s='No carriers available.'}
											{else}
												{assign var='flag_error_message' value=false}
												{foreach $errors as $error}
													{if $error == Carrier::SHIPPING_WEIGHT_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s): it is too heavy. Please amend your cart to lower its weight.'}
													{elseif $error == Carrier::SHIPPING_PRICE_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s). Please amend your cart.'}
													{elseif $error == Carrier::SHIPPING_SIZE_EXCEPTION}
														{$flag_error_message = true}
														{l s='The product selection cannot be delivered by the available carrier(s): its size does not fit. Please amend your cart to reduce its size.'}
													{/if}
												{/foreach}
												{if !$flag_error_message}
													{l s='No carriers available for the address "%s".' sprintf=$address->alias}
												{/if}
											{/if}
											{if !$address@last}
												<br />
											{/if}
										{foreachelse}
											{l s='No carriers available.'}
										{/foreach}
									</p>
								{/foreach}
							{/if}
					</div> <!-- end delivery_options_address -->

					<div id="extra_carrier" style="display: none;"></div>
						{if $opc}
							<p class="carrier_title">{l s='Leave a message'}</p>
							<div>
								<p>{l s='If you would like to add a comment about your order, please write it in the field below.'}</p>
								<textarea class="form-control" cols="120" rows="2" name="message" id="message">{strip}
									{if isset($oldMessage)}{$oldMessage|escape:'html':'UTF-8'}{/if}
								{/strip}</textarea>
							</div>
						{/if}
						{if $recyclablePackAllowed}
							<p class="carrier_title">{l s='Recyclable Packaging'}</p>
							<div class="checkbox recyclable">
								<label for="recyclable">
									<input type="checkbox" name="recyclable" id="recyclable" value="1"{if $recyclable == 1} checked="checked"{/if} />
									{l s='I would like to receive my order in recycled packaging.'}
								</label>
							</div>
						{/if}
						{if $giftAllowed}
							{if $opc}
								<hr style="" />
							{/if}
							<p class="carrier_title">{l s='Gift'}</p>
							<div class="checkbox gift">
								<input type="checkbox" name="gift" id="gift" value="1"{if $cart->gift == 1} checked="checked"{/if} />
								<label for="gift">
									{l s='I would like my order to be gift wrapped.'}
									{if $gift_wrapping_price > 0}
										&nbsp;<i>({l s='Additional cost of'}
										<span class="price" id="gift-price">
											{if $priceDisplay == 1}
												{convertPrice price=$total_wrapping_tax_exc_cost}
											{else}
												{convertPrice price=$total_wrapping_cost}
											{/if}
										</span>
										{if $use_taxes && $display_tax_label}
											{if $priceDisplay == 1}
												{l s='(tax excl.)'}
											{else}
												{l s='(tax incl.)'}
											{/if}
										{/if})
										</i>
									{/if}
								</label>
							</div>
							<p id="gift_div">
								<label for="gift_message">{l s='If you\'d like, you can add a note to the gift:'}</label>
								<textarea rows="2" cols="120" id="gift_message" class="form-control" name="gift_message">{$cart->gift_message|escape:'html':'UTF-8'}</textarea>
							</p>
						{/if}
						{/if}
					{/if}

					{if $conditions && $cms_id && (! isset($advanced_payment_api) || !$advanced_payment_api)}
						{if $opc}
							<hr style="" />
						{/if}
		                {if isset($override_tos_display) && $override_tos_display}
		                    {$override_tos_display}
		                {else}
		                    <div class="box hidden">
		                        <p class="checkbox">
		                            <input type="checkbox" name="cgv" id="cgv" value="1" checked {if $checkedTOS}checked="checked"{/if} />
		                            <label for="cgv">{l s='I agree to the terms of service and will adhere to them unconditionally.'}</label>
		                            <a href="{$link_conditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='(Read the Terms of Service)'}</a>
		                        </p>
		                    </div>
		                {/if}
					{/if}

				</div> <!-- end delivery_options_address -->

		{if !$opc}				
				
				<div class="cart_navigation clearfix  col-sm-3" style="padding:8px;">
					{include file="$tpl_dir./facturette.tpl"}
				</div>

			</div>
		</div>
	</form>
{else}
	</div> <!-- end opc_delivery_methods -->
{/if}
</div> <!-- end carrier_area -->
{strip}
{if !$opc}
	{addJsDef orderProcess='order'}
	{if isset($virtual_cart) && !$virtual_cart && $giftAllowed && $cart->gift == 1}
		{addJsDef cart_gift=true}
	{else}
		{addJsDef cart_gift=false}
	{/if}
	{addJsDef orderUrl=$link->getPageLink("order", true)|escape:'quotes':'UTF-8'}
	{addJsDefL name=txtProduct}{l s='Product' js=1}{/addJsDefL}
	{addJsDefL name=txtProducts}{l s='Products' js=1}{/addJsDefL}
{/if}
{if $conditions}
	{addJsDefL name=msg_order_carrier}{l s='You must agree to the terms of service before continuing.' js=1}{/addJsDefL}
{/if}
{capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
{capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
{addJsDef addressUrl=$smarty.capture.addressUrl}
{capture}{'&multi-shipping=1'|urlencode}{/capture}
{addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
{capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
{addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
{addJsDef formatedAddressFieldsValuesList=$formatedAddressFieldsValuesList}
{addJsDef opc=$opc|boolval}
{capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
{addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
{addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<a class="btn btn-default" style="position:absolute;top:6px;right:12px;font-size:20px" href="{$smarty.capture.addressUrlAdd}" title="{l s='Update' js=1}"><span><i class="fa fa-edit"></i></span></a>{/capture}
{addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{if isset($idSelectedState)}
	{addJsDef idSelectedState=$idSelectedState}
{/if}
{if isset($idSelectedCountry)}
	{addJsDef idSelectedCountry=$idSelectedCountry}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{/strip}

{literal}
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDnIXYJYTobkgB_9Nr1AEeGn84d_KPM74c&callback=initMap&language=fr&region=SN" async defer></script>
{/literal}