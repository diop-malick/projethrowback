<?php if ( ! defined( 'ABSPATH' ) ) exit; 

$is_front_page = get_post_meta($post->ID, 'ULPB_FrontPage', true );
$loadWpHead = get_post_meta($post->ID, 'ULPB_loadWpHead', true );
$loadWpFooter = get_post_meta($post->ID, 'ULPB_loadWpFooter', true );


?>
  <style type="text/css">
    .hidden{
      opacity: 0;
    }
    #container{
      list-style: none;
    }
  </style>
  <!-- ========= -->
  <!-- Your HTML -->
  <!-- ========= -->
  <script
  src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"
  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
  crossorigin="anonymous"></script>
  <div class="tabs">
  <ul class="tab-links">
    <li class="active"><a href="#tab1" class="tab_link">Editor</a></li>
    <li><a href="#tab2" class="tab_link">Templates</a></li>
    <li><a href="#tab3" class="tab_link">Page Settings</a></li>
  </ul>
  <div class="tab-content">
    <div id="tab1" class="tab active">
      <section id="todoapp">
        <header id="header">
          <h1>Page Builder</h1>
          <div class="ulpb_button newRow  btn-green medium-btn" style="min-width:120px;">Add new row</div>
        </header>
      </section>
      <ul id="container">
        <script type="text/template" id="item-template"></script>
      </ul>
    </div>
    <div id="tab2" class="tab">
      <div id="column-1" class="col">
        <div id="card" class="temp-prev-1 card">
        <div id="temp-prev-1" class="tempPrev"> <p id="temp-prev-1"><b>Preview</b></p></div>
          <label for="temp-1"> <img src="<?php echo ULPB_PLUGIN_URL.'/images/templates/simple-error-page.png'; ?>" class='card-img temp-prev-1'>
          <p class="card-desc"></p> </label>
          <input type="radio" class="template_select" id='temp-1' name="template_select" value='temp1'>
          <label for="temp-1"><strike> Select</strike> <a href='http://pluginops.com/page-builder' target="_blank" class="ftr-link" >Go Premium</a></label>
        </div>
        <div id="card" class="temp-prev-5 card">
        <div id="temp-prev-5" class="tempPrev"> <p id="temp-prev-5"><b>Preview</b></p></div>
          <label for="temp-5"> <img src="<?php echo ULPB_PLUGIN_URL.'/images/templates/lp-template-5.png'; ?>" class='card-img temp-prev-5'>
          <p class="card-desc"></p> </label>
          <input type="radio" class="template_select" id='temp-5' name="template_select" value='temp5'>
          <label for="temp-5"><strike> Select</strike> <a href='http://pluginops.com/page-builder' target="_blank" class="ftr-link" >Go Premium</a></label>
        </div>
        <div id="card" class="temp-prev-2 card">
        <div id="temp-prev-2" class="tempPrev"> <p id="temp-prev-2"><b>Preview</b></p></div>
          <label for="temp-2"> <img src="<?php echo ULPB_PLUGIN_URL.'/images/templates/lp-template-1.png'; ?>" class='card-img temp-prev-2'>
          <p class="card-desc"></p> </label>
          <input type="radio" class="template_select" id='temp-2' name="template_select" value='temp2'>
          <label for="temp-2"><strike> Select</strike> <a href='http://pluginops.com/page-builder' target="_blank" class="ftr-link" >Go Premium</a></label>
        </div>
        <div id="card" class="temp-prev-3 card">
        <div id="temp-prev-3" class="tempPrev"> <p id="temp-prev-3"><b>Preview</b></p></div>
          <label for="temp-3"> <img src="<?php echo ULPB_PLUGIN_URL.'/images/templates/lp-template-3.png'; ?>" class='card-img temp-prev-3'>
          <p class="card-desc"></p> </label>
          <input type="radio" class="template_select" id='temp-3' name="template_select" value='temp3'>
          <label for="temp-3"><strike> Select</strike> <a href='http://pluginops.com/page-builder' target="_blank" class="ftr-link" >Go Premium</a></label>
        </div>
        <div id="card" class="temp-prev-4 card">
        <div id="temp-prev-4" class="tempPrev"> <p id="temp-prev-4"><b>Preview</b></p></div>
          <label for="temp-4"> <img src="<?php echo ULPB_PLUGIN_URL.'/images/templates/lp-template-4.png'; ?>" class='card-img temp-prev-4'>
          <p class="card-desc"></p> </label>
          <input type="radio" class="template_select" id='temp-4' name="template_select" value='temp4'>
          <label for="temp-4"><strike> Select</strike> <a href='http://pluginops.com/page-builder' target="_blank" class="ftr-link" >Go Premium</a></label>
        </div>
      </div>
    </div>
    <div id="tab3" class="tab">
    <div class="pbp_form" style="min-height: 400px;padding:20px;">
      <h1 class="seoHeader"> Body Styles </h1>
      <br>
      <label>Body Background Color :</label>
      <input type="text" name="pageBgColor" class="color_picker pageBgColor" id="pageBgColor" value='transparent'>
      <br>
      <br>
      <label>Body Background Image :</label>
      <input id="image_location1" type="url" class=" pageBgImage upload_image_button2"  name='lpp_add_img_1' value=' ' placeholder='Insert Image URL here' style="width:40%;" />
      <input id="image_location1" type="button" class="upload_bg" data-id="2" value="Upload"  style="margin-left: 25px;" />
      <br>
      <br>
      <br>
      <label>Padding Top :</label>
      <input type="number" name="pagePaddingTop" class="pagePaddingTop" id="pagePaddingTop" value='0'>
      <br>
      <br>
      <br>
      <label>Padding Bottom :</label>
      <input type="number" name="pagePaddingBottom" class="pagePaddingBottom" id="pagePaddingBottom" value='0'>
      <br>
      <br>
      <br>
      <label>Padding Left :</label>
      <input type="number" name="pagePaddingLeft" class="pagePaddingLeft" id="pagePaddingLeft" value='0'>
      <br>
      <br>
      <br>
      <label>Padding Right :</label>
      <input type="number" name="pagePaddingRight" class="pagePaddingRight" id="pagePaddingRight" value='0'>
      <br>
      <br>
      <br>
      <br>
      <br>
      <h1 class="seoHeader"> Page SEO </h1>
      <br>
      <br>
      <label>Page Keywords <span class="text_small">(Separated with Commas)</span> :</label>
      <input type="text" class="pageSeoKeywords" style="width:60%">
      <br>
      <br>
      <br>
      <label> Short Page Description :</label>
      <textarea class="pageSeoDescription" cols="60"></textarea>
      <br>
      <br>
    </div>
    </div>
  </div>
  <div id="SavePage" class="btn-green aligncenter large-btn">Save Page</div>
