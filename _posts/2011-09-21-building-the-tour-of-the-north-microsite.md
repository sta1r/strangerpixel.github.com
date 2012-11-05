---
layout: post
title: 'Building the Tour of the North microsite'
tags:
  - cycling
  - flickr-api
  - google-maps-api
  - json
  - twitter

---

In April this year I went on a mountain-bike trip with a few mates. It was an epic, tough ride that involved digging very deep into limited early-season fitness reserves. On returning to London I decided that the journey should be appropriately documented and data-mined - for my grandchildren, at the very least.

[caption id="attachment_764" align="alignnone" width="550" caption="The Tour of the North website."]<img class="size-medium wp-image-764" title="totn-grab" src="http://www.strangerpixel.com/blog/wp-content/uploads/2011/09/totn-grab-550x376.jpg" alt="" width="550" height="376" />[/caption]

<strong>Prep</strong>

The planned route was a 5-day zig-zag from Lancaster to Scarborough, taking in the finest riding available.

Before heading north I encouraged all but the least tech member of our 4-man team to get on Twitter and get their heads around hashtags and geo-located tweets. Three of us, thankfully, had iPhones, which made this pretty easy.

<strong>Navigation</strong>

Tom was in charge of navigation: in addition to route maps, he brought with him the <a href="http://gps.motionx.com/iphone/overview/">GPS Motion-X app</a> for iPhone, which records detailed route data including distance, time, speed, and 3-dimensional coordinates (with elevation).

After each day's leg was completed, Tom emailed the KML route data to all of us to ensure everything was backed up.

<strong>Website</strong>

The Tour of the North microsite has two components:
<ul>
	<li>a page built out from my existing blog at <a href="http://www.legsfeelingnopressure.com/the-tour-of-the-north/">http://www.legsfeelingnopressure.com/the-tour-of-the-north/</a></li>
	<li>a dedicated map page with geolocated photos and tweets at <a href="http://www.legsfeelingnopressure.com/totn-map/index.html">http://www.legsfeelingnopressure.com/totn-map</a></li>
</ul>
The blog page features some neat CSS3 transitions, scrolling elevation charts and a lightbox to display the Flickr images. The trickiest element by far was processing the KML data to display accurately on the maps, and then using the Flickr and Twitter APIs to add photos and tweets to the dedicated map page.

[caption id="attachment_771" align="alignnone" width="550" caption="Mapping the ride: a Google Map with plotted KML routes, Flickr photos and tweets."]<img class="size-medium wp-image-771" title="totn-map-grab" src="http://www.strangerpixel.com/blog/wp-content/uploads/2011/09/totn-map-grab-550x398.jpg" alt="" width="550" height="398" />[/caption]

<strong>Mapping</strong>

Creating the maps involved various stages:
<ul>
	<li>Cleaning up the Motion-X KML data - Motion-X adds quite a lot of extraneous cruft to its exported KML route files, including Motion-X logos and route data that is loaded into Google Maps info windows by default.</li>
	<li>Repairing KML files where necessary - we suffered a technical malfunction on day 2, which resulted in a gap in the coordinates (it loos like we teleported). I had to populate the KML with dummy coordinates.</li>
	<li>Hosting KML files on Amazon S3 - so they load super-fast.</li>
	<li>Programming the Google Maps API to <a href="http://code.google.com/apis/maps/documentation/javascript/overlays.html#KMLLayers">plot the KML overlays</a> onto the maps.</li>
</ul>
<strong>Twitter &amp; Flickr APIs</strong>

I downloaded each tweeter's JSON for the 5 days of riding and combined them into a single .json file to reduce file size and speed up the rendering of the markers onto the map.

[php wraplines="1" gutter="0"]
// get a combined stream of tweets, downloaded from Twitter immediately after the trip
	$.getJSON('js/combined.json', function(data) {
		for (index in data) addTweetMarker(data[index]);
	});
[/php]

Because the main map needs to access more than 20 tagged photos from Flickr, I had to use the Flickr API with a key (check the source code). Also, of course, any photos uploaded to Flickr from a standard camera without geodata had to be manually added to Flickr's (not very detailed) maps - harder than it sounds when you're talking about a hillside in the Dales.

<strong>Elevation charts</strong>

I stumbled across a really awesome online tool called <a href="http://www.gpsvisualizer.com/">GPS Visualiser</a> which converts .gps and .kml files into all kinds of things, including profile graphics.

<strong>Future developments</strong>
<ul>
	<li>Swap out the Daytum iframes for some javascript graphs using <a href="http://code.google.com/p/flot/">Flot</a> or <a href="http://omnipotent.net/jquery.sparkline/">Sparklines</a>.</li>
	<li>Fix the map so that the Flickr info windows display the photo author and link to the original on Flickr.</li>
	<li>Go on another, similar trip and set all this up <em>in advance</em> with live tweets and route-plotting.</li>
</ul>
