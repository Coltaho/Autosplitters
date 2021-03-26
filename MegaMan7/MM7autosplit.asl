//Made by Coltaho 3/19/2019

state("snes9x"){}
state("snes9x-x64"){}
state("higan"){}

startup
{
	vars.stopwatch = new Stopwatch();
	refreshRate = 1;
	
	// settings.Add("options", true, "---Options---");
	// settings.Add("currentroomtimer", false, "Show Current Room Timer", "options");
	// settings.Add("currentroomid", false, "Show Current Room ID", "options");
	// settings.Add("lastroomtimer", true, "Show Last Room Timer", "options");
	// settings.Add("lastroomid", true, "Show Last Room ID", "options");
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 7 AutoSplitter v1.1 by Coltaho", "infosection");
	settings.Add("info1", true, "- Supported emulators : Higan 105/106, Snes9X 1.51 v7.1 rerecording, 1.55-1.60 32 and 64 bit (excluding 1.59)", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	
	
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
			new MemoryWatcher<byte>(memoryOffset + 0x19EE) { Name = "enemyhp" }, //enemy health
			new MemoryWatcher<byte>(memoryOffset + 0xC2E) { Name = "myhp" }, //mega man health
			new MemoryWatcher<byte>(memoryOffset + 0xB81) { Name = "mylives" }, //current lives
			new MemoryWatcher<byte>(memoryOffset + 0x39) { Name = "titleselection" }, //what cursor is on during title screen
			new MemoryWatcher<byte>(memoryOffset + 0x13C) { Name = "start" }, //something that seems to work for starting game 3->57
			new MemoryWatcher<byte>(memoryOffset + 0xB73) { Name = "stage" }, //current stage
			new MemoryWatcher<byte>(memoryOffset + 0xB7D) { Name = "screen1" }, //current screen 1 ?
			new MemoryWatcher<byte>(memoryOffset + 0xB7E) { Name = "screen2" }, //current screen 2 ?
			new MemoryWatcher<byte>(memoryOffset + 0xBC6) { Name = "transitioning" }, //transitioning/input locked
			new MemoryWatcher<byte>(othermemoryOffset + 0xF7) { Name = "sfx" } //61 to 60 for teleport after weapon get, 60 is teleport sound    
		};
	});
}

init
{
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	vars.watchers = new MemoryWatcherList();
	vars.stopwatch.Restart();

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
	// print("--SFX: " + vars.watchers["sfx"].Current + " MyHP: " + vars.watchers["myhp"].Current + " EnemyHP: " + vars.watchers["enemyhp"].Current + " StartVal: " + vars.watchers["start"].Current + " Screen1: " + vars.watchers["screen1"].Current + " Screen2: " + vars.watchers["screen2"].Current + " Transitioning: " + vars.watchers["transitioning"].Current);
}

start { 
	//US
	if (vars.watchers["start"].Old == 3 && vars.watchers["start"].Current == 57 && vars.watchers["titleselection"].Current == 0) {
		print("--Here we go!--");
		return true;
	}
	//JP
	if (vars.watchers["start"].Old == 65 && (vars.watchers["start"].Current == 1 || vars.watchers["start"].Current == 0) && vars.watchers["titleselection"].Current == 0) {
		print("--Here we go!--");
		return true;
	}
}

split
{
	//Split after teleport sound if not in a 'special' ...state? and not on stage 13!
	if (vars.watchers["stage"].Current != 13 && vars.watchers["start"].Current == 3 && vars.watchers["sfx"].Changed && vars.watchers["sfx"].Current == 60) {
		print("--MM7 Teleport split!--");
		return true;
	}
	
	//Split after final boss kill
	if (vars.watchers["stage"].Current == 13 && vars.watchers["screeny"].Current == 9 && vars.watchers["enemyhp"].Old > 0 && vars.watchers["enemyhp"].Current == 0 && vars.watchers["myhp"].Current > 0) {
		print("--MM7 Killed Wily Capsule and beat the game!--");
		return true;
	}
	return;
}
