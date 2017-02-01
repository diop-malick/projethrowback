<?php /*%%SmartyHeaderCode:1948525157588f7a5e3c89c2-72800544%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f4d949f44f217d580554628fd367c2fc7b9f927a' => 
    array (
      0 => '/vagrant/public/throwback16/themes/default-bootstrap/modules/blocksearch/blocksearch-top.tpl',
      1 => 1482160624,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1948525157588f7a5e3c89c2-72800544',
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_588f835e577048_63880873',
  'has_nocache_code' => false,
  'cache_lifetime' => 31536000,
),true); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_588f835e577048_63880873')) {function content_588f835e577048_63880873($_smarty_tpl) {?><!-- Block search module TOP -->
<div id="search_block_top" class="col-sm-4 clearfix">
	<form id="searchbox" method="get" action="//localhost:8081/throwback16/index.php?controller=search" >
		<input type="hidden" name="controller" value="search" />
		<input type="hidden" name="orderby" value="position" />
		<input type="hidden" name="orderway" value="desc" />
		<input class="search_query form-control" type="text" id="search_query_top" name="search_query" placeholder="Rechercher" value="" />
		<button type="submit" name="submit_search" class="btn btn-default button-search">
			<span>Rechercher</span>
		</button>
	</form>
</div>
<!-- /Block search module TOP --><?php }} ?>
