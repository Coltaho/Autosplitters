//Made by Coltaho 1/5/2022

state("emuhawk") {}
state("duckstation-qt-x64-ReleaseLTCG") {}
state("duckstation-nogui-x64-ReleaseLTCG") {}

startup {
	print("--[Autosplitter] Starting up!");
	
	settings.Add("finalevents", true, "---Final Events--(Leave on)---");
	settings.Add("chronoCross", true, "Chrono Cross Used", "finalevents");
	
	settings.Add("stars", true, "---Stars---");
	settings.Add("mamaKomodo", true, "Mama Komodo (1)", "stars");
	settings.Add("karshSP", true, "Karsh, S&P (2)", "stars");
	settings.Add("soltnpeppor3", true, "Solt & Peppor (3)", "stars");
	settings.Add("ketchop", true, "Ketchop (5)", "stars");
	settings.Add("neonbulbs", true, "Neo-N-Bulbs (6)", "stars");
	settings.Add("marcy", true, "Marcy (7)", "stars");
	settings.Add("lynx8", true, "Lynx (8)", "stars");
	settings.Add("fargo", true, "Fargo (10)", "stars");
	settings.Add("deadhead", true, "Dead Head (11)", "stars");
	settings.Add("3devas", true, "3 Devas (14)", "stars");
	settings.Add("giantgloop", true, "Giant Gloop (16)", "stars");
	settings.Add("taurusoid", true, "Taurusoid (17)", "stars");
	settings.Add("sunofagun", true, "Sun of a Gun (18)", "stars");
	settings.Add("bunyip", true, "Bunyip (19)", "stars");
	settings.Add("lynx21", true, "Lynx 2 (21)", "stars");
	settings.Add("radius", true, "Radius (22)", "stars");
	settings.Add("sage", true, "Sage (23)", "stars");
	settings.Add("garai", true, "Garai (24)", "stars");
	settings.Add("miguel", true, "Miguel (26)", "stars");
	settings.Add("roachester", true, "Roachester (27)", "stars");
	settings.Add("grobyc", true, "Grobyc (29)", "stars");
	settings.Add("earthdragon", true, "Earth Dragon (30)", "stars");
	settings.Add("waterdragon", true, "Water Dragon (31)", "stars");
	settings.Add("greendragon", true, "Green Dragon (33)", "stars");
	settings.Add("firedragon", true, "Fire Dragon (34)", "stars");
	settings.Add("skydragon", true, "Sky Dragon (35)", "stars");
	settings.Add("darkserge", true, "Dark Serge (36)", "stars");
	settings.Add("vitaunas", true, "Vita Unas (37)", "stars");
	settings.Add("fate", true, "Fate (37)", "stars");
	settings.Add("terrator", true, "Terrator (41)", "stars");
	settings.Add("pyrotor", true, "Pyrotor (42)", "stars");
	settings.Add("anemotor", true, "Anemotor (43)", "stars");
	settings.Add("aquator", true, "Aquator (46)", "stars");
	settings.Add("dragongod", true, "Dragon God (47)", "stars");
	
	settings.Add("nostars", true, "---No Stars---");
	settings.Add("soltnpeppor2nd", true, "Solt & Peppor 2", "nostars");
	settings.Add("dario", true, "Dario", "nostars");
	
	settings.Add("keyitems", true, "---Key Items---");
	settings.Add("teleporter", false, "Tele-Porter", "keyitems");
	settings.Add("sharktooth", false, "Shark Tooth", "keyitems");
	settings.Add("astralamulet", false, "Astral Amulet", "keyitems");
	settings.Add("greentinkler", false, "Green Tinkler", "keyitems");
	settings.Add("beebaflute", false, "Beeba Flute", "keyitems");
	settings.Add("einlanzer", false, "Einlanzer", "keyitems");
	settings.Add("icegun", false, "Ice Gun", "keyitems");
	settings.Add("icebreath", false, "Ice Breath", "keyitems");
	settings.Add("heckranbone", false, "Heckran Bone", "keyitems");
	settings.Add("bellflower", false, "Bellflower", "keyitems");
	settings.Add("bigegg", false, "Big Egg", "keyitems");
	settings.Add("heavyskull", false, "Heavy Skull", "keyitems");
	settings.Add("goodbackbone", false, "Good Backbone", "keyitems");
	settings.Add("sturdyribs", false, "Sturdy Ribs", "keyitems");
	settings.Add("pelvicbone", false, "Pelvic Bone", "keyitems");
	settings.Add("angryscapula", false, "Angry Scapula", "keyitems");
	settings.Add("mixedbones", false, "Mixed Bones", "keyitems");
	settings.Add("aromapouch", false, "Aroma Pouch", "keyitems");
	settings.Add("mushroom", false, "Mushroom", "keyitems");
	settings.Add("manorkey", false, "Manor Key", "keyitems");
	settings.Add("hydrahumour", false, "Hydra Humour", "keyitems");
	settings.Add("parlorkey", false, "Parlor Key", "keyitems");
	settings.Add("prisonkey", false, "Prison Key", "keyitems");
	settings.Add("dragontear", false, "Dragon Tear", "keyitems");
	settings.Add("whiterelic", false, "White Relic", "keyitems");
	settings.Add("blackrelic", false, "Black Relic", "keyitems");
	settings.Add("redrelic", false, "Red Relic", "keyitems");
	settings.Add("bluerelic", false, "Blue Relic", "keyitems");
	settings.Add("yellowrelic", false, "Yellow Relic", "keyitems");
	settings.Add("greenrelic", false, "Green Relic", "keyitems");
	settings.Add("lifesparkle", false, "Life Sparkle", "keyitems");
	settings.Add("komodoscale", false, "Komodo Scale", "keyitems");
	settings.Add("starfragment", true, "Star Fragment", "keyitems");	
	settings.Add("cardkey", false, "Card Key", "keyitems");
	settings.Add("explosive", false, "Explosive", "keyitems");
	settings.Add("tearofhate", false, "Tear of Hate", "keyitems");
	settings.Add("tearoflove", false, "Tear of Love", "keyitems");
	settings.Add("stationpass", false, "Station Pass", "keyitems");
	settings.Add("ancientfruit", false, "Ancient Fruit", "keyitems");
	settings.Add("mementopendant", false, "MementoPendant", "keyitems");
	settings.Add("handle", false, "Handle", "keyitems");
	settings.Add("garaikeepsake", false, "Garai Keepsake", "keyitems");
	settings.Add("decorshield", false, "Decor Shield", "keyitems");
	settings.Add("fiddlercrab", false, "Fiddler Crab", "keyitems");
	settings.Add("chronocross", false, "Chrono Cross", "keyitems");
	settings.Add("safetygear", false, "Safety Gear", "keyitems");
	settings.Add("sapphirebrooch", false, "SapphireBrooch", "keyitems");
	settings.Add("propsword", false, "Prop Sword", "keyitems");
	settings.Add("dragonemblem", false, "Dragon Emblem", "keyitems");
	settings.Add("bookofpoems", false, "Book of Poems", "keyitems");
	settings.Add("medicalbook", false, "Medical Book", "keyitems");
	settings.Add("herosmedal", false, "Hero's Medal", "keyitems");
	settings.Add("timeegg", false, "Time Egg", "keyitems");
	settings.Add("reliefcharm", false, "Relief Charm", "keyitems");
	settings.Add("timeshifter", false, "Time Shifter", "keyitems");
	settings.Add("smithspirit", false, "Smith Spirit", "keyitems");
	
	settings.Add("scriptsection", true, "---Script Options---");
	settings.Add("debug", false, "Print Debug Info", "scriptsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Chrono Cross AutoSplitter v1.0 by Coltaho", "infosection");
	settings.Add("info1", true, "- Autosplit: Bizhawk and Duckstation", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init {
	print("--[Autosplitter] Setting init variables!");
	
	vars.myBaseAddress = IntPtr.Zero;	
	vars.watchersInitialized = false;
	vars.tokenSource = new CancellationTokenSource();	
	
	vars.initializeWatchers = (Func<bool>)(() =>
	{
		vars.watchers = new MemoryWatcherList() {
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6B456)) { Name = "debug" },					
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x71C74)) { Name = "maxStars" },
			new MemoryWatcher<int>(new DeepPointer(vars.myBaseAddress + 0x6B48C)) { Name = "gameStart1" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x1D61AC)) { Name = "gameStart2" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0xDBDD8)) { Name = "enemy1HP" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6EBBE)) { Name = "groupID" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712D8)) { Name = "keyitems1" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712D9)) { Name = "keyitems2" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DA)) { Name = "keyitems3" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DB)) { Name = "keyitems4" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DC)) { Name = "keyitems5" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DD)) { Name = "keyitems6" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DE)) { Name = "keyitems7" },
			new MemoryWatcher<byte>(new DeepPointer(vars.myBaseAddress + 0x712DF)) { Name = "keyitems8" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6F30A)) { Name = "marcyMaxHP" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6EBDE)) { Name = "sergeMaxHP" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6FD66)) { Name = "harleMaxHP" },
			new MemoryWatcher<short>(new DeepPointer(vars.myBaseAddress + 0x6F172)) { Name = "karshMaxHP" }
		};

		vars.watchersInitialized = true;
		print("--[Autosplitter] Watchers Initialized!");
		return true;
	});
				
	
	vars.threadScan = new Thread(() => {
		print("--[Autosplitter] Starting Thread Scan...");
		var processName = game.ProcessName.ToLowerInvariant();		
		SignatureScanner gameAssemblyScanner = null;
		ProcessModuleWow64Safe gameAssemblyModule = null;

		//Scans for Bizhawk PS1 MainMem
		SigScanTarget gameScanTarget = new SigScanTarget(0x8, "49 03 c9 ff e1 48 8d 05 ?? ?? ?? ?? 48 89 02");
		IntPtr gameSigAddr = IntPtr.Zero;

		while(!vars.tokenSource.IsCancellationRequested) {
			if ((processName.Length > 10) && (processName.Substring(0, 11) == "duckstation")) {
				//gets base address of the first mem_mapped region of 0x200000 size
				foreach (var page in game.MemoryPages(true)) {
					if ((page.RegionSize != (UIntPtr)0x200000) || (page.Type != MemPageType.MEM_MAPPED))
						continue;
					vars.myBaseAddress = page.BaseAddress;
					break;
				}
				if (vars.myBaseAddress != IntPtr.Zero) {
					print("--[Autosplitter] Duckstation Memory BaseAddress: " + vars.myBaseAddress.ToString("X"));
					vars.initializeWatchers();
				}
			} else {
				if(gameAssemblyScanner == null) {
					ProcessModuleWow64Safe[] loadedModules = null;
					try {
						loadedModules = game.ModulesWow64Safe();
					} catch {
						loadedModules = new ProcessModuleWow64Safe[0];
					}

					gameAssemblyModule = loadedModules.FirstOrDefault(m => m.ModuleName == "octoshock.dll");
					if(gameAssemblyModule == null) {
						print("--[Autosplitter] Modules not initialized");
						Thread.Sleep(500);
						continue;
					}

					gameAssemblyScanner = new SignatureScanner(game, gameAssemblyModule.BaseAddress, gameAssemblyModule.ModuleMemorySize);
				}

				print("--[Autosplitter] Scanning memory");

				if(gameSigAddr == IntPtr.Zero && (gameSigAddr = gameAssemblyScanner.Scan(gameScanTarget)) != IntPtr.Zero) {					
					int offset = (int)((long)game.ReadValue<int>(gameSigAddr) + (long)gameSigAddr + 4 - (long)gameAssemblyModule.BaseAddress);
					print("--[Autosplitter] Bizhawk offset from module to Mem: " + offset.ToString("X"));
					vars.myBaseAddress = gameAssemblyModule.BaseAddress + offset;
					print("--[Autosplitter] Bizhawk Memory BaseAddress: " + vars.myBaseAddress.ToString("X"));
					vars.initializeWatchers();
				}
			}
			
			if(vars.watchersInitialized) {
				break;
			}

			print("--[Autosplitter] Couldn't find the pointers I want! Game is still starting or an update broke things!");
			Thread.Sleep(2000);
		}
		print("--[Autosplitter] Exited Thread Scan");
	});
	
	vars.threadScan.Start();
	
	vars.starObtained = (Func<int, bool>)((value) =>
	{
		return vars.watchers["maxStars"].Changed && vars.watchers["groupID"].Current == value;
	});
	
	vars.keyItemObtained = (Func<string, int, bool>)((name, value) =>
	{		
		return (vars.watchers[name].Current & value) > 0;
	});
	
	vars.noStarBoss = (Func<int, bool>)((value) =>
	{
		return  vars.watchers["groupID"].Current == value && (vars.watchers["marcyMaxHP"].Changed || vars.watchers["sergeMaxHP"].Changed || vars.watchers["harleMaxHP"].Changed || vars.watchers["karshMaxHP"].Changed);
	});
	
	vars.chronoCrossUsed = (Func<bool>)(() =>
	{
		return vars.watchers["enemy1HP"].Old == 30000 && vars.watchers["enemy1HP"].Current == 0;
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{
			// Star Bosses
			{ "mamaKomodo", vars.starObtained(389) },
			{ "karshSP", vars.starObtained(390) },
			{ "soltnpeppor3", vars.starObtained(393) },
			{ "ketchop", vars.starObtained(402) },
			{ "neonbulbs", vars.starObtained(406) },
			{ "marcy", vars.starObtained(407) },
			{ "lynx8", vars.starObtained(408) },
			{ "fargo", vars.starObtained(484) },
			{ "deadhead", vars.starObtained(423) },
			{ "3devas", vars.starObtained(427) },
			{ "giantgloop", vars.starObtained(429) },
			{ "taurusoid", vars.starObtained(430) },
			{ "sunofagun", vars.starObtained(428) },
			{ "bunyip", vars.starObtained(431) },
			{ "lynx21", vars.starObtained(433) },
			{ "radius", vars.starObtained(434) },
			{ "sage", vars.starObtained(447) },
			{ "garai", vars.starObtained(438) },
			{ "miguel", vars.starObtained(440) },
			{ "roachester", vars.starObtained(441) },
			{ "grobyc", vars.starObtained(445) },
			{ "earthdragon", vars.starObtained(451) },
			{ "waterdragon", vars.starObtained(452) },
			{ "greendragon", vars.starObtained(454) },
			{ "firedragon", vars.starObtained(453) },
			{ "skydragon", vars.starObtained(457) },
			{ "darkserge", vars.starObtained(473) },
			{ "vitaunas", vars.starObtained(458) },
			{ "fate", vars.starObtained(462) },
			{ "terrator", vars.starObtained(470) },
			{ "pyrotor", vars.starObtained(468) },
			{ "anemotor", vars.starObtained(469) },
			{ "aquator", vars.starObtained(467) },
			{ "dragongod", vars.starObtained(471) },
			
			// No Star Bosses
			{ "soltnpeppor2nd", vars.noStarBoss(474) },
			{ "dario", vars.noStarBoss(464) },
			
			// Key Items
			{ "teleporter", vars.keyItemObtained("keyitems1", 1) },
			{ "sharktooth", vars.keyItemObtained("keyitems1", 2) },
			{ "astralamulet", vars.keyItemObtained("keyitems1", 4) },
			{ "greentinkler", vars.keyItemObtained("keyitems1", 8) },
			{ "beebaflute", vars.keyItemObtained("keyitems1", 16) },
			{ "einlanzer", vars.keyItemObtained("keyitems1", 32) },
			{ "icegun", vars.keyItemObtained("keyitems1", 64) },
			{ "icebreath", vars.keyItemObtained("keyitems1", 128) },			
			{ "heckranbone", vars.keyItemObtained("keyitems2", 1) },
			{ "bellflower", vars.keyItemObtained("keyitems2", 2) },
			{ "bigegg", vars.keyItemObtained("keyitems2", 4) },
			{ "heavyskull", vars.keyItemObtained("keyitems2", 8) },
			{ "goodbackbone", vars.keyItemObtained("keyitems2", 16) },
			{ "sturdyribs", vars.keyItemObtained("keyitems2", 32) },
			{ "pelvicbone", vars.keyItemObtained("keyitems2", 64) },
			{ "angryscapula", vars.keyItemObtained("keyitems2", 128) },			
			{ "mixedbones", vars.keyItemObtained("keyitems3", 1) },
			{ "aromapouch", vars.keyItemObtained("keyitems3", 2) },
			{ "mushroom", vars.keyItemObtained("keyitems3", 4) },
			{ "manorkey", vars.keyItemObtained("keyitems3", 8) },
			{ "hydrahumour", vars.keyItemObtained("keyitems3", 16) },
			{ "parlorkey", vars.keyItemObtained("keyitems3", 32) },
			{ "prisonkey", vars.keyItemObtained("keyitems3", 64) },
			{ "dragontear", vars.keyItemObtained("keyitems3", 128) },			
			{ "whiterelic", vars.keyItemObtained("keyitems4", 1) },
			{ "blackrelic", vars.keyItemObtained("keyitems4", 2) },
			{ "redrelic", vars.keyItemObtained("keyitems4", 4) },
			{ "bluerelic", vars.keyItemObtained("keyitems4", 8) },
			{ "yellowrelic", vars.keyItemObtained("keyitems4", 16) },
			{ "greenrelic", vars.keyItemObtained("keyitems4", 32) },
			{ "lifesparkle", vars.keyItemObtained("keyitems4", 64) },
			{ "komodoscale", vars.keyItemObtained("keyitems4", 128) },			
			{ "starfragment", vars.keyItemObtained("keyitems5", 1) },
			{ "cardkey", vars.keyItemObtained("keyitems5", 2) },
			{ "explosive", vars.keyItemObtained("keyitems5", 4) },
			{ "tearofhate", vars.keyItemObtained("keyitems5", 8) },
			{ "tearoflove", vars.keyItemObtained("keyitems5", 16) },
			{ "stationpass", vars.keyItemObtained("keyitems5", 32) },
			{ "ancientfruit", vars.keyItemObtained("keyitems5", 64) },
			{ "mementopendant", vars.keyItemObtained("keyitems5", 128) },			
			{ "handle", vars.keyItemObtained("keyitems6", 1) },
			{ "garaikeepsake", vars.keyItemObtained("keyitems6", 2) },
			{ "decorshield", vars.keyItemObtained("keyitems6", 4) },
			{ "fiddlercrab", vars.keyItemObtained("keyitems6", 8) },
			{ "chronocross", vars.keyItemObtained("keyitems6", 16) },
			{ "safetygear", vars.keyItemObtained("keyitems6", 32) },
			{ "sapphirebrooch", vars.keyItemObtained("keyitems6", 64) },
			{ "propsword", vars.keyItemObtained("keyitems6", 128) },			
			{ "dragonemblem", vars.keyItemObtained("keyitems7", 1) },
			{ "bookofpoems", vars.keyItemObtained("keyitems7", 2) },
			{ "medicalbook", vars.keyItemObtained("keyitems7", 4) },
			{ "herosmedal", vars.keyItemObtained("keyitems7", 8) },
			{ "timeegg", vars.keyItemObtained("keyitems7", 16) },			
			{ "reliefcharm", vars.keyItemObtained("keyitems8", 16) },
			{ "timeshifter", vars.keyItemObtained("keyitems8", 32) },
			{ "smithspirit", vars.keyItemObtained("keyitems8", 64) },
			
			// Final Splits
			{ "chronoCross", vars.chronoCrossUsed() }
		};
		return splits;
	});
	
	vars.pastSplits = new HashSet<string>();
	vars.mystring = "";
	vars.paststring = "";
}

