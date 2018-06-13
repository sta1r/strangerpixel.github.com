---
layout: post
title: 'Simple content workflow for Wordpress'
tags:
  - wordpress
  - workflow

---

Create a simple and convenient workflow process for multiple Wordpress bloggers using two plugins.

Posting content on Wordpress is almost too easy. You paste text into a box and click publish, and your post is instantly pushed to your thousands of Twitter followers. Then you check the published post and find a grammatical war-zone...

Being an unashamed stickler for textual accuracy, I've put in place a system to catch occasional lapses by my team of Wordpress content editors at LCF. Here's how it works.

<strong>Step 1: Status notifications</strong>

Download and install the <a href="http://wordpress.org/extend/plugins/wp-status-notifier/">WP Status Notifier plugin</a>. This plugin is in charge of sending emails to and from contributors and a specified approver when the status of a piece of content changes. The settings screen (Settings &gt; Status Notifications) should look like this (fill in your admin email address of course):

[caption id="attachment_757" align="alignnone" width="550" caption="WP Status Notifier settings panel."]<img class="size-medium wp-image-757" title="status-notifier" src="http://www.strangerpixel.com/blog/wp-content/uploads/2011/09/status-notifier-550x259.jpg" alt="" width="550" height="259" />[/caption]

<strong>Step 2: Roles and Capabilities</strong>

First of all, read up on the <a href="http://codex.wordpress.org/Roles_and_Capabilities">Roles and Capabilities documentation</a> in the Wordpress Codex. Next, install the <a href="http://wordpress.org/extend/plugins/capsman/">Capability Manager plugin</a>. You now have to configure the plugin to ensure that all those users whose posts you want to moderate are prevented from doing so automatically. <em>Go to Users &gt; Capabilities.</em>

Most of my contributors are in fact Wordpress 'editors' - and by default they can publish posts and pages. Therefore we need to uncheck these capabilities from the editor capabilities table.

[caption id="attachment_759" align="alignnone" width="550" caption="Managing roles and capabilities in Wordpress."]<img class="size-medium wp-image-759" title="roles-caps" src="http://www.strangerpixel.com/blog/wp-content/uploads/2011/09/roles-caps-550x372.jpg" alt="" width="550" height="372" />[/caption]

I would recommend installing the Roles and Capabilities plugin in any case - it's often useful to strip out options and menus where they're not needed, or to give certain capabilities to a user you don't necessarily want to make an admin.

<strong>Step 3: Moderate and go</strong>

Provided you've configured your users' capabilities correctly, you should now receive an email whenever a post is ready for approval. This will happen the first time a user clicks 'Save' (be wary here about jumping in to approve instantly - the user might still be editing the content). Once you've had a chance to check the content and click Publish, the author will receive a confirmation email.