</div>
  
  <!-- ========= -->
  <!-- Libraries -->
  <!-- ========= -->
  <!-- =============== -->
  <!-- Javascript code -->
  <!-- =============== -->
<div class="lpp_modal pb_loader_container">
  <div class="pb_loader"></div>
</div>

<div class="lpp_modal pb_preview_container" style="">
  <div class="pb_temp_prev" style="text-align: center; overflow: visible; position: absolute;" ></div>
</div>

<div class="lpp_modal edit_column">
  <div class="lpp_modal_wrapper">
    <div class="edit_options_left">
      <h1 class="banner-h1">Column Options</h1>
      <label>Background Color :</label>
      <input type="text" name="columnBgColor" class="color_picker columnBgColor" id="columnBgColor" value='#ffffff'>
      <br>
      <br>
      <label>Column Width :</label>
      <input type="number" name="columnWidth" class="columnWidth" id="columnWidth" value='0'>
      <br>
      <br>
      <br>
      <div id="accordion">
      <h4>Margin</h4>
      <div style="height: 188px;">
      <br>
      <br>
      <label>Margin Top :</label>   
      <input type="number" name="columnMarginTop" class="columnMarginTop" id="columnMarginTop" value='0'>
      <br>
      <br>
      <label>Margin Bottom :</label>   
      <input type="number" name="columnMarginBottom" class="columnMarginBottom" id="columnMarginBottom" value='0'>
      <br>
      <br>
      <label>Margin Left :</label>   
      <input type="number" name="columnMarginLeft" class="columnMarginLeft" id="columnMarginLeft" value='0'>
      <br>
      <br>
      <label>Margin Right :</label>   
      <input type="number" name="columnMarginRight" class="columnMarginRight" id="columnMarginRight" value='0'>
      <br>
      <br>
      </div>
      <h4>Padding</h4>
      <div style="height: 188px;">
      <label>Padding Top :</label>
      <input type="number" name="columnPaddingTop" class="columnPaddingTop" id="columnPaddingTop" value='0'>
      <label>Padding Bottom :</label>
      <input type="number" name="columnPaddingBottom" class="columnPaddingBottom" id="columnPaddingBottom" value='0'>
      <label>Padding Left :</label>
      <input type="number" name="columnPaddingLeft" class="columnPaddingLeft" id="columnPaddingLeft" value='0'>
      <label>Padding Right :</label>
      <input type="number" name="columnPaddingRight" class="columnPaddingRight" id="columnPaddingRight" value='0'>
      </div>
      </div>
    </div>
    <div class="edit_form">
      <div class="btn add-widgets">Add Widget Area</div>
      <div class="wdt-dr"></div>
      <ul id="widgets">
        <script type="text/template" id="widget-template"></script>
      </ul>
    </div>
    <div class="edit_column_widgets">
      <h1 class="banner-h1">Widgets</h1>
      <div class="tabs">
        <ul class="tab-links">
          <li class="active"><a href="#tabFreeWidgets" class="tab_link">Widgets</a></li>
          <li><a href="#tabPremiumWidgets" class="tab_link">Extensions</a></li>
        </ul>
        <div class="tab-content" style="padding:10px 30px 30px 50px;">
          <div id="tabFreeWidgets" class="tab active">
            <div class="widget wdt-draggable" data-type="wigt-WYSIWYG">WYSIWYG Editor</div>
            <div class="widget wdt-draggable" data-type="wigt-img">Image</div>
            <div class="widget wdt-draggable" data-type="wigt-menu">Menu</div>
          </div>
          <div id="tabPremiumWidgets" class="tab">
            <div class="widget wdt-draggable" data-type="wigt-slider">Image Slider</div>
            <div class="widget wdt-draggable" data-type="wigt-smuzform">Form Builder</div>
            <div class="widget wdt-draggable" data-type="wigt-btn-gen">Button Generator</div>
            <div class="widget wdt-draggable" data-type="wigt-Sform">Subscribe Form</div>
            <div class="widget wdt-draggable" data-type="wigt-PostSlider">Posts Slider</div>
            <div class="widget wdt-draggable" data-type="wigt-TestimonialSlider">Testimonial Slider</div>
            <div class="widget wdt-draggable" data-type="wigt-SocialFeed">Social Feed</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="lpp_modal edit_row">
  <div class="lpp_modal_wrapper">
  <div class="edit_options_left">
      <h1 class="banner-h1">Row Options</h1>
       <label>Row Height :</label>
      <input type="text" name="row_height" id="row_height" placeholder="Set row height" class="edit_fields" value='200'>
      <br>
      <br>
      <label>Number of Columns :</label>
      <input type="number" name="number_of_columns" id="number_of_columns" placeholder="Number of columns in row" min="1" max="8"  class="edit_fields" value='1'>
      <br>
      <br>
      <label>Background Image :</label>
      <input id="image_location1" type="text" class=" rowBgImg upload_image_button2"  name='lpp_add_img_1' value='' placeholder='Insert Image URL here' />
      <input id="image_location1" type="button" class="upload_bg" data-id="2" value="Upload"  style="margin-left: 75px;" />
      <br>
      <br>
      <br>
      <br>
      <label>Background Color :</label>
      <input type="text" name="rowBgColor" class="color_picker rowBgColor" value='#fff'>
      <br>
      <br>
      <div id="accordion1">
      <h4>Margin</h4>
      <div style="height: 188px;">
      <label>Margin Top :</label>   
      <input type="number" name="rowMarginTop" class="rowMarginTop" id="rowMarginTop" value='0'>
      <br>
      <br>
      <label>Margin Bottom :</label>   
      <input type="number" name="rowMarginBottom" class="rowMarginBottom" id="rowMarginBottom" value='0'>
      <br>
      <br>
      <label>Margin Left :</label>   
      <input type="number" name="rowMarginLeft" class="rowMarginLeft" id="rowMarginLeft" value='0'>
      <br>
      <br>
      <label>Margin Right :</label>   
      <input type="number" name="rowMarginRight" class="rowMarginRight" id="rowMarginRight" value='0'>
      <br>
      <br>
      </div>
      <h4>Padding</h4>
      <div style="height: 188px;">
      <label>Padding Top :</label>
      <input type="number" name="rowPaddingTop" class="rowPaddingTop" id="rowPaddingTop" value='0'>
      <label>Padding Bottom :</label>
      <input type="number" name="rowPaddingBottom" class="rowPaddingBottom" id="rowPaddingBottom" value='0'>
      <label>Padding Left :</label>
      <input type="number" name="rowPaddingLeft" class="rowPaddingLeft" id="rowPaddingLeft" value='0'>
      <label>Padding Right :</label>
      <input type="number" name="rowPaddingRight" class="rowPaddingRight" id="rowPaddingRight" value='0'>
      </div>
      </div>
    </div>
    <div class="edit_options_right">
      <div class="tabs">
        <ul class="tab-links">
          <li class="active"><a href="#tabCustomCss" class="tab_link">Custom CSS</a></li>
          <li><a href="#tabCustomJS" class="tab_link">Custom JS</a></li>
        </ul>
        <div class="tab-content">
          <div id="tabCustomCss" class="tab active">
            <textarea class="rowCustomStyling" rows="20" cols="120"></textarea>
          </div>
          <div id="tabCustomJS" class="tab">
            <textarea class="rowCustomJS" rows="20" cols="120"></textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="lpp_modal_2 columnWidgetPopup">
