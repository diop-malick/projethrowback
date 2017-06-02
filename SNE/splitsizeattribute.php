<!-- 
FORMAT : 
EUR 40 / US 7 / UK 6 / 25CM *


TODO :
split en eur : 
add js for radio
gérer l'expo 1/2


Solution : trim -> explode -> trim
-->



<!DOCTYPE html>
<html>
<head>
  <title>Split attributes size test</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>

  <h1>Hello, Bootstrappers!</h1>


<div class="panel panel-default container">
      <?php
    $groupattributes = array (
      "33" => "EUR 40 / US 7 / UK 6 / 25CM", 
      "35" => "EUR 41 / US 8 / UK 7 / 26CM", 
      "37" => "EUR 42.5 / US 9 / UK 8 / 27CM"
      );

    print_r($groupattributes);
    echo "<br /><br />";
    ?>
</div>

  <div class="panel panel-default container">

    <div id="attributes">
    <div class="size-converter-wrapper row-fluid" id="size-converter-wrapper">

<a onclick="toggle_label('eu',5);" class="btn text-center white-bg red" id="size-converter-eu" href="#product_tabs_options">EU</a>
<a onclick="toggle_label('us',5);" class="btn text-center white-bg" id="size-converter-us" href="#product_tabs_options">US</a>
<a onclick="toggle_label('uk',5);" class="btn text-center white-bg" id="size-converter-uk" href="#product_tabs_options">UK</a>
<a onclick="toggle_label('cm',5);" class="btn text-center white-bg" id="size-converter-cm" href="#product_tabs_options">CM</a>
<a data-toggle="modal" class="size-chart-link text-link" href="#sizeTable"> Tableaux correspondance ?
</a>
</div>
      <fieldset class="row attribute_fieldset">

    <div class="attribute_list ">
      <ul>
        <?php
        foreach ($groupattributes as $id_attribute => $group_attribute){

          ?>

          <li>
            <label for='radio'>
              <input type="radio" id="<?php echo "radio_".$id_attribute; ?>" class="attribute_radio hidden" value="<?php echo $id_attribute; ?>" />
              <?php
                    // Remove slash délimiteurs              
              list($eu_size, $us_size, $uk_size, $cm_size) = split('[/]', $group_attribute);

              // Remove country identification
              list($eu_size_index, $eu_size_value) = preg_split('/\s+/', trim($eu_size));
              list($us_size_index, $us_size_value) = preg_split('/\s+/', trim($us_size));
              list($uk_size_index, $uk_size_value) = preg_split('/\s+/', trim($uk_size));
              list($cm_size_value) = preg_split('/\s+/', trim($cm_size));
              ?>
              <span class="hide_size eu_size" style="display: inline;"><?php echo $eu_size_value; ?></span>
              <span class="hide_size us_size" style="display: none;"><?php echo $us_size_value; ?></span>
              <span class="hide_size uk_size" style="display: none;"><?php echo $uk_size_value; ?></span>
              <span class="hide_size cm_size" style="display: none;"><?php echo $cm_size_value; ?></span>

            </label>
          </li>
          <?php 
          echo "<br />";
        } 
        ?>
      </ul>
    </div>
      </fieldset>
    </div>


  </div>

  <div class="panel panel-default container">

    <?php

    $chaine1 = "EUR 26.5 / US 9.5C / UK 9 / 15.5CM";
    $chaine2 ="EUR 45.5 / US 11.5 / UK 10.5 / 29.5CM";
    $chaine = "EUR 40 / US 7 / UK 6 / 25CM";

    echo "CHAINE D'origine ---> $chaine <br />\n";
    echo "<br />\n";

      // Remove slash délimiteurs

    list($eur_size, $us_size, $uk_size, $cm_size) = split('[/]', $chaine);
    
    var_dump($eur_size, $us_size, $uk_size, $cm_size );
    echo "<br />\n";


    list($eur_size_index, $eur_size_value) = preg_split('/\s+/', trim($eu_size));
    // scinde la phrase grâce aux virgules et espacements
// ce qui inclus les " ", \r, \t, \n et \f
    list($us_size_index, $us_size_value) = preg_split("/[\s,]+/", trim($us_size));
    echo "$eur_size_index = $eur_size_value<br />\n";
    echo "$us_size_index = $us_size_value<br />\n";
    echo "<br />\n";

    ?>
  </div>


  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.4/js/bootstrap.min.js"></script>



  <style type="text/css">
  #attributes .attribute_list ul li {
    float: left;
    clear: none;
}

    #attributes .attribute_list ul li > label:hover {
    border: 1px solid rgb(214, 157, 50);
    color: rgb(214, 157, 50) !important;
}
#attributes .attribute_list ul li > label {
    border: 1px solid #777;
    display: table-cell;
    width: 43px;
    height: 28px;
    text-align: center;
    vertical-align: middle;
    line-height: 12px;
    margin-right: 7px;
    border-radius: 2px;
    color: #000;
    font-size: 14px;
    font-weight: 700;
    transition: all 0.5s ease 0s;
    cursor: pointer;
    text-transform: uppercase;
}
  </style>

<style type="text/css">
  #size-converter-wrapper a {
    padding: 0;
    margin: 0 10px 0 0;
    text-decoration: underline !important;
}
#size-converter-wrapper .red {
    color: #000 !important;
}
#size-converter-wrapper {
    /*position: absolute;*/
    /*top: -30px;*/
    left: 0;
}
.row-fluid:before, .row-fluid:after {
    display: table;
    content: "";
}
.row-fluid {
    width: 100%;
}
</style>

  <script type="text/javascript">

$("#size-converter-eu").click(function(e){
    e.preventDefault();
    $(".hide_size").hide();
    $(".eu_size").show();
});
$("#size-converter-us").click(function(e){
    e.preventDefault();
    $(".hide_size").hide();
    $(".us_size").show();
});
$("#size-converter-uk").click(function(e){
    e.preventDefault();
    $(".hide_size").hide();
    $(".uk_size").show();
});
$("#size-converter-cm").click(function(e){
    e.preventDefault();
    $(".hide_size").hide();
    $(".cm_size").show();
});

  </script>

</body>
</html>