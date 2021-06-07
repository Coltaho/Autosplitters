state("Astalon") {
	ulong igt : "GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0x94;
	bool mainmenuopen : "GameAssembly.dll", 0x01D17EC4, 0x5C, 0x0, 0x10, 0xC;
	int currentroom : "GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xA0;
}

startup {
	print("--Starting up!--");
	
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
	vars.bosswatchers = new MemoryWatcherList();
	// vars.bosswatchers.Add(new MemoryWatcher<int>(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0xC)) { Name = "test" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x10, 0xC), 16) { Name = "boss0" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x14, 0xC), 16) { Name = "boss1" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x18, 0xC), 16) { Name = "boss2" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x1C, 0xC), 16) { Name = "boss3" });
	vars.bosswatchers.Add(new StringWatcher(new DeepPointer("GameAssembly.dll", 0x1D17FF0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, 0x20, 0xC), 16) { Name = "boss4" });
	
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
		return old.currentroom == prev && current.currentroom == value;
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
}

update {
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0)
		vars.pastSplits.Clear();
	
	vars.bosswatchers.UpdateAll(game);
	// vars.itemwatchers.UpdateAll(game);
	// print("--MainMenuOpen: " + current.mainmenuopen + " | IGT: " + current.igt + " | CurrentRoom: " + current.currentroom + " | Boss0: " + vars.bosswatchers["boss0"].Current);
}

start {
	if(old.igt == 0 && current.igt == 1) {
		return true;
	}
}

reset {
	return (current.mainmenuopen);
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
	return TimeSpan.FromSeconds(current.igt);
}

shutdown {
	timer.OnStart -= vars.timer_OnStart;
}
