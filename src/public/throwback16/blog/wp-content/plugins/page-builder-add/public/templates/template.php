<?php if ( ! defined( 'ABSPATH' ) ) exit;
include 'counter.php';

$data = get_post_meta( $post->ID, 'ULPB_DATA', true ); 

$loadWpHead = $data['pageOptions']['loadWpHead'];
$loadWpFooter = $data['pageOptions']['loadWpFooter'];
$pageSeoDescription = $data['pageOptions']['pageSeoDescription'];
$pageSeoKeywords = $data['pageOptions']['pageSeoKeywords'];
$pageSeoName = $data['pageOptions']['pageSeoName'];
$pageBgImage = $data['pageOptions']['pageBgImage'];
$pageBgColor = $data['pageOptions']['pageBgColor'];
$pagePadding = $data['pageOptions']['pagePadding'];
$pagePaddingTop = $pagePadding['pagePaddingTop'];
$pagePaddingBottom = $pagePadding['pagePaddingBottom'];
$pagePaddingLeft = $pagePadding['pagePaddingLeft'];
$pagePaddingRight = $pagePadding['pagePaddingRight'];

$pagePaddingTop = floor( ($pagePaddingTop/1268)*100);
$pagePaddingBottom = floor( ($pagePaddingBottom/1268)*100);
$pagePaddingLeft = floor( ($pagePaddingLeft/1268)*100);
$pagePaddingRight = floor( ($pagePaddingRight/1268)*100);


?>
<head>
<?php //wp_head(); ?>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="<?php echo $pageSeoDescription; ?>">
  <meta name="keywords" content="<?php echo $pageSeoKeywords; ?>">
  <?php include 'style.css'; ?>

  <title><?php echo the_title(); ?></title>
  <?php
    if ($loadWpHead === 'true') { wp_head(); }
  ?>

<style type="text/css">
<?php if (!empty($pageBgImage)) { ?>
  body{
    background:url("<?php echo $pageBgImage; ?>")no-repeat center center; background-size:cover;
  }
<?php } ?>
<?php if (!empty($pageBgImage)) { ?>
  body{
    background:url("<?php echo $pageBgImage; ?>")no-repeat center center; background-size:cover;
  }
<?php } ?>
body{
  padding: <?php echo "$pagePaddingTop"."% $pagePaddingRight"."% $pagePaddingBottom"."% $pagePaddingLeft"."% !important"; ?>;
}
</style>
</head>
<body>
<?php
$rows = $data['Rows'];

