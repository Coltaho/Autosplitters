state("Astalon") {}

startup {
	print("--[Autosplitter] Starting up!--");
	
	settings.Add("finalevents", true, "---Final Events--(Leave on)---");
	settings.Add("Medusa", true, "Medusa (Final)", "finalevents");
	settings.Add("gameCompleted", true, "Game Completed (Failsafe)", "finalevents");
	
	settings.Add("bosses", true, "---Bosses---");
	settings.Add("Tauros", true, "Tauros (Red)", "bosses");
	settings.Add("Volantis", true, "Volantis (Blue)", "bosses");
	settings.Add("Gemini", true, "Gemini (Basement)", "bosses");
	settings.Add("Solaria", true, "Solaria (Green)", "bosses");
	
	settings.Add("minibosses", true, "---Mini Bosses---");
	settings.Add("deadmaiden", false, "Dead Maiden", "minibosses");
	settings.Add("cyclopsprince", false, "Cyclops Prince", "minibosses");
	
	settings.Add("items", true, "---Items---");
	settings.Add("AmuletOfSol", false, "AmuletOfSol", "items");
	settings.Add("BanishSpell", false, "BanishSpell", "items");
	settings.Add("GorgonHeart", false, "GorgonHeart", "items");
	settings.Add("GriffonClaw", false, "GriffonClaw", "items");
	settings.Add("IcarusEmblem", false, "IcarusEmblem", "items");
	settings.Add("LunarianBow", false, "LunarianBow", "items");
	settings.Add("RingOfTheAncients", false, "RingOfTheAncients", "items");
	settings.Add("SwordOfMirrors", false, "SwordOfMirrors", "items");
	settings.Add("LunariaSword", false, "LunariaSword", "items");
	settings.Add("GorgonEyeRed", false, "GorgonEyeRed", "items");
	settings.Add("GorgonEyeBlue", false, "GorgonEyeBlue", "items");
	settings.Add("GorgonEyeGreen", false, "GorgonEyeGreen", "items");
	settings.Add("DeadMaidensRing", false, "DeadMaidensRing", "items");
	settings.Add("LinusMap", false, "LinusMap", "items");
	settings.Add("AthenasBell", false, "AthenasBell", "items");
	settings.Add("VoidCharm", false, "VoidCharm", "items");
	settings.Add("TomeOfTongues", false, "TomeOfTongues", "items");
	settings.Add("CloakOfLevitation", false, "CloakOfLevitation", "items");
	settings.Add("MarkOfEpimetheus", false, "MarkOfEpimetheus", "items");
	settings.Add("AdornedKey", false, "AdornedKey", "items");
	settings.Add("CrackedBell", false, "CrackedBell", "items");
	settings.Add("CeremonialDagger", false, "CeremonialDagger", "items");
	settings.Add("CrystalFragment", false, "CrystalFragment", "items");
	settings.Add("GoldChalice", false, "GoldChalice", "items");
	settings.Add("PrincesCrown", false, "PrincesCrown", "items");
	settings.Add("SkeletonIdol", false, "SkeletonIdol", "items");
	settings.Add("ZeekItem", false, "ZeekItem", "items");
	settings.Add("AscendantKey", false, "AscendantKey", "items");
	settings.Add("TalariaBoots", false, "TalariaBoots", "items");
	settings.Add("MonsterBall", false, "MonsterBall", "items");
	settings.Add("BloodChalice", false, "BloodChalice", "items");
	settings.Add("MorningStar", false, "MorningStar", "items");
	settings.Add("CyclopsIdol", false, "CyclopsIdol", "items");
	settings.Add("BoreasGauntlet", false, "BoreasGauntlet", "items");
	settings.Add("FamiliarGil", false, "FamiliarGil", "items");
	settings.Add("Bestiary", false, "Bestiary", "items");
	settings.Add("Music", false, "Music", "items");
	settings.Add("BiggerLoot", false, "BiggerLoot", "items");
	settings.Add("MagicBlock", false, "MagicBlock", "items");
	
	settings.Add("elevators", true, "---Elevators---");
	settings.Add("apex", false, "The Apex", "elevators");
	settings.Add("roa2", false, "Ruins of Ash 2", "elevators");
	settings.Add("roa1", false, "Ruins of Ash 1", "elevators");
	settings.Add("hop", false, "Hall of Phantoms", "elevators");
	settings.Add("mech2", false, "Mechanism 2", "elevators");
	settings.Add("mech1", false, "Mechanism 1", "elevators");
	settings.Add("gt2", false, "Gorgon Tomb 2", "elevators");
	settings.Add("gt1", false, "Gorgon Tomb 1", "elevators");
	settings.Add("sub1", false, "Subterranea 1", "elevators");
	settings.Add("sub2", false, "Subterranea 2", "elevators");
	settings.Add("roots", false, "Tower Roots", "elevators");
	
	settings.Add("cutsceneevents", true, "---Cutscenes---");
	settings.Add("forcedDeath", false, "Forced Death", "cutsceneevents");
	settings.Add("finalplatformride", false, "Final Platform Ride", "cutsceneevents");
	
	settings.Add("roomtransitions", true, "---Room Transitions---");
	settings.Add("entertauros", false, "Enter Tauros", "roomtransitions");
	settings.Add("bk1enter", false, "Enter Black Knight 1", "roomtransitions");
	settings.Add("bk1leave", false, "Leave Black Knight 1", "roomtransitions");
	settings.Add("entervolantis", false, "Enter Volantis", "roomtransitions");
	settings.Add("bk2enter", false, "Enter Black Knight 2", "roomtransitions");
	settings.Add("bk2leave", false, "Leave Black Knight 2", "roomtransitions");
	settings.Add("emptyheadenter", false, "Enter Empty Three Head", "roomtransitions");
	settings.Add("darkroomsenter", false, "Enter Dark Rooms", "roomtransitions");
	settings.Add("darkroomsleave", false, "Leave Dark Rooms", "roomtransitions");
	settings.Add("entersolaria", false, "Enter Solaria", "roomtransitions");
	settings.Add("cyclopsdenenter", false, "Enter Cyclops Den", "roomtransitions");
	settings.Add("dullahanleave", false, "Leave Dullahan", "roomtransitions");
	settings.Add("finalbossenter", false, "Enter Final Boss (broken?)", "roomtransitions");
	
	settings.Add("bossrush", true, "---Boss Rush---");
	settings.Add("TaurosBR", true, "Tauros BR", "bossrush");
	settings.Add("VolantisBR", true, "Volantis BR", "bossrush");
	settings.Add("SolariaBR", true, "Solaria BR", "bossrush");
	settings.Add("GeminiBR", true, "Gemini BR", "bossrush");
	
	settings.Add("scriptsection", true, "---Script Options---");
	settings.Add("RunInBackground", true, "Allow the game to run in background", "scriptsection");
    settings.Add("AllowInputBackground", false, "Allow game inputs while in background", "scriptsection");
	settings.Add("debug", false, "Print Debug Info", "scriptsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Astalon Autosplitter v1.12 by Coltaho", "infosection");
	settings.Add("info0", true, "Supports Astalon v1.0+", "infosection");	
}

