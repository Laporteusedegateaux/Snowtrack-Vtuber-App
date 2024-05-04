# SnowTrack - An Open source vtuber app made in Godot
###[Version francais de ce Readme ici!](docs/README_FR.md)
## What is this project?
This is an open-source vtuber app made by vtubers, for vtubers.
It's meant to be a base for intermediate and advanced users for now, but will expand to be as user-friendly as possible in the future.

You can freely modify what's provided here!
Think a feature should be made? Get to coding, or let me know!

## What's working?
- Arkit (IFacialMocap or Meowface) tracking
- Twitch integration for redeems, chat, bits, subs, hype trains, follows, etc.
- Hand tracking (WIP)
- Different cameras and easy swapping between them

## What's planned?
I want to add a lot more features over time. For now, here's what I have in mind:
- load avatars straight from blender with an integrated setup
- load decor and props straight from file, and edit them directly without conversion to another format
- more tracking options like webcam, kinect and mediapipe
- the possibility to run the app on another computer to avoid slurping graphical power from your streaming pc
- Live2D support
- PNGtuber support

And probably a lot more. Want a feature? Let me know, or even fork this project and code it yourself!

## Known issues
At the moment, this is what I know is broken. This is very early in the projects - bugs and unpolished features are to be expected.
Here goes:
- The only tracking supported as of now is ARKit. IfacialMocap (Iphone) and Meowface (Android) both work and are supported.
- There is no way to easily import an avatar - you have to do the setup yourself. I will have resources up for that in the future.
- Only 3D avatars are supported at the moment.
- The code is not always super optimized - I'm doing my best.

## Credit where credit is due
This project uses a number of other open-source addons that were made by other people.
So, thanks and credits to these awesome projects! They are as follow:
- [Wigglebones](https://github.com/Laporteusedegateaux/godot-wigglebones) by Bauxitedev, Yaelatletl, Cory Petkovsek and myself
- [Phantom Camera](https://github.com/ramokz/phantom-camera) by Ramokz
- [GlobalInput](https://github.com/Darnoman/Godot-GlobalInput-Addon) by Darnoman
- [TMI](https://github.com/erodozer/tmi.gd) by Erodozer
- [Ultraleap godot addon](https://forge.lunai.re/rodolphe/godot-ultraleap-plugin) by Rodolphe
- [Jolt for Godot](https://github.com/godot-jolt/godot-jolt) by... Godot Jolt
