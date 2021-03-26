//Made by Coltaho 4/30/2019

state("snes9x"){}
state("snes9x-x64"){}
state("higan"){}

startup
{
	vars.stopwatch = new Stopwatch();
	refreshRate = 1;
	
	settings.Add("optionsection", true, "---Options---");
	settings.Add("exitshop", false, "Split on exiting shop (will split each time)", "optionsection");
	settings.Add("jetkill", true, "Split on killing King Jet (use if death abusing)", "optionsection");
	settings.Add("kinghallway", false, "Split when entering final hallway after King before Megazord", "optionsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Rockman & Forte AutoSplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : Higan 105/106, Snes9X 1.51 v7.1 rerecording, 1.55-1.60 32 and 64 bit (excluding 1.59)", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	
	vars.dostuff = (Action<Process, int>)((proc, mymodulesize) => {
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	switch (mymodulesize)
	{
		case 10244096: //snes9x (1.51 v7.1 rerecording)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28C4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28D4) + 0x2049;
			break;
		case 6602752: //snes9x (1.55)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x762874);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x97046C);
			break;
		case 8355840: //snes9x (1.55-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405BFDB8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x14074D188);
			break;
		case 9003008: //snes9x (1.56-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405D8C68);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140765EC8);
			break;
		case 6848512: //snes9x (1.56.1)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7811B4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x92523C);
			break;
		case 8945664: //snes9x (1.56.1-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405C80A8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140756EB8);
			break;
		case 6856704: //snes9x (1.56.2 and 1.56)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7832C4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x92734C);
			break;
		case 9015296: //snes9x (1.56.2-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405D9298);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1407680A8);
			break;
		case 6991872: //snes9x (1.57)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7A6EE4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x92A26C);
			break;
		case 9048064: //snes9x (1.57-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405ACC58);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140751F98);
			break;
		case 7000064: //snes9x (1.58)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7A7EE4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x92BA5C);
			break;
		case 9060352: //snes9x (1.58-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1405AE848);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1407547A8);
			break;
		case 8953856: //snes9x (1.59.2)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x975E40);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0xAF95D0);
			break;
		case 12537856: //snes9x (1.59.2-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1408D86F8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140A8B280);
			break;
		case 9027584: //snes9x (1.60)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x92CAF8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0xAD16B0);
			break;
		case 12836864: //snes9x (1.60-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1408D8BE8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140A87520);
			break;
		case 16756736: //higan (v105tr1)
			vars.memoryOffset = 0x94F144;
			vars.othermemoryOffset = (IntPtr)0x96D437 - 0xF7;
			break;
		case 16019456: //higan (v106)
			vars.memoryOffset = (IntPtr)0x94D144;
			vars.othermemoryOffset = (IntPtr)0x96D437 - 0xF7;
			break;
		default:
			vars.memoryOffset = IntPtr.Zero;
			vars.othermemoryOffset = IntPtr.Zero;
			break;
	}});

	vars.GetWatcherList = (Func<IntPtr, IntPtr, MemoryWatcherList>)((memoryOffset, othermemoryOffset) =>
	{   
		return new MemoryWatcherList
		{
			new MemoryWatcher<byte>(memoryOffset + 0x19EF) { Name = "enemyhp" }, //enemy health
			new MemoryWatcher<byte>(memoryOffset + 0x1AEF) { Name = "jetbosshp" }, //jet boss health
			new MemoryWatcher<byte>(memoryOffset + 0xC2F) { Name = "myhp" }, //mega man health
			new MemoryWatcher<byte>(memoryOffset + 0xB7E) { Name = "mylives" }, //current lives
			new MemoryWatcher<byte>(memoryOffset + 0xBD5) { Name = "gridselection" }, //screen selection stuff
			new MemoryWatcher<byte>(memoryOffset + 0xB73) { Name = "stage" }, //current stage
			new MemoryWatcher<byte>(memoryOffset + 0xB7D) { Name = "screen" }, //current screen
			new MemoryWatcher<byte>(othermemoryOffset + 0xF7) { Name = "sfx" } //4 to 33 for teleport after weapon get, 33 is teleport sound
		};
	});
}

init
{
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	vars.watchers = new MemoryWatcherList();
	vars.stopwatch.Restart();
	vars.wilymachinedead = false;

	print("--Setting init variables!--");
	refreshRate = 60;
}

update {
	if (vars.stopwatch.ElapsedMilliseconds > 1500)
    {
        vars.dostuff(game, modules.First().ModuleMemorySize);
		print("--My Mem: " + vars.memoryOffset + " otherMem: " + vars.othermemoryOffset);
        if (vars.memoryOffset != IntPtr.Zero && vars.othermemoryOffset != IntPtr.Zero)
        {
			print("--Found offsets!");
            vars.watchers = vars.GetWatcherList(vars.memoryOffset, vars.othermemoryOffset);
            vars.stopwatch.Reset();
        }
        else
        {
			print("--Still looking for offsets... Next check in 1.5 seconds...");
            vars.stopwatch.Restart();
            return false;
        }
    }
    else if (vars.watchers.Count == 0)
        return false;
	
	vars.watchers.UpdateAll(game);
	print("--SFX: " + vars.watchers["sfx"].Current + " MyHP: " + vars.watchers["myhp"].Current + " EnemyHP: " + vars.watchers["enemyhp"].Current + " Stage: " + vars.watchers["stage"].Current + " Screen: " + vars.watchers["screen"].Current + " Wily Machine Dead: " + vars.wilymachinedead);
}

start { 
	if (vars.watchers["sfx"].Old == 2 && vars.watchers["sfx"].Current == 96) {
		print("--R&F Here we go!--");
		return true;
	}
}

split
{
	//Split after teleport sound for intro
	if (vars.watchers["stage"].Current == 0 && vars.watchers["screen"].Current == 10 && vars.watchers["sfx"].Old == 57 && vars.watchers["sfx"].Current == 33) {
		print("--R&F Intro Teleport split!--");
		return true;
	}
	
	//Split after teleport sound for 8 robos
	if (vars.watchers["stage"].Current <= 8 && vars.watchers["sfx"].Old == 4 && vars.watchers["sfx"].Current == 33) {
		print("--R&F 8 Robo Teleport split!--");
		return true;
	}
	
	//Split after exiting shop
	if (settings["exitshop"] && vars.watchers["stage"].Current == 13 && vars.watchers["gridselection"].Old > 0 && vars.watchers["gridselection"].Current == 0) {
		print("--R&F Exit Shop split!--");
		return true;
	}
	
	//Split after teleport sound for atet
	if (vars.watchers["stage"].Current == 10 && vars.watchers["sfx"].Old == 250 && vars.watchers["sfx"].Current == 33) {
		print("--R&F Atet Teleport split!--");
		return true;
	}
	
	//Split after teleport sound for king stage 2
	if (vars.watchers["stage"].Current == 11 && vars.watchers["sfx"].Old != 33 && vars.watchers["sfx"].Current == 33) {
		print("--R&F King Stage Teleport split!--");
		return true;
	}
	
	//Split on Jet boss kill
	if (settings["jetkill"] && vars.watchers["stage"].Current == 11 && vars.watchers["screen"].Current == 10 && vars.watchers["myhp"].Current > 0 && vars.watchers["jetbosshp"].Old > 0 && vars.watchers["jetbosshp"].Current == 0) {
		print("--R&F Jet Boss Kill split!--");
		return true;
	}
	
	//Split on last King hallway enter
	if (settings["kinghallway"] && vars.watchers["stage"].Current == 11 && vars.watchers["screen"].Old == 15   && vars.watchers["screen"].Current == 16) {
		print("--R&F King Hallway split!--");
		return true;
	}
	
	//logic for knowing we are on Wily Capsule - enemy id would simplify greatly
	if (!vars.wilymachinedead && vars.watchers["stage"].Current == 12 && vars.watchers["screen"].Current == 23 && vars.watchers["enemyhp"].Old != 28 && vars.watchers["enemyhp"].Old > 0 && vars.watchers["enemyhp"].Current == 0 && vars.watchers["myhp"].Current > 0) {
		vars.wilymachinedead = true;
		print("--R&F Killed Wily Machine!--");
		return false;
	} else if (vars.wilymachinedead && vars.watchers["myhp"].Current == 0) {
		vars.wilymachinedead = false;
		print("--R&F Died after killing Wily Machine :( --");
		return false;
	}
	
	//Split after final boss kill
	if (vars.wilymachinedead && vars.watchers["stage"].Current == 12 && vars.watchers["screen"].Current == 23 && vars.watchers["enemyhp"].Old > 0 && vars.watchers["enemyhp"].Current == 0 && vars.watchers["myhp"].Current > 0) {
		print("--R&F Killed Wily Capsule and beat the game!--");
		return true;
	}
	return;
}
