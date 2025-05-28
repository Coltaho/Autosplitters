//Made by Coltaho 6/23/2018
//Splits on boss kill, assumes boss rush is 1 split
//Updated by McBobX on 2/23/2023
//MesenRTA support added ~Aurel

state("fceux", "v2.2.3")
{
	byte bosshp : 0x436B04, 0x6C1;
	byte myhp : 0x436B04, 0x6C0;
	byte mylives : 0x436B04, 0xA8;
	byte mytitlescreen : 0x436B04, 0x04B0;
	byte mycontroller : 0x436B04, 0x0025;
	byte soundfx : 0x436B04, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte stage : 0x436B04, 0x2A; //12 is boss rush, 13 is alien
}

state("fceux", "v2.6.4")
{
	byte bosshp : 0x3DA4EC, 0x6C1;
	byte myhp : 0x3DA4EC, 0x6C0;
	byte mylives : 0x3DA4EC, 0xA8;
	byte mytitlescreen : 0x3DA4EC, 0x04B0;
	byte mycontroller : 0x3DA4EC, 0x0025;
	byte soundfx : 0x3DA4EC, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte stage : 0x3DA4EC, 0x2A; //12 is boss rush, 13 is alien
}

state("Mesen", "0.9.9")
{
	byte bosshp : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x6C1;
	byte myhp : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x6C0;
	byte mylives : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0xA8;
	byte mytitlescreen : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x04B0;
	byte mycontroller : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x0025;
	byte soundfx : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte stage : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x2A; //12 is boss rush, 13 is alien
}

state("Mesen", "0.0.7")
{
	byte bosshp : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x6C1;
	byte myhp : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x6C0;
	byte mylives : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0xA8;
	byte mytitlescreen : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x04B0;
	byte mycontroller : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x0025;
	byte soundfx : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte stage : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x2A; //12 is boss rush, 13 is alien
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
	byte soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x14a;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x92;
}

startup
{
	settings.Add("onteleport", true, "Split on teleport, instead of on boss kill");
	settings.Add("main", false, "Mega Man 2 AutoSplitter v1.7 by Coltaho");
	settings.Add("main0", false, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.Add("main1", false, "- Supported emulators : FCEUX, Nestopia, Mesen, MesenRTA", "main");
	settings.SetToolTip("main", "Pretty cool, right?");
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
	vars.bossrushdone = 0;
	
	if (modules.First().ModuleMemorySize == 0x487000)
        version = "v2.2.3";
    else if (modules.First().ModuleMemorySize == 0x603000)
        version = "v2.6.4";
	
	if(game.ProcessName == "Mesen")
	{
		var coreDLL = Array.Find(modules, x => x.ModuleName == "MesenCore.dll");
		if (coreDLL == null)
		{
			// This shouldn't happen...?
			print("MesenCore.dll isn't loaded?");
			throw new Exception("Couldn't find MesenCore.dll");
		}

		string hashStr;
		using (var sha1 = System.Security.Cryptography.SHA1.Create())
			using (var fs = File.OpenRead(coreDLL.FileName))
				hashStr = string.Concat(sha1.ComputeHash(fs).Select(b => b.ToString("X2")));

		switch (hashStr)
		{
			case "3D5571326AAF55B17663EE0D6C828D4D0782941A":
				print("Detected Mesen 0.9.9");
				version = "0.9.9";
				break;
			case "12BFF659191984F011E0F4FC5AC2900C929D5991":
				print("Detected MesenRTA 0.0.7");
				version = "0.0.7";
				break;
			default:
				print("Unrecognized Mesen version! SHA1 = " + hashStr);
				version = "";
				break;
		}
	}
}

start {
	if (((old.mytitlescreen == 119 && current.mytitlescreen == 119) || (old.mytitlescreen == 103 && current.mytitlescreen == 103)) && old.mycontroller == 0 && current.mycontroller == 8) {
		print("--Starting, Reset vars!--");
		vars.inBossFight = 0;
		vars.currentBossRush = 0;
		vars.splitNumber = 0;
		vars.iknowimdead = 0;
		vars.framecounter = 0;
		vars.bossrushdone = 0;
		print("--Here we go!");
		return true;
	}
}

update {
	// print("--Current myhp: " + current.myhp + " Current bosshp: " + current.bosshp + " --framecount: " + vars.framecounter + " --SoundFX: " + current.soundfx + " --incombat: " + vars.inBossFight);
}

split
{
	if (!settings["onteleport"]) { //old logic
		if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.iknowimdead == 0 && vars.framecounter <= 8) {
			vars.framecounter++;	//Accounts for a DKO by giving you 8 frames of leeway if you die before the boss does	
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
		if (current.stage < 12) {
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
		} else if (current.stage == 12) {
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
			if (vars.currentBossRush == 10 && vars.bossrushdone == 0) {
				print("--Yay ALL bosses in rush are dead!--");
				vars.bossrushdone = 1;
				return true;
			}
		} else if (current.stage == 13) {
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
	} else { //new logic
		if (old.soundfx == 0xF1 && current.soundfx == 0x35) {
			print("--Boss killed and teleported out!--");
			return true;
		}
		if (old.stage == 12 && current.stage == 13) {
			print("--Beat Wily Machine, moving to last stage!--");
			return true;
		}
		if (current.stage == 13) {
			if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.framecounter <= 8) {
				vars.framecounter++;	//Accounts for a DKO by giving you 8 frames of leeway if you die before the boss does	
			} else if (current.myhp == 0 && current.bosshp != 0 && vars.inBossFight == 1 && vars.framecounter > 8) {
				vars.inBossFight = 0;
				print("--You died!--");
			}
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
	}
	return;
}
