//Made by Coltaho 2/19/2019

state("fceux")
{
	byte enemyhp : 0x436B04, 0x4FF;
	byte secondenemyhp : 0x436B04, 0x4FE; //used for gemini
	byte enemyid : 0x436B04, 0x4DF; //Number the enemy appears in the stage, 255 if despawned
	byte secondenemyid : 0x436B04, 0x4DE;
	// byte enemyidbreakman : 0x436B04, 0x4D2; //breakman is 12 in this slot whyyyy
	byte myhp : 0x436B04, 0xA2; //128 is dead (disregards high bit)
	byte soundfx : 0x436B04, 0x702; //58 is teleport
	byte stage : 0x436B04, 0x22;
	// byte xpos : 0x436B04, 0x22;
	byte screen : 0x436B04, 0xCB; //1 on intro screen
}

state("nestopia")
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte enemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x567;
	byte secondenemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x566;
	byte enemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x547;
	byte secondenemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x546;
	// byte enemyidbreakman : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x53A;
	byte myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x10A;
	byte soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x88;
	// byte xpos : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8A;
	byte screen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x133;
}

startup
{
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 3 Autosplitter v1.2 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Netstopia (maybe)", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	vars.waiting = false;
	vars.splitboss = false;
	refreshRate = 60;
}

start {
	if (current.screen == 3 && old.screen == 1) {
		print("--Starting--");
		return true;
	}
}

reset {
	if (current.screen == 1) {
		print("--Resetting--");
		return true;
	}	
}

update {
	print("--Stage: " + current.stage + " | Enemy: " + current.enemyid + " | Second Enemy: " + current.secondenemyid + " | SFX: " + current.soundfx + " | Splitboss: " + vars.splitboss + " | Waiting: " + vars.waiting);
	
	if (current.screen == 1 || current.myhp == 128 || current.enemyhp == 31) {
			vars.waiting = false;
	}
	
	
	if ((current.enemyid == 35 && current.stage == 1) || (current.enemyid == 39 && current.stage == 3) ||
		(current.enemyid == 45 && current.stage == 4) || (current.enemyid == 45 && current.stage == 7) || 
		(current.enemyid == 30 && current.stage == 0) || (current.enemyid == 74 && current.stage == 5) || 
		(current.enemyid == 40 && current.stage == 6) || (current.enemyid == 53 && current.stage == 11) ||
		(current.enemyid == 61 && current.stage == 9) || (current.enemyid == 62 && current.stage == 8) ||
		(current.enemyid == 36 && current.stage == 10) || (current.enemyid == 35 && current.stage == 13) ||
		(current.enemyid == 44 && current.stage == 14) || (current.enemyid == 4 && current.stage == 16)){
		vars.splitboss = true;
	} else {
		vars.splitboss = false;
	}
	
	if (!vars.waiting && vars.splitboss && current.myhp > 128 && current.enemyhp == 0 && old.soundfx != 58) {
		print("--Waiting for sound cue--");
		vars.waiting = true;
	}
	
	if (!vars.waiting && current.enemyid == 60 && current.stage == 2 && current.myhp > 128 && ((current.enemyhp == 0 && current.secondenemyhp == 14) || (current.enemyhp == 14 && current.secondenemyhp == 0))) {
		print("--Stupid Gemini... Waiting for sound cue--");
		vars.waiting = true;
	}
	
	if (!vars.waiting && current.stage == 12 && old.secondenemyid == 33 && current.secondenemyid == 255 && current.myhp > 128 && old.soundfx != 58) {
		print("--Stupid turtles... Waiting for sound cue--");
		vars.waiting = true;
	}
	
	if (!vars.waiting && current.stage == 17 && current.enemyid == 7 && old.enemyhp == 0 && current.enemyhp == 28) {
		print("--Stupid Gamma engaged... Waiting for kill--");
		vars.waiting = true;
	}
}

split
{
	if (vars.waiting && current.stage < 8 && old.soundfx == 42 && current.soundfx == 58) {
		vars.waiting = false;
		print("--Split 8 Robos--");
		return true;
	}
	
	if (vars.waiting && current.stage >= 8 && old.soundfx == 43 && current.soundfx == 58) {
		vars.waiting = false;
		print("--Split past 8 Robos--");
		return true;
	}
	
	if ((old.stage == 15 || old.stage == 3) && current.stage == 22) {
		print("--Breakman or Refight Split--");
		return true;
	}
	
	if (vars.waiting && current.stage == 17 && current.enemyid == 7 && current.myhp > 128 && current.enemyhp == 0) {
		vars.waiting = false;
		print("--Gamma killed! Game beaten!--");
		return true;
	}
}
