//Made by Coltaho 8/6/2018

state("snes9x"){}
state("snes9x-x64"){}
state("higan"){}

startup
{
	vars.stopwatch = new Stopwatch();
	refreshRate = 60;		
	
	settings.Add("onding", true, "Split on helmet ding instead of boss kill");
	settings.SetToolTip("onding", "Turn off if you want to split on boss kill - Except for X-Hunters who talk before blowing up");

	settings.Add("main", false, "Mega Man X2 AutoSplitter v1.1 by Coltaho");
	settings.Add("main0", false, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.Add("main1", false, "- Supported emulators : Higan 105/106, Snes9X 1.55-1.58, 1.60 32 and 64 bit", "main");
	settings.SetToolTip("main", "Pretty cool, right?");
	
	
	vars.dostuff = (Action<Process, int>)((proc, mymodulesize) => {
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	switch (mymodulesize)
	{
		case 10244096: //snes9x (1.51 v7.1 rerecording)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28C4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7B28D4) + 0x2049;
			print(vars.othermemoryOffset.ToString());
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
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1407680A8);  //all of these seem to be first mem  + 0x18EE10 for 64 bit
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
			print(mymodulesize.ToString());
			vars.memoryOffset = IntPtr.Zero;
			vars.othermemoryOffset = IntPtr.Zero;
			break;
	}});

	//sfx is 5 the frame X puts his gun out on selecting game start (3rd frame after hitting start)
	//sfx is 17 the frame X teleports after killing the intro boss (blue line)
	
	vars.GetWatcherList = (Func<IntPtr, IntPtr, MemoryWatcherList>)((memoryOffset, othermemoryOffset) =>
	{
		return new MemoryWatcherList
		{
			new MemoryWatcher<byte>(memoryOffset + 0xD3F) { Name = "enemyhp" }, //enemy health (first slot in a section used for all enemies)
			new MemoryWatcher<byte>(memoryOffset + 0xD7F) { Name = "enemyhp2" }, //2nd health
			new MemoryWatcher<byte>(memoryOffset + 0xDBF) { Name = "enemyhp3" }, //3rd health
			new MemoryWatcher<byte>(memoryOffset + 0xDFF) { Name = "enemyhp4" }, //4th health
			new MemoryWatcher<byte>(memoryOffset + 0xD22) { Name = "enemyid" }, //enemy object id 1
			new MemoryWatcher<byte>(memoryOffset + 0xD62) { Name = "enemyid2" }, //enemy object id 2
			new MemoryWatcher<byte>(memoryOffset + 0xDA2) { Name = "enemyid3" }, //enemy object id 3
			new MemoryWatcher<byte>(memoryOffset + 0xDE2) { Name = "enemyid4" }, //enemy object id 4
			new MemoryWatcher<byte>(memoryOffset + 0x9FF) { Name = "myhp" }, //current health
			new MemoryWatcher<byte>(memoryOffset + 0x1FB3) { Name = "mylives" }, //current lives
			new MemoryWatcher<byte>(memoryOffset + 0x3C) { Name = "titleselection" }, //what cursor is on during title screen
			new MemoryWatcher<byte>(memoryOffset + 0x1FAD) { Name = "currentlevel" }, //current stage
			new MemoryWatcher<byte>(othermemoryOffset + 0xF7) { Name = "sfx" } //3 to 17 when teleporting
		};
	});
}

init
{
	vars.enemyids = new MemoryWatcher[4];
	vars.enemyhps = new MemoryWatcher[4];
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	vars.watchers = new MemoryWatcherList();
	vars.stopwatch.Restart();

	
	print("--Setting init variables!--");
	vars.introboss = 14; //multi slot, was in 3rd
	vars.mavericks = new Dictionary<string, int>();
	vars.mavericks["sponge"] = 35;
	vars.mavericks["gator"] = 60;
	vars.mavericks["stag"] = 56;
	vars.mavericks["centipede"] = 52;
	vars.mavericks["snail"] = 29;
	vars.mavericks["ostrich"] = 53; //multi slot, was in 1st
	vars.mavericks["crab"] = 30; //multi slot, was in 1st
	vars.mavericks["moth"] = 59;
	vars.mavericks["sigmafinal"] = 94; //multi slot, was in 1st
	vars.sigmabosses = new Dictionary<string, int>();
	vars.sigmabosses["violen"] = 90; //multi slot, was in 1st
	vars.sigmabosses["serges"] = 97; //multi slot, was in 1st
	vars.sigmabosses["agile"] = 89; //multi slot, was in 1st
	vars.currentBossList = vars.mavericks;
	vars.currentBossSlot = -1;
	vars.currentBossName = "";
	vars.inBossFight = 0;
	vars.shoryget = 0;
}

