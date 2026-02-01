## Timespinner Autosplitter
 
Auto Splitter for MIO: Memories in Orbit(PC)

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.
- [ASL](https://github.com/LiveSplit/LiveSplit/blob/master/Documentation/Auto-Splitters.md) - Here you can find more information about ASL (basically C#) and autosplitters in general.

## Features

- Syncs timer to gametime
- Automatically start timer on game start
- Automatically split on user picked events

This reads your save file which you will have to select on first run. There's a save bus that saves every 5 seconds and runs nonstop. However for quit outs, you want to ensure your event splits before quitting out. This might change in the future.

## Installation 

- Go to "Edit Splits.." in LiveSplit
- Enter the name of the game in "Game Name"
  - This must be entered correctly for LiveSplit to know which script to load
- Click the "Activate" button to download and enable the autosplitter script
  - If you ever want to stop using the autosplitter altogether, just click "Deactivate"

## Manual Installation (skip if you used the 'Activate' Button)

- Download https://raw.githubusercontent.com/Coltaho/Autosplitters/master/MIO/mio_autosplitter.asl
- Edit Layout
- Add Other /Scriptable Component / Script Path: Browse to the "mio_autosplitter.asl" file you downloaded previously
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

- Thanks to Nick, Dinopony, and Rocher of the MIO Speedrun community for testing.
- Thanks to Carnaval (MIO Dev) for help behind the scenes.

## Contact

If you encounter any issues or have feature requests, please let me know! 

- [Coltaho](http://twitch.tv/Coltaho) or Coltaho#2016 on Discord
