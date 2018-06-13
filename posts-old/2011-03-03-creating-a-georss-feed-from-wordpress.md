---
layout: post
title: 'Creating a geoRSS feed from Wordpress'
tags:
  - georss
  - maps
  - php
  - templates
  - wordpress

---

A back-to-basics tutorial for generating a geoRSS feed from Wordpress, correctly formatted for use in Google Maps KML layers.

There are a profusion of (often very full-featured and cool) Wordpress plugins out there providing <a href="http://wordpress.org/extend/plugins/search.php?q=geolocation&amp;sort=">geolocation</a> or <a href="http://wordpress.org/extend/plugins/search.php?q=geotagging&amp;sort=">geotagging</a> functionality. However, none of them really fit my purposes for any or all of the following reasons:
<ul>
	<li>they use geolocation data from the blogger who is writing the post, as opposed to manually-entered coordinates.</li>
	<li>they are focussed on providing mapping within Wordpress, as opposed to generating a feed for use externally.</li>
	<li>they added unnecessary calls to Google or Yahoo scripts in <code>wp_head().</code></li>
	<li>they used out-of-date versions of the Google Maps API.</li>
</ul>
<a href="http://gpress.my/">gPress</a> is currently the most promising-looking complete package for mapping in Wordpress, and it apparently offers geoRSS functionality, although I haven't checked it out yet. However, I simply wanted to provide a geoRSS feed without any additional baggage, besides wanting to build the nuts and bolts myself.

<strong>Generating a new feed</strong>

In <code>functions.php</code>, add the following:

[php]
add_action('init', 'my_maps_init');

function my_maps_init() {
    add_feed('georss','my_georss_feed');
}

function my_georss_feed() {
    load_template( TEMPLATEPATH . '/feed-georss.php' );
}
[/php]

Now you can create your new <code>feed-georss.php</code> template. I based my code on the output from <a href="http://api.flickr.com/services/feeds/geo/?g=322338@N20&amp;lang=en-us&amp;format=feed-georss">Flickr's geoRSS feed</a>, as used in <a href="http://code.google.com/apis/maps/documentation/javascript/examples/layer-georss.html">this example</a>. It contains latitude and longitude coordinates from two new custom fields set up in the post itself. Note the special RSS template tags e.g. <code>the_title_rss()</code> that strip out tags and convert characters to present the raw data via RSS.

<script src="https://gist.github.com/852944.js?file=feed-georss.php"></script>

Assuming you have some posts ready with geo-coordinates in custom fields, you can test the feed output at:

[html gutter="false"]http://www.yourblog.com/?feed=georss[/html]

If you are only adding coordinates to posts in certain categories you can also use e.g.:

[html gutter="false"]http://www.yourblog.com/category/maps/?feed=georss[/html]

<strong>Google Maps</strong>

Assuming your feed is working correctly, you can now get your geotagged posts to show up on a Google map using a KML Layer. You'll need to <a href="http://code.google.com/apis/maps/documentation/javascript/overlays.html#KMLLayers">read up on the documentation</a> first, but for reference here's the relevant snippet of my code:

[javascript]
var kmlLayerOptions = {
	map: map,
	preserveViewport: true,
	suppressInfoWindows: true
}

var georssLayer = new google.maps.KmlLayer('http://blogs.fashion.arts.ac.uk/snapshot/category/international/?feed=georss', kmlLayerOptions);

google.maps.event.addListener(georssLayer, 'click', function(kmlEvent) {
	showKmlWindow(kmlEvent, georssLayer);
});

function showKmlWindow(e, layer) {
	infoWindow.close();
	infoWindow.setPosition(e.latLng);
	infoWindow.open(map);
	infoWindow.setContent('&lt;h3&gt;' + e.featureData.name + '&lt;/h3&gt;' + e.featureData.description);
}
[/javascript]

Note that, in order to manipulate the infoWindow content when each marker is clicked, you have to suppress the infoWindows that open automatically. You then catch the <code>kmlEvent</code> generated on click, and then do what you will with the <code>KmlFeatureData</code> object.
<ul>
	<li><a href="http://www.fashion.arts.ac.uk/lcf-in-the-world.php">View London College of Fashion activity map</a></li>
</ul>
