//Made by Coltaho 7/6/2019

state("EmuHawk"){}

startup
{	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man Zero 3 AutoSplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : Win10 Bizhawk with VBA-Next Core", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	vars.findpointers = (Action<Process, int>)((proc, mymodulesize) => {
		print("--Scanning for pointers!--");
		
		vars.baseptr = IntPtr.Zero;
		vars.ewram = IntPtr.Zero;
		vars.us = false;
		
		vars.scantest = new SigScanTarget(5, "83EC2048B9????????????????488B0949BB????????????????390941FF13488BF0488BCEE8");
		vars.ptr = IntPtr.Zero;

		foreach (var page in proc.MemoryPages()) {
			var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);		
			if(vars.ptr == IntPtr.Zero && ((vars.ptr = scanner.Scan(vars.scantest)) != IntPtr.Zero)) {
				print("--[Autosplitter] Ptr Found : " + (vars.ptr).ToString("X"));
				break;
			}
		}
		
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
	
	vars.GetWatcherList = (Func<IntPtr, IntPtr, MemoryWatcherList>)((baseptr, ewram) =>
	{
		if (vars.us) {
			//US addresses
			return new MemoryWatcherList
			{
				new MemoryWatcher<ulong>((IntPtr)baseptr) { Name = "baseptr" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x38044) { Name = "myhp" }, 
				new MemoryWatcher<byte>((IntPtr)ewram + 0x30E78) { Name = "menuselection" }, //0 for new game
				new MemoryWatcher<uint>((IntPtr)ewram + 0x30C44) { Name = "start" }, // = 328452       
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x372BA) { Name = "scorescreen" }, // changed   
				new MemoryWatcher<uint>((IntPtr)ewram + 0x3031C) { Name = "end" } // = 983060? actually 20?     
			};
		} else {
			//JP addresses
			return new MemoryWatcherList
			{
				new MemoryWatcher<ulong>((IntPtr)baseptr) { Name = "baseptr" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x37D04) { Name = "myhp" },
				new MemoryWatcher<byte>((IntPtr)ewram + 0x30B38) { Name = "menuselection" }, //0 for new game
				new MemoryWatcher<uint>((IntPtr)ewram + 0x30904) { Name = "start" }, // = 328452
				new MemoryWatcher<ushort>((IntPtr)ewram + 0x36F7A) { Name = "scorescreen" }, // changed
				new MemoryWatcher<uint>((IntPtr)ewram + 0x2FFDC) { Name = "end" } // = 20
			};
		}
	});
}

init
{
	print("--Setting init variables!--");

	vars.baseptr = IntPtr.Zero;
	vars.ewram = IntPtr.Zero;
	vars.watchers = new MemoryWatcherList();
	
	vars.findpointers(game, modules.First().ModuleMemorySize);
	vars.watchers = vars.GetWatcherList((IntPtr)vars.baseptr, (IntPtr)vars.ewram);
	
	refreshRate = 60;
}

update {
	vars.watchers.UpdateAll(game);
	if (vars.watchers["baseptr"].Changed || vars.watchers["baseptr"].Current == 0) {
		print("--Base ptr changed to: " + vars.watchers["baseptr"].Current.ToString("X"));
		vars.findpointers(game, modules.First().ModuleMemorySize);
		vars.watchers = vars.GetWatcherList((IntPtr)vars.baseptr, (IntPtr)vars.ewram);
	}
	print("--Start: " + vars.watchers["start"].Current + " | Scorescreen: " + vars.watchers["scorescreen"].Current + " | End: " + vars.watchers["end"].Current + " | HP: " + vars.watchers["myhp"].Current + " | Menu Selection: " + vars.watchers["menuselection"].Current);
}

start { 
	return (vars.watchers["menuselection"].Current == 0 && vars.watchers["start"].Current == 328452);
}

reset { 
	return vars.watchers["start"].Current == 262916 || vars.watchers["start"].Current == 512 || vars.watchers["start"].Current == 1280 || vars.watchers["start"].Current == 66308;
}

split
{
	return (vars.watchers["scorescreen"].Changed && vars.watchers["scorescreen"].Current != 0) || (vars.watchers["end"].Changed && vars.watchers["end"].Current == 20);
}
