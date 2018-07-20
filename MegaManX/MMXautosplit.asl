//Made by Coltaho 6/24/2018

state("snes9x"){}
state("snes9x-x64"){}
state("higan"){}

startup
{
	vars.stopwatch = new Stopwatch();
	refreshRate = 60;
	settings.Add("onding", true, "Split on helmet ding instead of boss kill");
	settings.SetToolTip("onding", "Turn off if you want to split on boss kill");
	settings.Add("ongrab", true, "Split on Intro Grab instead of Intro teleport out");
	settings.SetToolTip("ongrab", "Turn off if you want to split on teleport out of the intro screen");
	
	settings.Add("hundosplits", true, "Optional 100% splits (Can keep on for Any%, it won't hurt)");
	settings.SetToolTip("hundosplits", "Turn off if you don't want to split on these events");
	settings.Add("chillpenguin", true, "- Chill Penguin Split (on heart pick up)", "hundosplits");
	settings.Add("hadouken", true, "- Hadouken Split (on helmet ding)", "hundosplits");
	
	settings.Add("main", false, "Mega Man X AutoSplitter v1.3 by Coltaho");
	settings.Add("main0", false, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.Add("main1", false, "- Supported emulators : Higan 105/106, Snes9X 1.53+ 32 and 64 bit", "main");
	settings.SetToolTip("main", "Pretty cool, right?");
	
	
	vars.dostuff = (Action<Process, int>)((proc, mymodulesize) => {
	vars.memoryOffset = IntPtr.Zero;
	vars.othermemoryOffset = IntPtr.Zero;
	switch (mymodulesize)
	{
		case 5914624: //snes9x (1.53)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x6EFBA4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x6EFBB4) + 0x2140 - 0xF7;
			break;
		case 6909952: //snes9x (1.53-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140405EC8);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140594CD8);
			break;
		case 6447104: //snes9x (1.54.1)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7410D4);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x7410E4)+ 0x2140 - 0xF7;
			break;
		case 7946240: //snes9x (1.54.1-x64)
			vars.memoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x1404DAF18);
			vars.othermemoryOffset = (IntPtr)proc.ReadValue<int>((IntPtr)0x140669D28);
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
		// case 12509184: //higan (v102)
			// vars.memoryOffset = 0x915304;
			// break;
		// case 13062144: //higan (v103)
			// vars.memoryOffset = 0x937324;
			// break;
		// case 15859712: //higan (v104)
			// vars.memoryOffset = 0x952144;
			// break;
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
			new MemoryWatcher<byte>(memoryOffset + 0xE8F) { Name = "enemyhp" }, //enemy health (first slot in a section used for all enemies)
			new MemoryWatcher<byte>(memoryOffset + 0xECF) { Name = "enemyhp2" }, //used for sigma 3 and eagle
			new MemoryWatcher<byte>(memoryOffset + 0xF0F) { Name = "enemyhp3" }, //3rd health
			new MemoryWatcher<byte>(memoryOffset + 0xF4F) { Name = "enemyhp4" }, //4th health
			new MemoryWatcher<byte>(memoryOffset + 0xE72) { Name = "enemyid" }, //enemy object id 1
			new MemoryWatcher<byte>(memoryOffset + 0xEB2) { Name = "enemyid2" }, //enemy object id 2
			new MemoryWatcher<byte>(memoryOffset + 0xEF2) { Name = "enemyid3" }, //enemy object id 3
			new MemoryWatcher<byte>(memoryOffset + 0xF32) { Name = "enemyid4" }, //enemy object id 4
			new MemoryWatcher<byte>(memoryOffset + 0xBCF) { Name = "myhp" }, //current health
			new MemoryWatcher<byte>(memoryOffset + 0x1F80) { Name = "mylives" }, //current lives
			new MemoryWatcher<byte>(memoryOffset + 0x3C) { Name = "titleselection" }, //what cursor is on during title screen
			new MemoryWatcher<byte>(memoryOffset + 0x1F7A) { Name = "currentlevel" }, //current stage
			new MemoryWatcher<byte>(memoryOffset + 0xB3) { Name = "fade" }, //current amount of screen fade
			new MemoryWatcher<byte>(memoryOffset + 0xA8) { Name = "mycontroller" }, //controller input
			new MemoryWatcher<byte>(memoryOffset + 0x1F7E) { Name = "myvisits" }, //visits to hadoukun, turns to 133 when you get it
			new MemoryWatcher<byte>(memoryOffset + 0x1F9C) { Name = "myhearts" }, //Bitflags for heart tanks collected. Format hgfedcba: a = Penguin b = Armadillo c = Eagle d = Chameleon e = Mammoth f = Kuwanger g = Mandrill h = Octopus
			new MemoryWatcher<byte>(memoryOffset + 0xC32) { Name = "stance" }, //kind of a stance flag? I think i can use it for intro grab (value of 48)
			new MemoryWatcher<byte>(memoryOffset + 0x1F9B) { Name = "introdone" }, //0 if intro is not done, 4 if it is
			new MemoryWatcher<byte>(othermemoryOffset + 0xF7) { Name = "sfx" } //250 to 45 when helmet dings       
		};
			vars.enemyids[0] = vars.watchers["enemyid"];
			vars.enemyids[1] = vars.watchers["enemyid2"];
			vars.enemyids[2] = vars.watchers["enemyid3"];
			vars.enemyids[3] = vars.watchers["enemyid4"];
			vars.enemyhps[0] = vars.watchers["enemyhp"];
			vars.enemyhps[1] = vars.watchers["enemyhp2"];
			vars.enemyhps[2] = vars.watchers["enemyhp3"];
			vars.enemyhps[3] = vars.watchers["enemyhp4"];
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
	vars.introtext = 60;
	vars.mavericks = new Dictionary<string, int>();
	vars.mavericks["penguin"] = 2;
	vars.mavericks["eagle"] = 82;
	vars.mavericks["octopus"] = 7;
	vars.mavericks["mammmoth"] = 12;
	vars.mavericks["kuwanger"] = 5;
	vars.mavericks["armadilllo"] = 20;
	vars.mavericks["mandrill"] = 49;
	vars.mavericks["chameleon"] = 10;
	vars.sigmabosses = new Dictionary<string, int>();
	vars.sigmabosses["sigma1"] = 99;
	vars.sigmabosses["sigma2"] = 93;
	vars.sigmabosses["sigma3"] = 97;
	vars.sigmabosses["sigmafinal"] = 101;
	vars.currentBossList = vars.mavericks;
	vars.currentBossSlot = -1;
	vars.currentBossName = "";
	vars.inBossFight = 0;
	vars.sigmaFight = 1;
	vars.hadoget = 0;
}

start { 
	if (vars.watchers["sfx"].Current == 4 && vars.watchers["titleselection"].Current == 0) {
		print("--Starting, Reset vars!--");
		vars.currentBossSlot = -1;
		vars.currentBossName = "";
		vars.inBossFight = 0;
		vars.sigmaFight = 1;
		vars.hadoget = 0;
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
	print("--SFX: " + vars.watchers["sfx"].Current + " mem: " + vars.memoryOffset + " otherMem: " + vars.othermemoryOffset);
	//print("--SFX: " + vars.watchers["sfx"].Current + " MyHP: " + vars.watchers["myhp"].Current + " Enemy1 ID: " + vars.watchers["enemyid"].Current + " EnemyHP: " + vars.watchers["enemyhp"].Current + " Enemy2 ID: " + vars.watchers["enemyid2"].Current  + " Enemy2HP: " + vars.watchers["enemyhp2"].Current + " Combat: " + vars.inBossFight + " bossname: " + vars.currentBossName + " bossslot: " + vars.currentBossSlot);
}

split
{
	//split after X is grabbed during Intro
	if (settings["ongrab"] && vars.watchers["currentlevel"].Current == 0 && vars.watchers["stance"].Old == 46 && vars.watchers["stance"].Current == 48) {
		print("--Yay intro done!--");
		return true;
	} else 
	//split after intro (Zero stops yapping and they teleport out)	
	if (!settings["ongrab"] && vars.watchers["introdone"].Old == 0 && vars.watchers["introdone"].Current == 4) {
		print("--Yay intro done!--");
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
		}
		if (vars.currentBossName == "") {
			vars.currentBossSlot = -1;
		}
	} else if (vars.currentBossSlot >= 0) {
		if (vars.inBossFight == 0 && (vars.enemyhps[vars.currentBossSlot].Current > vars.enemyhps[vars.currentBossSlot].Old || vars.enemyhps[vars.currentBossSlot].Current == 32)) {
			print("--Boss fight started with: " + vars.currentBossName);
			vars.inBossFight = 1;
		}
		if (vars.inBossFight == 1 && vars.enemyids[vars.currentBossSlot].Current == 0) {
			print("--Died to boss: " + vars.currentBossName);
			vars.inBossFight = 0;
			vars.currentBossName = "";
			vars.currentBossSlot = -1;
			vars.sigmaFight = 1;
			return;
		} else if (vars.inBossFight == 0 && vars.enemyids[vars.currentBossSlot].Current == 0) {
			print("--Boss faded (revisit or after kill)");
			vars.currentBossName = "";
			vars.currentBossSlot = -1;
			return;
		}
		if (vars.inBossFight == 1 && vars.currentBossName != "" && vars.enemyhps[vars.currentBossSlot].Current == 0 && vars.enemyids[vars.currentBossSlot].Current != 0) {
			if (vars.currentBossName == "sigmafinal" && vars.sigmaFight == 1) {
				vars.inBossFight = 0;
				vars.sigmaFight++;
				print("--Sigma Phase 1 killed!");
				return;
			} else {
				print("--Boss killed: " + vars.currentBossName);
				vars.inBossFight = 0;
				vars.currentBossName = "";
				//split on boss kill if onding is true, OR always if we killed final sigma
				if (!settings["onding"] || vars.sigmaFight == 2) {
					return true;
				}
			}
		}
	}
	
	//split after we kill a boss and hear helmet ding
	if (settings["onding"] && vars.watchers["sfx"].Old == 250 && vars.watchers["sfx"].Current == 45 && vars.currentBossSlot != -1) {
		print("--After Boss Kill Helmet Ding!--");
		return true;
	}
	
	//split when chill penguin tank is picked up, bit 0 is this tank
	if (settings["chillpenguin"] && ((vars.watchers["myhearts"].Old & (1 << 0)) == 0) && ((vars.watchers["myhearts"].Current & (1 << 0)) == 1)) {
		print("--Yay chill penguin heart got!--");
		return true;
	}
	
	//split when we get hadouken and helmet dings
	if (settings["hadouken"] && vars.hadoget == 0 && vars.watchers["myvisits"].Current == 133 && vars.watchers["sfx"].Current == 45) {
		print("--Yay HADOUKEN!--");
		vars.hadoget = 1;
		return true;
	}
	
	return;
}
