<?php

/*
* 04/02/2017
* Surcharge Module user info
* 
* Modify hook for display top
*/

if (!defined('_PS_VERSION_'))
	exit;

class BlocktopmenuOverride extends Blocktopmenu
{

    public function hookLeftColumn($params)
    {
         return $this->hookDisplayTop($params);
    }
    
}

