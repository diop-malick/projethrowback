<div class="container clearfix">

  <br>
  <div class="row ">
    {*********************************************************
    Onglets paiements
    **********************************************************}
    <div class="paiement_block col-sm-12 col-md-9 payment_content  clearfix">
      <div class="row panel-group" id="accordion"> 

                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse1">
                      {* <span class="resp-arrow"></span> *}
                        {l s='Payer et terminer votre commande'}
                      </a>
                    </h4>
                  </div>
                  <div id="collapse1" class="panel-collapse collapse in">
                    <div class="panel-body delivery_options">
                      {hook h='displayPayment' mod='hipay_professional'}
                    </div> <!-- end panel body -->
                  </div> <!-- end panel-collapse -->
                </div> <!-- end panel-default -->

                
                
      </div> 
      {* end row panel-group *}
    </div>
    {* end paiement_block *}

    {*********************************************************
    Facturerette
    **********************************************************}
    <div class="cart_navigation col-sm-12 col-md-3">
        {include file="$tpl_dir./facturette.tpl"}
    </div>

  </div> 
  {* end row  clearfix *}

</div> 
{* end container clearfix *}
<script>
  $( document ).ready(function() {
    $('a.popup-cgv').fancybox({
        'type' : 'iframe',
        'width':600,
        'height':600
      });
  });
</script>