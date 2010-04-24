---
layout: post
title: Deluge in Chrome extension
category: projects
---

During the christmas holidays I decided to have a play around with writing Chrome extensions, however it wasn't until now that I've decided to write a quick introduction post about it.

The extension I wrote gives a simple overview, with controls, of torrents for Deluge - Deluge is a multi-platform torrent application written in Python. You can see the name, size, progress, ETA and current speed of the torrents along with some actions: moving torrents up and down; pausing and resuming; toggling auto-managed, basically if they should obey the queue rules; and since version 0.5 you can now delete torrents, with the option to delete just the torrent file or the data and torrent file.

Here's a screenshot:

<img src="/images/posts/2010-04-24-deluge-in-chrome/1.png" alt="" />

## Requirements

The extension currently requires the 1.2.x series (I have yet to look into the 1.3 series). You also need to have the webUI running. Once installed, on the options page, enter the address of the webUI and the port it's running on. You may also enter the password which will do the initial login for you, however, this isn't required and you can login to the webUI manually if you wish.
## Getting it

The extension can be found on the <a href="https://chrome.google.com/extensions/detail/pbenannnhhgfhhijhlpgfbjagebjeeel">Chrome extension page</a>. Please feel free to give a rating! =)

For developer folk the code can be found on <a href="http://github.com/RichGuk/deluge-in-chrome">github</a>, I'm more than happy to accept patches for fixes, improvements and new features.