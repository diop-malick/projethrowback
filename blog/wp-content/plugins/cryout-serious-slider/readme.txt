=== Plugin Name ===
Contributors: Cryout Creations
Donate link: https://www.cryoutcreations.eu/donate/
Tags: slider, carousel, shortcode, bootstrap, responsive, responsive slider
Requires at least: 4.0
Tested up to: 4.8.0
Stable tag: 0.6.5
Text Domain: cryout-serious-slider
License: GPLv3
License URI: http://www.gnu.org/licenses/gpl.html

Responsive slider, built on Bootstrap Carousel, uses core WordPress functionality, easy to use. Seriously!

== Description ==

= Features: = 

* Unlimited sliders with unlimited slides 
* Seriously configurable 
* Fully responsive 
* Touch Swipe Navigation 
* Customization options for each individual slider 
* Slide attributes: image, caption title, caption text (with HTML support), target link
* Easy to use - uses WordPress custom post types
* Translation ready and compatible with translation plugins 
* Accessibility ready
* Lightweight (uses CSS and iconfont only)
* CSS transitions – fast and powerful hardware accelerated CSS3 3D transforms 
* HTML5 valid
* Sample content 

== Installation ==

= Automatic installation =

1. Navigate to Plugins in your dashboard and click the Add New button.
2. Type in "Cryout Serious Slider" in the search box on the right and press Enter, then click the Install button next to the plugin title. 
3. After installation Activate the plugin, look for Serious Slider in the dashboard menu to set up a slider.

= Manual installation =

1. Upload `cryout-serious-slider` folder to the `/wp-content/plugins/` directory
2. Activate the plugin through the 'Plugins' menu in WordPress
3. Navigate to Serious Slider in the dashboard menu to set up a slider. 

== Changelog ==

= 0.6.5 =
* Added 'shortcode' column in sliders list
* Fixed animation hiccup on some versions of Safari
* Fixed slider bullets alignment
* Fixed unclosed label in widget HTML markup
* Changed class initialization hook to 'setup_theme'

= 0.6.4 = 
* Added check to hide caption titles and text when they are not defined
* Fixed widget slider no longer displaying slider output buffering shortcode in 0.6.1
* Improved styling to remove prev/next buttons border on some themes

= 0.6.3 =
* Fixed leftover debug output in 0.6.2

= 0.6.2 =
* Fixed slides links always opening in a new window

= 0.6.1 =
* Fixed extraneous slide/term fields being visible after double quick edit
* Fixed version information not updated in about page
* Fixed slide image not vertically center-aligned when image is narrower than screen
* Improved slider captions responsiveness
* Fixed slider being displayed at top of content due to improper outputting (also separated inline script and moved to footer enqueue)
* Removed some log messages that would appear in the browser's console
* Fixed overslide, underslide and parallax transitions functionality on 3D-enabled browsers

= 0.6 =
* Enabled quick-edit functionality on the sliders
* Fixed slider query overlapping WordPress query in specific usage scenarios (thanks to webdragon)
* Limited dashboard resource loading only to plugin's sections
* Fixed multiple instances of the same slider missing styling after moving inline styling to footer in 0.5.1
* Added extra taxonomy hook for support in Cryout themes
* Fixed animation glitch on Fluida theme

= 0.5.1 = 
* Moved inline styling to footer
* Fixed responsive styling issue on about page
* Added widget HTML wrapper for better compatibility with themes
* Added get_sliders_list() function for custom theme integration
* Improved 'No slides' message to link to slider management / sample slider loader.
* Corrected slider selection label in slider metabox
* Corrected insert slider window to display 'no slider available' message when there are no sliders
* Fixed missing closing bracked in template code example
* Fixed slider image tag to only be outputted when an image was defined
* Improved contrained slider layout
* Fixed missing insert slider icon in TinyMCE editor

= 0.5 =
* Initial release.
