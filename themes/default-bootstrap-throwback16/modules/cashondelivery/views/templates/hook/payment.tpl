{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<!--
<div class="row">
	<div class="col-xs-12">
        <p class="payment_module">
            <a class="cash" href="{$link->getModuleLink('cashondelivery', 'validation', [], true)|escape:'html'}" title="{l s='Pay with cash on delivery (COD)' mod='cashondelivery'}" rel="nofollow">
            	{l s='Pay with cash on delivery (COD)' mod='cashondelivery'}
            	<span>({l s='You pay for the merchandise upon delivery' mod='cashondelivery'})</span>
            </a>
        </p>
    </div>
</div>
-->

<div class="row">
	<div class="col-xs-12">
        <div class="row">
        	<div class="col-xs-12">
        	Présentez vous à la caisse de notre boutique, munie de votre bon de commande reçue par mail et d’une pièce d’identité. Vous pourrez payer la commande selon le mode de votre choix et la retirer.
        	</div>
        </div>

        <div class="row">
        <div class="col-xs-3 text-center">
        		<i class="fa fa-money fa-paiement" aria-hidden="true"></i>
        	</div>
        	<div class="col-xs-3 text-center">
        		<i class="fa fa-cc-mastercard fa-paiement" aria-hidden="true"></i>
        	</div>
        	<div class="col-xs-3 text-center">
        		<i class="fa fa fa-credit-card fa-paiement" aria-hidden="true"></i>
        	</div>
        	<div class="col-xs-3 text-center">
        		<i class="fa fa-cc-visa fa-paiement" aria-hidden="true"></i>
        	</div>

        </div>
        <hr>
        <div class="row">
        	<div class="col-xs-12">
        		<p>Où nous trouver</p>													
				<div class="clearfix">
		             	<div id="map" style="width:100%;height:18em;background:#ececec;float:left;max-width:36em;margin:0 12px 12px 0" ></div>
		             	<p style="line-height: 1.5em" class="shop-info">
							<strong>Adresse :</strong><br>
							67 rue de Belleville 75019 Paris<br><br>
							<strong>Horaires :</strong><br>														
							Du Mardi au Vendredi de 11H à 13H30 / de 15H à 19H30<br>
							Samedi de 11H à 19H30<br>
							Dimanche 14h - 19H<br><br>
							<strong>Tel :</strong> +33(0)9 50 64 02 96<br><br>
						</p>
				</div>
        	</div>
        </div>
        <hr>
        <div class="row">
        	<div class="col-xs-12">
        		En validant votre commande, vous acceptez et déclarez avoir pris connaissance des <a href="{$link->getCMSLink('17', 'cgv')|escape:'html'}&content_only=1" class="popup-cgv">conditions générales de vente</a>.
        	</div>
        </div>

    </div>
</div>
<script>
    
    function initMap(){
    if(document.getElementById('map')){
      var latLong = {
        lat: 48.873509 , lng: 2.382527
      };
      var center = {
        lat: 48.873499 , lng: 2.382627
      };
      var map = new google.maps.Map(document.getElementById('map'), {
        center: center,
        zoom: 20
      });
      var marker = new google.maps.Marker({
        position: latLong,
        map: map
      });
    }   
  }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDnIXYJYTobkgB_9Nr1AEeGn84d_KPM74c&callback=initMap&language=fr&region=SN" async defer></script>