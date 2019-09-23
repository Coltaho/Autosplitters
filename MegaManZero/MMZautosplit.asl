//Made by Coltaho 8/25/2019

state("EmuHawk"){}

startup {	
	refreshRate = 1;

	settings.Add("options", true, "---Options---");
	settings.Add("missiontimer", false, "Show Mission Timer", "options");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man Zero AutoSplitter v1.1 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : Win7 or Win10 Bizhawk with VBA-Next Core", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	vars.findpointers = (Action<Process, int>)((proc, mymodulesize) => {
		print("--Scanning for pointers!--");
		
		vars.baseptr = IntPtr.Zero;
		vars.ewram = IntPtr.Zero;
		vars.scantest = new SigScanTarget[4];
		
		vars.scantest[0] = new SigScanTarget(38, "448B41104489442438488BCA488D5424404C8D442428E8");
		vars.scantest[1] = new SigScanTarget(5, "83EC2048B9????????????????488B0949BB????????????????390941FF13488BF0488BCEE8");
		vars.scantest[2] = new SigScanTarget(9, "488B00E9????????BA????????488B1248B9????????????????E8????????488BC849BB");
		vars.scantest[3] = new SigScanTarget(4, "488BF8BA????????488B124885D20F84");
		vars.ptr = IntPtr.Zero;

		for (int i = 0; i < 4; i++) {
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
	});
	
	vars.GetWatcherList = (Func<IntPtr, IntPtr, MemoryWatcherList>)((baseptr, ewram) =>
	{
		return new MemoryWatcherList
		{
			new MemoryWatcher<ulong>((IntPtr)baseptr) { Name = "baseptr" }, // 0x37F0C is sword xp, 0x37F0A is buster xp, 0x37F0E is chain, 0x37F10 is shield
			new MemoryWatcher<byte>((IntPtr)ewram + 0x2B62C) { Name = "myhp" },
			new MemoryWatcher<byte>((IntPtr)ewram + 0x23688) { Name = "menuselection" }, //0 for new game
			new MemoryWatcher<uint>((IntPtr)ewram + 0x23684) { Name = "start" }, // = 1284 to 1540 for starting, 261 while game in progress
			new MemoryWatcher<ushort>((IntPtr)ewram + 0x22CC4) { Name = "end" }, // = 65535 when control lost but for whole game, seems to be 111 during seraph X only?
			new MemoryWatcher<ushort>((IntPtr)ewram + 0x2A5D6) { Name = "scorescreen" }, // changed
			new MemoryWatcher<uint>((IntPtr)ewram + 0x22B28) { Name = "missiontimer" }
		};
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
	// print("--Menu Selection: " + vars.watchers["menuselection"].Current + " | End: " + vars.watchers["end"].Current + " | Scorescreen: " + vars.watchers["scorescreen"].Current + " | HP: " + vars.watchers["myhp"].Current);
}

start { 
	return (vars.watchers["menuselection"].Old == 0 && vars.watchers["start"].Old == 1284 && vars.watchers["start"].Current == 1540);
}

reset { 
	return (vars.watchers["start"].Old > 1 && vars.watchers["start"].Current == 1);
}

split {
	return (vars.watchers["scorescreen"].Changed && vars.watchers["scorescreen"].Current != 0) || (vars.watchers["myhp"].Current > 0 && vars.watchers["end"].Old == 111 && vars.watchers["end"].Current == 65535);
}
