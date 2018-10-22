state("Timespinner") {}

startup {
	print("--Starting up!--");
	refreshRate = 2;
	
	settings.Add("bosses", true, "---Bosses---");
	settings.Add("robokitty", true, "Robo Kitty", "bosses");
	settings.Add("varndagroth", true, "Eye Ball Varndagroth", "bosses");
	settings.Add("bird", true, "Big Bird", "bosses");
	settings.Add("incubus", true, "Incubus Twins", "bosses");
	settings.Add("aelana", true, "Aelana", "bosses");
	settings.Add("maw", true, "Maw Gateway", "bosses");
	settings.Add("genza", true, "Shapeshifter Genza", "bosses");
	settings.Add("emporor", true, "Emporor", "bosses");
	settings.Add("sandman", false, "Sandman", "bosses");
	settings.Add("nightmare", true, "Nightmare", "bosses");
	settings.Add("raven", false, "Raven Flock", "bosses");
	settings.Add("xarion", false, "Dead Bird Xarion", "bosses");
	settings.Add("zel", true, "Zel", "bosses");
	settings.Add("cantoran", true, "Cantoran", "bosses");
	
	settings.Add("relics", true, "---Relics---");
	settings.Add("wheel", false, "Timespinner Wheel (Timestop)", "relics");
	settings.Add("tablet", false, "Tablet", "relics");
	settings.Add("soulscanner", false, "Soul Scanner", "relics");
	settings.Add("elevatorcard", false, "Elevator Keycard", "relics");
	settings.Add("spindle", false, "Timespinner Spindle", "relics");
	settings.Add("pyramidkey", false, "Twin Pyramid Key", "relics");
	settings.Add("doublejump", false, "Succubus Hairpin", "relics");
	settings.Add("jewelrybox", false, "Jewelry Box", "relics");
	settings.Add("watermask", false, "Water Mask", "relics");
	settings.Add("gasmask", false, "Gas Mask", "relics");
	settings.Add("dash", false, "Talaria Attachment (Dash)", "relics");
	settings.Add("carda", false, "Security Card A", "relics");
	settings.Add("cardb", false, "Security Card B", "relics");
	settings.Add("cardc", false, "Security Card C", "relics");
	settings.Add("cardd", false, "Security Card D", "relics");
	settings.Add("cardv", false, "Library Card V", "relics");
	settings.Add("gear1", false, "Timespinner Gear 1", "relics");
	settings.Add("gear2", false, "Timespinner Gear 2", "relics");
	settings.Add("gear3", false, "Timespinner Gear 3", "relics");
	settings.Add("sash", false, "Celestial Sash", "relics");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Timespinner Autosplitter v1.1 by Coltaho", "infosection");
	settings.Add("info0", true, "Supports Timespinner v1.022", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
}

init {
	vars.scanTarget = new SigScanTarget(0, "3C 01 ", String.Join(" ", Enumerable.Repeat("??", 129)), " 80");

	IntPtr ptr = IntPtr.Zero;
	foreach (var page in game.MemoryPages()) {
		var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
		ptr = scanner.Scan(vars.scanTarget);
		var c = (int)ptr & 0x0000000F;
		if (ptr != IntPtr.Zero && (c == 12 || c == 4 || c == 8)) {
			vars.voxelse = (int)ptr - (int)game.Modules[0].BaseAddress;
			break;
		}
	}
	
	if (ptr == IntPtr.Zero)
		throw new Exception("--Couldn't find what I want! Game is still starting or an update broke things!");
	
	print("--Base Pointer Address: " + ((int)ptr).ToString("X") + " | First module base: " + ((int)game.Modules[0].BaseAddress).ToString("X"));
	
	vars.watchers = new MemoryWatcherList();
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x26C)) { Name = "enemy1hp" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x2D8)) { Name = "enemy1id" });
	vars.watchers.Add(new MemoryWatcher<bool>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x363)) { Name = "enemy1dead" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0xE4)) { Name = "era" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0xE8)) { Name = "levelid" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x11C)) { Name = "roomid" });
	vars.watchers.Add(new StringWatcher(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0xC, 0x68, 0x4, 0x8), 40) { Name = "toast" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x0, 0x4)) { Name = "screen0" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0xC, 0x0, 0x4)) { Name = "screen1" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x10, 0x0, 0x4)) { Name = "screen2" });

	
	vars.Current = (Func<string, int, bool>)((name, value) =>
	{
		return vars.watchers[name].Current == value;
	});
	
	vars.Obtained = (Func<string, bool>)((value) =>
	{
		return vars.watchers["toast"].Changed && vars.watchers["toast"].Current == value;
	});
	
	vars.Killed = (Func<bool>)(() =>
	{
		return vars.watchers["enemy1dead"].Old == false && vars.watchers["enemy1dead"].Current == true;
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{
			//Bosses
			{ "bird", vars.Current("enemy1id", 48) && vars.Killed() },
			{ "robokitty", vars.Current("enemy1id", 49) && vars.Killed() },
			{ "varndagroth", vars.Current("enemy1id", 50) && vars.Killed() },
			{ "aelana", vars.Current("enemy1id", 51) && vars.Killed() },
			{ "incubus", vars.Current("enemy1id", 52) && vars.Killed() },
			{ "maw", vars.Current("enemy1id", 53) && vars.Killed() },
			{ "genza", vars.Current("enemy1id", 54) && vars.Killed() },
			{ "emporor", vars.Current("enemy1id", 55) && vars.Killed() },
			{ "sandman", vars.Current("enemy1id", 56) && vars.Killed() },
			{ "nightmare", vars.Current("enemy1id", 57) && vars.Killed() },
			{ "raven", vars.Current("enemy1id", 58) && vars.Killed() },
			{ "xarion", vars.Current("enemy1id", 59) && vars.Killed() },
			{ "zel", vars.Current("enemy1id", 60) && vars.Killed() },
			{ "cantoran", vars.Current("enemy1id", 61) && vars.Killed() },
			
			//Relics
			{ "wheel", vars.Obtained("Timespinner Wheel") },
			{ "tablet", vars.Obtained("Tablet") },
			{ "soulscanner", vars.Obtained("Soul Scanner") },
			{ "elevatorcard", vars.Obtained("Elevator Keycard") },
			{ "spindle", vars.Obtained("Timespinner Spindle") },
			{ "pyramidkey", vars.Obtained("Twin Pyramid Key") },
			{ "doublejump", vars.Obtained("Succubus Hairpin") },
			{ "jewelrybox", vars.Obtained("Jewelry Box") },
			{ "watermask", vars.Obtained("Water Mask") },
			{ "gasmask", vars.Obtained("Gas Mask") },
			{ "dash", vars.Obtained("Talaria Attachment") },
			{ "carda", vars.Obtained("Security Keycard A") },
			{ "cardb", vars.Obtained("Security Keycard B") },
			{ "cardc", vars.Obtained("Security Keycard C") },
			{ "cardd", vars.Obtained("Security Keycard D") },
			{ "cardv", vars.Obtained("Library Keycard V") },
			{ "gear1", vars.Obtained("Timespinner Gear 1") },
			{ "gear2", vars.Obtained("Timespinner Gear 2") },
			{ "gear3", vars.Obtained("Timespinner Gear 3") },
			{ "sash", vars.Obtained("Celestial Sash") },
			
		};
		return splits;
	});

	refreshRate = 60;
}

update {
	vars.watchers.UpdateAll(game);
	print("--Era: " + vars.watchers["era"].Current + " | LevelID: " + vars.watchers["levelid"].Current + " | RoomID: " + vars.watchers["roomid"].Current);
}

start {
	return ((vars.watchers["screen1"].Current == 300 && vars.watchers["screen1"].Old == 312) || (vars.watchers["screen2"].Current == 300 && vars.watchers["screen2"].Old == 312));
}

reset {
	return (vars.watchers["screen0"].Current == 604 && vars.watchers["screen0"].Old != 604);
}

split {	

	var splits = vars.GetSplitList();

	foreach (var split in splits)
	{
		if (settings[split.Key] && split.Value)
		{
			print("--[Autosplitter] Split: " + split.Key);
			return true;
		}
	}
}
