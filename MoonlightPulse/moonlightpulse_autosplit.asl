//Created by Coltaho 3/14/2024
//Updated 11/26/2025 for new Unity patch by Rumii

state("Moonlight Pulse") {}

startup
{
	vars.scriptVer = "1.2";
	
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
	vars.Uhara.EnableDebug();
	
	settings.Add("bosskills", true, "---Bosses---");
	settings.Add("siflaron", true, "Siflaron", "bosskills");
	settings.Add("pipen", true, "Pipen", "bosskills");
	settings.Add("nephelie", true, "Nephelie", "bosskills");
	settings.Add("evilsilex", true, "Evil Silex", "bosskills");
	settings.Add("racnore", true, "Racnore", "bosskills");
	settings.Add("efbee", true, "Efbee", "bosskills");
	
	settings.Add("charactersjoin", true, "---Characters---");
	settings.Add("charlotte", true, "Charlotte", "charactersjoin");
	settings.Add("clyde", true, "Clyde", "charactersjoin");
	
	settings.Add("itemsheld", true, "---Items Held---");
	settings.Add("puritystone", true, "Purity Stone", "itemsheld");
	
	settings.Add("scriptsection", true, "---Script Options---");
	settings.Add("debug", false, "Print Debug Info", "scriptsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Moonlight Pulse autosplitter v" + vars.scriptVer + " by Coltaho", "infosection");
	settings.Add("info1", true, "- Autosplit: PC Steam version, maybe others", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
    var Tool = vars.Uhara.CreateTool("Unity", "IL2CPP", "Instance");
	
	Tool.Watch<bool>("start_IsExecuting", "StartGame", "<IsExecuting>k__BackingField");
	Tool.Watch<float>("playtime", "PlayTime", "_playTime", "<Value>k__BackingField");
	Tool.Watch<int>("lastSelectedCharacter", "Players:PlayerManager", "_lastSelectedCharacter", "<Value>k__BackingField");
	Tool.Watch<int>("itemHeld", "Players:PlayerManager", "<Instance>k__BackingField", "<CurrentPlayer>k__BackingField", "<HeldItem>k__BackingField", "<Id>k__BackingField");
	vars.Resolver["itemHeld"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
	var BossName = Tool.Get("UI.BossHealthBar:BossHealthBar", "<Instance>k__BackingField", "_bossText", "m_text", "0x14");
	vars.Resolver.WatchString("bossname", BossName.Base, BossName.Offsets);
	Tool.Watch<bool>("boss_isdead", "UI.BossHealthBar:BossHealthBar", "<Instance>k__BackingField", "<BossEnemy>k__BackingField", "<IsDead>k__BackingField");
	
	vars.paststring = "";
	vars.mystring = "";
	vars.nephkill = 0;
	vars.pastSplits = new HashSet<string>();
	vars.Uhara.Log("Script Version: " + vars.scriptVer);
	
	vars.bossKilled = (Func<string, bool>)((value) =>
	{
		if (value == "Nephelie" && current.bossname == "Nephelie" && vars.Resolver["boss_isdead"].Current && !vars.Resolver["boss_isdead"].Old)
		{
			vars.nephkill += 1;
			vars.Uhara.Log("Nephelie kills: " + vars.nephkill);
		}
		return vars.Resolver["boss_isdead"].Current && !vars.Resolver["boss_isdead"].Old && current.bossname == value;
	});

	vars.characterJoined = (Func<int, bool>)((value) =>
	{
		return vars.Resolver["lastSelectedCharacter"].Current != vars.Resolver["lastSelectedCharacter"].Old && vars.Resolver["lastSelectedCharacter"].Current == value;
	});
	
	vars.itemHeld = (Func<int, bool>)((value) =>
	{
		return vars.Resolver["itemHeld"].Old != value && vars.Resolver["itemHeld"].Current == value;
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{			
			// Bosses
			{ "siflaron", vars.bossKilled("Siflaron") },
			{ "pipen", vars.bossKilled("Pipen") },
			{ "nephelie", vars.bossKilled("Nephelie") },
			{ "evilsilex", vars.bossKilled("Silex") },
			{ "racnore", vars.bossKilled("Racnore") },
			{ "efbee", vars.bossKilled("Efbee") },

			// Characters Join
			{ "charlotte", vars.characterJoined(4) },
			{ "clyde", vars.characterJoined(5) },
			
			// Item first held by current character
			{ "puritystone", vars.itemHeld(4) }
		};
		return splits;
	});
}

update
{
    vars.Uhara.Update();	

	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0)
	{
		vars.pastSplits.Clear();
		vars.nephkill = 0;
	}
	
	if (settings["debug"])
	{
		vars.mystring = "Held Item: " + current.itemHeld + " | Boss: " + current.bossname + " | isDead: " + current.boss_isdead + " | Neph kills: " + vars.nephkill + " | LastCharacter: " + current.lastSelectedCharacter;
		if (vars.paststring != vars.mystring)
		{
			vars.Uhara.Log(vars.mystring);
			vars.paststring = vars.mystring;
		}
	}
}

start
{	
	if (!old.start_IsExecuting && current.start_IsExecuting && current.playtime == 0)
	{	
		vars.Uhara.Log("Go!");
		return true;
	}
}

reset
{
	if (old.playtime > 0 && current.playtime == 0)
	{
		vars.Uhara.Log("Reset!");
		return true;
	}
}

split {
	var splits = vars.GetSplitList();

	foreach (var split in splits)
	{
		if (settings[split.Key] && split.Value && !vars.pastSplits.Contains(split.Key))
		{
			if (split.Key == "nephelie" && vars.nephkill <= 1) {
				return false;
			}
			vars.pastSplits.Add(split.Key);
			vars.Uhara.Log("Split: " + split.Key);
			return true;
		}
	}
}

gameTime
{
	return TimeSpan.FromSeconds(current.playtime);
}

isLoading
{
	return true;
}