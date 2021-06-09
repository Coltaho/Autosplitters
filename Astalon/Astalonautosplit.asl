state("Astalon") {}

startup {
	print("--Starting up!--");
	refreshRate = 2;
	
	settings.Add("bosses", true, "---Bosses---");
	settings.Add("tauros", true, "Tauros (Red Gem)", "bosses");
	settings.Add("volantis", true, "Volantis (Blue Gem)", "bosses");
	settings.Add("gemini", true, "Gemini", "bosses");
	settings.Add("solaria", true, "Solaria (Green Gem)", "bosses");
	settings.Add("medusa", true, "Medusa (Final Boss)", "bosses");
	
	settings.Add("items", true, "---Items---");
	settings.Add("testitem", false, "TestItem", "items");
	
	settings.Add("location", true, "---Location Based Events---");
	settings.Add("testloc", false, "TestLoc", "location");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Astalon Autosplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "Supports Astalon v1.0+", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	vars.timer_OnStart = (EventHandler)((s, e) =>
    {
        vars.bosswatchers.ResetAll();
    });
    timer.OnStart += vars.timer_OnStart;
}

init {	
	vars.scanTarget = new SigScanTarget(0, "A1 ???????? 83 C4 08 8B 40 5C 8B 00 85 C0 0F84 ???????? 8B 40 10 85 C0 0F84 ???????? 6A 00 50 E8 ???????? 83 C4 08 A1 ???????? 8B 40 5C 8B 30");

	vars.ptr = IntPtr.Zero;
	foreach (var module in modules) {
		if (module.ModuleName != "GameAssembly.dll")  continue;
		var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);
		vars.ptr = scanner.Scan(vars.scanTarget);
		if (vars.ptr != IntPtr.Zero) {			
			break;
		}
	}
	
	if (vars.ptr == IntPtr.Zero)
		throw new Exception("--Couldn't find a pointer I want! Game is still starting or an update broke things!");
	
	print("--Sig scan addr: " + ((int)vars.ptr).ToString("X"));
	
	vars.watchers = new MemoryWatcherList();
	vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(vars.ptr + 0x1, 0x0, 0x5C, 0x0, 0x10, 0xC)) { Name = "mainMenuOpen" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x94)) { Name = "igt" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xA0)) { Name = "currentRoom" });

	vars.bosswatchers = new MemoryWatcherList();
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x10, 0xC), 16) { Name = "boss0" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x14, 0xC), 16) { Name = "boss1" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x18, 0xC), 16) { Name = "boss2" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x1C, 0xC), 16) { Name = "boss3" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer(vars.ptr + 0x2C, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x20, 0xC), 16) { Name = "boss4" });
	
	// for (int i = 0; i <= 16; i++) {
		// var itemoffset = 0x8 + i * 0x10;
		// vars.itemwatchers.Add(new StringWatcher(new DeepPointer((vars.voxelse + 0x78), 0x38, 0x4, 0x8, 0x78, 0x28, 0x24, 0x4, 0x8, itemoffset, 0x4, 0x8), 256) { Name = "item" + i.ToString() });
	// }
	
	vars.Obtained = (Func<string, bool>)((value) =>
	{
		// for (int i = 0; i <= 16; i++) {
			// var name = "item" + i.ToString();
			// if (vars.itemwatchers[name].Old != value && vars.itemwatchers[name].Current == value)
				// return true;
		// }
		return false;
	});
	
	vars.Killed = (Func<string, bool>)((value) =>
	{
		for (int i = 0; i <= 4; i++) {
			var name = "boss" + i.ToString();
			if (vars.bosswatchers[name].Old != value && vars.bosswatchers[name].Current == value)
				return true;
		}
		return false;
	});
	
	vars.Transitioned = (Func<int, int, bool>)((prev, value) =>
	{
		return vars.watchers["currentRoom"].Current == prev && vars.watchers["currentRoom"].Current == value;
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{
			// Bosses
			{ "tauros", vars.Killed("Tauros") },
			{ "volantis", vars.Killed("Volantis") },
			{ "gemini", vars.Killed("Gemini") },
			{ "solaria", vars.Killed("Solaria") },
			{ "medusa", vars.Killed("Medusa") },
			
			// Items
			// { "wheel", vars.Obtained("Wheel") },
			
		};
		return splits;
	});
	
	vars.pastSplits = new HashSet<string>();
	vars.mystring = "";
	vars.paststring = "";
	refreshRate = 60;
}

update {
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0)
		vars.pastSplits.Clear();
	
	vars.bosswatchers.UpdateAll(game);
	vars.watchers.UpdateAll(game);
	
	// vars.mystring = "--MainMenuOpen: " + vars.watchers["mainMenuOpen"].Current + " | IGT: " + vars.watchers["igt"].Current + " | CurrentRoom: " + vars.watchers["currentRoom"].Current + " | Boss0: " + vars.bosswatchers["boss0"].Current;
	// if (vars.paststring != vars.mystring) {
		// print(vars.mystring);
		// vars.paststring = vars.mystring;
	// }
}

start {
	if(vars.watchers["igt"].Old == 0 && vars.watchers["igt"].Current == 1) {
		return true;
	}
}

reset {
	return (vars.watchers["mainMenuOpen"].Current);
}

split {	

	var splits = vars.GetSplitList();

	foreach (var split in splits)
	{
		if (settings[split.Key] && split.Value && !vars.pastSplits.Contains(split.Key))
		{
			vars.pastSplits.Add(split.Key);
			print("--[Autosplitter] Split: " + split.Key);
			return true;
		}
	}
}

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromSeconds(vars.watchers["igt"].Current);
}

shutdown {
	timer.OnStart -= vars.timer_OnStart;
}
