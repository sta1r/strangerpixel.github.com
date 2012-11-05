---
layout: post
title: 'Curzon: why flash?'
tags:
  - cinema
  - flash
  - usability

---

Following on from my post on <a href="http://www.strangerpixel.com/web/flat-hunting-with-flash/">Flat-hunting with Flash</a>, I've just noticed another odd usage of Flash on the <a href="http://www.curzoncinemas.com/flash/" target="_blank">Curzon Cinemas</a> website. In this case it isn't so much about Flash not being the right tool for the job; it merely highlights an unnecessary cosmetic application of Flash on a site that really doesn't need it.

<img src="http://www.strangerpixel.com/wordpress/wp-content/uploads/2007/11/curzon.jpg" class="blog" alt="Curzon Cinemas screenshot" />

On the site, try switching to the non-Flash version via the link in the bottom right-hand corner. The non-Flash home page looks pretty similar to the Flash version, except:
<ul>
	<li>the content is constrained to the viewport and the four columns of info become scrollable</li>
	<li>the image blocks at the bottom of the page are thus kept in view</li>
	<li>there's a cascade effect as the page loads and the text drops into view</li>
</ul>
My angle on this is:
<ul>
	<li>if the main reason for wanting to constrain the content to the viewport is keeping the image blocks in view - why not bring them further up the page?</li>
</ul>
Curzon has a perfectly functional HTML website with a nice URL structure that helps its performance on Google. Each HTML page can be viewed in Flash or non-Flash - but if you're in Flash mode and you navigate away from the original page, the URL doesn't change, which is potentially confusing for the unsavvy.

The point is that Curzon didn't need to deploy Flash. Improvements in the home page structure would remove the need for keeping all content in view at once, by prioritising more popular content (i.e. what's on now - not what's on in a fortnight). The cascade effects are initially cute but actually become tedious when you're really looking for information. There's no value added by what would have taken extra time and expense in development.

The very presence of a non-Flash option implies an awareness that some visitors might find it annoying, or inconvenient, and would prefer to view the site normally - which is not great web strategy.

For a good example of a beneficial implementation of Flash, check the superb Barbican home page.

<img class="blog" src="http://www.strangerpixel.com/wordpress/wp-content/uploads/2007/11/barbican.jpg" alt="Barbican home page screenshot" />

A favourite of mine, this page displays ever-changing content inside a set of 6 vibrantly colour-coded windows. In this case, Flash is used to add visual dynamism to a rigid HTML table grid; it's effective and attractive, but it's used sparingly.
