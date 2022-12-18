---
layout: post
title: Vertical Video
author: Paul
type: post
layout: post
date: 2022-07-30
permalink: /verticalvideo/
featured_image: /assets/images/posts/2021-10/desk.jpg
categories:
  - Content Creation
  - programming

---
I've recently been working with Tiktok which means producing a lot of vertical video - 9:16 ratio video. Having produced entirely horizontal/landscape video my entire life, vertical video presents some new problems.
### Camera Orientation
9:16 is just 16:9 flipped 90 degrees, so you should just flip your camera as well, right? In my experience, this doesn't *always* create the best workflow. That's not to say it can't work but depending on your content, the limited horizontal plane means framing can become trickier - depending on how tightly you frame things, moving just a few centimeters can cause the target to be out of frame and the shot is ruined. 

**Shoot 16:9, and in post reframe as required.**

Shooting in "regular landscape" mode, then reframing as required in post has saved my bacon. It also means that the same content can be used in "regular" videos on platforms like YouTube. But what about the loss in resolution and detail? The big two (Instagram and Tiktok) only accept up to 1080p, and even then pretty low bitrate. The detail loss from resolution doesn't matter a great deal to overall clarity when its re-encoded server side to be so low.

If you have a video monitor, some will have various different guideline options (such as 9:16), which makes framing while in landscape mode much easier. For those that don't, it's honestly worth considering putting a couple of lines of masking tape onto your monitor to simulate.

### Text-to-speech
While audiences on other mediums do not generally accept text-to-speech, on the 'vertical video platforms' many creators exclusively use it. The TTS voices built in to the platform are hit and miss. Within the TikTok app, if you're on iOS you have a few voices, but on Android just the one option. And then the voices aren't consistent between platforms.

One solution for that is using a third party cloud service like Google Cloud, Amazon Polly or Microsoft Azure.

#### Balabolka 
Those cloud services are typically just API-access only, [Balabolka](http://www.cross-plus-a.com/balabolka.htm) provides a user interface and lets you save to WAV. Fantastic free software.

#### TWKVideoTools
**Or SRT to TTS to FCPXML** (Text-To-Speech-Back-To-Resolve)  

I had been writing my scripts in a text file, then using Balabolka to create one big WAV file. Then I would have to chop up the audio, place it back on my timeline and export.

That got old pretty quick, so I wrote a small application that takes exported subtitles (SRT) - meaning I can write/time the script within Resolve, then hits up the API and creates individual WAV files for each subtitle. Then it creates a FinalCutProXML file (FCPXML) that Resolve can import, creating a new timeline with all the WAV's at the same timecode that the subtitles were at.

This is *very* rough at this stage, so I currently am not distributing binaries. It uses C#/Windows only

**Other TWK Tools**
You may notice some other tabs, such as *EDL-to-Youtube* and *Members CSV to TXT*.

YouTube has chapter markers in a particular format, "00:00 - title". *EDL-to-Youtube* lets you export your timeline markers then convert that straight to Youtubes format. It isn't anything revolutionary, but it makes the process a lot easier.
![](https://thewoodknight.github.io/EDLtoYT/example.jpg)

It is possible to export your current [Member's](https://www.youtube.com/intl/en_uk/join/) list on youtube to a CSV list (Youtube Studio -> Monetisation -> Memberships -> See Your Members -> Export All Members To A CSV file). 
I use this information in a Resolve/Fusion composition to create a "thanks" section, but I require a plain text file for that. *Members CSV to TXT* simply converts it to the format that I use

While YouTube does have an API for this, unfortunately its invite only so I am unable to programmatically access this data.