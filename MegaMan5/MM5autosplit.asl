//Made by Coltaho 3/3/2019

state("fceux")
{
	byte enemyhp : 0x436B04, 0x458;
	byte enemyid : 0x436B04, 0x440; //Number the enemy appears in the stage, 255 if despawned
	byte myhp : 0x436B04, 0xB0; //128 is dead (disregards high bit)
	byte soundfx : 0x436B04, 0x702; //68 to 66 is teleport
	byte stage : 0x436B04, 0x26; //goes 0 at reset then to 16 during intro
	byte screenassets : 0x436B04, 0x611; // 0 if on start screen
	byte otherscreenassets : 0x436B04, 0x18B;
	byte selection : 0x436B04, 0x200; //151 on Game Start
	byte levelscreen : 0x436B04, 0xF9; //actual screen num in stage
	byte controller : 0x436B04, 0x16; //controller 1 inputs held
	int timer : 0x436B04, 0x10; //timer for things
}

state("nestopia")
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte enemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4C0;
	byte enemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4A8;
	byte myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x118;
	byte soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8C;
	byte screenassets : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x679;
	byte otherscreenassets : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x1F3;
	byte selection : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x268;
	byte levelscreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x161;
	byte controller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x7E;
	int timer : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x78;
}

startup
{
	settings.Add("optionsection", true, "---Options---");
	settings.Add("darkfade", true, "Split at initial fade out after Dark 4", "optionsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 5 Autosplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Netstopia (maybe)", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
}

start {
	if (old.screenassets == 0 && current.screenassets == 15 && old.otherscreenassets == 255 && current.otherscreenassets <= 4 && current.controller > 0) {
		print("--Starting--");
		return true;
	}
}

reset {
	if ((old.timer != 0 && current.timer == 0)) {
		print("--Resetting--");
		return true;
	}
}

update {
	print("--screenassets: " + current.screenassets + " | otherscreenassets: " + current.otherscreenassets + " | Timer: " + current.timer + " | SFX: " + current.soundfx);
}

split
{
	if (old.soundfx == 68 && current.soundfx == 66) {
		print("--Teleport Split--");
		return true;
	}
	
	if (settings["darkfade"] && current.stage == 11 && old.levelscreen == 3 && current.levelscreen == 0 && current.myhp > 128) {
		print("--Dark 4 Split--");
		return true;
	}
	
	if (current.stage == 15 && current.levelscreen == 7 && old.enemyid == 255 && old.enemyhp > 0 && current.enemyhp == 0 && current.myhp > 128) {
		print("--Wily Capsule Dead Split! Game Beaten!--");
		return true;
	}
}
