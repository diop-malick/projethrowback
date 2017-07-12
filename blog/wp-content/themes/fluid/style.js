jQuery( document ).ready( function() {
	var url =document.URL;
	var  expr = "/en/";
	function menuTraduction() {
		jQuery('.sf-menu li:nth-child(1) a').empty().append('News');
		jQuery('.sf-menu li:nth-child(2) a').empty().append('Sneakers');
		jQuery('.sf-menu li:nth-child(3) a').empty().append('Clothes');
		jQuery('.sf-menu li:nth-child(4) a').empty().append('Accessoires');
		jQuery('.sf-menu li:nth-child(5) a').empty().append('Ladies');
		jQuery('.sf-menu li:nth-child(6) a').empty().append('Sales');
		jQuery('.sf-menu li:nth-child(7) a').empty().append('Brands');
		jQuery('.sf-menu li:nth-child(8) a').empty().append('Blog');
	}
	function SearchFormTraduction() {
		jQuery('.searchform input[type=search]').attr("placeholder", "Your search");
		
	}
	function footerTraduction() {
		jQuery('.footer-block .list-inline li:nth-child(1) a').empty().append('Contact us');
		jQuery('.footer-block .list-inline li:nth-child(2) a').empty().append('Services');
		jQuery('.footer-block .list-inline li:nth-child(3) a').empty().append('Legal notice');
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
		/*menuTraduction();*/
		SearchFormTraduction();
		/*footerTraduction();*/
		linkNavigationTraduction();
		searchResultTraduction();
	}
	
}); 

