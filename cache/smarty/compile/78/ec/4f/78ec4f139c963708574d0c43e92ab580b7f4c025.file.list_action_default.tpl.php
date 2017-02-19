<?php /* Smarty version Smarty-3.1.19, created on 2017-02-19 19:42:31
         compiled from "/vagrant/public/throwback16/admin16/themes/default/template/helpers/list/list_action_default.tpl" */ ?>
<?php /*%%SmartyHeaderCode:186761202158a9e717868626-03609797%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '78ec4f139c963708574d0c43e92ab580b7f4c025' => 
    array (
      0 => '/vagrant/public/throwback16/admin16/themes/default/template/helpers/list/list_action_default.tpl',
      1 => 1482160620,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '186761202158a9e717868626-03609797',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'href' => 0,
    'action' => 0,
    'name' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_58a9e717bb8c43_82421612',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58a9e717bb8c43_82421612')) {function content_58a9e717bb8c43_82421612($_smarty_tpl) {?>
<a href="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['href']->value, ENT_QUOTES, 'UTF-8', true);?>
" title="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
"<?php if (isset($_smarty_tpl->tpl_vars['name']->value)) {?> name="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
"<?php }?> class="default">
	<i class="icon-asterisk"></i> <?php echo $_smarty_tpl->tpl_vars['action']->value;?>

</a><?php }} ?>
