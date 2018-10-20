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
	settings.Add("zel", true, "Zel?", "bosses");
	settings.Add("cantoran", true, "Cantoran", "bosses");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Timespinner Autosplitter v1.0 by Coltaho", "infosection");
  	settings.Add("info0", true, "Currently only splits on bosses (no start)", "infosection");
	settings.Add("info1", true, "Supports Timespinner v1.022", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
}

init {
    vars.scanTarget = new SigScanTarget(0, "3C 01 ", String.Join(" ", Enumerable.Repeat("??", 129)), " 80");

    IntPtr ptr = IntPtr.Zero;
    foreach (var page in game.MemoryPages()) {
    	var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
		ptr = scanner.Scan(vars.scanTarget);
		var c = (int)ptr & 0x0000000F;
		if (ptr != IntPtr.Zero && c == 12) {
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
    //vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer((vars.voxelse + 0x78), 0x34, 0x4, 0x8, 0x54, 0x54, 0x8, 0x18, 0x26C)) { Name = "enemy2hp" });
	
    vars.Current = (Func<string, int, bool>)((name, value) =>
    {
        return vars.watchers[name].Current == value;
    });
	
    vars.Killed = (Func<bool>)(() =>
    {
        return vars.watchers["enemy1dead"].Old == false && vars.watchers["enemy1dead"].Current == true;
    });
	
    vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
    {
        var splits = new Dictionary<string, bool>
        {
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
            { "cantoran", vars.Current("enemy1id", 61) && vars.Killed() }
        };
		return splits;
    });

    refreshRate = 60;
}

update {
    vars.watchers.UpdateAll(game);
    print("--Enemy1 Health: " + vars.watchers["enemy1hp"].Current + " | Enemy1 ID: " + vars.watchers["enemy1id"].Current + " | Enemy1 Dead: " + vars.watchers["enemy1dead"].Current + " | isKilled?: " + vars.Killed());
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
