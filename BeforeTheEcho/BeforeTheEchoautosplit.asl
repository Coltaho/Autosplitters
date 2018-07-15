state("sequence") {}

startup {
	print("--Starting up!--");
    vars.scanTarget = new SigScanTarget(0, "?? B0 ?? ?? 00 00 00 00 00 00 00 00", String.Join(" ", Enumerable.Repeat("??", 204)), "FF FF FF FF");
//	AF", String.Join(" ", Enumerable.Repeat("??", 214)), "FF FF FF FF");
	refreshRate = 60;
	settings.Add("main", false, "Before the Echo Autosplitter v1.1 by Coltaho");
	settings.Add("main0", false, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.SetToolTip("main", "Pretty cool, right?");
}

init {
    var ptr = IntPtr.Zero;
	List<IntPtr> iList = new List<IntPtr>();
	vars.mypointers = iList;
	vars.foundsig = false;
	vars.currentpointer = IntPtr.Zero;
	print("--init!--");
	vars.FindOffsets = (Action<Process>)((proc) => 
		{
		ptr = IntPtr.Zero;
		foreach (var page in game.MemoryPages(true)) {
			var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
			//print("--baseaddress: " + page.BaseAddress);
			if (ptr == IntPtr.Zero) {
				ptr = scanner.Scan(vars.scanTarget);	
			} 
			if (ptr != IntPtr.Zero) {
				foreach(IntPtr pointer in vars.mypointers) {
					if (ptr == pointer) {
						print("--Already attempted with this pointer: " + ptr);
						ptr = IntPtr.Zero;
						break;
					}
				}
				if (ptr != IntPtr.Zero) {
					print("--Bingo! Base address: " + (int)page.BaseAddress);
					vars.currentpointer = ptr;
					break;
				}
			}
		}

		if (ptr == IntPtr.Zero) {
			// Waiting for the game to have booted up. This is a pretty ugly work
			// around, but we don't really know when the game is booted or where the
			// struct will be, so to reduce the amount of searching we are doing, we
			// sleep a bit between every attempt.
			Thread.Sleep(1000);
			throw new Exception();
		} else {
			vars.ptr = ptr;
			vars.myhp = new MemoryWatcher<int>(ptr + 0x4); //my health
			vars.currentlevel = new MemoryWatcher<byte>(ptr + 0x1C); //current level
			vars.maxfloor = new MemoryWatcher<byte>(ptr + 0x134); //max floor unlocked
			vars.enemyhp = new MemoryWatcher<int>(ptr + 0x8); //enemy health
			vars.enemymaxhp = new MemoryWatcher<int>(ptr + 0x10); //enemy max health
			vars.scenetransition = new MemoryWatcher<byte>(ptr + 0x60); //unsure exactly but seems to go to 90 for a second when starting a new game
			
			vars.watchers = new MemoryWatcherList() {
				vars.myhp,
				vars.currentlevel,
				vars.maxfloor,
				vars.enemyhp,
				vars.enemymaxhp,
				vars.scenetransition
			};
		}
	});
	vars.FindOffsets(game);
}

update {
    vars.watchers.UpdateAll(game);
	print("--scene: " + vars.scenetransition.Current + " myhp: " + vars.myhp.Current + " enemyhp: " + vars.enemyhp.Current + " enemymaxhp: " + vars.enemymaxhp.Current + " maxfloor: " + vars.maxfloor.Current);
	if (vars.foundsig == false) {
		if ((vars.scenetransition.Current == 90 || vars.scenetransition.Current == 60) && vars.maxfloor.Current >= 0 && vars.maxfloor.Current <= 7 && vars.enemyhp.Current == 0 && vars.enemymaxhp.Current == 0) {
			print("--Signature should be good!");
			vars.foundsig = true;
		} else {
			print("--Let's find another offset!");
			vars.mypointers.Add(vars.currentpointer);
			vars.FindOffsets(game);
		}
	}
}

start {
    return (vars.scenetransition.Old == 90 && vars.scenetransition.Current == 240);
}

split {
	//Split if the max unlocked floor changes. It starts at 1 (but persists and changes on application load/save select)
	if ((vars.maxfloor.Old >= 1 && vars.maxfloor.Current >= 1) && (vars.maxfloor.Old != vars.maxfloor.Current)) {
		return true;
	}
	
	//Split if we are fighting Mir and he dies
	if (vars.enemyhp.Old > 0 && vars.enemyhp.Current == 0 && vars.enemymaxhp.Current == 250) {
		print("--You won the game!");
		return true;
	}
}
