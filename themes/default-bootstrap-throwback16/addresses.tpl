
{capture name=path}<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">{l s='My account'}</a><span class="navigation-pipe">{$navigationPipe}</span><span class="navigation_page">{l s='My addresses'}</span>{/capture}

<div class="my-account-selfcare">
    <h3 class="page-subheading text-xs-center">{l s='My addresses'}</h3>
    <!--
    <p>{l s='Please configure your default billing and delivery addresses when placing an order. You may also add additional addresses, which can be useful for sending gifts or receiving an order at your office.'}</p> -->
    {if isset($multipleAddresses) && $multipleAddresses}
    <div class="addresses">
    	<!--<p><strong class="dark">{l s='Your addresses are listed below.'}</strong></p>
    	<p class="p-indent">{l s='Be sure to update your personal information if it has changed.'}</p>-->
    	{assign var="adrs_style" value=$addresses_style}
    	<div class="bloc_adresses row">
    	{foreach from=$multipleAddresses item=address name=myLoop}
        	<div class="col-xs-12 col-sm-6 address">
    			<ul class="{if $smarty.foreach.myLoop.last}last_item{elseif $smarty.foreach.myLoop.first}first_item{/if}{if $smarty.foreach.myLoop.index % 2} alternate_item{else} item{/if} box">

                    <div class="row">
                      <div class="col-xs-8 col-sm-8 col-md-10">
                          <h3 class="page-subheading" style="margin-top: 0;">{$address.object.alias}</h3>
                      </div>
                      <div class="col-xs-4 col-sm-4 col-md-2 pull-right">
                          <div class="row">
                            <div class="col-xs-6 text-right up-addr">
                              <a  class="edit" href="{$link->getPageLink('address', true, null, "id_address={$address.object.id|intval}")|escape:'html':'UTF-8'}" title="{l s='Update'}">
                                <i class="fa fa-pencil-square-o icone-update icone-active " aria-hidden="true"></i></a>
                            </div>
                            <div class="col-xs-6 text-left del-addr">
                                <a  class="cart_quantity_delete" href="{$link->getPageLink('address', true, null, "id_address={$address.object.id|intval}&delete")|escape:'html':'UTF-8'}" data-id="addresses_confirm" title="{l s='Delete'}">X</a>
                            </div>
                        </div>
                        </div>
                    </div>

                    {assign var="tab" value=array_splice($address.ordered, 1, 1)}
                    {assign var="tab2" value=array_splice($address.ordered, 0, 0, $tab)}
                    {foreach from=$address.ordered name=adr_loop item=pattern}
                        {assign var=addressKey value=" "|explode:$pattern}
                        <li>
                        {foreach from=$addressKey item=key name="word_loop"}
                            <span {if isset($addresses_style[$key])} class="{$addresses_style[$key]}"{/if}>
                                {$address.formated[$key|replace:',':'']|escape:'html':'UTF-8'}
                            </span>
                        {/foreach}
                        </li>
                    {/foreach}

                </ul>
            </div>
    	{if $smarty.foreach.myLoop.index % 2 && !$smarty.foreach.myLoop.last}
    	</div>
    	<div class="bloc_adresses row">
    	{/if}
    	{/foreach}
    	</div>
    </div>
    {else}
    	<p class="alert alert-no-adress">{l s='No addresses are available.'}</p>
    {/if}


    <div class="row vertical-center">
        <div class="col-md-6 col-sm-6 col-xs-5 vertical-center ">
            <a class="button-exclusive" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}">

                        <span>
                            <i class="icon-chevron-left"></i>
                            {l s='Retour'}
                        </span>

            </a>

        </div>
        {if count($multipleAddresses) < 3}
        <div class="col-md-6 col-sm-6 col-xs-7 text-right pull-right vertical-center">
            <div class="clearfix">
                <a href="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" title="{l s='Add an address'}" class="btn btn-default button button-medium"><span>{l s='Add a new address'}<i class="icon-chevron-right right"></i></span></a>
            </div>
        </div>
        {/if}
    </div>


</div> <!-- end my-account-selfcare -->



{addJsDefL name=addressesConfirm}{l s='Are you sure?' js=1}{/addJsDefL}
