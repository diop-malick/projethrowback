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

	jQuery(".lp-box").click(function(){
    //On Hover - Works on ios
    	jQuery(this).find(".lp-box-content").show();
 	});

 	jQuery(".seriousslider-inner .item a").click(function(e){
 		e.preventDefault();
        window.location.href = "www.leral.net";
 	});

}); 

