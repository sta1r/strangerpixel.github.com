---
layout: post
title: 'Extending the Wordpress Campaign Monitor Addon plugin'
tags:
  - api
  - campaign-monitor
  - php

---

A starting point for customising the Wordpress <a href="http://www.campaignmonitor.com/downloads/wordpress-contact-form-7-plugin/">Campaign Monitor Addon plugin</a>, for using Wordpress forms to maintain detailed contact lists in Campaign Monitor.

By extending the <a href="http://wordpress.org/extend/plugins/contact-form-7/">Contact Form 7 plugin</a> with the Campaign Monitor Addon, and with a little help from my colleague <a href="http://twitter.com/djkofi">Mouhannad Al-Sayegh</a>, I was able to unlock a pretty powerful combination that enables all kinds of list management functions using the <a href="http://www.campaignmonitor.com/api/">Campaign Monitor API</a>.

<strong>Campaign Monitor</strong>

To start you'll need an account with Campaign Monitor, and a demo list for testing purposes.

<strong>Contact Form 7</strong>

This plugin is super-flexible and easy to use if you know a little HTML and the rudiments of building forms. If you haven't already you'll need to install the plugin and create a demo form.

<strong>Campaign Monitor Addon</strong>

When installed and activated, this plugin appends a module to your form. No need for me to go into detail here - read <a href="http://www.bettigole.us/published-work/wordpress-contributions/campaign-monitor-addon-for-contact-form-7/">Joshua Bettigole's instructions</a> and download his excellent manual on the steps required.

<strong>Connecting to Campaign Monitor</strong>

By default the Campaign Monitor Addon provides two fields for subscriber data:
<ul>
	<li>Subscriber Email</li>
	<li>Subscriber Name</li>
</ul>
It takes these fields and feeds them to the <em>subscriberAdd</em> method:

[php gutter="false"]$result = $cm-&amp;gt;subscriberAdd($email, $name);[/php]

<strong>Custom fields</strong>

So far so good - but I wanted to process additional fields from the form. Campaign Monitor allows you to <a href="http://help.campaignmonitor.com/topic.aspx?t=33">add custom fields to lists</a> (e.g. business name, country, gender, website URL, etc.) so I wanted to harvest this data directly from my contact form.

First of all I needed to modify cf7-campaignmonitor.php. I added new form fields to the existing list:

[php]
&lt;div class=&quot;mail-field&quot;&gt;
        &lt;label for=&quot;wpcf7-campaignmonitor-email&quot;&gt;&lt;/label&gt;
&lt;input id=&quot;wpcf7-campaignmonitor-email&quot; class=&quot;wide&quot; name=&quot;wpcf7-campaignmonitor[email]&quot; size=&quot;70&quot; type=&quot;text&quot; value=&quot;&amp;lt;?php echo esc_attr( $cf7_cm['email'] ); ?&amp;gt;&quot; /&gt;&lt;/div&gt;
&lt;div class=&quot;mail-field&quot;&gt;
        &lt;label for=&quot;wpcf7-campaignmonitor-name&quot;&gt;&lt;/label&gt;
&lt;input id=&quot;wpcf7-campaignmonitor-name&quot; class=&quot;wide&quot; name=&quot;wpcf7-campaignmonitor[name]&quot; size=&quot;70&quot; type=&quot;text&quot; value=&quot;&amp;lt;?php echo esc_attr( $cf7_cm['name'] ); ?&amp;gt;&quot; /&gt;&lt;/div&gt;
&lt;div class=&quot;mail-field&quot;&gt;
        &lt;label for=&quot;wpcf7-campaignmonitor-accept&quot;&gt;&lt;/label&gt;
