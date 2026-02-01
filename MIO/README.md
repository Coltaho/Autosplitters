## Timespinner Autosplitter
 
Auto Splitter for MIO: Memories in Orbit(PC)

- [LiveSplit](http://livesplit.github.io/) - Here you can find out more about and download LiveSplit. It is a popular timer program typically used for speedruns.

## Features

- Syncs timer to gametime
- Automatically start timer on game start
- Automatically split on user picked events

This reads your save file!  On first run it will warn you and ask you to pick your save file. It will read all saves in that folder going forward. If you don't select one, you will need to deactivate and reactivate the splitter to try again later. If your save folder changes or you picked wrong, you will need to edit the savepath.txt file in MIO\Saves\ or delete it.

The save system is on a 5 second bus.  Due to this, most splits may not happen exactly at the same time the event happens. There's pros and cons to this. If you're quitting out, you know 100% sure it was saved if the split happens. Cons is that your split could vary a few seconds depending on what bus you caught. This may change in the future if the devs change how saves work.

Also this reads the ingame timer. You must being looking at gametime in Livesplit to see this. Right now the ingame timer pauses when you're in a menu. Hopefully this gets changed in a future patch.

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
