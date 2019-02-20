## Mega Man 3 Autosplitter
 
Auto Splitter for Mega Man 3 NES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - FCEUX 2.2.2+
 - Nestopia 1.40
 
## Features

- Automatically start the timer when you start a run.
- Automatically split on teleport after stage clear except for Breakman and Refights which split slightly after (screen transition) and on kill hit of last boss.
- Automatically reset the timer when you are back on the start screen

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Deactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/Coltaho/Autosplitters/master/MegaMan3/MM3autosplit.asl
- Edit Layout
- Add Other /Scriptable Componment / Script Path: Browse to the "MM3autosplit.asl" file you downloaded previously
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

- Thanks to [Fastatcc](http://twitch.tv/fastatcc) for making the tutorial I used to learn the game.

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [Coltaho](http://twitch.tv/Coltaho) or Coltaho#2016 on Discord
