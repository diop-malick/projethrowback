<?php

class ProductController extends ProductControllerCore{

    // Add for throwback curstomisation 

    public function getDateDiff($date1, $date2){
        $diff = abs($date1 - $date2); // abs pour avoir la valeur absolute, ainsi éviter d'avoir une différence négative
        $retour = array();
     
        $tmp = $diff;
        $retour['second'] = $tmp % 60;
     
        $tmp = floor( ($tmp - $retour['second']) /60 );
        $retour['minute'] = $tmp % 60;
     
        $tmp = floor( ($tmp - $retour['minute'])/60 );
        $retour['hour'] = $tmp % 24;
     
        $tmp = floor( ($tmp - $retour['hour'])  /24 );
        $retour['day'] = $tmp;
     
        return $retour;
    }

    // Add for throwback curstomisation 

    public function getDateavailabilitydiff(){

        $now = time();
        $date2 = strtotime($this->product->available_date);
        // print_r($this->getDateDiff($now, $date2));

        $dateavailabilitydiff = $this->getDateDiff($now, $date2); 
        // var_dump(($dateavailabilitydiff));

        return $dateavailabilitydiff;
    }

    // overide init content

    public function initContent()
    {
        parent::initContent();

        // Add for throwback curstomisation 
        $dateavailabilitydiff = $this->getDateavailabilitydiff();;
        $this->context->smarty->assign('dateavailabilitydiff', $dateavailabilitydiff);
    }

}

?>