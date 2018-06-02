/** 
 * MM2autosplit_v1.2.asl - An ASL script for LiveSplit for the game Mega Man 2 (NES) using FCEUX. Nestopia NYI.
 * @author Coltaho
 * @version 1.2 on May 31st 2018
 * Splits on boss kill, assumes boss rush is 1 split
 */

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
	byte bosshp : 0x41AEC, 0x2C4, 0x6C1;
	byte myhp : 0xC1C8, 0x38, 0x568, 0x6C0;
	byte mylives : 0x41AEC, 0x2C4, 0xA8;
	byte mytitlescreen : 0x41AEC, 0x2C4, 0x04B0;
	byte mycontroller : 0x41AEC, 0x2C4, 0x0025;
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
	if (old.mytitlescreen == 119 && current.mytitlescreen == 119 && old.mycontroller == 0 && current.mycontroller == 8) {
		print("--Here we go!");
		return true;
	}
}

update { 
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (current.mytitlescreen == null) {
		return false;
	}
	//print("--Current bosshp: " + current.bosshp + "\n--Current boss rush: " + vars.currentBossRush + "\n--Current split: " + vars.splitNumber + "\n--Current boss fight status: " + vars.inBossFight);
	//print("--info: " + current.myhp);
}

split
{
	if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.iknowimdead == 0) {
		vars.inBossFight = 0;
		vars.iknowimdead = 1;
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
	settings.Add("DoesNothing", true, "Splits on boss kill, get used to it. Works only with FCEUX!");
	settings.SetToolTip("DoesNothing", "Pretty cool, right?");
}
