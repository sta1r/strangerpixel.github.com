---
layout: post
title: 'How to fix cd: Too many arguments'
tags:
  - code
  - shell
  - terminal

---

Probably a really easy one - but, being a command-line newbie, I had to guess this after several fruitless Google searches.

When using Terminal to navigate your folder system, you will occasionally run into a folder with a space in its name, like /Application Support. Trying to access a folder, e.g.:
<pre lang="bash">[Alastair-Mucklows-Computer:~/Library] alastair% cd Application Support</pre>
will trigger the error:
<pre lang="bash">cd: Too many arguments.</pre>
The solution is to wrap the folder name in quotes, like so:
<pre lang="bash">[Alastair-Mucklows-Computer:~/Library] alastair% cd "Application Support"</pre>
