//Created by Coltaho 3/14/2024

state("Moonlight Pulse") {}

startup {
	vars.scriptVer = "1.1";
	
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
	vars.Helper.UnityVersion = new Version(2021, 3);
	
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


init {
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
		var StartGame = mono["StartGame"];
		vars.Helper["start_IsExecuting"] = StartGame.Make<bool>("IsExecuting");
		var PlayTime = mono["PlayTime"];
		vars.Helper["playtime"] = PlayTime.Make<float>("_playTime", 0x38);
		var PlayerManager = mono["PlayerManager"];
		vars.Helper["lastSelectedCharacter"] = PlayerManager.Make<int>("_lastSelectedCharacter", 0x38);		
		vars.Helper["itemHeld"] = PlayerManager.Make<int>("Instance", 0x68, 0x130, 0x10);
		vars.Helper["itemHeld"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
		var BossHealthBar = mono["BossHealthBar"];
		vars.Helper["bossname"] = BossHealthBar.MakeString("Instance", 0x50, 0xD8);
		vars.Helper["boss_isdead"] = BossHealthBar.Make<bool>("Instance", 0x78, 0x7D);
        return true;
    });
	vars.paststring = "";
	vars.mystring = "";
	vars.nephkill = 0;
	vars.pastSplits = new HashSet<string>();
	vars.Log("Script Version: " + vars.scriptVer);
	
	vars.bossKilled = (Func<string, bool>)((value) =>
	{
		if (value == "Nephelie" && vars.Helper["bossname"].Current == "Nephelie" && vars.Helper["boss_isdead"].Current && !vars.Helper["boss_isdead"].Old) {
			vars.nephkill += 1;
			vars.Log("Nephelie kills: " + vars.nephkill);
		}
		return vars.Helper["boss_isdead"].Current && !vars.Helper["boss_isdead"].Old && vars.Helper["bossname"].Current == value;
	});

	vars.characterJoined = (Func<int, bool>)((value) =>
	{
		return vars.Helper["lastSelectedCharacter"].Changed && vars.Helper["lastSelectedCharacter"].Current == value;
	});
	
	vars.itemHeld = (Func<int, bool>)((value) =>
	{
		return vars.Helper["itemHeld"].Old != value && vars.Helper["itemHeld"].Current == value;
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

update {
	
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.pastSplits.Count > 0) {
		vars.pastSplits.Clear();
		vars.nephkill = 0;
	}
	
	if (settings["debug"]) {
		vars.mystring = "Held Item: " + current.itemHeld + " | Boss: " + current.bossname + " | isDead: " + current.boss_isdead + " | Neph kills: " + vars.nephkill + " | LastCharacter: " + vars.Helper["lastSelectedCharacter"].Current;
		if (vars.paststring != vars.mystring) {
			vars.Log(vars.mystring);
			vars.paststring = vars.mystring;
		}
	}
}

start {	
	if (!vars.Helper["start_IsExecuting"].Old && vars.Helper["start_IsExecuting"].Current && vars.Helper["playtime"].Current == 0) {	
		vars.Log("Go!");
		return true;
	}
}

reset {
	if (vars.Helper["playtime"].Old > 0 && vars.Helper["playtime"].Current == 0) {
		vars.Log("Reset!");
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
			vars.Log("Split: " + split.Key);
			return true;
		}
	}
}

gameTime {
	return TimeSpan.FromSeconds(current.playtime);
}

isLoading {
	return true;
}