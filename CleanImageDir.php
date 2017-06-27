<?php

// include config file
require_once(dirname(__FILE__).'/config/settings.inc.php');


$pdo = new PDO( 'mysql:host='._DB_SERVER_.';dbname='._DB_NAME_, _DB_USER_, _DB_PASSWD_ );
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$result=$pdo->query('select count(1) cnt from ps_image')->fetch();
echo 'count images database: '.$result['cnt'] . "<Br />";

$limit=100000;


//  count
$cnt_files=0; 
$cnt_checked=0;
$cnt_not_found=0;
$cnt_found=0;
$cnt_not_exist=0;
$cnt_del_file=0;

$cnt_old_format_del_file=0;

for($ii=1; ($ii<=9) && ($cnt_files != $limit); $ii++)
{
  // chemin relatif vers le dossier images - trought browser
  $beinpath ='img/p/';
  $path=$beinpath.$ii;
  deleteImage($path);

  for($jj=0; ($jj<=9) && ($cnt_files != $limit); $jj++)
  { 
    $path=$beinpath.$ii.'/'.$jj;
    deleteImage($path);
    for($kk=0; ($kk<=9) && ($cnt_files != $limit); $kk++)
    {
      $path=$beinpath.$ii.'/'.$jj.'/'.$kk;
      deleteImage($path);
      for($ll=0; ($ll<=9) && ($cnt_files != $limit); $ll++)
      {
        $path=$beinpath.$ii.'/'.$jj.'/'.$kk.'/'.$ll;
        deleteImage($path);
        for($xx=0; ($xx<=9) && ($cnt_files != $limit); $xx++)
        {
          $path=$beinpath.$ii.'/'.$jj.'/'.$kk.'/'.$ll.'/'.$xx;
          deleteImage($path);
        }
      } 
    }
  }   
}


echo 'files in img/p : '.$cnt_files.'<br/> checked file: '.$cnt_checked.'<br/> not_found: '.$cnt_not_found.'<br/> found: '.$cnt_found;
echo "<br/>";
echo 'cnt_not_exist : '.$cnt_not_exist.'<br/>';
echo 'cnt_del_file : '.$cnt_del_file.'<br/>';
// echo 'cnt_old_format_del_file : '.$cnt_old_format_del_file.'<br/>';



function deleteImage($imageDir)
{
  global $limit, $pdo, $cnt_files, $cnt_checked, $cnt_not_found, $cnt_found, $cnt_not_exist, $cnt_del_file, $cnt_old_format_del_file ;
  
  // Open a directory
  //@ is wriiten to avoid warning message and is handled in else condition
  if ($handle = @opendir($imageDir)) {
    while ($cnt_files != $limit && false !== ($entry = readdir($handle))) { 
      if ($entry != "." && $entry != "..") {
        $cnt_files++;
        $pi = explode('-',$entry);                    

        /* DeleteOldFileFormat($pi); */

        // check if entry is image file
        if (preg_match('/(\.jpg|\.png|\.bmp)$/i', $entry)) {
          // echo '<pre>'; print_r($entry); echo '</pre><br>';

          if($pi[0]>0) {
            $cnt_checked++;
            if(!checkExistsDb($pdo,$pi[0])) {
              $cnt_not_found++; 
              //$delResult = unlink($imageDir.'/'.$entry);
              //if($delResult ==1) $cnt_del_file++;
            } else {
              $cnt_found++;
            }
          }

        }

      }
    }     
      // close
    closedir($handle);
  }
  else
  {
    $cnt_not_exist++;
  }
}

function checkExistsDb($pdo, $id_image) {
  $result=$pdo->query($q='select \'ok\' ok, (select id_image from ps_image where id_image = '.(int)$id_image.') id_image');
  $row=$result->fetch();
  if($row['ok']!='ok') die( 'Problem with query, please correct');
  return $row['id_image']?true:false;
}


// Delete 1.4 formats
                    // IMPORTANT !!! RUN ONCE , not run it again
function DeleteOldFileFormat($pi) {

  if(count($pi)==2) {
                      //echo '<pre>'; print_r($pi); echo '</pre>';
                      $delOldResult = unlink($imageDir.'/'.$entry); // delete files
                      if($delOldResult ==1) $cnt_old_format_del_file++;
                    }

                  }