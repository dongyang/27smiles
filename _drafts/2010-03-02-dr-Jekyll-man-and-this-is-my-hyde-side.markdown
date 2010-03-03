---
layout: post
title: Dr. Jekyll man and this is my hyde side!
---
It's that time of year again! The time of year where I decide to revive the blog - which seems to becoming common practice for me! <img src="http://farm4.static.flickr.com/3349/3423669462_cf844811c6_m.jpg" alt="" class="alignright" title="I remember taking this picture last March!" /> According to the posting history it has been over a year since I showed this place any love! So, with the start of spring, I'm giving the blog new life and much needed TLC.

Well the major change in the revision is that I've ditched Wordpress - nice! The blog is now running, or should I said generated, by [Jekyll](github.com/mojombo/jekyll); Jekyll is a static site generator written in Ruby.

For some reason, unbeknown to me, I grew to dislike writing any blogs in Wordpress - hell logging in even became painful for some reason, especially when I forgot my password, twice! Bloody idiot. I think one of the reasons I grew to dislike Wordpress was the flaky-ness you get from WYSIWYG editors, seems more much logical to be writing my posts in markdown and the odd bit of HTML as after all I should know HTML, right? :) Wordpress also felt bloated, slow and just yuk! Furthermore anyone who thinks using tabs in their code base is a good idea ought to be taken out and shot in the head with a bolt gun, preferably nailed to the floor (wow where did that come from?).

## Jekyll
There were several things I wanted when moving the blog to Jekyll; I wanted to maintain the support for comments, I wanted to use Gist for inserting code snippets, I wanted to maintain the archive and category lists I had with wordpress and finally I wanted to integrate twitter, flickr and last.fm from the current layout. The comments issue was quickly resolved without any changes to Jekyll by using a JS based commenting system, I went with [Disqus](http://disqus.com) - it seems one of the more popular ones and a pretty decent service. Adding gists to post could also, if I wanted, be resolved by using the JS embedded stuff but as a lot of my posts are likely to have 2 or 3 snippet inserts I opted for inserting the HTML at compile time which meant I had to hack around with Jekyll's code.

## Forking the code

It isn't far in Jekyll land before you find a commit on someone else's fork doing exactly what you want! In fact it's one of the most fork repositories on github, so there was plenty of git cherry-picking to be had. I found the answer to the gist question in the [new-bamboo's fork](github.com/newbamboo/jekyll). Although it was one of the first things I looked for I didn't actually cherry-pick the commit till later on, I also needed to make an addition to allow me to specify a file within a multi-file gist.

Within a short period of time developing in Jekyll I began to get annoyed and felt limited by the stupid template system it uses, [Liquid](http://www.liquidmarkup.org/). I can see why it's used as Jekyll is used to generate the pages on github and they don't want people running ruby code in the template! However, for us not hosting on github pages there should be an alternative! I instantly started looking for HAML support in Jekyll and found [Henrik's](github.com/henrik/jekyll) fork. His fork was a little out of date and some of the features had been merged into the main Jekyll so I had several conflicts merging so I found it easier to manually rip out the HAML support and add it to my fork (I also made some additions in several places).

Another thing I found Jekyll lacks by default, at least the original repo, was the ability to generate archive indexes and also index pages for the different categories. I found the archive support in [cantorrodista's](http://github.com/cantorrodista/jekyll) branch and I copied his same method to do the category stuff myself.

### In my fork
So to summarise what's in my fork.

- HAML support; Taken from Henrik's fork I added HAML support (not SASS as I don't use it). I also added the option to change the output extension of the template, by default HAML will input the file as .html but, in the case of the atom.xml I wanted to output the file in .xml. This option is used in the YAML front matter like so **output_ext: .xml** 
- Archive/Category listings; Taken from cantorrodista's for the archive stuff and copied to enable category listings too.
- Gist embedding; Taken from new-bamboo's fork and adapted to allow supplying a file in multi-file gists.

### My fork

My fork is on my github account](http://github.com/RichGuk/jekyll) the [source code](http://github.com/RichGuk/27smiles) for this blog is also on there which will have examples of the different features added to Jekyll in the fork.

### Twitter, Flickr and Last.fm integration
To integrate the 3 services I had to write some scripts to pull the relevant data down from my feeds and spit the HTML formatted data into 3 different files for each service which I then included into the layout at the appropriate point.

For example here is the twitter script, the others can be found on the source code for this blog (on my github).

{{ 320150 | gist }}

## Migration of posts
I used the provided Wordpress import script to import the posts however I had to edit a lot of the posts because I used various plugins for wordpress that added stuff to the raw content. To import the comments into disqus I first had to install the wordpress plugin which imported them.

## Nginx setup
I use Nginx to serve all my sites and with moving to static content for the blog meant I could reduce my virtual host, so for anyone who's interested here my vhost used serve the blog.

{{ 320155 | gist }}