foreach ($rows as $row) { 
  $columns = $row['columns'];
  $rowHeight = $row['rowHeight'];
  $rowData = $row['rowData'];
  $rowMargins = $rowData['margin'];
  $rowPadding = $rowData['padding'];
  $rowBgColor = $rowData['bg_color'];
  $rowBgImg = $rowData['bg_img'];
  $currentRowcustomCss = $rowData['customStyling'];

  $rowMarginTop = $rowMargins['rowMarginTop'];
  $rowMarginBottom = $rowMargins['rowMarginBottom'];
  $rowMarginLeft = $rowMargins['rowMarginLeft'];
  $rowMarginRight = $rowMargins['rowMarginRight'];

  $rowPaddingTop = $rowPadding['rowPaddingTop'];
  $rowPaddingBottom = $rowPadding['rowPaddingBottom'];
  $rowPaddingLeft = $rowPadding['rowPaddingLeft'];
  $rowPaddingRight = $rowPadding['rowPaddingRight'];

  $rowMarginTop = floor( ($rowMarginTop/1268)*100);
  $rowMarginBottom = floor( ($rowMarginBottom/1268)*100);
  $rowMarginLeft = floor( ($rowMarginLeft/1268)*100);
  $rowMarginRight = floor( ($rowMarginRight/1268)*100);

  $rowPaddingTop = floor( ($rowPaddingTop/1268)*100);
  $rowPaddingBottom = floor( ($rowPaddingBottom/1268)*100);
  $rowPaddingLeft = floor( ($rowPaddingLeft/1268)*100);
  $rowPaddingRight = floor( ($rowPaddingRight/1268)*100);


  $rowMarginStyle = "margin:$rowMarginTop"."% $rowMarginRight"."% $rowMarginBottom"."% $rowMarginLeft"."% !important;";

  $rowPaddingStyle = "padding:$rowPaddingTop"."% $rowPaddingRight"."% $rowPaddingBottom"."% $rowPaddingLeft"."% !important;";

  $currentRowStyles = "min-height:$rowHeight"."px; background:url('$rowBgImg')no-repeat center center; background-size:cover; background-color:$rowBgColor ; $rowPaddingStyle  $rowMarginStyle";
  //echo($row['rowID']."<br>");
  include_once 'column-width-resize.php';
  ?>
  <style type="text/css">
  <?php echo $currentRowcustomCss; ?>
  </style>
  <div class='row w3-row' data-row_id='<?php echo $row["rowID"]; ?>' id='<?php echo $row["rowID"]; ?>' style="<?php echo $currentRowStyles; ?>">
  <?php 
  for($i = 1; $i <= $columns; $i++) {
    $Columni = 'column'.$i;
    $currentColumn = $row[$Columni];
    //$columnContentEditor = do_shortcode($currentColumn['columnContent']);
    $columnOptions = $currentColumn['columnOptions'];
    $columnBgColor = $columnOptions['bg_color'];
    $columnMargin = $columnOptions['margin'];
    $columnPadding = $columnOptions['padding'];
    $columnWidth = $columnOptions['width'];

    $columnMarginTop = $columnMargin['columnMarginTop'];
    $columnMarginBottom = $columnMargin['columnMarginBottom'];
    $columnMarginLeft = $columnMargin['columnMarginLeft'];
    $columnMarginRight = $columnMargin['columnMarginRight'];

    $columnPaddingTop = $columnPadding['columnPaddingTop'];
    $columnPaddingBottom = $columnPadding['columnPaddingBottom'];
    $columnPaddingLeft = $columnPadding['columnPaddingLeft'];
    $columnPaddingRight = $columnPadding['columnPaddingRight'];

    $columnMarginTop = floor( ($columnMarginTop/1268)*100);
    $columnMarginBottom = floor( ($columnMarginBottom/1268)*100);
    $columnMarginLeft = floor( ($columnMarginLeft/1268)*100);
    $columnMarginRight = floor( ($columnMarginRight/1268)*100);

    $columnPaddingTop = floor( ($columnPaddingTop/1268)*100);
    $columnPaddingBottom = floor( ($columnPaddingBottom/1268)*100);
    $columnPaddingLeft = floor( ($columnPaddingLeft/1268)*100);
    $columnPaddingRight = floor( ($columnPaddingRight/1268)*100);


  $columnMarginStyle = "margin:$columnMarginTop"."% $columnMarginRight"."% $columnMarginBottom"."% $columnMarginLeft"."% !important;";

  $columnPaddingStyle = "padding:$columnPaddingTop"."% $columnPaddingRight"."% $columnPaddingBottom"."% $columnPaddingLeft"."% !important;";
    
    $columnContent = "";
    //Widgets
    $colWidgets = $currentColumn['colWidgets'];
    for ($j = 0; $j < count($colWidgets); $j++) {  // widgets loop
        $thisWidget = $colWidgets[$j];
        $this_column_type = $thisWidget['widgetType'];
        $widgetStyling = $thisWidget['widgetStyling'];

        $widgetMtop = $thisWidget['widgetMtop'];
        $widgetMleft = $thisWidget['widgetMleft'];
        $widgetMbottom = $thisWidget['widgetMbottom'];
        $widgetMright = $thisWidget['widgetMright'];
        $widgetBgColor = $thisWidget['widgetBgColor'];

        //WYSIWYG Widget
        $this_widget_editor = $thisWidget['widgetWYSIWYG'];
        $thisWidgetContentEditor =  $this_widget_editor['widgetContent'];


        // IMG Widget
        $this_widget_img_content = $thisWidget['widgetImg'];
        $imgUrl  = $this_widget_img_content['imgUrl'];
        $imgSize = $this_widget_img_content['imgSize'];
        $imgAlignment = $this_widget_img_content['imgAlignment'];

        // BTN Widget
        $this_widget_btn_content = $thisWidget['widgetButton'];
        $btnText = $this_widget_btn_content['btnText'];
        $btnLink = $this_widget_btn_content['btnLink'];
        $btnAllignment = $this_widget_btn_content['btnButtonAlignment'];
        $btnTextColor = $this_widget_btn_content['btnTextColor'];
        $btnFontSize = $this_widget_btn_content['btnFontSize'];
        $btnBgColor = $this_widget_btn_content['btnBgColor'];
        $btnWidth = $this_widget_btn_content['btnWidth'];
        $btnHeight = $this_widget_btn_content['btnHeight'];
        $btnHoverBgColor = $this_widget_btn_content['btnHoverBgColor'];
        //$btnBlankAttr = $this_widget_btn_content['btnBlankAttr'];
        $btnBorderColor = $this_widget_btn_content['btnBorderColor'];
        $btnBorderWidth = $this_widget_btn_content['btnBorderWidth'];
        $btnBorderRadius = $this_widget_btn_content['btnBorderRadius'];

        //$this_widget_btn = "<br><div class='wdt-$this_column_type' style='text-align:$btnAllignment;'><a href='$btnLink' style='text-decoration:none !important;' target='' > <button style='color:$btnTextColor !important;font-size:$btnFontSize !important; background: $btnBgColor !important; background-color: $btnBgColor !important; padding: $btnHeight"."px $btnWidth"."px !important; border: $btnBorderWidth"."px solid $btnBorderColor !important; border-radius: $btnBorderRadius"."px !important; text-align:center;'>$btnText</button></a></div><br>";

        //Menu Widget
        $menuSpecificStyles = " ";
        $menuSpecificClass = " ";
        if ($this_column_type == 'wigt-menu') {
          $this_widget_menu_content = $thisWidget['widgetMenu'];
          $menuName = $this_widget_menu_content['menuName'];
          $menuStyle = $this_widget_menu_content['menuStyle'];
          $menuColor = $this_widget_menu_content['menuColor'];

          if ($menuStyle == 'menu-style-1') {
            $menuSpecificStyles = "display: flex; justify-content: center; align-items: center;";
          } elseif ($menuStyle == 'menu-style-2') {
            $menuSpecificClass = "widget-$j-menuFixed";
          }

          include('menus/'.$menuStyle.'.php');
        }


        switch ($this_column_type) {
          case 'wigt-WYSIWYG':
            $widgetContent = do_shortcode($thisWidgetContentEditor);
            $contentAlignment = ' ';
            break;
          case 'wigt-img':
            $widgetContent = "<img src=".$imgUrl." style='text-align:".$imgAlignment.";' align=".$imgAlignment." class='ftr-img-".$Columni." img-".$imgSize."'>";
            $contentAlignment = $imgAlignment;
            break;
          case 'wigt-menu':
            $widgetContent = $this_widget_menu;
            $contentAlignment = ' ';
            break;
            case 'wigt-btn-gen':
            $widgetContent = "<button> Button </button>";
            $contentAlignment = ' ';
            break;
          default:
            $widgetContent = $thisWidgetContentEditor;
            $contentAlignment = ' ';
              break;
        } // column type switch ends here

        $widgetMtop = floor( ($widgetMtop/1268)*100);
        $widgetMright = floor( ($widgetMright/1268)*100);
        $widgetMbottom = floor( ($widgetMbottom/1268)*100);
        $widgetMleft = floor( ($widgetMleft/1268)*100);
       /// $columnContentOld = 
        $widgetMarigns = "margin:".$widgetMtop."% ".$widgetMright."% ".$widgetMbottom."% ".$widgetMleft."%; background: $widgetBgColor; background-color:$widgetBgColor; text-align:$imgAlignment;";
        $columnContent = $columnContent."\n <br> \n"."<div class='widget-$j $menuSpecificClass' style='$widgetMarigns $menuSpecificStyles  $widgetStyling' >".$widgetContent."</div>";
    
    } // widget loop ends here
    

      if ($columnWidth == 0 || $columnWidth === "") {
        switch ($columns) {
        case '1':
          $columnWidthPercent = '99';
          break;
        case '2':
          $columnWidthPercent = '49';
          break;
        case '3':
          $columnWidthPercent = '33.3';
          break;
        case '4':
          $columnWidthPercent = '24';
          break;
        case '5':
          $columnWidthPercent = '19';
          break;
        case '6':
          $columnWidthPercent = '16';
          break;
        case '7':
          $columnWidthPercent = '13.5';
          break;
        case '8':
          $columnWidthPercent = '11.5';
          break;
        case '9':
          $columnWidthPercent = '10.5';
          break;
        case '10':
          $columnWidthPercent = '5';
          break;  
        default:
          $columnWidthPercent = '99';
          break;
      }
        } else{
          if ($columns > 1) {
          $traces = 1/$columns;
          }else { $traces = 0; }
          $columnWidthPercent = floor( ($columnWidth/1268)*100) + $traces;
        }
        
        //$columnWidthPercent = ($columnWidth/1268)*100;
    $columnStyles = "width:".$columnWidthPercent."%; min-height:$rowHeight; background-color:$columnBgColor;text-align:; $columnMarginStyle  $columnPaddingStyle";
    ?> <div id='<?php echo $row["rowID"]."-$Columni"; ?>' class='column' style="<?php echo $columnStyles; ?> "> <?php echo $columnContent; ?> </div> <!-- Column ends!-->
    <?php
  } // For loop columns ends here ?>
  </div>
  <?php 
} // ForEach loop ends here
?>

<?php
    if ($loadWpFooter === 'true') { wp_footer(); }
  ?></body>