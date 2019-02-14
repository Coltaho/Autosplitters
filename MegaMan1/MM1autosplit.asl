//Made by Coltaho 2/13/2019

state("fceux")
{
	byte bosshp : 0x436B04, 0x6C1;
	byte myhp : 0x436B04, 0x6A; //28 is max
	byte mylives : 0x436B04, 0xA6;
	byte soundfx : 0x436B04, 0xEF; //3 is common
	byte stage : 0x436B04, 0x31; //10 is start/gameover screen
	byte orb : 0x436B04, 0x501; //158 after orb grab/wily stages last boss kill
	byte timer : 0x436B04, 0x3C; //Timer that tends to decrement waiting for animations
	byte xpos : 0x436B04, 0x22;
	byte bossid : 0x436B04, 0xAC; //10 is last wily phase
}

state("nestopia")
{
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x729;
	byte myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xD2;
	byte mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x10E;
	byte soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x157;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x99;
	byte orb : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x569;
	byte timer : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA4;
	byte xpos : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8A;
}

startup
{
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 1 Autosplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Netstopia (maybe)", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
}

start {
	if (current.stage == 10 && current.timer != 0) {
		print("--Starting--");
		return true;
	}
}

reset {
	if (current.stage == 10 && current.timer == 0 && current.xpos == 0) {
		print("--Resetting--");
		return true;
	}	
}

update {
	//print("--Stage: " + current.stage + " | Orb: " + current.orb + " | XPos: " + current.xpos + " | Timer: " + current.timer);
}

split
{
	if ((current.stage < 6 && current.orb == 158 && old.orb != 158) ||
	   (current.stage >= 6 && current.stage != 9 && (current.orb == 172 || current.orb == 158) && current.myhp > 0 && current.bosshp == 0 && old.bosshp > 0) ||
	   (current.stage == 9 && current.orb == 172 && current.myhp > 0 && current.bosshp == 0 && old.bosshp > 0 && current.bossid == 10)) {
		print("--Split--");
		return true;
	}	
}
