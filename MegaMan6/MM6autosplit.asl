//Made by Coltaho 3/14/2018

state("fceux", "v2.2.3")
{
	byte myhp : 0x3B1388, 0x3E5;
	byte mylives : 0x3B1388, 0xA9;
	byte bosshp : 0x3B1388, 0x3ED;
	byte stage : 0x3B1388, 0x51;
	byte currentscreen : 0x3B1388, 0x92;
	byte mycontroller : 0x3B1388, 0x40;
	byte mymenuselection : 0x3B1388, 0x5B1;
	byte soundfx : 0x3B1388, 0x702; //current/last played sound
}

state("fceux", "v2.6.4")
{
	byte myhp : 0x3DA4EC, 0x3E5;
	byte mylives : 0x3DA4EC, 0xA9;
	byte bosshp : 0x3DA4EC, 0x3ED;
	byte stage : 0x3DA4EC, 0x51;
	byte currentscreen : 0x3DA4EC, 0x92;
	byte mycontroller : 0x3DA4EC, 0x40;
	byte mymenuselection : 0x3DA4EC, 0x5B1;
	byte soundfx : 0x3DA4EC, 0x702; //current/last played sound
}

state("nestopia")
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x44D;
	byte mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x111;
	byte bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x455;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xB9;
	byte currentscreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xFA;
	byte mycontroller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA8;
	byte mymenuselection : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x619;
	byte soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
}

startup
{
	settings.Add("optionsection", true, "---Options---");
	settings.Add("onteleport", true, "Split on teleport instead of boss kill", "optionsection");
		
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 6 Autosplitter v2.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Nestopia", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.inBossFight = 0;
	vars.currentBossRush = 0;
	vars.iknowimdead = 0;
	vars.framecounter = 0;
	
	if (modules.First().ModuleMemorySize == 0x487000)
        version = "v2.2.3";
    else if (modules.First().ModuleMemorySize == 0x603000)
        version = "v2.6.4";
}

start {
	if (current.mymenuselection == 0 && current.currentscreen == 163 && current.soundfx == 63) {
		print("--Starting, Reset vars!--");
		vars.inBossFight = 0;
		vars.currentBossRush = 0;
		vars.iknowimdead = 0;
		vars.framecounter = 0;
		print("--Here we go!");
		return true;
	}
}

update { 
	// print("-- myhealth: " + current.myhp + " --Current bosshp: " + current.bosshp + " --Current SFX: " + current.soundfx + " --Current Stage: " + current.stage + " --Current boss fight status: " + vars.inBossFight);
}

split
{
	//Logic for on boss kill
	if (!settings["onteleport"]) {
		if (current.myhp > 127 && current.bosshp != 255 && vars.iknowimdead == 0 && vars.framecounter <= 8) {
				vars.framecounter++;	//Accounts for a DKO by giving you 8 frames of leeway if you die before the boss does	
			} else if (current.myhp > 127 && current.bosshp != 255 && vars.iknowimdead == 0 && vars.framecounter > 8) {
			vars.inBossFight = 0;
			vars.iknowimdead = 1;
			vars.framecounter = 0;
			print("--You died!--");
			if (current.stage == 15) {
				vars.currentBossRush = 0;
				print("--You Died during Wily Man!--");
			}
		} else if (current.myhp <= 27) {
			vars.iknowimdead = 0;
		}
		if (current.stage < 14) {
			if (vars.inBossFight == 0) {
				if (current.bosshp == 27 && old.bosshp == 26) {
					print("--Starting a boss!--");
					vars.inBossFight = 1;				
				}
			} else {
				if (current.bosshp == 255) {
					vars.inBossFight = 0;
					vars.framecounter = 0;
					print("--Yay boss dead!--");
					return true;
				}
			}
		}
	} else {
		//Logic for on teleport
		if (current.stage > 7 && current.stage != 14 && old.soundfx == 68 && current.soundfx == 66)
			return true;
		if (current.stage <= 7 && old.soundfx == 65 && current.soundfx == 68)
			return true;
	}
	
	//Always split on kill for last boss
	if (current.stage == 15) {
		if (settings["onteleport"] && current.myhp > 127 && vars.inBossFight == 1) {
			vars.inBossFight = 0;
			vars.currentBossRush = 0;
			print("--You Died during Wily Man!--");
		}
		if (vars.inBossFight == 0) {
			if ((current.bosshp == 22 && old.bosshp == 21) || (vars.currentBossRush == 2 && current.bosshp == 0 && old.bosshp == 255)) {
				if (vars.currentBossRush == 0) {
					print("--Starting LAST boss phase 1 of 3!--");
				} else {
					print("--Starting Phase " + (vars.currentBossRush + 1) + "!--");
				}
				vars.inBossFight = 1;
			}
		} else {
			if (current.bosshp == 255) {
				vars.inBossFight = 0;
				vars.framecounter = 0;
				vars.currentBossRush++;
				print("--Yay Wily Phase " + vars.currentBossRush +  " is dead!--");
			}
		}
		if (vars.currentBossRush == 3) {
			vars.currentBossRush = 0;
			print("--Yay LAST boss is dead! You Win!--");
			return true;
		}
	}
	
	//Split after Mr X 4 to next stage transition if on teleport is true
	if (settings["onteleport"] && old.stage == 11 && current.stage == 12) {
		return true;
	}
	
	//Always split after refights to last stage transition
	if (old.stage == 14 && current.stage == 15) {
		return true;
	}
	return;
}
