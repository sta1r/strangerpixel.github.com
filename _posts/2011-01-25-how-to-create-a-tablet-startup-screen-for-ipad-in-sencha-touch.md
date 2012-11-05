---
layout: post
title: 'How to create a tablet startup screen for iPad in Sencha Touch'
tags:
  - sencha-touch

---

When creating a web app using Sencha Touch, the icing on the cake is a nice sexy startup screen that displays as soon as your app loads after pressing the home screen button.

[javascript]
Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: true,
    onReady: function() {
		Showtime.MasterPanel = new Showtime.MasterPanel();
    }
});
[/javascript]

To show a tablet startup screen for the first few seconds after clicking the button on your home screen, you need to do 2 things:
<ol>
	<li>Create a portrait-orientation .png with dimensions 768px x 1004px. <a href="http://dev.sencha.com/deploy/touch/docs/source/Ext1.html#method-Ext-setup">It only works in portrait</a> - so far.</li>
	<li>Put it in your web root folder (putting it in any other folder doesn't seem to work).</li>
</ol>

You can use absolute URLs, but for some reason I had problems trying to use relative URLs like '../img/touch/tablet_startup.png'. You can also name the file whatever you like, and it still works.

