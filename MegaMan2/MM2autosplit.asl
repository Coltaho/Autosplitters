//Made by Coltaho 6/23/2018
//Splits on boss kill, assumes boss rush is 1 split
//Version 1.3

state("fceux")
{
	byte bosshp : 0x436B04, 0x6C1;
	byte myhp : 0x436B04, 0x6C0;
	byte mylives : 0x436B04, 0xA8;
	byte mytitlescreen : 0x436B04, 0x04B0;
	byte mycontroller : 0x436B04, 0x0025;
}

state("nestopia")
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x729;
	byte myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x728;
	byte mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x110;
	byte mytitlescreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x518;
	byte mycontroller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8d;
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.inBossFight = 0;
	vars.currentBossRush = 0;
	vars.splitNumber = 0;
	vars.iknowimdead = 0;
	vars.framecounter = 0;
}

start { 
	if (vars.splitNumber > 0) {
		print("--Starting, Reset vars!--");
		vars.inBossFight = 0;
		vars.currentBossRush = 0;
		vars.splitNumber = 0;
		vars.iknowimdead = 0;
		vars.framecounter = 0;
	}
	if (old.mytitlescreen == 119 && current.mytitlescreen == 119 && old.mycontroller == 0 && current.mycontroller == 8) {
		print("--Here we go!");
		return true;
	}
}

update {
	print("--Current myhp: " + current.myhp + " Current bosshp: " + current.bosshp + " --framecount: " + vars.framecounter + " --split: " + vars.splitNumber + " --incombat: " + vars.inBossFight);
}

split
{
	if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.iknowimdead == 0 && vars.framecounter <= 8) {
		vars.framecounter++;	//Accounts for a DKO, gives you 8 frames of leeway if you die before the boss does	
	} else if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.iknowimdead == 0 && vars.framecounter > 8) {
		vars.inBossFight = 0;
		vars.iknowimdead = 1;
		vars.framecounter = 0;
		print("--You died!--");
		if (vars.currentBossRush == 9) {
			vars.currentBossRush = 8;
			print("--You Died during Wily Phase 2 Man!--");
		}
		if (current.mylives == 1) {
			vars.currentBossRush = 0;
			print("--You Gameovered Man!--");
		}
	} else if (current.mylives < old.mylives && vars.inBossFight == 1) {
		vars.inBossFight = 0;
		vars.iknowimdead = 1;
		vars.framecounter = 0;
		print("--You died to falling?!--");
	} else if (current.myhp > 0 && vars.iknowimdead == 1) {
		vars.iknowimdead = 0;
		print("--You have risen!--");
	}
	if (vars.splitNumber < 12) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 28 && old.bosshp == 27) {
				print("--Starting boss " + (vars.splitNumber + 1) + "!--");
				vars.inBossFight = 1;				
			}
		} else {
			if (current.bosshp == 0) {
				vars.inBossFight = 0;
				vars.framecounter = 0;
				vars.splitNumber++;
				print("--Yay " + vars.splitNumber + " boss dead!--");
				return true;
			}
		}
	} else if (vars.splitNumber == 12) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 28 && old.bosshp == 27) {
				print("--Starting boss rush boss " + vars.currentBossRush + "!--");
				vars.inBossFight = 1;
			}
		} else {
			if (current.bosshp == 0) {
				vars.inBossFight = 0;
				vars.framecounter = 0;
				vars.currentBossRush++;
				print("--Yay " + vars.currentBossRush + " boss(es) in rush is dead!--");
			}
		}
		if (vars.currentBossRush == 10) {
			print("--Yay ALL bosses in rush are dead!--");
			vars.splitNumber++;
			return true;
		}
	} else if (vars.splitNumber == 13) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 28 && old.bosshp == 27) {
				print("--Starting LAST boss!--");
				vars.inBossFight = 1;
			}
		} else {
			if (current.bosshp == 0) {
				vars.inBossFight = 0;
				print("--Yay LAST boss dead! You Win!--");
				return true;
			}
		}
	}
	return;
}

startup
{
	settings.Add("main", false, "Mega Man 2 AutoSplitter v1.3 by Coltaho");
	settings.Add("main0", false, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.Add("main1", false, "- Supported emulators : FCEUX, Netstopia", "main");
	settings.Add("main2", false, "- Splits on boss kill, get used to it", "main");
	settings.SetToolTip("DoesNothing", "Pretty cool, right?");
}
