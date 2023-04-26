---
layout: page
title: Paul Doesn't Want A Console
permalink: /gaming
showlastmodified: true
---

Consoles are lame, PC's are great... except for when it comes to gaming on the TV or more specifically, not at your desk. Until now!

### Parsec
[Download Parsec](https://parsec.app/downloads)

Install *for all users* if you want to be able to login, or just for yourself if you only want it to work once you've logged in the host.

I'd **recommend** for all users if you're going to be using Wake-On-Lan.

##### Settings
Recommended settings

**Parsec -> Settings -> Host**  
![](/assets/images/gaming/parsec.png)  

* Resolution: Use Client Resolution
* Bandwidth Limit: 50mbps (can always set the actual rate on the client, but only up to the max on the host)
* Fallback to Virtual Display: On (with this set to off, hosts monitor *must* be on)
* FPS: 60 unless going to a high refresh display


##### Notes
There are a few gotcha's to be aware of 

* Xbox controllers connect to the client, and are supported natively via Parsec. Other controllers (PS4, etc) can work, but may require tinkering to get it to appear as an Xbox controller. No settings need to be touched to make this work out of the box, and it'll work for multiple controllers at once.

* Windows requires a mouse on the host otherwise it won't render the mouse pointer at all. Not a Parsec issue. If its a wireless mouse with a non-bluetooth receiver, the receiver alone is enough to tell Windows its plugged in, mouse can be off.

* Parsec cannot handle audio that is higher than 32bit/48khz. Unlike other software where mismatched sample rates will cause slower or faster pitched audio, Parsec just goes silent.

* If you're using a tiny PC like **Lenovo's M93p**, you may need to grab machine specific drivers to get them to install properly. The key is to get the correct graphics driver, otherwise performance will be terrible. Even Intel's HD4600 (found in the i5-4590T and other 4th gen chips) is capable of 1080p@60fps decoding in under 5ms latency. Running purely off the CPU will see that latency spike to well over 20fps.

At 60fps, every frame is displayed for 16.6ms. Latency at or below that number will mean no more than 1 frame of latency - completely imperceptible. 

To that end, if its a M93p, install ThinkVantage System Update (TVSU) (link needed)

### WOL (Wake-On-Lan)
Wake On Lan is magical when it works, but hard to track down when it doesn't. WOL only works over ethernet, not wifi.

##### In BIOS
Different brands and different models within the same brands will have different BIOS layouts and different labels for the settings, so it's impossible to give an exact guide.

*Typically in the power menu*

* Disable ErP ("ErP Ready").
* Enable: Wake On PCIe
* Enable: Wake On LAN

##### In Windows
**Power Menu**  

![](/assets/images/gaming/powerplan.png)  
* Windows + R, "powercfg.cpl"
* "Choose What The Power Buttons Do"
* "Change settings that are currently unavailable"
* Untick 'Turn on fast start-up'

**Adapter Settings**  

![](/assets/images/gaming/ethernet.png)  
* Windows + R, "ncpa.cpl"
* Right click your ethernet adapter, Properties -> Configure
* Under **Advanced**, search for "Wake On Magic Packet" and "Wake On Magic Packet From S5", make sure both are enabled. S5 is powered off.
* Under **Power Management**, see if you can tick those boxes. I can't, but it still works.

### WOL with NFC
TODO

### Playnite
[Playnite](https://playnite.link/) is a front end for other game libraries like Steam, Epic, Origin, GOG, Battle.net, Ubisoft Connect. Install those launchers/install your games, then setup playnite.
It'll pull down the data, find what you've got installed, etc.

*Playnite Fullscreen is great for hitting play, but the general management (installing of games, getting all the metadata etc) should be done at a desktop*


### Autogame
[Autogame](https://github.com/jarrettgilliam/AutoGame/releases) launches Playnite (or other game launches like Steam Big Picture) in full screen when it detects a Parsec connection.

Has two options, "start when a game controller is connected" and "start when a parsec connection is established". I *believe* its an 'or' condition rather than an 'and' condition, so I'd opt for just the latter.