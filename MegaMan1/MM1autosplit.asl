//Made by Coltaho 2/13/2019
//added Mesen and MesenRTA support ~Aurel

state("fceux", "v2.2.3")
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

state("fceux", "v2.6.4")
{
	byte bosshp : 0x3DA4EC, 0x6C1;
	byte myhp : 0x3DA4EC, 0x6A; //28 is max
	byte mylives : 0x3DA4EC, 0xA6;
	byte soundfx : 0x3DA4EC, 0xEF; //3 is common
	byte stage : 0x3DA4EC, 0x31; //10 is start/gameover screen
	byte orb : 0x3DA4EC, 0x501; //158 after orb grab/wily stages last boss kill
	byte timer : 0x3DA4EC, 0x3C; //Timer that tends to decrement waiting for animations
	byte xpos : 0x3DA4EC, 0x22;
	byte bossid : 0x3DA4EC, 0xAC; //10 is last wily phase
}

//MesenRTA
state("Mesen", "0.0.7")
{
	byte bosshp : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x6C1;
	byte myhp : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x6A;
	byte mylives : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0xA6;
	byte soundfx : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0xEF;
	byte stage : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x31;
	byte orb : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x501;
	byte timer : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x3C;
	byte xpos : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0x22;
	byte bossid : "MesenCore.dll", 0x42F99D0, 0xB8, 0x58, 0xAC;
}

//Regular Mesen
state("Mesen", "0.9.9")
{
	byte bosshp : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x6C1;
	byte myhp : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x6A;
	byte mylives : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0xA6;
	byte soundfx : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0xEF;
	byte stage : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x31;
	byte orb : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x501;
	byte timer : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x3C;
	byte xpos : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0x22;
	byte bossid : "MesenCore.dll", 0x42E0F30, 0xB8, 0x58, 0xAC;
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
	byte bossid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x114;
}

startup
{
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 1 Autosplitter v1.1 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Nestopia (untested), Mesen and MesenRTA", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
	
	if (modules.First().ModuleMemorySize == 0x487000)
        version = "v2.2.3";
    else if (modules.First().ModuleMemorySize == 0x603000)
        version = "v2.6.4";
	

	if(game.ProcessName == "Mesen")
	{
		var coreDLL = Array.Find(modules, x => x.ModuleName == "MesenCore.dll");
		if (coreDLL == null)
		{
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