update {
	
	if(!vars.watchersInitialized) {
        return false;
    }
	
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0) {
		vars.pastSplits.Clear();
	}
	
	vars.watchers.UpdateAll(game);
	
	if (settings["debug"]) {
		vars.mystring = "--[Autosplitter] GrpID: " + vars.watchers["groupID"].Current + " | Stars: " + vars.watchers["maxStars"].Current + " | M: " + vars.watchers["marcyMaxHP"].Current + " | S: " + vars.watchers["sergeMaxHP"].Current + " | H: " + vars.watchers["harleMaxHP"].Current + " | K: " + vars.watchers["karshMaxHP"].Current;
		if (vars.paststring != vars.mystring) {
			print(vars.mystring);
			vars.paststring = vars.mystring;
		}
	}
}

start {	
	if (vars.watchers["gameStart1"].Old == -2145387048 && vars.watchers["gameStart1"].Current == 0) {	
		print("--[Autosplitter] Go!");
		return true;
	}
}

reset {
	if (vars.watchers["debug"].Old == 0 && vars.watchers["debug"].Current == 4129 || (vars.watchers["gameStart1"].Current == -2145387048 && vars.watchers["maxStars"].Current == 20)) {
		print("--[Autosplitter] Reset!");
		return true;
	}
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

exit {
	vars.tokenSource.Cancel();
}

shutdown {
	vars.tokenSource.Cancel();
}