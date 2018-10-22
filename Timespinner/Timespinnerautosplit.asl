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
	settings.Add("emperor", true, "Emperor", "bosses");
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
	settings.Add("doublejump", false, "Succubus Hairpin (Double Jump)", "relics");
	settings.Add("jewelrybox", false, "Jewelry Box", "relics");
	settings.Add("watermask", false, "Water Mask", "relics");
	settings.Add("gasmask", false, "Gas Mask", "relics");
	settings.Add("dash", false, "Talaria Attachment (Dash)", "relics");
	settings.Add("sash", false, "Celestial Sash", "relics");
	settings.Add("carda", false, "Security Card A", "relics");
	settings.Add("cardb", false, "Security Card B", "relics");
	settings.Add("cardc", false, "Security Card C", "relics");
	settings.Add("cardd", false, "Security Card D", "relics");
	settings.Add("cardv", false, "Library Card V", "relics");
	settings.Add("gear1", false, "Timespinner Gear 1 (Lab)", "relics");
	settings.Add("gear2", false, "Timespinner Gear 2 (Military Hangar)", "relics");
	settings.Add("gear3", false, "Timespinner Gear 3 (Sealed Caves)", "relics");
	
	settings.Add("location", true, "---Location Based Events---");
	settings.Add("firstpast", false, "First Past Transition", "location");
	settings.Add("anyend", true, "Any % End", "location");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Timespinner Autosplitter v1.3 by Coltaho", "infosection");
	settings.Add("info0", true, "Supports Timespinner v1.022", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	vars.timer_OnStart = (EventHandler)((s, e) =>
    {
        vars.itemwatchers.ResetAll();
    });
    timer.OnStart += vars.timer_OnStart;
}

init {
	vars.scanTarget = new SigScanTarget(0, "3C 01 ", String.Join(" ", Enumerable.Repeat("??", 129)), " 80");

	IntPtr ptr = IntPtr.Zero;
	foreach (var page in game.MemoryPages()) {
		var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
		ptr = scanner.Scan(vars.scanTarget);
		var c = (int)ptr & 0x0000000F;
		if (ptr != IntPtr.Zero && (c == 4 || c == 8 || c == 12)) {
			vars.voxelse = (int)ptr - (int)game.Modules[0].BaseAddress;
			break;
		}
	}
	
	if (ptr == IntPtr.Zero)
		throw new Exception("--Couldn't find what I want! Game is still starting or an update broke things!");
	
	print("--Base Pointer Address: " + ((int)ptr).ToString("X") + " | First module base: " + ((int)game.Modules[0].BaseAddress).ToString("X"));
	
	vars.watchers = new MemoryWatcherList();
	vars.itemwatchers = new MemoryWatcherList();
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x26C)) { Name = "enemy1hp" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x2D8)) { Name = "enemy1id" });
	vars.watchers.Add(new MemoryWatcher<bool>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x8, 0x363)) { Name = "enemy1dead" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0xE4)) { Name = "era" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0xE8)) { Name = "levelid" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x11C)) { Name = "roomid" });
	//vars.watchers.Add(new StringWatcher(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0xC, 0x68, 0x4, 0x8), 256) { Name = "toast" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x0, 0x4)) { Name = "screen0" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0xC, 0x0, 0x4)) { Name = "screen1" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x10, 0x0, 0x4)) { Name = "screen2" });
	vars.watchers.Add(new StringWatcher(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x70, 0x4, 0x8), 256) { Name = "dialogue" });
	for (int i = 0; i <= 16; i++) {
		var itemoffset = 0x8 + i * 0x10;
		vars.itemwatchers.Add(new StringWatcher(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x78, 0x28, 0x24, 0x4, 0x8, itemoffset, 0x4, 0x8), 256) { Name = "item" + i.ToString() });
	}

	
	vars.Current = (Func<string, int, bool>)((name, value) =>
	{
		return vars.watchers[name].Current == value;
	});
	
	vars.Obtained = (Func<string, bool>)((value) =>
	{
		for (int i = 0; i <= 16; i++) {
			var name = "item" + i.ToString();
			if (vars.itemwatchers[name].Old != value && vars.itemwatchers[name].Current == value)
				return true;
		}
		return false;
	});
	
	vars.Killed = (Func<bool>)(() =>
	{
		return vars.watchers["enemy1dead"].Old == false && vars.watchers["enemy1dead"].Current == true;
	});
	
	vars.Transitioned = (Func<string, int, int, bool>)((name, prev, value) =>
	{
		return vars.watchers[name].Old == prev && vars.watchers[name].Current == value;
	});
	
	vars.StringContains = (Func<string, string, bool>)((name, value) =>
	{
		return !vars.watchers[name].Old.ToString().Contains(value) && vars.watchers[name].Current.ToString().Contains(value);
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
			{ "emperor", vars.Current("enemy1id", 55) && vars.Killed() },
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
			
			//Location Change Events
			{ "firstpast", vars.Transitioned("roomid", 40, 28) },
			{ "anyend", vars.StringContains("dialogue", "No. I'll stay here") || vars.StringContains("dialogue", "Yes... With most of my clan gone") },
			
		};
		return splits;
	});

	refreshRate = 60;
	vars.newgameplus = false;
	vars.lastsplit = "";
	vars.pastSplits = new HashSet<string>();
}

update {
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0)
		vars.pastSplits.Clear();
	
	vars.watchers.UpdateAll(game);
	vars.itemwatchers.UpdateAll(game);
	print("--Last Split: " + vars.lastsplit + " | Split Hash Count: " + vars.pastSplits.Count + " | Era: " + vars.watchers["era"].Current + " | LevelID: " + vars.watchers["levelid"].Current + " | RoomID: " + vars.watchers["roomid"].Current + " | Screen1: " + vars.watchers["screen1"].Current + " | Screen2: " + vars.watchers["screen2"].Current + " | Dialogue: " + vars.watchers["dialogue"].Current);
}

start {
	if(vars.Transitioned("screen1", 312, 300)) {
		vars.newgameplus = true;
		return true;
	}
	if(vars.Transitioned("screen2", 312, 300)) {
		vars.newgameplus = false;
		return true;
	}
	return (false);
}

reset {
	return (vars.watchers["screen0"].Current == 604 && vars.watchers["screen0"].Old != 604);
}

split {	

	var splits = vars.GetSplitList();

	foreach (var split in splits)
	{
		if (vars.newgameplus && (split.Key == "soulscanner" || split.Key == "jewelrybox" || split.Key == "dash")) {
			//don't do anything
		} else if (settings[split.Key] && split.Value && !vars.pastSplits.Contains(split.Key))
		{
			vars.pastSplits.Add(split.Key);
			vars.lastsplit = split.Key;
			print("--[Autosplitter] Split: " + split.Key);
			return true;
		}
	}
}

shutdown {
	timer.OnStart -= vars.timer_OnStart;
}
