//Created by Coltaho
//Updated by JohnnyGo 9/9/2020

state("snes9x"){}
state("snes9x-x64"){}
state("higan"){}
state("retroarch") {}

startup
{
	print("--Starting up!--");
	refreshRate = 1;
	
	settings.Add("options", true, "---Options---");
	settings.Add("rta", true, "Use RTA Timing (Start on turtle select)", "options");
	settings.SetToolTip("rta", "If false, SDA timing will be used (Start on turtle control)");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("infosection0", true, "Turtles In Time AutoSplitter v1.0 by Coltaho", "infosection");
	settings.Add("infosection1", true, "-Starts on either turtle select or gaining control (RTA or SDA)", "infosection");
	settings.Add("infosection2", true, "-Splits at each stage increase (during transition)", "infosection");
	settings.Add("infosection3", true, "-Splits upon losing control after final shredder", "infosection");
	settings.Add("infosection4", true, "-Resets on ... reset", "infosection");
	settings.Add("infosection5", true, "Supported emulators : Higan 105/106, Snes9X 1.51 v7.1 rerecording, 1.55-1.60 32 and 64 bit (excluding 1.59), Retroarch with 'Snes9X - Current' Core", "infosection");
	settings.Add("infosection6", true, "Website : https://github.com/Coltaho/Autosplitters", "infosection");
	settings.SetToolTip("infosection", "Pretty cool, right?");
}

init
{
	print("--Setting init variables!--");
	IntPtr ptr = IntPtr.Zero;
	switch (modules.First().ModuleMemorySize)
	{
		case 10244096: //snes9x (1.51 v7.1 rerecording)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28C4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28D4) + 0x2049;
			break;
		case 6602752: //snes9x (1.55)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x762874);
			break;
		case 8355840: //snes9x (1.55-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405BFDB8);
			break;
		case 9003008: //snes9x (1.56-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405D8C68);
			break;
		case 6848512: //snes9x (1.56.1)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x7811B4);
			break;
		case 8945664: //snes9x (1.56.1-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405C80A8);
			break;
		case 6856704: //snes9x (1.56.2 and 1.56)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x7832C4);
			break;
		case 9015296: //snes9x (1.56.2-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405D9298);
			break;
		case 6991872: //snes9x (1.57)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x7A6EE4);
			break;
		case 9048064: //snes9x (1.57-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405ACC58);
			break;
		case 7000064: //snes9x (1.58)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x7A7EE4);
			break;
		case 9060352: //snes9x (1.58-x64)
			ptr = (IntPtr)game.ReadValue<int>((IntPtr)0x1405AE848);
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
			ptr = (IntPtr)0x94F144;
			break;
		case 16019456: //higan (v106)
			ptr = (IntPtr)0x94D144;
			break;
		//Retroarch sigscan copied from BenInSweeden's update to the SMW Autosplitter
		case 21250048: //retroarchX64 - 'Snes9x - Current'
			ProcessModuleWow64Safe libretromodule = modules.Where(m => m.ModuleName == "snes9x_libretro.dll").First();
			IntPtr baseAddress = libretromodule.BaseAddress;
			if (game.Is64Bit())
			{
				IntPtr result = IntPtr.Zero;
				SigScanTarget target = new SigScanTarget(13, "83 F9 01 74 10 83 F9 02 75 2C 48 8B 05 ?? ?? ?? ?? 48 8B 40 ??");
				SignatureScanner scanner = new SignatureScanner(game, baseAddress, (int)libretromodule.ModuleMemorySize);
				IntPtr codeOffset = scanner.Scan(target);
				int memoryReference = memory.ReadValue<int>(codeOffset) + (int) codeOffset + 0x04 +  - (int) libretromodule.BaseAddress;
				byte memoryReferenceoffset = memory.ReadValue<byte>(codeOffset + 7);
				IntPtr outOffset;
				new DeepPointer("snes9x_libretro.dll", memoryReference, memoryReferenceoffset, 0x0).DerefOffsets(game, out outOffset);
				ptr = (IntPtr)outOffset;
			}
			break;
		default:
			ptr = IntPtr.Zero;
			break;
	}
	
	if (ptr == IntPtr.Zero)
		throw new Exception("--Couldn't find a pointer I want! Emulator is still starting or an unsupported emulator is being used!");

	vars.watchers = new MemoryWatcherList {
			new MemoryWatcher<byte>(ptr + 0x82) { Name = "stage" }, //Current Stage
			new MemoryWatcher<byte>(ptr + 0x45E) { Name = "controlflag" }, //Control Flag
			new MemoryWatcher<byte>(ptr + 0x44A) { Name = "p1hp" }, //Player1 HP
			new MemoryWatcher<byte>(ptr + 0x91A) { Name = "enemyhp" }, //Enemy HP
			new MemoryWatcher<byte>(ptr + 0x72) { Name = "loading" }, //Some kind of load flag? From 5 to 6 is start for RTA
			new MemoryWatcher<byte>(ptr + 0x70) { Name = "turtleactive" }, //Turtle active flag? From 12 to 10 is start for SDA
			new MemoryWatcher<byte>(ptr + 0xD0) { Name = "p1turtle" }, //Turtle used by player 1 (0 during demo)
	};
	
	refreshRate = 60;
}

update {
	vars.watchers.UpdateAll(game);
	//print("--Stage: " + vars.watchers["stage"].Current + " | ControlFlag: " + vars.watchers["controlflag"].Current + " | Loading: " + vars.watchers["loading"].Current + " | Turtle Active: " + vars.watchers["turtleactive"].Current);
}

start { 
	bool start = false;
	
	//Start if RTA is true
	if (settings["rta"] && vars.watchers["stage"].Current == 0 && vars.watchers["loading"].Old == 5 && vars.watchers["loading"].Current == 6)
		start = true;
	//Start if RTA is false (SDA desired)
	if (!settings["rta"] && vars.watchers["p1turtle"].Current != 0 && vars.watchers["turtleactive"].Old == 12 && vars.watchers["turtleactive"].Current == 10)
		start = true;
	
	return start;
}

reset {
	return (vars.watchers["stage"].Current == 0 && vars.watchers["controlflag"].Current == 0 && vars.watchers["p1hp"].Current == 0
	&& vars.watchers["enemyhp"].Current == 0 && vars.watchers["loading"].Current == 0 & vars.watchers["turtleactive"].Current == 0);
}

split
{
	bool split = false;
	
	//Split when stage increases up until 9 (final stage)
	if (vars.watchers["stage"].Current > vars.watchers["stage"].Old && vars.watchers["stage"].Current <= 9)
		split = true;
	//Split upon losing control on final stage
	if (vars.watchers["stage"].Current == 9 && vars.watchers["controlflag"].Changed && vars.watchers["controlflag"].Current == 192)
		split = true;
		
	return split;
}
