//Made by Coltaho 2/7/2025

state("Brave Escape"){}

startup {
	print("--[Autosplitter] Starting up!");
	
	settings.Add("scriptsection", true, "---Script Options---");
	settings.Add("debug", false, "Print Debug Info", "scriptsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Brave Escape AutoSplitter v1.0 by Coltaho", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init {
	print("--[Autosplitter] Setting init variables!");
	
	vars.myBaseAddress = IntPtr.Zero;	
	vars.watchersInitialized = false;
	vars.tokenSource = new CancellationTokenSource();	
	
	vars.initializeWatchers = (Func<bool>)(() =>
	{
		vars.watchers = new MemoryWatcherList() {
			new MemoryWatcher<int>(vars.myBaseAddress + 0) { Name = "magicnumber" },					
			new MemoryWatcher<int>(vars.myBaseAddress + 4) { Name = "caveindex" },
			new MemoryWatcher<int>(vars.myBaseAddress + 8) { Name = "levelindex" },
			new MemoryWatcher<long>(vars.myBaseAddress + 24) { Name = "totaltime" },
			new MemoryWatcher<byte>(vars.myBaseAddress + 32) { Name = "iscompletable" },
			new MemoryWatcher<byte>(vars.myBaseAddress + 35) { Name = "inmenu" }
		};

		vars.watchersInitialized = true;
		print("--[Autosplitter] Watchers Initialized!");
		return true;
	});
				
	
	vars.threadScan = new Thread(() => {
		print("--[Autosplitter] Starting Thread Scan...");

		while(!vars.tokenSource.IsCancellationRequested) {
			print("--[Autosplitter] Scanning memory");
			
			vars.scanTarget = new SigScanTarget(0, "D8 25 8D 57 00 00 00 00");

			foreach (var page in game.MemoryPages()) {
				var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
				vars.myBaseAddress = scanner.Scan(vars.scanTarget);		
				if (vars.myBaseAddress != IntPtr.Zero) {
					break;
				}
			}
			
			if(vars.myBaseAddress != IntPtr.Zero) {
				print("--Magic Number Address: " + ((long)vars.myBaseAddress).ToString("X"));
				vars.initializeWatchers();
			}
			
			if(vars.watchersInitialized) {
				break;
			}

			print("--[Autosplitter] Couldn't find Magic Number! Game is still starting or an update broke things!");
			Thread.Sleep(2000);
		}
		print("--[Autosplitter] Exited Thread Scan");
	});
	
	vars.threadScan.Start();

	vars.mystring = "";
	vars.paststring = "";
}

update {
	
	if(!vars.watchersInitialized) {
        return false;
    }
	
	vars.watchers.UpdateAll(game);
	
	if (settings["debug"]) {
		vars.mystring = "--[Autosplitter] MagicNumber: " + vars.watchers["magicnumber"].Current + " | CaveIndex: " + vars.watchers["caveindex"].Current + " | LevelIndex: " + vars.watchers["levelindex"].Current + " | iscompletable: " + vars.watchers["iscompletable"].Current + " | inmenu: " + vars.watchers["inmenu"].Current;
		if (vars.paststring != vars.mystring) {
			print(vars.mystring);
			vars.paststring = vars.mystring;
		}
	}
}

start {	
	if (vars.watchers["levelindex"].Old == 0 && vars.watchers["levelindex"].Current == 1) {	
		print("--[Autosplitter] Go!");
		return true;
	}
}

reset {
	if (vars.watchers["inmenu"].Current == 1) {
		print("--[Autosplitter] Reset!");
		return true;
	}
}

split {
	if (vars.watchers["iscompletable"].Current == 1 && (vars.watchers["levelindex"].Old != vars.watchers["levelindex"].Current)) {	
		print("--[Autosplitter] Split!");
		return true;
	}
}

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromTicks(vars.watchers["totaltime"].Current);
}

exit {
	vars.tokenSource.Cancel();
}

shutdown {
	vars.tokenSource.Cancel();
}