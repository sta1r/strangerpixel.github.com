---
layout: post
title: 'Integrating Zenphoto with Wordpress part 2'

---

I've just cleared up <a href="http://www.strangerpixel.com/web/integrating-zenphoto-with-wordpress-on-iis/" title="See Part 1">another</a> aggravating problem with integrating Zenphoto albums into a Wordpress blog. This is for anyone who has implemented <a href="http://www.ruzee.com/blog/2006/06/integrating-zenphoto-into-wordpress/">Ruzee's method</a> and found that album and image links randomly trigger a 404 in Internet Explorer 6 and 7.

Although I initially thought it must be something to do with either the Zenphoto or Wordpress theme files, what finally solved it was turning off mod-rewrite in both the .htaccess file in the Zenphoto directory, and in zp-config.php. Perhaps there are some tweaks I could have done in .htaccess to remove the IE bug, but my programming skills didn't stretch to it!

Surprising that this hasn't come up in Ruzee's comments. In case it matters, which I imagine it might, the website in question is hosted with <a href="http://www.heartinternet.co.uk/">Heart Internet</a> - who, incidentally, I would recommend unreservedly to anyone looking for a decent, good value, well-supported, UK-based <a href="http://www.heartinternet.co.uk/home-h.shtml">hosting package</a>.
