<?php /* Smarty version Smarty-3.1.19, created on 2017-02-19 19:42:30
         compiled from "/vagrant/public/throwback16/admin16/themes/default/template/helpers/list/list_action_edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:5027309758a9e7168c1f25-59326717%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ba8e6a2dfdaf6fc3700b64ff3b9ba6e8b9657ecf' => 
    array (
      0 => '/vagrant/public/throwback16/admin16/themes/default/template/helpers/list/list_action_edit.tpl',
      1 => 1482160620,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '5027309758a9e7168c1f25-59326717',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'href' => 0,
    'action' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.19',
  'unifunc' => 'content_58a9e716b402e1_00481867',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58a9e716b402e1_00481867')) {function content_58a9e716b402e1_00481867($_smarty_tpl) {?>
<a href="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['href']->value, ENT_QUOTES, 'UTF-8', true);?>
" title="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['action']->value, ENT_QUOTES, 'UTF-8', true);?>
" class="edit">
	<i class="icon-pencil"></i> <?php echo htmlspecialchars($_smarty_tpl->tpl_vars['action']->value, ENT_QUOTES, 'UTF-8', true);?>

</a><?php }} ?>