&lt;input id=&quot;wpcf7-campaignmonitor-accept&quot; class=&quot;wide&quot; name=&quot;wpcf7-campaignmonitor[accept]&quot; size=&quot;70&quot; type=&quot;text&quot; value=&quot;&amp;lt;?php echo esc_attr( $cf7_cm['accept'] ); ?&amp;gt;&quot; /&gt;&lt;/div&gt;
&lt;!-- Additional form fields --&gt;
&lt;div class=&quot;mail-field&quot;&gt;
        &lt;label for=&quot;wpcf7-campaignmonitor-business&quot;&gt;&lt;/label&gt;
&lt;input id=&quot;wpcf7-campaignmonitor-business&quot; class=&quot;wide&quot; name=&quot;wpcf7-campaignmonitor[business]&quot; size=&quot;70&quot; type=&quot;text&quot; value=&quot;&amp;lt;?php echo esc_attr( $cf7_cm['business'] ); ?&amp;gt;&quot; /&gt;&lt;/div&gt;
&lt;div class=&quot;mail-field&quot;&gt;
        &lt;label for=&quot;wpcf7-campaignmonitor-website&quot;&gt;&lt;/label&gt;
&lt;input id=&quot;wpcf7-campaignmonitor-website&quot; class=&quot;wide&quot; name=&quot;wpcf7-campaignmonitor[website]&quot; size=&quot;70&quot; type=&quot;text&quot; value=&quot;&amp;lt;?php echo esc_attr( $cf7_cm['website'] ); ?&amp;gt;&quot; /&gt;&lt;/div&gt;
[/php]


These can obviously be re-ordered to suit. Next you need to modify the main wpcf7_cm_subscribe() function below:

[php]$email = preg_replace_callback( $regex, $callback, $cf7_cm['email'] );
$name = preg_replace_callback( $regex, $callback, $cf7_cm['name'] );
// initialise new field variables
$business = preg_replace_callback( $regex, $callback, $cf7_cm['business'] );
$website = preg_replace_callback( $regex, $callback, $cf7_cm['website'] );
// create array for additional fields
$extraFields = array('Business Name' =&amp;gt; $business, 'Business Website' =&amp;gt; $website);
[/php]

Note that 'Business Name' and 'Business Website' should match the custom field names you have created in Campaign Monitor.

Finally, we need to modify the method call. In campaignmonitor.php are listed a number of PHP wrapper functions for Campaign Monitor API methods. It's possible to use different method calls in place of <em>subscriberAdd</em> - for example we needed to use <em>subscriberAddWithCustomFields</em>. Our previously defined $extraFields variable follows the standard $email and $name:

[php gutter="false"]$result = $cm-&amp;gt;subscriberAddWithCustomFields($email, $name, $extraFields);[/php]

Campaign Monitor will check the email address against a given list. If it already exists, any new data will replace what is already in the record. Note that you need to re-supply any existing data, or it will be wiped. You may need to run a few tests to make sure your form submissions are putting the additional data in the right places.

<strong>Checkboxes etc.</strong>

The above example demonstrates form submission using custom fields with single values. But what happens when you want to process a set of checkboxes into a 'Multi-option' custom field in Campaign Monitor?

[php gutter="false"]
$checkboxes = preg_replace_callback( $regex, $callback, $cf7_cm['checkboxes'] );
[/php]

The above line extracts the cleaned-up data from the form submission, but stores it as a string e.g. 'category 1, category 2, category 3' etc. What I wanted was to put each comma-separated value into its own option inside of a multi-option custom field - so an additional step was required:

[php]
$checkboxes = preg_replace_callback( $regex, $callback, $cf7_cm['checkboxes'] );
// explode the string into an array
$checkboxArray = explode(&quot;, &quot;, $checkboxes);
// create array for additional fields
$extraFields = array('Business Name' =&amp;gt; $business, 'Business Website' =&amp;gt; $website, 'Categories' =&amp;gt; $checkboxArray);
[/php]

This is really just scratching the surface of what could be developed using these tools - but hopefully it helps people trying to move beyond the standard tutorials and installation instructions already out there.
