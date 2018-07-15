//Made by Coltaho 6/1/2018
//Splits on boss kill, assumes boss rush is 1 split
//Version 1.3

state("fceux")
{
	byte myhp : 0x3B1388, 0x3E5;
	byte mylives : 0x3B1388, 0xA9;
	byte bosshp : 0x3B1388, 0x3ED;
	byte currentstage : 0x3B1388, 0x51;
	byte currentscreen : 0x3B1388, 0x92;
	byte mycontroller : 0x3B1388, 0x40;
}

startup
{
	settings.Add("DoesNothing", true, "V1.3 - Splits on boss kill, get used to it. Only works with FCEUX for now!");
	settings.SetToolTip("DoesNothing", "Pretty cool though, right?");
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
	if (old.currentscreen == 163 && current.currentscreen == 163 && old.mycontroller == 0 && current.mycontroller == 16) {
		print("--Starting, Reset vars!--");
		vars.inBossFight = 0;
		vars.currentBossRush = 0;
		vars.splitNumber = 0;
		vars.iknowimdead = 0;
		vars.framecounter = 0;
		print("--Here we go!");
		return true;
	}
}

update { 
	print("-- myhealth: " + current.myhp + " --Current bosshp: " + current.bosshp + " --Current boss rush: " + vars.currentBossRush + " --Current split: " + vars.splitNumber + " --Current boss fight status: " + vars.inBossFight);
	//print("--info: " + current.bosshp);
}

split
{
	if (current.myhp > 127 && current.bosshp != 255 && vars.iknowimdead == 0 && vars.framecounter <= 8) {
			vars.framecounter++;	//Accounts for a DKO by giving you 8 frames of leeway if you die before the boss does	
		} else if (current.myhp > 127 && current.bosshp != 255 && vars.iknowimdead == 0 && vars.framecounter > 8) {
		vars.inBossFight = 0;
		vars.iknowimdead = 1;
		vars.framecounter = 0;
		print("--You died!--");
		if (current.mylives == 0 || current.currentstage == 15) {
			vars.currentBossRush = 0;
			print("--You Gameovered and/or died during Wily Man!--");
		}		
	} else if (current.myhp <= 27) {
		vars.iknowimdead = 0;
	}
	if (current.currentstage < 14) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 27 && old.bosshp == 26) {
				print("--Starting boss " + (vars.splitNumber + 1) + "!--");
				vars.inBossFight = 1;				
			}
		} else {
			if (current.bosshp == 255) {
				vars.inBossFight = 0;
				vars.framecounter = 0;
				vars.splitNumber++;
				print("--Yay " + vars.splitNumber + " boss dead!--");
				return true;
			}
		}
	} else if (current.currentstage == 14) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 27 && old.bosshp == 26) {
				print("--Starting boss rush boss " + (vars.currentBossRush + 1) + "!--");
				vars.inBossFight = 1;
			}
		} else {
			if (current.bosshp == 255) {
				vars.inBossFight = 0;
				vars.framecounter = 0;
				vars.currentBossRush++;
				print("--Yay " + vars.currentBossRush + " boss(es) in rush is dead!--");
			}
		}
		if (vars.currentBossRush == 8) {
			print("--Yay ALL bosses in rush are dead!--");
			vars.currentBossRush = 0;
			return true;
		}
	} else if (current.currentstage == 15) {
		if (vars.inBossFight == 0) {
			if ((current.bosshp == 27 && old.bosshp == 26) || (vars.currentBossRush == 2 && current.bosshp == 0 && old.bosshp == 255)) {
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
	return;
}
