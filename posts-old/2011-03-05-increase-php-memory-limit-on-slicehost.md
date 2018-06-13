---
layout: post
title: 'Increase PHP memory limit on Slicehost'
tags:
  - apache
  - code
  - php
  - terminal

---

The simultaneously daunting and great thing about Slicehost is the control it gives developers over their server setup. I'm very much a novice at server admin, but today I learned something new.

I needed to increase the memory limit for PHP because my Wordpress Next Gen gallery plugin was throwing failure errors when attempting to batch-resize thumbnails. Why 33MB of memory is required to resize a 100KB image is anyone's guess - but there was no way around it.

To change files situated above the /www level in your server tree, or to change folder permissions, you need to access your server via ssh, then switch to the root user. It's really easy, but it's incredible how long it's taken me to learn this. Thanks to <a href="http://samoliver.com/">Sam Oliver</a> for helping the penny drop.

For info the server I'm using is Apache on Ubuntu.

<strong>Gaining root access</strong>

Typically, when using Terminal, you will not be able to do:

[shell gutter="false"]$ ssh root@your-domain.com[/shell]

You have to start by going in as another user with non-root privileges, e.g. 

[shell gutter="false"]$ ssh joe@your-domain.com[/shell]

I guess it depends what users you have created on the server in the first place - I don't know, I didn't set mine up.

Once you've logged in as joe with joe's password, you can then type:

[shell gutter="false"]# su[/shell]

then [ENTER], then your root password. You should then see something like:

[shell gutter="false"]root@your-domain:/home/dir#[/shell]

<strong>Modifying php.ini</strong>

If you have sftp access to your server, then you can find out where php lives on your server. Or, again, you can use Terminal. First of all, type:

[shell gutter="false"]# cd[/shell]

to return to the topmost root level. Now type:

[shell gutter="false"]# cd /etc/php5/apache2[/shell]

[shell gutter="false"]# ls[/shell]

This list command should bring up a list of files in the apache2 folder: <code>conf.d</code> and <code>php.ini</code>. Now type:

[shell gutter="false"]# sudo pico php.ini[/shell]

The php.ini file will now be displayed inside Terminal. You can key down and edit the line:

[php gutter="false"]memory_limit = 16M      ; Maximum amount of memory a script may consume (16MB)[/php]

Increase it to 48M. Finally, you need to restart Apache by typing:

[shell gutter="false"]# /etc/init.d/apache2 restart[/shell] 
