<?php if ( ! defined( 'ABSPATH' ) ) exit;
include 'counter.php';

$data = get_post_meta( $post->ID, 'ULPB_DATA', true );

if (!empty($data)) {
  include('header.php');
?>
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
    $currentRowcustomJS = $rowData['customJS'];

    $rowMarginTop = $rowMargins['rowMarginTop'];
    $rowMarginBottom = $rowMargins['rowMarginBottom'];
    $rowMarginLeft = $rowMargins['rowMarginLeft'];
    $rowMarginRight = $rowMargins['rowMarginRight'];

    $rowPaddingTop = $rowPadding['rowPaddingTop'];
    $rowPaddingBottom = $rowPadding['rowPaddingBottom'];
    $rowPaddingLeft = $rowPadding['rowPaddingLeft'];
    $rowPaddingRight = $rowPadding['rowPaddingRight'];

/*
    $rowMarginTop = floor( ($rowMarginTop/1268)*100);
    $rowMarginBottom = floor( ($rowMarginBottom/1268)*100);
    $rowMarginLeft = floor( ($rowMarginLeft/1268)*100);
    $rowMarginRight = floor( ($rowMarginRight/1268)*100);

    $rowPaddingTop = floor( ($rowPaddingTop/1268)*100);
    $rowPaddingBottom = floor( ($rowPaddingBottom/1268)*100);
    $rowPaddingLeft = floor( ($rowPaddingLeft/1268)*100);
    $rowPaddingRight = floor( ($rowPaddingRight/1268)*100);
*/

    $rowMarginStyle = "margin:$rowMarginTop"."% $rowMarginRight"."% $rowMarginBottom"."% $rowMarginLeft"."% !important;";

    $rowPaddingStyle = "padding:$rowPaddingTop"."% $rowPaddingRight"."% $rowPaddingBottom"."% $rowPaddingLeft"."% !important;";

  	$currentRowStyles = "min-height:$rowHeight"."px; background:url('$rowBgImg')no-repeat center center; background-size:cover; background-color:$rowBgColor ; $rowPaddingStyle  $rowMarginStyle";
  	//echo($row['rowID']."<br>");
  	include_once 'column-width-resize.php';

  	?>

    <style type="text/css">
    <?php echo '#'.$row["rowID"].' { '; ?>
    <?php echo $currentRowcustomCss.' } '; ?>
    </style>
    <script type="text/javascript">
      <?php echo $currentRowcustomJS; ?>
    </script>
  	<div class='row w3-row' data-row_id='<?php echo $row["rowID"]; ?>' id='<?php echo $row["rowID"]; ?>' style="<?php echo $currentRowStyles; ?>">

  	<?php include('columns.php'); ?>

  	</div>
  	<?php 
  } // ForEach loop ends here
  ?>

  <?php
      if ($loadWpFooter === 'true') { wp_footer(); }
    ?></body>
<?php
} else{
  echo "Please add some content in your page.";
}

?>