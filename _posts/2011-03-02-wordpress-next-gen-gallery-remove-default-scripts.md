---
layout: post
title: 'Wordpress + Next Gen gallery - remove default scripts'

---

<a href="http://wordpress.org/extend/plugins/nextgen-gallery/">Next Gen gallery</a> is probably the most full-featured, customisable Wordpress gallery plugin out there.

I'd been using it for a year or so before I read <a href="http://daverupert.com/2010/06/web-performant-wordpress/">Dave Rupert's post on optimising Wordpress for speed</a>. Looking at the source, I realised that Next Gen was loading additional jQuery script files even if they weren't required for the gallery theme.

The solution is to block this in the <code>wp-config.php</code> file like so:
[php]
/* Prevent load of NGG JS */
define('NGG_SKIP_LOAD_SCRIPTS', TRUE);
/* That's all, stop editing! Happy blogging. */
[/php] 
