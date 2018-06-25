//Made by Coltaho 6/1/2018
//Splits on boss kill, assumes boss rush is 1 split
//Version 1.2

state("fceux")
{
	byte myhp : 0x3B1388, 0x03E5;
	byte mylives : 0x3B1388, 0x00A9;
	byte bosshp : 0x3B1388, 0x03ED;
	byte currentscreen : 0x3B1388, 0x0092;
	byte mycontroller : 0x3B1388, 0x0040;
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.inBossFight = 0;
	vars.currentBossRush = 0;
	vars.splitNumber = 0;
	vars.iknowimdead = 0;
}

start { 
	if (vars.splitNumber > 0) {
		print("--Starting, Reset vars!--");
		vars.inBossFight = 0;
		vars.currentBossRush = 0;
		vars.splitNumber = 0;
		vars.iknowimdead = 0;
	}
	if (old.currentscreen == 163 && current.currentscreen == 163 && old.mycontroller == 0 && current.mycontroller == 16) {
		print("--Here we go!");
		return true;
	}
}

update { 
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (current.myhp == null) {
		return false;
	}
	//print("--Current bosshp: " + current.bosshp + "\n--Current boss rush: " + vars.currentBossRush + "\n--Current split: " + vars.splitNumber + "\n--Current boss fight status: " + vars.inBossFight);
	//print("--info: " + current.bosshp);
}

split
{
	if (current.myhp > 127 && current.bosshp != 255 && vars.iknowimdead == 0) {
		vars.inBossFight = 0;
		vars.iknowimdead = 1;
		print("--You died!--");
		if (current.mylives == 0 || vars.splitNumber == 15) {
			vars.currentBossRush = 0;
			print("--You Gameovered and/or died during Wily Man!--");
		}		
	} else if (current.myhp <= 27) {
		vars.iknowimdead = 0;
	}
	if (vars.splitNumber < 14) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 27 && old.bosshp == 26) {
				print("--Starting boss " + (vars.splitNumber + 1) + "!--");
				vars.inBossFight = 1;				
			}
		} else {
			if (current.bosshp == 255) {
				vars.inBossFight = 0;
				vars.splitNumber++;
				print("--Yay " + vars.splitNumber + " boss dead!--");
				return true;
			}
		}
	} else if (vars.splitNumber == 14) {
		if (vars.inBossFight == 0) {
			if (current.bosshp == 27 && old.bosshp == 26) {
				print("--Starting boss rush boss " + (vars.currentBossRush + 1) + "!--");
				vars.inBossFight = 1;
			}
		} else {
			if (current.bosshp == 255) {
				vars.inBossFight = 0;
				vars.currentBossRush++;
				print("--Yay " + vars.currentBossRush + " boss(es) in rush is dead!--");
			}
		}
		if (vars.currentBossRush == 8) {
			print("--Yay ALL bosses in rush are dead!--");
			vars.splitNumber++;
			vars.currentBossRush = 0;
			return true;
		}
	} else if (vars.splitNumber == 15) {
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

startup
{
	settings.Add("DoesNothing", true, "Splits on boss kill, get used to it. Only works with FCEUX for now!");
	settings.SetToolTip("DoesNothing", "Pretty cool though, right?");
}
