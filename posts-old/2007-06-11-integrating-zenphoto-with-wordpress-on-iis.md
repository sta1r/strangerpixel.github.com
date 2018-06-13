---
layout: post
title: 'Integrating Zenphoto with Wordpress on IIS'

---

If you're working with Zenphoto and Wordpress, chances are you will have considered integrating the two systems in order to implement your blog theme in your gallery or photo album.

<a href="http://www.ruzee.com/blog/2006/06/integrating-zenphoto-into-wordpress/" target="_blank">Ruzee's method</a> is the one I've been using. It's a simple way of pulling your Wordpress functions into Zenphoto, so that you can include <code>header.php</code> and <code>footer.php</code> within your Zenphoto files and thus avoid having to repeat the same code in several different places.

Ruzee's fix works on Apache, but not on IIS. In fact, Zenphoto's comments don't work on IIS either, not to mention the lack of mod_rewrite. If you have the option to host your site on Apache, and you want to install either Wordpress or Zenphoto, don't even think about using IIS. That said, if you don't have the option, then here's a way to make Ruzee's method work on IIS. 

Simply insert the following code:

[php]
if ( ! isset($_SERVER['DOCUMENT_ROOT'] ) )
$_SERVER['DOCUMENT_ROOT'] = str_replace( '\\', '/', substr(
$_SERVER['SCRIPT_FILENAME'], 0, 0-strlen($_SERVER['PHP_SELF']) ) );
[/php]

above the line

[php]require($_SERVER['DOCUMENT_ROOT'].'/wordpress-install-directory/wp-blog-header.php');[/php]

All the rest of the code in the Ruzee method works as per Apache.

IIS's problem stems from the fact that it does not provide the universal environment variable $_SERVER['DOCUMENT_ROOT'], so you have to cobble it together from other variables. <a href="http://www.helicron.net/php/" target="_blank">Helicron's PHP pages</a> offer a good explanation, but the solution - which involves using PHP's <code>realpath()</code> function - didn't work for me.

<strong>Extension to post 4/8/07:</strong>
Note to anyone considering hosting Wordpress on an IIS server - don't do it. Wordpress runs very slowly when installed on an IIS server running PHP5. If your host is as bad as the company I recently used, they won't warn you in advance and then they'll blame Wordpress for the slow performance. Avoid. Go Apache.
