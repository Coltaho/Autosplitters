## Mega Man X Autosplitter
 
Auto Splitter for Mega Man X SNES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - SNES9x 1.55+ 32 and 64 bit
 - SNES9x 1.54 RR (COOP EMU)
 - Higan v105 and 106 (untested)
 
 Note that support for older versions is disabled!
 
## Features

- Automatically start the timer when you start a run. Timer starts after selecting Game Start
- Automatically split after being grabbed on Highway scene OR when screen fades afterward
- Automatically split either on helmet ding OR each Maverick kill in their stage, as well as Sigma 1-4 last bosses. 
- Optional splits for 100% run: Chill Penguin Heart and Hadouken

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Deactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/Coltaho/Autosplitters/master/MegaManX/MMXautosplit.asl
- Edit Layout
- Add Other /Scriptable Componment / Script Path: Browse to the "MMXautosplit.asl" file you downloaded previously
- Enable Start/Split feature here
  
## Set-up (if auto-installed)

- Go to "Edit Splits..." in LiveSplit
- Click "Settings" to configure the autosplitter
  - **Note:** If for some reason LiveSplit does not automatically load the script, click "Browse...", navigate to "\LiveSplit\Components\" and select the appropriate script.
- Enable Start/Split feature here
  
Here you can enable/disable the options for auto start and auto splitting.

## Bugs

- Let me know of any bugs

## Thanks

- Thanks to [Square_One_](http://twitch.tv/Square_One_) for moral support and expertise in MMX.
- Thanks to [Brasswolf](http://twitch.tv/Brasswolf) for patience and testing multiple Snes9x versions.
- Thanks to [Spiraster](http://twitch.tv/Spiraster) for help with memory stuffs.

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [Coltaho](http://twitch.tv/Coltaho) or Coltaho#2016 on Discord
