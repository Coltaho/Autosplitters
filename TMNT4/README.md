## Teenage Mutant Ninja Turtles IV: Turtles in Time Autosplitter
 
Auto Splitter for TMNT IV: Turtles In Time SNES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - SNES9x 1.55+ 32 and 64 bit
 - Higan v105 and 106 (untested)
 
 Note that support for older versions is disabled!
 
## Features

- Automatically start the timer when you start a run. OPTIONAL between turtle selection (RTA) and turtle control (SDA). Note that currently the leaderboards require SDA timing!
- Automatically split after each stage. This happens during the black screen between stages.
- Automatically split upon losing control after beating final shredder. 
- Automatically reset when the game appears to be reset.

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Deactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/Coltaho/Autosplitters/master/TMNT4/TurtlesInTimeautosplit.asl
- Edit Layout
- Add Other /Scriptable Componment / Script Path: Browse to the "TurtlesInTimeautosplit.asl" file you downloaded previously
- Enable Start/Split/Reset feature here
  
## Set-up (if auto-installed)

- Go to "Edit Splits..." in LiveSplit
- Click "Settings" to configure the autosplitter
  - **Note:** If for some reason LiveSplit does not automatically load the script, click "Browse...", navigate to "\LiveSplit\Components\" and select the appropriate script.
- Enable Start/Split/Reset feature here
  
Here you can enable/disable the options for auto start, auto splitting, and auto reset.

## Bugs

- Let me know of any bugs

## Thanks

- Thanks to [Mannix](http://twitch.tv/Mannix86) for help getting the Fall 2018 tourney organized

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [Coltaho](http://twitch.tv/Coltaho) or Coltaho#2016 on Discord
