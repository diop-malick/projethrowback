<?php /* Smarty version Smarty-3.1.19, created on 2017-02-19 19:41:57
         compiled from "/vagrant/public/throwback16/admin16/themes/default/template/content.tpl" */ ?>
<?php /*%%SmartyHeaderCode:155604655758a9e6f5a40039-55910002%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'b0fe478ed66c74a5d4eb4a244c77a8499f0d226d' => 
    array (
      0 => '/vagrant/public/throwback16/admin16/themes/default/template/content.tpl',
      1 => 1482160620,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '155604655758a9e6f5a40039-55910002',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'content' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_58a9e6f5a8e797_86048157',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58a9e6f5a8e797_86048157')) {function content_58a9e6f5a8e797_86048157($_smarty_tpl) {?>
<div id="ajax_confirmation" class="alert alert-success hide"></div>

<div id="ajaxBox" style="display:none"></div>


<div class="row">
	<div class="col-lg-12">
		<?php if (isset($_smarty_tpl->tpl_vars['content']->value)) {?>
			<?php echo $_smarty_tpl->tpl_vars['content']->value;?>

		<?php }?>
	</div>
</div><?php }} ?>