start { 
	if (vars.watchers["sfx"].Current == 5 && vars.watchers["titleselection"].Current == 0) {
		print("--Starting, Reset vars!--");
		vars.currentBossSlot = -1;
		vars.currentBossName = "";
		vars.inBossFight = 0;
		vars.shoryget = 0;
		print("--Here we go!--");
		return true;
	}
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
			vars.enemyids[0] = vars.watchers["enemyid"];
			vars.enemyids[1] = vars.watchers["enemyid2"];
			vars.enemyids[2] = vars.watchers["enemyid3"];
			vars.enemyids[3] = vars.watchers["enemyid4"];
			vars.enemyhps[0] = vars.watchers["enemyhp"];
			vars.enemyhps[1] = vars.watchers["enemyhp2"];
			vars.enemyhps[2] = vars.watchers["enemyhp3"];
			vars.enemyhps[3] = vars.watchers["enemyhp4"];
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
	//print("--SFX: " + vars.watchers["sfx"].Current + " mem: " + vars.memoryOffset + " otherMem: " + vars.othermemoryOffset);
	//print("--SFX: " + vars.watchers["sfx"].Current + " MyHP: " + vars.watchers["myhp"].Current + " Enemy1 ID: " + vars.watchers["enemyid"].Current + " EnemyHP: " + vars.watchers["enemyhp"].Current + " Enemy2 ID: " + vars.watchers["enemyid2"].Current  + " Enemy2HP: " + vars.watchers["enemyhp2"].Current + " level: " + vars.watchers["currentlevel"].Current + " bossname: " + vars.currentBossName + " bossslot: " + vars.currentBossSlot);
	print("--SFX: " + vars.watchers["sfx"].Current + " Stage: " + vars.watchers["currentlevel"].Current + " MyHP: " + vars.watchers["myhp"].Current + " Enemy1 ID: " + vars.watchers["enemyid"].Current + " EnemyHP: " + vars.watchers["enemyhp"].Current + " Enemy2 ID: " + vars.watchers["enemyid2"].Current  + " Enemy2HP: " + vars.watchers["enemyhp2"].Current + " Enemy3 ID: " + vars.watchers["enemyid3"].Current  + " Enemy3HP: " + vars.watchers["enemyhp3"].Current + " Enemy4 ID: " + vars.watchers["enemyid4"].Current  + " Enemy4HP: " + vars.watchers["enemyhp4"].Current + " bossname: " + vars.currentBossName + " bossslot: " + vars.currentBossSlot);
}

split
{
	//split after we teleport out of intro
	if (vars.watchers["sfx"].Old == 52 && vars.watchers["sfx"].Current == 17 && vars.watchers["currentlevel"].Current == 0) {
		print("--After Intro Boss Kill Teleport!--");
		return true;
	}
	
	//Iterate through the first 4 enemy objects and see if we are fighting a boss. If they die on their stage then split (so we don't split on refights)
	if (vars.currentBossSlot == -1) {
		if (vars.watchers["currentlevel"].Current <= 8) {
			vars.currentBossList = vars.mavericks;
		} else {
			vars.currentBossList = vars.sigmabosses;
		}
		for (int x = 0; x < 3; x++) {
			 foreach (var boss in vars.currentBossList) {
				if (vars.enemyids[x].Current == boss.Value) {
					print("--Boss found: " + boss.Key + " in slot: " + x);
					vars.currentBossName = boss.Key;
					vars.currentBossSlot = x;
					break;
				}
			 }
			 if (vars.currentBossSlot != -1) {
				 break;
			 }
		}
		if (vars.currentBossName == "") {
			vars.currentBossSlot = -1;
		}
	} else if (vars.currentBossSlot >= 0) {
		if (vars.inBossFight == 0 && (vars.enemyhps[vars.currentBossSlot].Current > vars.enemyhps[vars.currentBossSlot].Old || vars.enemyhps[vars.currentBossSlot].Current == 32 || vars.enemyhps[vars.currentBossSlot].Current == 64)) {
			print("--Boss fight started with: " + vars.currentBossName);
			vars.inBossFight = 1;
		}
		if (vars.inBossFight == 1 && vars.enemyids[vars.currentBossSlot].Current == 0) {
			print("--Died to boss: " + vars.currentBossName);
			vars.inBossFight = 0;
			vars.currentBossName = "";
			vars.currentBossSlot = -1;
			return;
		} else if (vars.inBossFight == 0 && vars.enemyids[vars.currentBossSlot].Current == 0) {
			print("--Boss faded (revisit or after kill)");
			vars.currentBossName = "";
			vars.currentBossSlot = -1;
			return;
		}
		if (vars.inBossFight == 1 && vars.currentBossName != "" && (vars.enemyhps[vars.currentBossSlot].Current == 0 || vars.enemyhps[vars.currentBossSlot].Current == 128) && vars.enemyids[vars.currentBossSlot].Current != 0) {
			print("--Boss killed: " + vars.currentBossName);
			//split if we just killed sigma final
			if (vars.currentBossName == "sigmafinal") {
				vars.inBossFight = 0;
				vars.currentBossName = "";
				return true;
			}
			vars.inBossFight = 0;
			vars.currentBossName = "";
		}
	}
	
	//split on teleport after refights
	if (vars.watchers["currentlevel"].Current == 12 && vars.watchers["sfx"].Old == 35 && vars.watchers["sfx"].Current == 17) {
		print("--After Refights Teleport!--");
		return true;
	}
	
	//split after we kill a boss and hear teleport out
	if (settings["onding"] && (vars.watchers["sfx"].Old == 3 || vars.watchers["sfx"].Old == 250) && (vars.watchers["sfx"].Current == 17 || vars.watchers["sfx"].Current == 29) && vars.currentBossSlot != -1) {
		print("--After Boss Kill Teleport!--");
		return true;
	}
	
	//split after we kill a boss and hear first explosion
	if (!settings["onding"] && vars.watchers["sfx"].Old != 17 && vars.watchers["sfx"].Old != 254 && vars.watchers["sfx"].Old != 246 && vars.watchers["sfx"].Current == 246 && vars.currentBossSlot != -1 && vars.currentBossName != "") {
		print("--After Boss Kill Explosion!--");
		return true;
	}
	
	return;
}