<div class="lpp_modal_wrapper">
  <div class="edit_form" style="width: 95% !important;">
    <div class="wdt-left">
      <div class="btn closeWidgetPopup">Close</div>
      <br>
      <br>
      <div class="wdt-editor" style="display:none">
          <?php 
          $settings = array('media_buttons'=> true,'columnContent','tinymce' => true, 'editor_height' => 425);
          wp_editor(" ","columnContent",$settings); ?>
      </div>
      <div class="wdt-img" style="display:none">
        <label>Upload Image :</label>
        <input id="image_location1" type="text" class=" ftr-img upload_image_button2"  name='lpp_add_img_1' value='' placeholder='Insert Image URL here' />
        <input id="image_location1" type="button" class="upload_bg" data-id="2" value="Upload" />
        <br>
        <br>
        <br>
        <br>
        <label>Select Size :</label>
        <select name="ftr-img-size" id="ftr-img-size">
          <option value="original">Original</option>
          <option value="large">Large</option>
          <option value="medium">Medium</option>
          <option value="small">Small</option>
        </select>
        <br>
        <br>
        <label>Select Alignment :</label>
        <select name="ftr-img-alignment" id="ftr-img-alignment">
          <option value="default">Default</option>
          <option value="left">Left</option>
          <option value="right">Right</option>
          <option value="center">Center</option>
        </select>
      </div>
      <div class="wdt-menu" style="display:none">

        <label for="ftr-menu-style-1"> Style 1 <img src="<?php echo ULPB_PLUGIN_URL.'/images/menu/menu-style-1.png'; ?>" class='menu-select'> </label>
        <input type="radio" class="ftr-menu-style" id='ftr-menu-style-1' name="ftr-menu-select-style" value='menu-style-1'>
        <br>
        <br>
        <label for="ftr-menu-style-2"> Style 2 (Sticky) <img src="<?php echo ULPB_PLUGIN_URL.'/images/menu/menu-style-2.png'; ?>" class='menu-select'> </label>
        <input type="radio" class="ftr-menu-style" id='ftr-menu-style-2' name="ftr-menu-select-style" value='menu-style-2'>
        <br>
        <br>
        <label for="ftr-menu-style-3"> Style 3 (Without Logo) <img src="<?php echo ULPB_PLUGIN_URL.'/images/menu/menu-style-3.png'; ?>" class='menu-select'> </label>
        <input type="radio" class="ftr-menu-style" id='ftr-menu-style-3' name="ftr-menu-select-style" value='menu-style-3'>
        <br>
        <br>
        <label>Select Menu :</label>
        <select name="ftr-menu-select" id="ftr-menu-select">
        <option value="Select">Choose</option>
          <?php
          $menus = get_terms( 'nav_menu', array( 'hide_empty' => true ) ); 
            foreach($menus as $menu){
              echo "<option value='$menu->name'>$menu->name</option>";
            }
           ?>
        </select>
        <br>
        <br>
        <label>Menu Text Color :</label>
        <input type="text" class="btn_color_picker ftr-menu-color" id="ftr-menu-color" value='#333333'>
        <br>
      </div>
      <br>
      <br>
      <div class="wdt-smuzform" style="display:none">
        <?php

        if (is_plugin_active( 'contact-form-add/forms.php' )) {
          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'smuzform',
          'post_status'      => 'publish',
        );
        
        $wppb_smuzforms = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_smuz_form">Please select a form to display : </label>
        <select  id="select_smuz_form">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_smuzforms as $form) {
          $currentID = $form->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[sform  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>
        <?php } else{ echo "Please install the Form Builder Plugin : <a href='http://pluginops.com/form-builder/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-slider" style="display:none">
        <?php
        if (is_plugin_active('WPRocketLayerSlider/rocketlayerslider.php')) {

          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'wprls_slider',
          'post_status'      => 'publish',
        );
        
        $wppb_smuz_slider = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_smuz_slider">Please select a slider to display : </label>
        <select  id="select_smuz_slider">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_smuz_slider as $slider) {
          $currentID = $slider->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[sform  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>

        <?php } else{ echo "Extension not found - Please install the Slider Plugin : <a href='http://web-settler.com/layer-slider-plugin/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-sForm" style="display:none">
        <?php
        if (is_plugin_active('mailchimp-subscribe-sm-premium/subcribe-me.php')) {

          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'subscribe_me_forms',
          'post_status'      => 'publish',
        );
        
        $wppb_subscribe_form = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_subscribe_form">Please select a slider to display : </label>
        <select  id="select_subscribe_form">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_subscribe_form as $sForm) {
          $currentID = $sForm->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[ssm_form  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>

        <?php } else{ echo "Extension not found - Please install the Subscribe Form Plugin : <a href='http://web-settler.com/mailchimp-subscribe-form/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-postsSlider" style="display:none">
        <?php
        if (is_plugin_active('Posts-Slider-premium/Posts-Slider.php')) {

          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'mpsp_slider',
          'post_status'      => 'publish',
        );
        
        $wppb_posts_slider = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_posts_slider">Please select a slider to display : </label>
        <select  id="select_posts_slider">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_posts_slider as $postsSlider) {
          $currentID = $postsSlider->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[mpsp_posts_slider  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>

        <?php } else{ echo "Extension not found - Please install the Posts Slider Plugin : <a href='http://web-settler.com/posts-slider/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-testimonialSlider" style="display:none">
        <?php
        if (is_plugin_active('testimonial-add-premium/Testimonial-Slider.php')) {

          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'tss_slider',
          'post_status'      => 'publish',
        );
        
        $wppb_testimonials_slider = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_testimonials_slider">Please select a Testimonial Slider to display : </label>
        <select  id="select_testimonials_slider">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_testimonials_slider as $testimonialsSlider) {
          $currentID = $testimonialsSlider->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[tss_slider  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>

        <?php } else{ echo "Extension not found - Please install the Testimonial Slider Plugin : <a href='http://web-settler.com/testimonials-plugin/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-socialFeed" style="display:none">
        <?php
        if (is_plugin_active('social-feed-premium/plugin.php')) {

          $args = array(
          'posts_per_page'   => 99,
          'offset'           => 0,
          'orderby'          => 'date',
          'order'            => 'ASC',
          'post_type'        => 'wssf_social_feed',
          'post_status'      => 'publish',
        );
        
        $wppb_social_feed = get_posts( $args );
        ?>
        <br>
        <br>
        <label for="select_socialFeed">Please select a Social feed to display : </label>
        <select  id="select_socialFeed">
        <option value="Select">Select</option>
        <?php
        foreach ($wppb_social_feed as $socialfeed) {
          $currentID = $socialfeed->ID;
          $title = get_the_title($currentID);
        ?>
        <option value="[socialfeed  id='<?php echo $currentID ?>']" > <?php echo $title ?> </option>
        <?php
        } ?>
        </select>

        <?php } else{ echo "Extension not found - Please install the Social Feed Plugin : <a href='http://web-settler.com/wordpress-facebook-feed/' target='_blank' class='wdt-premium'>Install Now</a> "; }   ?>
      </div>
      <div class="wdt-btn-gen" style="display:none; ">
      Premium Extension : <a href='http://pluginops.com/form-builder-plugin/' target='_blank'>Go Premium</a>
      <h1 id="btn-gen" class="widgetHeader">Button Generator</h1>
        <div id="btn-gen" class="pbp_form">
          <label>Button Text :</label>
          <input type="text" class="btnText" style="width: 250px;" placeholder="Button Text">
          <br>
          <br>
          <label>Button Link :</label>
          <input type="URL" class="btnLink" placeholder="Link URL">
          <br>
          <br>
          <label>Set Height: </label>
          <input type="number" class="btnHeight">
          <br>
          <br>
          <label>Set width: </label>
          <input type="number" class="btnWidth">
          <br>
          <br>
          <label>Button Background Color :</label>
          <input type="text" class="btn_color_picker btnBgColor" id="btnBgColor" value='#333333'>
          <br>
          <label>Button Hover Color :</label>
          <input type="text" class="btn_color_picker btnHoverBgColor" id="btnHoverBgColor" value='#333333'>
          <br>
          <label>Button Text Color :</label>
          <input type="text" class="btn_color_picker btnColor" id="btnColor">
          <br>
          <label>Button Font size : </label>
          <input type="number" class="btnFontSize">
          <br>
          <br>
          <label>Border Width: </label>
          <input type="number" class="btnBorderWidth">
          <br>
          <br>
          <label>Border Color: </label>
          <input type="text" class="btn_color_picker btnBorderColor" id="btnBorderColor" value='#ffffff'>
          <br>
          <label>Border Radius: </label>
          <input type="number" class="btnBorderRadius" max="100" min="0">
          <br>
          <br>
          <label>Button Alignment :</label>
          <select class="btnButtonAlignment" id="btnButtonAlignment">
            <option value="default">Default</option>
            <option value="left">Left</option>
            <option value="right">Right</option>
            <option value="center">Center</option>
          </select>
        </div>
        <div class="btn-preview">
            <button id="btn-prev"></button>
        </div>
      </div>
    </div>
    <div class="wdt-right">
      <div class="wdt-fields pbp_form" style="margin:40px 0 0 75px; width: 550px;">
        <label>Background Color :</label>
        <input type="text" name="widgetBgColor" class="color_picker widgetBgColor" value='transparent' style="margin-left: -150px;">
        <br>
        <br>
        <label>Set Margin Top: </label>
        <input type="number" class="widgetMtop">
        <br>
        <br>
        <label>Set Margin Bottom: </label>
        <input type="number" class="widgetMbottom">
        <br>
        <br>
        <label>Set Margin Left: </label>
        <input type="number" class="widgetMleft">
        <br>
        <br>
        <label>Set Margin Right: </label>
        <input type="number" class="widgetMright">
        <br>
        <br>
        <label>Custom Styling (CSS) :</label>
        <textarea  style="min-width: 250px; min-height: 250px;" class="widgetStyling"></textarea>
      </div>
    </div>
    </div>
</div>
</div>

<div class="lpp_modal new_row_div">
  <div class="lpp_modal_wrapper">
  <div class="edit_options_left">
      <h1 class="banner-h1">Row Options</h1>
      <label>Row Height :</label>
      <input type="text" name="row_height" id="new_row_height" placeholder="Set row height" class="edit_fields" value='200'>
      <br>
      <br>
      <label>Number of Columns :</label>
      <input type="number" name="number_of_columns" id="new_row_number_of_columns" placeholder="Number of columns in row" min="1" max="8"  class="edit_fields" value='1'>
      <br>
      <br>F
      <label>Background Image :</label>
      <input id="image_location1" type="text" class=" new_rowBgImg upload_image_button2"  name='lpp_add_img_1' value='' placeholder='Insert Image URL here' />
      <input id="image_location1" type="button" class="upload_bg" data-id="2" value="Upload"  style="margin-left: 75px;" />
      <br>
      <br>
      <br>
      <br>
      <label>Background Color :</label>
      <input type="text" name="rowBgColor" class="color_picker new_rowBgColor" value='#ffffff'>
      <br>
      <br>
      <label>Row Margin :</label>
      <input type="number" name="rowMargin" class="new_rowMargin" value='0'>
      <br>
      <br>
      <label>Row Padding :</label>
      <input type="number" name="rowPadding" class="new_rowPadding" value='0'>
    </div>
  </div>
</div>
<div style="display: none;">
  <div id="sideOptions">
  <br>
  <h2 style="text-align: center;">Advanced Options</h2>
    <div id='extra_options' style="margin-left: 15px;">
    <br>
    <p id='label'>Set as Front Page : </p>
    <label class="switch" id="setFrontPage">
      <input type="checkbox" class="setFrontPage" name='is_front_page' value='true' <?php checked( 'true', $is_front_page); ?> >
      <div class="slider round"></div>
    </label>
    <br>
    <br>
    <br>
    <p></p>
    <p id='label'>Load wp_head :  </p>
    <label class="switch" id="loadWpHead">
      <input type="checkbox" class="loadWpHead" name='load_wphead' value='true' <?php checked( 'true', $loadWpHead); ?> >
      <div class="slider round"></div>
    </label>
    <br>
    <br>
    <p style="font-size:12px; font-style:italic;">This will load your theme header scripts.</p>
    <br>
    <p id='label'> Load wp_footer :  </p>
    <label class="switch" id="loadWpFooter">
      <input type="checkbox" class="loadWpFooter" name='load_wpfooter' value='true'  <?php checked( 'true', $loadWpFooter); ?>>
      <div class="slider round"></div>
    </label>
    <br>
    <br>
    <p style="font-size:12px; font-style:italic;">This will load your theme footer scripts.</p>
    </div>
  </div>
</div>

<div style="display: none;">
<div id="ftr-list">
<br>
<h2 style="font-size:16px; text-align: center;" >Features you will get with premium version.</h2>
  <ul style="font-size:16px; list-style: square; text-align: left; margin-left:40px;">
    <li>Responsive Templates</li>
    <li>Pre Designed Navigation Menu</li>
    <li>Button Generator Extension</li>
    <li>More features in updates.</li>
  </ul>
  <br>
  <a href="http://pluginops.com/page-builder" target="_blank" style="text-align: center;"><div class="btn" style="float: inherit; width: 65%; margin-left: 15px; padding:15px 30px; font-size: 19px; background:#2196F3; text-align: center;">Get Started</div></a>
  <br>
</div>

</div>





<?php $plugData = get_plugin_data(ULPB_PLUGIN_PATH.'/page-builder-add.php',false,true); ?>
<script type="text/javascript">
  var app = {};
  var URLL = "<?php echo admin_url('admin-ajax.php?action=ulpb_admin_data&page_id='.get_the_id()); ?>";
  var PageBuilderAdminImageFolderPath = '<?php echo ULPB_PLUGIN_URL."/images/menu/"; ?>';
  var P_ID = "<?php echo get_the_id(); ?>";
  var P_menu  = "<?php foreach($menus as $menu){  echo "$menu->name"; } ?>";
  var PageBuilder_Version = "<?php echo $plugData['Version']; ?>";
  var admURL = "<?php echo admin_url(); ?>";
  var isPub = "<?php echo get_post_status( get_the_id() ); ?>";
</script>
<script type="text/javascript">
    jQuery(document).ready(function() {
    jQuery('.tabs .tab-links a').on('click', function(e)  {
        var currentAttrValue = jQuery(this).attr('href');
 
        // Show/Hide Tabs
        jQuery('.tabs ' + currentAttrValue).show().siblings().hide();
 
        // Change/remove current tab to active
        jQuery(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });

    jQuery( function() {
    jQuery( "#accordion" ).accordion({
      collapsible: true,
      heightStyle: "content"
    });
  } );
    jQuery( function() {
    jQuery( "#accordion1" ).accordion({
      collapsible: true,
      heightStyle: "content"
    });
  } );

});
</script>