<?php

/**
The script will read the img/p folder and check for each file if it exists in the database table ps_image.
In case it doesn't exists then it prints the file and deletes the file.

The script is prepared for the new img/p/1/2/3/ structure

TODO : cleanup.php

The query to check the ps_image table will always result in 1 row to ensure that no files will be deleted when there are database errors. So the script is secured for unexpected mysql errors (like overload of mysql server which you don't want to result in not finding the images and thus would remove the image files).


image id : correspond à ipg/p/i/j/k/l
e.g: 6127.jpg  == img/p/6/1/2/7/6127.jpg

* @link https://openclassrooms.com/courses/supprimer-des-fichiers-sur-le-serveur-grace-a-php
*/


// include config file
require_once(dirname(__FILE__).'/config/settings.inc.php');


// ensure PATH
echo "Le chemin absolu est : ".realpath('CleanupImageDir.php'); 
echo "<br/>";
echo "Le chemin relatif est : ".$_SERVER['PHP_SELF'];
echo "<br/><br/>";


$pdo = new PDO( 'mysql:host='._DB_SERVER_.';dbname='._DB_NAME_, _DB_USER_, _DB_PASSWD_ );
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$result=$pdo->query('select count(1) cnt from ps_image')->fetch();
echo 'count images database: '.$result['cnt'] . "<Br />";

// limit number of image files to check, set to 10 for testing
// set a max number of files that the script will read from the img/p folder
$limit=800000;



// reset some counters

//  to count founded files
$cnt_files=0; 
$cnt_checked=0;
$cnt_not_found=0;
$cnt_found=0;
$cnt_not_exist=0;
$cnt_del_file=0;

for($ii=1; ($ii<=9) && ($cnt_files != $limit); $ii++)
{
	// chemin relatif vers le dossier images - trought browser
	$path='img/p/'.$ii;
	deleteImage($path);

	for($jj=0; ($jj<=9) && ($cnt_files != $limit); $jj++)
	{	
		$path='img/p/'.$ii.'/'.$jj;
		deleteImage($path);
		for($kk=0; ($kk<=9) && ($cnt_files != $limit); $kk++)
		{
			$path='img/p/'.$ii.'/'.$jj.'/'.$kk;
			deleteImage($path);
			for($ll=0; ($ll<=9) && ($cnt_files != $limit); $ll++)
			{
				$path='img/p/'.$ii.'/'.$jj.'/'.$kk.'/'.$ll;
				deleteImage($path);
			}	
		}
 	}
 		
}
echo 'files in img/p : '.$cnt_files.'<br/> checked file: '.$cnt_checked.'<br/> not_found: '.$cnt_not_found.'<br/> found: '.$cnt_found;
echo "<br/>";
echo 'cnt_not_exist : '.$cnt_not_exist;
echo 'cnt_del_file : '.$cnt_del_file;


function deleteImage($imageDir)
{
	global $limit, $pdo, $cnt_files, $cnt_checked, $cnt_not_found, $cnt_found, $cnt_not_exist, $cnt_del_file;
	
	// Open a directory
	//@ is wriiten to avoid warning message and is handled in else condition
	if ($handle = @opendir($imageDir)) {
		
		$output = shell_exec('ls');
		echo "<pre>$output</pre>";

		// echo $imageDir."<BR />";
    	
    	// Si le fichier n'est pas un répertoire…
    	// read directory contents*
		/*
    	while ($cnt_files != $limit && false !== ($entry = readdir($handle))) { 
        		if ($entry != "." && $entry != "..") { // check if dir is not empty
                		$cnt_files++;
                		// break filename string : from 10006-fullsize.jpg to [10006][fullsize.jpg]
                		// pi[0] == imageID
                		$pi = explode('-',$entry); 
                		// if($pi[0]>0 && !empty($pi[1])) {
                		if($pi[0]>0) {
                        		$cnt_checked++;
                        		if(!checkExistsDb($pdo,$pi[0])) {
                                	$cnt_not_found++;
                                	// echo 'rm '.$imageDir.'/'.$entry."<BR />";
                                	// chown($imageDir.'/'.$entry,666);
                                	// $delResult = unlink($imageDir.'/'.$entry); // delete files
                                	// if($delResult) $cnt_del_file++
                        		} else {
                                		$cnt_found++;
                       			}
                		}
        		}
    	}
    	*/
    	// close
    	closedir($handle);
	}
	else
	{
		$cnt_not_exist++;
		// echo $imageDir." doesn't exist".'<BR />';
	}
}
 
function checkExistsDb($pdo, $id_image) {
        $result=$pdo->query($q='select \'ok\' ok, (select id_image from ps_image where id_image = '.(int)$id_image.') id_image');
        $row=$result->fetch();
        if($row['ok']!='ok') die( 'Problem with query, please correct');
        return $row['id_image']?true:false;
}