init {
	
	//Run in background code courtesy of Voxelse#3117	
	vars.GetAbsoluteAddress = (Func<IntPtr, IntPtr>)((ptr) => ptr + 0x4 + game.ReadValue<int>(ptr));

    vars.SetRunInBackground = (Action<bool>)((value) => {
        if(vars.runInBackgroundPtr != IntPtr.Zero) {
            game.WriteValue<bool>((IntPtr)vars.runInBackgroundPtr, value);
            vars.runInBackground = value;
			print("--[Autosplitter] Run in background set to: " + value);
        }
	});

    vars.SetIgnoreInputs = (Action<bool>)((value) => {
        if(vars.ignoreInputsPtr != IntPtr.Zero) {
            game.WriteValue<bool>((IntPtr)vars.ignoreInputsPtr, value);
            vars.ignoreInputs = value;
			print("--[Autosplitter] Ignore inputs in background set to: " + value);
        }
	});

    vars.runInBackgroundPtr = IntPtr.Zero;
    vars.runInBackground = false;
	
    vars.ignoreInputsPtr = IntPtr.Zero;
    vars.ignoreInputs = true;
	
    vars.tokenSource = new CancellationTokenSource();

    vars.watchersInitialized = false;

    vars.threadScan = new Thread(() => {
		SignatureScanner unityScanner = null;
		SignatureScanner gameAssemblyScanner = null;

        SigScanTarget gameScanTarget = new SigScanTarget(0x0, "A1 ???????? 83 C4 08 8B 40 5C 8B 00 85 C0 0F84 ???????? 8B 40 10 85 C0 0F84 ???????? 6A 00 50 E8 ???????? 83 C4 08 A1 ???????? 8B 40 5C 8B 30");
        IntPtr gameSigAddr = IntPtr.Zero;
        
		SigScanTarget runInBackgroundScanTarget = new SigScanTarget(0x0, "E8 ???????? 85 C0 74 0C E8 ???????? 8A 80 C0 01 00 00 C3 32 C0 C3");
        IntPtr runInBackgroundSigAddr = IntPtr.Zero;

        SigScanTarget ignoreInputsScanTarget = new SigScanTarget(0x9, "0F1F 84 00 00000000 A1 ???????? F6 80 BB000000 02 74 ?? 83 78 74 00 75 0E 50 E8 ???????? A1 ???????? 83 C4 04 8B 40 5C 8B 40 18 85 C0 74 ?? 8B 40 08 85 C0 74");
        IntPtr ignoreInputsSigAddr = IntPtr.Zero;
        
		while(!vars.tokenSource.IsCancellationRequested) {
            if(unityScanner == null || gameAssemblyScanner == null) {
                ProcessModuleWow64Safe[] loadedModules = null;
                try {
                    loadedModules = game.ModulesWow64Safe();
                } catch {
                    loadedModules = new ProcessModuleWow64Safe[0];
                }

                ProcessModuleWow64Safe unityModule = loadedModules.FirstOrDefault(m => m.ModuleName == "UnityPlayer.dll");
                ProcessModuleWow64Safe gameAssemblyModule = loadedModules.FirstOrDefault(m => m.ModuleName == "GameAssembly.dll");
                if(unityModule == null || gameAssemblyModule == null) {
                    print("--[Autosplitter] Modules not initialized");
                    Thread.Sleep(500);
                    continue;
                }

                unityScanner = new SignatureScanner(game, unityModule.BaseAddress, unityModule.ModuleMemorySize);
                gameAssemblyScanner = new SignatureScanner(game, gameAssemblyModule.BaseAddress, gameAssemblyModule.ModuleMemorySize);
            }

            print("--[Autosplitter] Scanning memory");

            if(gameSigAddr == IntPtr.Zero && (gameSigAddr = gameAssemblyScanner.Scan(gameScanTarget)) != IntPtr.Zero) {
                print("--[Autosplitter] Sig scan game addr: " + gameSigAddr.ToString("X"));

                vars.gameLoaderAsm = gameSigAddr + 0x1;
                vars.gameManagerAsm = gameSigAddr + 0x2C;
                
                vars.watchers = new MemoryWatcherList() {
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameLoaderAsm, 0x0, 0x5C, 0x0, 0x10, 0xC)) { Name = "mainMenuOpen" },
                    
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x94)) { Name = "igt" },
					new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x90)) { Name = "gameMode" },
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xA0)) { Name = "currentRoom" },
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xA8)) { Name = "previousRoom" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x170)) { Name = "gameCompleted" },
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0xC)) { Name = "defeatedBosses_size" },
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC4, 0xC)) { Name = "elevatorsFound_size" },
                    new MemoryWatcher<int>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xF0, 0xC)) { Name = "collectedItems_size" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x1B5)) { Name = "forcedDeath" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x1B7)) { Name = "finalplatformride" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x1C0)) { Name = "cyclopsDenKey" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0x1C8)) { Name = "cyclopsprince" },
                    new MemoryWatcher<bool>(new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xD4)) { Name = "deadmaiden" },
                };

                vars.watchersInitialized = true;
            }	

            if(vars.runInBackgroundPtr == IntPtr.Zero
            && (runInBackgroundSigAddr != IntPtr.Zero || (runInBackgroundSigAddr = unityScanner.Scan(runInBackgroundScanTarget)) != IntPtr.Zero)) {
                print("--[Autosplitter] Sig scan runInBackground addr: " + runInBackgroundSigAddr.ToString("X"));
                
                IntPtr unityGetSettings = vars.GetAbsoluteAddress(runInBackgroundSigAddr + 0xA);
                IntPtr unityGetManager = vars.GetAbsoluteAddress(unityGetSettings + 0x3);
                IntPtr unityGetContext = game.ReadPointer((IntPtr)game.ReadValue<int>(unityGetManager + 0x9));

                if(unityGetContext == IntPtr.Zero) {
                    print("--[Autosplitter] runInBackground pointer not initialized");
                } else {
                    vars.runInBackgroundPtr = unityGetContext + 0x1C0;
                    print("--[Autosplitter] runInBackground addr: " + vars.runInBackgroundPtr.ToString("X"));
                }
            }

            if(vars.ignoreInputsPtr == IntPtr.Zero
            && (ignoreInputsSigAddr != IntPtr.Zero || (ignoreInputsSigAddr = gameAssemblyScanner.Scan(ignoreInputsScanTarget)) != IntPtr.Zero)) {
                print("--[Autosplitter] Sig scan ignoreInput addr: " + ignoreInputsSigAddr.ToString("X"));
                
                IntPtr rewired = game.ReadPointer((IntPtr)game.ReadValue<int>(ignoreInputsSigAddr));
                IntPtr platform = game.ReadPointer(rewired + 0x5C);
                
                if(platform == IntPtr.Zero) {
                    print("--[Autosplitter] ignoreInput pointer not initialized");
                } else {
                    vars.ignoreInputsPtr = platform + 0x5C;
                    print("--[Autosplitter] ignoreInput addr: " + vars.ignoreInputsPtr.ToString("X"));
                }
            }

            if(runInBackgroundSigAddr != IntPtr.Zero && vars.runInBackgroundPtr != IntPtr.Zero && vars.ignoreInputsPtr != IntPtr.Zero) {
                break;
            }

			print("--[Autosplitter] Couldn't find the pointers I want! Game is still starting or an update broke things!");
            Thread.Sleep(2000);
        }
        print("--[Autosplitter] Exit thread scan");
    });
    vars.threadScan.Start();
	
	
	vars.ItemObtained = (Func<int, bool>)((value) =>
	{		
		if (vars.watchers["collectedItems_size"].Old != vars.watchers["collectedItems_size"].Current) {
			for (int i = 0; i < vars.watchers["collectedItems_size"].Current; i++) {
				var itemoffset = 0x10 + i * 0x4;
				var itemID = new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xF0, 0x8, itemoffset).Deref<int>(game);
				if (itemID == value) {
					return true;
				}
			}
		}
		return false;
	});
	
	vars.Killed = (Func<string, bool>)((value) =>
	{
		if (vars.watchers["defeatedBosses_size"].Old != vars.watchers["defeatedBosses_size"].Current) {
			for (int i = 0; i < vars.watchers["defeatedBosses_size"].Current; i++) {
				var itemoffset = 0x10 + i * 0x4;
				var boss = new DeepPointer(vars.gameManagerAsm, 0x0, 0x5C, 0x0, 0x28, 0x144, 0xC8, 0x8, itemoffset, 0xC).DerefString(game, 20);				
				if (boss == value && value == "Medusa") {
					vars.medusakilled = true;
					return false;
				}
				if (boss == value)
					return true;
			}
		}
		return false;
	});
	
	vars.ElevatorFound = (Func<int, bool>)((value) =>
	{
		if (vars.watchers["elevatorsFound_size"].Old != vars.watchers["elevatorsFound_size"].Current) {
			return vars.watchers["currentRoom"].Current == value;
		}
		return false;
	});
	
	vars.checkBool = (Func<string, bool>)((value) =>
	{
		return vars.watchers[value].Current;
	});
	
	vars.checkBoolGameCompleted = (Func<bool>)(() =>
	{
		if (vars.watchers["gameCompleted"].Current && vars.watchers["gameMode"].Current == 1) {
			vars.bkfinished = true;
			return false;
		}
		else 
			return vars.watchers["gameCompleted"].Current;
	});
	
	vars.Transitioned = (Func<int, int, bool>)((prev, value) =>
	{
		return vars.watchers["previousRoom"].Current == prev && vars.watchers["currentRoom"].Current == value;
	});
	
	vars.JustTransitioned = (Func<int, bool>)((value) =>
	{
		return vars.watchers["currentRoom"].Current == value;
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{
			// Bosses
			{ "Tauros", vars.Killed("Tauros") },
			{ "Volantis", vars.Killed("Volantis") },
			{ "Gemini", vars.Killed("Gemini") },
			{ "Solaria", vars.Killed("Solaria") },
			// { "bkFinalDead", vars.checkBoolFinalRoom("bkFinalDead") },
			// { "medusaPhase1Dead", vars.checkBoolFinalRoom("medusaPhase1Dead") },
			// { "medusaPhase2Dead", vars.checkBoolFinalRoom("medusaPhase2Dead") },
			{ "Medusa", vars.Killed("Medusa") },
			{ "gameCompleted", vars.checkBoolGameCompleted() },
			
			//Mini bosses
			{ "cyclopsprince", vars.checkBool("cyclopsprince") },
			{ "deadmaiden", vars.checkBool("deadmaiden") },
			
			
			// Items
			{ "AmuletOfSol", vars.ItemObtained(0) },
			{ "BanishSpell", vars.ItemObtained(1) },
			{ "GorgonHeart", vars.ItemObtained(2) },
			{ "GriffonClaw", vars.ItemObtained(3) },
			{ "IcarusEmblem", vars.ItemObtained(4) },
			{ "LunarianBow", vars.ItemObtained(5) },
			{ "RingOfTheAncients", vars.ItemObtained(6) },
			{ "SwordOfMirrors", vars.ItemObtained(7) },
			{ "LunariaSword", vars.ItemObtained(8) },
			{ "GorgonEyeRed", vars.ItemObtained(9) },
			{ "GorgonEyeBlue", vars.ItemObtained(10) },
			{ "GorgonEyeGreen", vars.ItemObtained(11) },
			{ "DeadMaidensRing", vars.ItemObtained(12) },
			{ "LinusMap", vars.ItemObtained(13) },
			{ "AthenasBell", vars.ItemObtained(14) },
			{ "VoidCharm", vars.ItemObtained(15) },
			{ "TomeOfTongues", vars.ItemObtained(16) },
			{ "CloakOfLevitation", vars.ItemObtained(18) },
			{ "MarkOfEpimetheus", vars.ItemObtained(19) },
			{ "AdornedKey", vars.ItemObtained(20) },
			{ "CrackedBell", vars.ItemObtained(21) },
			{ "CeremonialDagger", vars.ItemObtained(22) },
			{ "CrystalFragment", vars.ItemObtained(23) },
			{ "GoldChalice", vars.ItemObtained(24) },
			{ "PrincesCrown", vars.ItemObtained(25) },
			{ "SkeletonIdol", vars.ItemObtained(26) },
			{ "ZeekItem", vars.ItemObtained(27) },
			{ "AscendantKey", vars.ItemObtained(28) },
			{ "TalariaBoots", vars.ItemObtained(29) },
			{ "MonsterBall", vars.ItemObtained(34) },
			{ "BloodChalice", vars.ItemObtained(35) },
			{ "MorningStar", vars.ItemObtained(36) },
			{ "CyclopsIdol", vars.checkBool("cyclopsDenKey") },
			{ "BoreasGauntlet", vars.ItemObtained(39) },
			{ "FamiliarGil", vars.ItemObtained(40) },
			{ "Bestiary", vars.ItemObtained(41) },
			{ "Music", vars.ItemObtained(42) },
			{ "BiggerLoot", vars.ItemObtained(43) },
			{ "MagicBlock", vars.ItemObtained(44) },
			
			// Elevators
			{ "apex", vars.ElevatorFound(4109) },
			{ "roa2", vars.ElevatorFound(8771) },
			{ "roa1", vars.ElevatorFound(1080) },
			{ "hop", vars.ElevatorFound(10535) },
			{ "mech2", vars.ElevatorFound(803) },
			{ "mech1", vars.ElevatorFound(3947) },
			{ "gt2", vars.ElevatorFound(248) },
			{ "gt1", vars.ElevatorFound(6629) },
			{ "sub1", vars.ElevatorFound(61) },
			{ "sub2", vars.ElevatorFound(2574) },
			{ "roots", vars.ElevatorFound(2705) },
			
			// Cutscenes
			{ "forcedDeath", vars.checkBool("forcedDeath") },
			{ "finalplatformride", vars.checkBool("finalplatformride") },
			
			// Room Transitions
			{ "entertauros", vars.Transitioned(248, 64) },
			{ "bk1enter", vars.Transitioned(342, 7210) },
			{ "bk1leave", vars.Transitioned(7210, 342) },
			{ "entervolantis", vars.Transitioned(803, 802) },
			{ "bk2enter", vars.Transitioned(1080, 884) },
			{ "bk2leave", vars.Transitioned(884, 1054) },
			{ "emptyheadenter", vars.Transitioned(4080, 4079) },
			{ "darkroomsenter", vars.Transitioned(8762, 8763) },
			{ "darkroomsleave", vars.Transitioned(8862, 4107) },
			{ "entersolaria", vars.Transitioned(10017, 10015) },
			{ "cyclopsdenenter", vars.Transitioned(3728, 7359) },
			{ "dullahanleave", vars.Transitioned(9067, 9066) },
			{ "finalbossenter", vars.JustTransitioned(5000) },
			
			// Boss Rush
			{ "TaurosBR", vars.Killed("TaurosBR") },
			{ "VolantisBR", vars.Killed("VolantisBR") },
			{ "SolariaBR", vars.Killed("SolariaBR") },
			{ "GeminiBR", vars.Killed("GeminiBR") },
			
		};
		return splits;
	});
	
	vars.pastSplits = new HashSet<string>();
	vars.medusakilled = false;
	vars.bkfinished = false;
	vars.mystring = "";
	vars.paststring = "";
}

