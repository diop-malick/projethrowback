<?php

include_once(dirname(__FILE__) . '/../../../config/config.inc.php');
include_once(dirname(__FILE__) . '/../../../init.php');

$debug = Tools::getValue("DEBUG","0");
if(!empty($debug))
{
    @error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);
    @ini_set("display_errors", "ON");
}

@set_time_limit(0);
ini_set('memory_limit', '512M');

$api_key = Tools::getValue("key");
$service = Tools::getValue("service");
$action = Tools::getValue("action");

if(!empty($api_key))
{
    $sql = '
				SELECT *
				FROM `'._DB_PREFIX_.'webservice_account`
				WHERE 
					`key` = "'.pSQL($api_key).'"
					AND active = "1"';
    $authorized = Db::getInstance()->getRow($sql);
    if(!empty($authorized["id_webservice_account"]))
    {
        if(!empty($service) && !empty($action))
        {
            if(strpos($service, "/")===false && file_exists(dirname(__FILE__)."/services/".$service.".php"))
            {
                require_once (dirname(__FILE__)."/services/".$service.".php");
            }
            else
            {
                header("HTTP/1.1 400 Bad Request");
                exit;
            }
        }
        else
        {
            header("HTTP/1.1 400 Bad Request");
            exit;
        }
    }
    else
    {
        header("HTTP/1.1 401 Unauthorized");
        exit;
    }
}
else
{
    header("HTTP/1.1 401 Unauthorized");
    exit;
}