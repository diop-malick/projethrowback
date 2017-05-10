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
<div class="box text-confirmation">
    <p>{l s='Merci pour votre commande' mod='hipay_professional'} <span class="bold">{$cookie->customer_firstname}</span>
        <br />
        {l s='Votre commande a bien été enregistrée, elle est en cours de traitement par nos équipes.' mod='hipay_professional'}
        <br /><span class="bold">{l s='Un email de confirmation vous a été envoyé à l’adresse' mod='hipay_professional'} {$cookie->email}. </span>
        <br />{l s='Nous espérons qu’elle vous apportera entière satisfaction et espérons vous revoir très bientôt sur' mod='hipay_professional' } <a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}index.php{else}{$base_dir}index.php{/if}">Throwbacksneakers.com</a> {l s='pour d’autres instants shopping !' mod='hipay_professional'}
        <br />{l s='Après réception de votre colis, vous avez un délai de 7 jours pour faire des réclamations (échange ou retour).' mod='hipay_professional'}
        <br />{l s='En savoir plus sur les conditions de' mod='hipay_professional'} <a href="{$link->getCMSLink('11', 'retours-et-remboursements')|escape:'html'}">{l s='Retours et remboursement' mod='hipay_professional'}</a>.
    </p>
</div>