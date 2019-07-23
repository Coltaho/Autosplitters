//Made by Coltaho 7/6/2019

state("EmuHawk"){}

startup {	
	refreshRate = 1;

	settings.Add("options", true, "---Options---");
	settings.Add("missiontimer", false, "Show Mission Timer", "options");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man Zero 3 AutoSplitter v1.5 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : Win7 or Win10 Bizhawk with VBA-Next Core", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	vars.findpointers = (Action<Process, int>)((proc, mymodulesize) => {
		print("--Scanning for pointers!--");
		
		vars.baseptr = IntPtr.Zero;
		vars.ewram = IntPtr.Zero;
		vars.scantest = new SigScanTarget[3];
		vars.us = false;
		
		vars.scantest[0] = new SigScanTarget(5, "83EC2048B9????????????????488B0949BB????????????????390941FF13488BF0488BCEE8");
		vars.scantest[1] = new SigScanTarget(9, "488B00E9????????BA????????488B1248B9????????????????E8????????488BC849BB");
		vars.scantest[2] = new SigScanTarget(4, "488BF8BA????????488B124885D20F84");
		vars.ptr = IntPtr.Zero;

		for (int i = 0; i < 3; i++) {
			print("--Searching for Window OS Signatures index: " + i);
			foreach (var page in proc.MemoryPages()) {
				var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);		
				if(vars.ptr == IntPtr.Zero && ((vars.ptr = scanner.Scan(vars.scantest[i])) != IntPtr.Zero)) {
					print("--Ptr Found : " + (vars.ptr).ToString("X"));
					break;
				}
			}
			if (vars.ptr != IntPtr.Zero) {
				break;
			}
		}
		
		if (vars.ptr == IntPtr.Zero)
			throw new Exception("--Couldn't find a pointer I want! GBA Core probably not loaded!");
		
		List<int> offsets = new List<int> { 0x0, 0x70, 0x8, 0x8, 0x18, 0x28 };
		
		vars.ewram = proc.ReadValue<ulong>((IntPtr)vars.ptr);
		vars.baseptr = vars.ewram;
		print("--Base Ptr: " + (vars.ewram).ToString("X"));
		
		foreach	(int offset in offsets) {
			vars.ewram = proc.ReadValue<ulong>((IntPtr)vars.ewram + offset);
			print("--Offset " + offset.ToString("X") + " value: " + vars.ewram.ToString("X"));
		}
		
		if (proc.ReadValue<uint>((IntPtr)vars.ewram + 0x30904) == 0) {
			print("--Looks like US ROM--");
			vars.us = true;
		}
	});
	
	vars.GetWatcherList = (Func<IntPtr, IntPtr, MemoryWatcherList>)((baseptr, ewram) =>	{
		if (vars.us) {
			//US addresses
			return new MemoryWatcherList
			{
				new MemoryWatcher<ulong>((IntPtr)baseptr) { Name = "baseptr" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x38044) { Name = "myhp" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x3BE44) { Name = "bosshp" },
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x3BE38) { Name = "bossid" }, // 54945 for omega zero
				new MemoryWatcher<byte>((IntPtr)ewram + 0x30E78) { Name = "menuselection" }, //0 for new game
				new MemoryWatcher<uint>((IntPtr)ewram + 0x30C44) { Name = "start" }, // = 328452
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x372BA) { Name = "scorescreen" }, // changed
				new MemoryWatcher<uint>((IntPtr)ewram + 0x30168) { Name = "missiontimer" }
			};
		} else {
			//JP addresses
			return new MemoryWatcherList
			{
				new MemoryWatcher<ulong>((IntPtr)baseptr) { Name = "baseptr" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x37D04) { Name = "myhp" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x3BB04) { Name = "bosshp" },
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x3BAF8) { Name = "bossid" }, // 55001 for omega zero
				new MemoryWatcher<byte>((IntPtr)ewram + 0x30B38) { Name = "menuselection" }, //0 for new game
				new MemoryWatcher<uint>((IntPtr)ewram + 0x30904) { Name = "start" }, // = 328452
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x36F7A) { Name = "scorescreen" }, // changed
				new MemoryWatcher<uint>((IntPtr)ewram + 0x2FE28) { Name = "missiontimer" }
			};
		}
	});
	
	vars.UpdateRoomTimer = (Action<Process>)((proc) => {
        if(vars.textSettingMissionTimer == null) {
            foreach (dynamic component in timer.Layout.Components) {
                if (component.GetType().Name != "TextComponent") continue;
                if (component.Settings.Text1 == "Mission Timer") vars.textSettingMissionTimer = component.Settings;
            }

            if(vars.textSettingMissionTimer == null)
                vars.textSettingMissionTimer = vars.CreateTextComponent("Mission Timer");
        }
        vars.textSettingMissionTimer.Text2 = vars.FormatTimer(vars.watchers["missiontimer"].Current);       
    });
	
	vars.CreateTextComponent = (Func<string, dynamic>)((name) => {
        var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
        dynamic textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
        timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
        textComponent.Settings.Text1 = name;
        return textComponent.Settings;
    });
	
	vars.FormatTimer = (Func<uint, string>)((frames) => {
        return (frames / 60 / 60 % 60).ToString("D2") + "'" + (frames / 60 % 60).ToString("D2");
    });
}

init {
	print("--Setting init variables!--");

	vars.baseptr = IntPtr.Zero;
	vars.ewram = IntPtr.Zero;
	vars.watchers = new MemoryWatcherList();
	vars.textSettingMissionTimer = null;
	
	vars.findpointers(game, modules.First().ModuleMemorySize);
	vars.watchers = vars.GetWatcherList((IntPtr)vars.baseptr, (IntPtr)vars.ewram);
	
	refreshRate = 60;
}

update {
	vars.watchers.UpdateAll(game);
	if(settings["missiontimer"]) vars.UpdateRoomTimer(game);
	if (vars.watchers["baseptr"].Changed || vars.watchers["baseptr"].Current == 0) {
		print("--Base ptr changed to: " + vars.watchers["baseptr"].Current.ToString("X"));
		vars.findpointers(game, modules.First().ModuleMemorySize);
		vars.watchers = vars.GetWatcherList((IntPtr)vars.baseptr, (IntPtr)vars.ewram);
	}
	// print("--Start: " + vars.watchers["start"].Current + " | Scorescreen: " + vars.watchers["scorescreen"].Current + " | HP: " + vars.watchers["myhp"].Current + " | BossHP: " + vars.watchers["bosshp"].Current + " | BossID: " + vars.watchers["bossid"].Current);
}

start { 
	return (vars.watchers["menuselection"].Current == 0 && vars.watchers["start"].Current == 328452);
}

reset { 
	return vars.watchers["start"].Current == 262916 || vars.watchers["start"].Current == 512 || vars.watchers["start"].Current == 1280 || vars.watchers["start"].Current == 66308;
}

split {
	return (vars.watchers["scorescreen"].Changed && vars.watchers["scorescreen"].Current != 0) || (vars.watchers["bosshp"].Old > 0 && vars.watchers["bosshp"].Current == 0 && (vars.watchers["bossid"].Current == 54945 || vars.watchers["bossid"].Current == 55001) && vars.watchers["myhp"].Current > 0);
}
