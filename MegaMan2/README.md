## MegaMan 2 Autosplitter
 
Auto Splitter for Mega Man 2 NES

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

**Supported emulators:**
 - FCEUX 2.2.2+
 - Nestopia 1.40
 - Let me know if you need support for another emulator
 
## Features

- Automatically start the timer when you start a run. Timer starts after selecting the difficulty
- Automatically split when a boss dies (except for boss rush, and then after Wily Machine phase 2)

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Desactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/Coltaho/Autosplitters/MegaMan2/master/MM2autosplit.asl
- Edit Layout
- Add Other /Scriptable Componment / Script Path: Browse to the "MM2autosplit.asl" file you downloaded previously
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

- Thanks to [Resistingframe](http://twitch.tv/Resistingframe) for testing. 

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [Coltaho](http://twitch.tv/Coltaho) or Coltaho#2016 on Discord