update {
    if(!vars.watchersInitialized) {
        return false;
    }

    if(vars.runInBackground != settings["RunInBackground"]) {
        vars.SetRunInBackground(settings["RunInBackground"]);
    }
    if(vars.ignoreInputs == settings["AllowInputBackground"]) {
        vars.SetIgnoreInputs(!settings["AllowInputBackground"]);
    }
	
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0) {
		vars.pastSplits.Clear();
		vars.medusakilled = false;
		vars.bkfinished = false;
	}
	vars.watchers.UpdateAll(game);

	if (settings["debug"]) {
		vars.mystring = "--MainMenuOpen: " + vars.watchers["mainMenuOpen"].Current + " | IGT: " + vars.watchers["igt"].Current + " | PreviousRoom: " + vars.watchers["previousRoom"].Current + " | CurrentRoom: " + vars.watchers["currentRoom"].Current + " | GameCompleted: " + vars.watchers["gameCompleted"].Current;
		if (vars.paststring != vars.mystring) {
			print(vars.mystring);
			vars.paststring = vars.mystring;
		}
	}
}

start {
	if(vars.watchers["igt"].Old == 0 && vars.watchers["igt"].Current == 1) {
		return true;
	}
}

reset {
	return (!vars.watchers["mainMenuOpen"].Old && vars.watchers["mainMenuOpen"].Current);
}

split {

	if (vars.medusakilled == true && vars.watchers["igt"].Old != vars.watchers["igt"].Current) {
		print("--[Autosplitter] Split: Medusa");
		vars.medusakilled = false;
		return true;
	}
	
	if (vars.bkfinished == true && vars.watchers["igt"].Old != vars.watchers["igt"].Current) {
		print("--[Autosplitter] Split: BK Completed");
		vars.bkfinished = false;
		return true;
	}
	
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

exit {
    vars.tokenSource.Cancel();
}

shutdown {
	vars.tokenSource.Cancel();
    vars.SetRunInBackground(false);
    vars.SetIgnoreInputs(true);
}