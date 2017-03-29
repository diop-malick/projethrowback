/*
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
*/
// Variable globale

$(document).ready(function(){
	//var node = document.querySelectorAll('a[title="Services"]')
	var catCmsDir = "index.php?id_cms_category";
	var dir = baseDir + catCmsDir;
    var cms_services = baseDir  + 'index.php?id_cms=7&controller=cms&id_lang='+ langue_id;
    var cms_lien_legaux = baseDir + 'index.php?id_cms=12&controller=cms&id_lang='+ langue_id;
	//var els = document.querySelectorAll("a[href^='"+dir+"']");   
    $("a[href^='"+dir+"']").addClass("CategoryCms");
    var els =  document.getElementsByClassName("CategoryCms");
	for (var i = 0, l = els.length; i < l; i++) {
  		var el = els[i];       
          if (el.href.indexOf("id_cms_category=3") > -1) {
               el.onclick = function(){el.href = cms_services}();
          }
          else if (el.href.indexOf("id_cms_category=4") > -1) {
               el.onclick = function(){el.href = cms_lien_legaux}();
          }

	} 
});