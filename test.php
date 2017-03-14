<?php

// ensure PATH
echo "Le chemin absolu est : ".realpath('CleanupImageDir.php'); 
echo "<br/>";
echo "Le chemin relatif est : ".$_SERVER['PHP_SELF'];
echo "<br/><br/>";

$path='malick';

// unlink($path.'/'.$entry);
$result = unlink($path.'/test.txt');
echo "result : ".$result ;
