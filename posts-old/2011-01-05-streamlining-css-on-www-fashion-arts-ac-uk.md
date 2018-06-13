---
layout: post
title: 'Streamlining CSS on www.fashion.arts.ac.uk'
tags:
  - lcf

---

I recently began a mini-project to streamline and upgrade the London College of Fashion CSS stylesheets. The overall aim was good housekeeping - and the wish to put new skills to use in polishing up the site's front end. This post is a work in progress, I'll be updating it as I go.

<strong>Why upgrade the CSS?</strong>

Some background: the <a href="http://www.fashion.arts.ac.uk/">LCF website</a> was redesigned in 2007 as part of the <a href="http://www.arts.ac.uk">University of the Arts London</a> family of websites. The original designers implemented some generic styles used by all College sites, as well as styles particular to each College (including colour-coding). Since 2007 the stylesheets have been copied, tweaked, added to and duplicated without any version control or system of documenting changes (beyond occasional comments in the files themselves).

The system that I've inherited has quite a few flaws:
<ul>
	<li>Too many CSS files - I counted nine - meaning unnecessary HTTP requests</li>
	<li>Bloated files with unnecessary rules - about 3,000 lines of code in total, including a blog stylesheet</li>
	<li>Verbose, inefficient CSS selectors (I've learned some new tricks to do with <a href="http://css-tricks.com/efficiently-rendering-css/">efficiently rendering CSS</a> recently)</li>
	<li>No style rules for basic semantic elements like <code>&lt;blockquote&gt;</code> and <code>&lt;small&gt;</code></li>
</ul>
Speed and inefficiency weren't the only reasons for improving our CSS; the site - with the exception of our Wordpress blog - has a static front end anyway, so it's already pretty fast. Making these changes were also motivated by wanting to put new skills into practice, taking ownership of the CSS, and generally setting the LCF house in order in time for the new CMS implementation.

As anyone skilled in CSS knows, writing good CSS is all about refinement and cleanness. It's about writing one line instead of two. If you care about CSS, you shouldn't be able live with shoddy, inaccurate code.

<strong>Step 1: HTML5 Reset</strong>

It made sense to start with the basics, and to implement a future-proof reset stylesheet that not only addressed gaps in the current CSS but also catered for all the new HTML elements we're sure to be using sooner or later.

Lots of work has been done <a href="http://html5reset.org/">in this area</a> but <a href="http://html5doctor.com/author/richc/">Rich Clark</a>'s <a href="http://html5doctor.com/html-5-reset-stylesheet/">HTML5 Doctor reset stylesheet</a> appeared to be the industry standard.

Resetting base styles in this way meant I could do an initial pass of the existing CSS, removing all those instances of <code>border: 0;</code> and <code>margin: 0;</code> etc.

<strong>Step 2: Reduce and refine</strong>

The existing CSS had a file called <code>type.css</code>. It had about 60 lines, but incorporated a dozen rules for selectors that were not used at all, anywhere on our website. So anything useful in <code>type.css</code> was rolled into my core stylesheet, <code>html.css</code>.

I found lots of dead wood in the biggest stylesheet, <code>custom.css</code>. This kind of <em>selector mayhem</em>:

[css gutter="false"]#main-content #content-col #inner-right h3.wide span[/css]

was everywhere. To focus on this example alone, I discovered that nowhere on our site is there an occurence of <code>#content-col</code> outside of a containing <code>#main-content</code> block - so there was no need for a parent selector. Similarly, there's no need for this:

[css gutter="false"]#main-content #content-col h1[/css]

if there's only ever one instance of <code>&lt;h1&gt;</code> on the page. Again:

[css gutter="false"]div#breadcrumb-trail[/css]

- the <code>div</code> here is an over-qualification, since the 'breadcrumb-trail' id is only ever applied to a <code>div</code>, and only makes the rule less efficient (thanks again <a href="http://css-tricks.com/efficiently-rendering-css/">Chris Coyier</a>).

There were all kinds of elements in the old HTML files that have become part of the furniture over the last 3 years, but which probably should never have been there in the first place. For example, the designers must at some point have decided to add a colour-coded class to the <code>&lt;body&gt;</code> element, but they never made it college-specific. So each of the hundreds of HTML pages on the University website has:

[css gutter="false"]&lt;body class=&quot;blue&quot;&gt;[/css]

The class 'blue' has no style rules, so it's just useless cruft.

<strong>Step 3: styling for Internet Explorer</strong>

Following <a href="http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/">Paul Irish's guidelines</a> for feeding modified style rules to different versions of IE, I set up a basic conditional statement to detect for everybody's favourite browser, adding a class to the element:

[xml]
&lt;!--[if IE ]&gt;&lt;html class=&quot;ie&quot; xmlns=&quot;http://www.w3.org/1999/xhtml&quot; xml:lang=&quot;en&quot; lang=&quot;en&quot;&gt;&lt;![endif]--&gt;
&lt;!--[if !IE]&gt;&lt;!--&gt;&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot; xml:lang=&quot;en&quot; lang=&quot;en&quot;&gt;&lt;!--&lt;![endif]--&gt;
[/xml]

I didn't expect there to be too many special rules, but at least this gave me a valid method of specifying rules without fetching a separate file from the server.

<strong>Step 4: rediscovering the lost grid</strong>

The LCF site is built around a grid. Not one of today's <a href="http://960.gs/">nice modern 960 grids</a>, but a custom-built one with the following spec:
<ul>
	<li>16 columns</li>
	<li>982px wide</li>
	<li>51px grid squares</li>
	<li>9px gutters on the right-hand side of each column (as opposed to 4.5px on each side like most grids. This means that the far-right column has to have its margin removed so as not to overspill)</li>
	<li>a 30px left-hand margin on the main container element, to prevent the content resting flush against the left-hand edge of the viewport</li>
</ul>
The original grid existed only as a PSD file buried deep in a shared drive. However, using it and the column widths in the existing CSS, I was able to modify Nathan Smith's 16-column grid stylesheet to fit the UAL grid. It's not pretty, I realise. I actually had to make the left margin 31px, to remove the 1px wide gap on the right hand edge of the main content block, which was there because 16 x 60 - 9 equals 951, not 952, the original width of the container. Phew.

With my new <code>ualgrid.css</code>, I was able to apply predefined CSS selectors to HTML elements, and ensure consistent widths and spacing site-wide. Using a grid also meant that I could remove dozens of instances of <code>&lt;float: left;&gt;</code>, and <code>&lt;clear: both;&gt;</code> from the CSS.

[caption id="attachment_568" align="alignnone" width="550" caption="Illustration of the website&#39;s original design grid."]<img class="size-full wp-image-568" title="lcf-about-grid" src="http://www.strangerpixel.com/blog/wp-content/uploads/2010/11/lcf-about-grid.png" alt="" width="550" height="547" />[/caption] 
