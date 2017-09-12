jQuery( document ).ready( function() {
	var url =document.URL;
	var  expr = "/en/";
	
	function SearchFormTraduction() {
		jQuery('.searchform input[type=search]').attr("placeholder", "Your search");
		
	}
	
	function linkNavigationTraduction() {
		jQuery('.accueil a').empty().append('Home');
		jQuery('.nav-previous a').empty().append('Previous article');
		jQuery('.nav-next a').empty().append('Next article');
	}

	function searchResultTraduction() {
		jQuery('.pas-resultat').empty().append('No results for your search:');
		jQuery('.result_found').empty().append('Your search:');
		
	}
	
	if(url.match(expr)){
		SearchFormTraduction();
		linkNavigationTraduction();
		searchResultTraduction();
	}

	//On Hover - Works on ios
	jQuery(".lp-box").click(function(){
    	jQuery(this).find(".lp-box-content").show();
 	});

	//click on slider show
 	jQuery(".seriousslider-inner .item a").click(function(e){
 		e.preventDefault();
        window.location.href = jQuery(this).attr('href');
 	});

 	var isIpad = window.matchMedia("(min-width: 768px) and (max-width: 991px)");
 	if(isIpad.matches){
 		jQuery('.logo_footer').removeClass('col-sm-2').addClass('col-sm-4').css("text-align", "center");
 		jQuery('.newsletter_footer').removeClass('col-sm-6').addClass('col-sm-4');
 	}
 	

}); 

