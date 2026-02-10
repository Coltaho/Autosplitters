//Created by Coltaho 1/29/2026

state("mio", "Unknown") {
	// float gametime : 0x1113C20; //release
	// int deaths : 0x1113BF4;
	float gametime : 0x1114C20;
	int deaths : 0x1114BF4;
}

state("mio", "patch1.2") { 
	float gametime : 0x1114C20;
	int deaths : 0x1114BF4;
}

startup
{
	vars.scriptVer = "0.9.2";
	
	settings.Add("misc", true, "---Misc---");
	settings.Add("intro", true, "Intro Completed", "misc");
	settings.Add("hacker_met", true, "Hacker Met (Samsk finished upgrade)", "misc");
	settings.Add("fan_breakables", true, "Metropolis Last Fan Breakable", "misc");
	
	settings.Add("bossmeet", false, "---Bosses Meet---");
	settings.Add("nabuu_meet", false, "Nabuu Meet", "bossmeet");
	settings.Add("egis_meet", false, "Egis Meet", "bossmeet");
	settings.Add("flora_meet", false, "Flora Meet", "bossmeet");
	settings.Add("acat_meet", false, "Acat Meet", "bossmeet");
	settings.Add("atmos_meet", false, "Atmos Meet", "bossmeet");
	settings.Add("devourer_meet", false, "Lombre Meet", "bossmeet");
	settings.Add("poltergates_meet", false, "Poltergates Meet", "bossmeet");
	settings.Add("anra_meet", false, "Anra Meet", "bossmeet");
	settings.Add("rambo_meet", false, "Debby Meet", "bossmeet");
	settings.Add("ati_meet", false, "Ati Meet", "bossmeet");
	settings.Add("sawlong_meet", false, "Sawlong Meet", "bossmeet");
	settings.Add("crow_meet", false, "Crow Meet", "bossmeet");
	settings.Add("friends_meet", false, "Friends Meet", "bossmeet");	
	settings.Add("doubleegis_meet", false, "Double Egis Meet", "bossmeet");
	settings.Add("zangy_meet", false, "Calderon Meet", "bossmeet");
	settings.Add("vlad_meet", false, "Vlad Meet", "bossmeet");
	settings.Add("solvin_meet", false, "Sol and Vin Meet", "bossmeet");
	settings.Add("shii_meet", false, "Shii Meet", "bossmeet");
	
	settings.Add("bosskills", true, "---Bosses Killed---");
	settings.Add("nabuu_dead", true, "Nabuu Dead", "bosskills");
	settings.Add("egis_dead", true, "Egis Dead", "bosskills");
	settings.Add("flora_dead", true, "Flora Dead", "bosskills");
	settings.Add("acat_dead", true, "Acat Dead", "bosskills");
	settings.Add("atmos_dead", true, "Atmos Dead", "bosskills");
	settings.Add("devourer_dead", true, "Lombre Dead", "bosskills");
	settings.Add("poltergates_dead", true, "Poltergates Dead", "bosskills");
	settings.Add("anra_dead", true, "Anra and Halyn Dead", "bosskills");
	settings.Add("rambo_dead", true, "Debby Dead", "bosskills");
	settings.Add("ati_dead", true, "Ati Dead", "bosskills");
	settings.Add("sawlong_dead", true, "Sawlong Dead", "bosskills");
	settings.Add("crow_dead", true, "Crow Dead", "bosskills");
	settings.Add("friends_dead", true, "Friends Dead", "bosskills");
	settings.Add("doubleegis_dead", true, "Double Egis Dead", "bosskills");
	settings.Add("zangy_dead", true, "Calderon Dead", "bosskills");
	settings.Add("vlad_dead", true, "Vlad Dead", "bosskills");
	settings.Add("solvin_dead", true, "Sol and Vin Dead", "bosskills");
	settings.Add("shii_dead", true, "Shii Dead", "bosskills");
	
	settings.Add("voicesobtained", true, "---Voices Obtained---");
	settings.Add("voice_amytis", true, "Amytis (Breath)", "voicesobtained");
	settings.Add("voice_asma", true, "Asma (Eye)", "voicesobtained");
	settings.Add("voice_halyn", false, "Halyn (Hand)", "voicesobtained");
	settings.Add("voice_liho", true, "Liho (Blood)", "voicesobtained");
	settings.Add("voice_noden", false, "Noden (Spine)", "voicesobtained");
	
	settings.Add("skillsunlocked", true, "---Skills Unlocked---");
	settings.Add("unlock_map", false, "Map", "skillsunlocked");
	settings.Add("unlock_grapple", false, "Hairpin", "skillsunlocked");
	settings.Add("unlock_hitrecharge", false, "Hit Recharge", "skillsunlocked");
	settings.Add("unlock_glide", true, "Glide", "skillsunlocked");
	settings.Add("unlock_block", true, "Dodge", "skillsunlocked");
	settings.Add("unlock_spider", false, "Spider", "skillsunlocked");
	settings.Add("unlock_slingshot", true, "Slingshot", "skillsunlocked");
	settings.Add("unlock_spidergoo", true, "Spider Goo", "skillsunlocked");
	
	settings.Add("modsobtained", true, "---Mods Obtained---");	
	settings.Add("mod_alexandersfate", false, "Alexander's Fate", "modsobtained");
	settings.Add("mod_analyser", false, "Analyser", "modsobtained");
	settings.Add("mod_berserker", false, "Berserker", "modsobtained");
	settings.Add("mod_betterdodge", false, "Enhanced Dodge", "modsobtained");
	settings.Add("mod_energyleacher", false, "Energy Leecher", "modsobtained");
	settings.Add("mod_glitchtrail", false, "Glitch Trail", "modsobtained");
	settings.Add("mod_countermeasures", false, "Counter Measures", "modsobtained");
	settings.Add("mod_oathember", false, "Oath to Ember", "modsobtained");
	settings.Add("mod_afterimage", false, "Afterimage", "modsobtained");
	settings.Add("mod_perfectstate", false, "Perfect State", "modsobtained");
	settings.Add("mod_nacredrought", false, "Nacre Drought", "modsobtained");
	settings.Add("mod_foolishideal", false, "Foolish Ideal", "modsobtained");
	settings.Add("mod_reducedlatency", false, "Reduced Latency", "modsobtained");
	settings.Add("mod_highriskvoucher", false, "High-Risk Voucher", "modsobtained");
	settings.Add("mod_defectivecore", false, "Defective Core", "modsobtained");
	settings.Add("mod_birdofprey", false, "Bird of Prey", "modsobtained");
	settings.Add("mod_firefly", false, "Firefly", "modsobtained");
	settings.Add("mod_defensemech", false, "Defense Mechanism", "modsobtained");
	settings.Add("mod_gratitude", false, "Gratitude", "modsobtained");
	settings.Add("mod_kineticthrust", true, "Kinetic Thrust", "modsobtained");
	settings.Add("mod_wildcat", false, "Wild Cat", "modsobtained");
	settings.Add("mod_sharpenedhairpin", false, "Sharpened Hairpin", "modsobtained");
	settings.Add("mod_selfawareness", false, "Self-Awareness", "modsobtained");
	settings.Add("mod_painconversion", false, "Pain Conversion", "modsobtained");
	settings.Add("mod_imperfectfocus", false, "Imperfect Focus", "modsobtained");
	settings.Add("mod_makeshiftrecovery", false, "Makeshift Recovery", "modsobtained");
	settings.Add("mod_resourceshort", false, "Resources Shortage", "modsobtained");
	settings.Add("mod_portablecrystal", false, "Portable Crystalliser", "modsobtained");
	settings.Add("mod_mainthack", false, "Maintenance Hack", "modsobtained");
	settings.Add("mod_effectivedismaintle", false, "Effective Dismantlement", "modsobtained");
	settings.Add("mod_splinterdodge", false, "Splintering Dodge", "modsobtained");
	settings.Add("mod_defrag", false, "Defragmentation", "modsobtained");
	settings.Add("mod_asmaswill", false, "Asma's Will", "modsobtained");
	settings.Add("mod_heartsfav", false, "The Heart's Favourite", "modsobtained");
	settings.Add("mod_nacreoverload", false, "Nacre Overload", "modsobtained");
	settings.Add("mod_thinnerframe", false, "Thinner Frame", "modsobtained");
	settings.Add("mod_protoverlay", false, "Protective Overlay", "modsobtained");
	settings.Add("mod_splitprocess", false, "Split Process", "modsobtained");
	settings.Add("mod_blackwidow", false, "Black Widow", "modsobtained");
	settings.Add("mod_highvoltage", false, "High-voltage Discharge", "modsobtained");
	settings.Add("mod_sunsail", false, "Sunsail", "modsobtained");
	settings.Add("mod_extracoating", false, "Extra-Coating Processor", "modsobtained");
	
	settings.Add("dialogread", true, "---Dialogue Read---");
	settings.Add("dialog_rad_kidnapping", true, "DIALOG:TXT_RAD_KIDNAPPING", "dialogread");
	settings.Add("dialog_flick", true, "DIALOG:VO_ST_HALYN_MEETING_FLICK", "dialogread");
	
	settings.Add("candleobtained", true, "---Candle Obtained---");
	settings.Add("candle_0", false, "Candle 0", "candleobtained");
	settings.Add("candle_1", false, "Candle 1", "candleobtained");
	settings.Add("candle_2", false, "Candle 2", "candleobtained");
	settings.Add("candle_3", false, "Candle 3", "candleobtained");
	settings.Add("candle_4", false, "Candle 4", "candleobtained");
	settings.Add("candle_5", false, "Candle 5", "candleobtained");
	settings.Add("candle_6", false, "Candle 6", "candleobtained");
	settings.Add("candle_7", false, "Candle 7", "candleobtained");
	settings.Add("candle_8", false, "Candle 8", "candleobtained");
	settings.Add("candle_9", false, "Candle 9", "candleobtained");
	settings.Add("candle_10", false, "Candle 10", "candleobtained");
	settings.Add("candle_11", false, "Candle 11", "candleobtained");
	
	settings.Add("atkpowerobtained", true, "---Attack Power Obtained---");
	settings.Add("atkpower_0", true, "Attack Power 0 (Ice Pierced)", "atkpowerobtained");
	settings.Add("atkpower_1", true, "Attack Power 1 (Above Nexus)", "atkpowerobtained");
	settings.Add("atkpower_2", false, "Attack Power 2 (In Plants)", "atkpowerobtained");
	settings.Add("atkpower_3", false, "Attack Power 3 (After Twin Egis)", "atkpowerobtained");
	settings.Add("atkpower_4", false, "Attack Power 4 (End of Pit)", "atkpowerobtained");
	
	settings.Add("checkpointobtained", true, "---Checkpoint Obtained---");
	settings.Add("cp_nexus", true, "Nexus", "checkpointobtained");	
	settings.Add("cp_citygates", false, "City Gates", "checkpointobtained");
	settings.Add("cp_cityhall", false, "City Hall", "checkpointobtained");
	settings.Add("cp_bloodsanctum", false, "Blood Sanctum", "checkpointobtained");
	settings.Add("cp_belltower", false, "Bell Tower", "checkpointobtained");
	settings.Add("cp_promenadeentrance", false, "Promenade Entrance", "checkpointobtained");
	settings.Add("cp_promenadetower", false, "Promenade Tower", "checkpointobtained");
	settings.Add("cp_redacted1", false, "Redacted One", "checkpointobtained");
	settings.Add("cp_redacted2", false, "Redacted Two", "checkpointobtained");
	settings.Add("cp_vaultsshuttle", false, "Vault's Shuttle", "checkpointobtained");
	settings.Add("cp_canopy", false, "Canopy", "checkpointobtained");
	settings.Add("cp_dwellings", false, "Dwellings", "checkpointobtained");
	settings.Add("cp_celestialbay", false, "Celestial Bay", "checkpointobtained");
	settings.Add("cp_library", false, "Library", "checkpointobtained");
	settings.Add("cp_crucible", false, "Crucible", "checkpointobtained");
	settings.Add("cp_lab", false, "The Lab", "checkpointobtained");
	settings.Add("cp_vaults", true, "Vaults", "checkpointobtained");
	settings.Add("cp_manufactory", false, "Manufactory", "checkpointobtained");
	settings.Add("cp_pit", false, "The Pit", "checkpointobtained");
	
	settings.Add("overseerobtained", true, "---Overseer Obtained---");
	settings.Add("os_nexus", false, "Nexus", "overseerobtained");	
	settings.Add("os_citygates", false, "City Gates", "overseerobtained");
	settings.Add("os_cityhall", false, "City Hall", "overseerobtained");
	settings.Add("os_bloodsanctum", false, "Blood Sanctum", "overseerobtained");
	settings.Add("os_belltower", false, "Bell Tower", "overseerobtained");
	settings.Add("os_promenadeentrance", false, "Promenade Entrance", "overseerobtained");
	settings.Add("os_promenadetower", false, "Promenade Tower", "overseerobtained");
	settings.Add("os_redacted1", false, "Redacted One", "overseerobtained");
	settings.Add("os_redacted2", false, "Redacted Two", "overseerobtained");
	settings.Add("os_vaultsshuttle", false, "Vault's Shuttle", "overseerobtained");
	settings.Add("os_canopy", false, "Canopy", "overseerobtained");
	settings.Add("os_dwellings", false, "Dwellings", "overseerobtained");
	settings.Add("os_celestialbay", false, "Celestial Bay", "overseerobtained");
	settings.Add("os_crucible", false, "Crucible", "overseerobtained");
	settings.Add("os_lab", false, "The Lab", "overseerobtained");
	settings.Add("os_vaults", false, "Vaults", "overseerobtained");
	settings.Add("os_manufactory", false, "Manufactory", "overseerobtained");
	
	settings.Add("keyobtained", true, "---Key Obtained---");
	settings.Add("key_roots", false, "Silo Access Badge", "keyobtained");	
	settings.Add("key_glasshouse", false, "Averie Passport", "keyobtained");
	settings.Add("key_belltower", false, "Bell Tower Pass", "keyobtained");	
	settings.Add("key_friendlyinvite", false, "Friendly Invitation", "keyobtained");	
	
	settings.Add("endingsection", true, "---Endings---");
	settings.Add("badending", true, "Bad Ending", "endingsection");
	settings.Add("goodending", true, "Good Ending", "endingsection");
	
	settings.Add("scriptsection", true, "---Script Options---");
	settings.Add("debug", false, "Print Debug Info", "scriptsection");
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "MIO autosplitter v" + vars.scriptVer + " by Coltaho", "infosection");
	settings.Add("info1", true, "- Autosplit: PC version", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("[Autosplitter] Script v" + vars.scriptVer + " init starting...");
	
	string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    
	switch (MD5Hash) {
            case "2FF2DF335A5D2F4943079CDDACFAAB15":
                version = "patch1.2";
                break;
            default:
                version = "Unknown";
                break;
	}
	print("[Autosplitter] Hash is: " + MD5Hash + " | version: " + version);
	
	// var targetSignature = new SigScanTarget(0, "5B 73 61 76 65 5D 20 6E 65 77 20 73 61 76 65 20 61 6C 72 65 61 64 79 20");
	// var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
	// IntPtr ptr = scanner.Scan(targetSignature);
	// print("[Autosplitter] Found ptr: " + ptr.ToString("X"));
	
	string savePath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData) + "\\MIO\\Saves\\";
	string selectedFileName = "";
	if (File.Exists(savePath + "savepath.txt")){
		print("[Autosplitter] Found config file: " + savePath + "savepath.txt");
		try {
			selectedFileName = File.ReadAllText(savePath + "savepath.txt");
			Path.GetFullPath(selectedFileName);
			print("[Autosplitter] Selected filename read: " + selectedFileName);
		} catch (Exception ex) {
			print("[Autosplitter] Error reading config file! " + ex.Message);
			MessageBox.Show("Error reading config file!\n\n" + ex.Message + "\n\nScript will need manual restart by removing component and re-adding.",
				"Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
		}
	} else {	
		print("[Autosplitter] No config file found at: " + savePath + "savepath.txt");
		MessageBox.Show("A save file must be selected for autosplitter to work.\n\nThis was only tested on Steam saves, let me know in Discord if your platform doesn't work.\n\nNote that it will watch all slot_*.save files in the folder no matter which you select.\n\nThis path will be written to /Mio/Saves/savepath.txt and used in the future.\n\nScript Version " + vars.scriptVer,
			"Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);				
		
		OpenFileDialog openFileDialog1 = new OpenFileDialog();
		openFileDialog1.InitialDirectory = savePath;
		openFileDialog1.Filter = "Save files (*.save)|*.save|All files (*.*)|*.*";
		openFileDialog1.FilterIndex = 1;
		openFileDialog1.RestoreDirectory = true;
		openFileDialog1.Title = "Select a save file to watch";

		if (openFileDialog1.ShowDialog() == DialogResult.OK)
		{
			selectedFileName = openFileDialog1.FileName;
			try {
				File.WriteAllText(savePath + "savepath.txt", selectedFileName);		
				print("[Autosplitter] Created new savepath.txt file: " + selectedFileName);
			} catch (Exception ex) {
				print("[Autosplitter] Error writing config file! " + ex.Message);
				MessageBox.Show("Error writing config file!\n\n" + ex.Message + "\n\nYou will have to select a new file next time. Autosplitter could still work fine.",
				"Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}			
			print("[Autosplitter] Selected Save: " + selectedFileName);
		} else {
			print("[Autosplitter] No Selected Save! Will not split!");
			MessageBox.Show("No save selected, autosplitter unable to work.\n\nScript will need manual restart by removing component and re-adding.",
				"Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
		}
	}
	
	if (File.Exists(selectedFileName)){		
		vars.watcher = new FileSystemWatcher(Path.GetDirectoryName(selectedFileName));
		vars.watcher.Filter = "slot_*.save";
		FileSystemEventHandler _handler = (sender, args) =>
		{
			// print("[Autosplitter] FileWatcher: " + args.FullPath + " " + args.ChangeType);
			vars.args = args;
			vars.CheckData = true;
		};	
		vars.myhandler = _handler;
		vars.watcher.Deleted += vars.myhandler;
		vars.watcher.EnableRaisingEvents = true;
		print("[Autosplitter] File Watcher initialized!");
	} else {
		print("[Autosplitter] File Watcher not initialized! Will not split!");
	}
	
	vars.stopwatch = new Stopwatch();
	vars.delay = 0;
	vars.CheckData = false;
	vars.OldList = new List<string>();
	vars.NewestList = new List<string>();
	vars.hackermet = false;
	vars.paststring = "";
	vars.mystring = "";
	vars.pastSplits = new HashSet<string>();	
	
	vars.eventExists = (Func<string, bool>)((value) =>
	{
		return vars.NewestList.Contains(value);
	});
	
	vars.GetSplitList = (Func<Dictionary<string, bool>>)(() =>
	{
		var splits = new Dictionary<string, bool>
		{
			// Triggers
			{ "intro", vars.eventExists("CODE:TUTO_JUMP_DONE") },
			{ "hacker_met", vars.hackermet },
			{ "fan_breakables", vars.eventExists("BREAKABLE:0x2213a832e590affa") },
			{ "badending", vars.eventExists("GAME:BAD_ENDING") },
			{ "goodending", vars.eventExists("GAME:GOOD_ENDING") },
			
			{ "nabuu_meet", vars.eventExists("BOSS_MEET:BAMBY") },
			{ "egis_meet", vars.eventExists("BOSS_MEET:CRABASH") },
			{ "flora_meet", vars.eventExists("BOSS_MEET:VINE") },
			{ "acat_meet", vars.eventExists("BOSS_MEET:BLACKSMITH") },
			{ "atmos_meet", vars.eventExists("BOSS_MEET:TRAPU") },
			{ "devourer_meet", vars.eventExists("BOSS_MEET:DEVOURER") },
			{ "poltergates_meet", vars.eventExists("BOSS_MEET:DOOR") },
			{ "anra_meet", vars.eventExists("BOSS_MEET:PROJEKT") },
			{ "rambo_meet", vars.eventExists("BOSS_MEET:RAMBO") },
			{ "ati_meet", vars.eventExists("BOSS_MEET:SASUKE") },
			{ "sawlong_meet", vars.eventExists("BOSS_MEET:SAW_LONGUE") },
			{ "crow_meet", vars.eventExists("BOSS_MEET:SCARECROW") },
			{ "shii_meet", vars.eventExists("BOSS_MEET:SHII") },
			{ "friends_meet", vars.eventExists("BOSS_MEET:SPIDY") },
			{ "solvin_meet", vars.eventExists("BOSS_MEET:TWIN") },
			{ "doubleegis_meet", vars.eventExists("BOSS_MEET:TWIN_CRABASH") },
			{ "vlad_meet", vars.eventExists("BOSS_MEET:WASHING_MACHINE") },
			{ "zangy_meet", vars.eventExists("BOSS_MEET:ZANGY") },
			
			{ "nabuu_dead", vars.eventExists("BOSS:BAMBY") },
			{ "egis_dead", vars.eventExists("BOSS:CRABASH") },
			{ "flora_dead", vars.eventExists("BOSS:VINE") },
			{ "acat_dead", vars.eventExists("BOSS:BLACKSMITH") },
			{ "atmos_dead", vars.eventExists("BOSS:TRAPU") },
			{ "devourer_dead", vars.eventExists("BOSS:DEVOURER") },
			{ "poltergates_dead", vars.eventExists("BOSS:DOOR") },
			{ "anra_dead", vars.eventExists("BOSS:PROJEKT") },
			{ "rambo_dead", vars.eventExists("BOSS:RAMBO") },
			{ "ati_dead", vars.eventExists("BOSS:SASUKE") },
			{ "sawlong_dead", vars.eventExists("BOSS:SAW_LONGUE") },
			{ "crow_dead", vars.eventExists("BOSS:SCARECROW") },
			{ "shii_dead", vars.eventExists("BOSS:SHII") },
			{ "friends_dead", vars.eventExists("BOSS:SPIDY") },
			{ "solvin_dead", vars.eventExists("BOSS:TWIN") },
			{ "doubleegis_dead", vars.eventExists("BOSS:TWIN_CRABASH") },
			{ "vlad_dead", vars.eventExists("BOSS:WASHING_MACHINE") },
			{ "zangy_dead", vars.eventExists("BOSS:ZANGY") },
			
			{ "voice_amytis", vars.eventExists("VOICE:AMYTIS") },
			{ "voice_asma", vars.eventExists("VOICE:ASMA") },
			{ "voice_halyn", vars.eventExists("VOICE:HALYN") },
			{ "voice_liho", vars.eventExists("VOICE:LIHO") },
			{ "voice_noden", vars.eventExists("VOICE:NODEN") },
			
			{ "unlock_map", vars.eventExists("UNLOCK:MAP") },
			{ "unlock_grapple", vars.eventExists("UNLOCK:HOOK") },
			{ "unlock_hitrecharge", vars.eventExists("UNLOCK:HIT_RECHARGE") },
			{ "unlock_glide", vars.eventExists("UNLOCK:GLIDE") },
			{ "unlock_block", vars.eventExists("UNLOCK:BLOCK") },
			{ "unlock_spider", vars.eventExists("UNLOCK:SPIDER") },
			{ "unlock_slingshot", vars.eventExists("UNLOCK:ORB_SHOOT") },
			{ "unlock_spidergoo", vars.eventExists("UNLOCK:SPIDER_GOO") },
			
			{ "mod_kineticthrust", vars.eventExists("TRINKET:HEAVY_ATTACK") },
			{ "mod_alexandersfate", vars.eventExists("TRINKET:ALEXANDERS_FATE") },
			{ "mod_analyser", vars.eventExists("TRINKET:ANALYZER") },
			{ "mod_berserker", vars.eventExists("TRINKET:BERSERKER") },
			{ "mod_betterdodge", vars.eventExists("TRINKET:BETTER_DODGE") },
			{ "mod_energyleacher", vars.eventExists("TRINKET:BIG_ENERGY_DRAIN") },
			{ "mod_glitchtrail", vars.eventExists("TRINKET:CARLO_HOOK") },
			{ "mod_countermeasures", vars.eventExists("TRINKET:COUNTER_ATTACK") },
			{ "mod_oathember", vars.eventExists("TRINKET:DAREDEVIL") },
			{ "mod_afterimage", vars.eventExists("TRINKET:DECOY") },
			{ "mod_perfectstate", vars.eventExists("TRINKET:DOUBLE_DAMAGES") },
			{ "mod_nacredrought", vars.eventExists("TRINKET:DRY_FOUNTAINS") },
			{ "mod_foolishideal", vars.eventExists("TRINKET:ENERGY_EMPTY_ATTACK") },
			{ "mod_reducedlatency", vars.eventExists("TRINKET:FAST_RECOVERY") },
			{ "mod_highriskvoucher", vars.eventExists("TRINKET:FOUNTAIN_OVERLOAD") },
			{ "mod_defectivecore", vars.eventExists("TRINKET:GLASS_CANNON") },
			{ "mod_birdofprey", vars.eventExists("TRINKET:GLIDE_BERSERKER") },
			{ "mod_firefly", vars.eventExists("TRINKET:GLIDE_STATIC") },
			{ "mod_defensemech", vars.eventExists("TRINKET:GOO_REVENGE") },
			{ "mod_gratitude", vars.eventExists("TRINKET:HEAL_GROUND") },
			{ "mod_wildcat", vars.eventExists("TRINKET:HOOK_BERSERKER") },
			{ "mod_sharpenedhairpin", vars.eventExists("TRINKET:HOOK_SLASH") },
			{ "mod_selfawareness", vars.eventExists("TRINKET:HUD") },
			{ "mod_painconversion", vars.eventExists("TRINKET:KINETIC_CONVERSION") },
			{ "mod_imperfectfocus", vars.eventExists("TRINKET:KURO_CHARM") },
			{ "mod_makeshiftrecovery", vars.eventExists("TRINKET:LAST_CHANCE") },
			{ "mod_resourceshort", vars.eventExists("TRINKET:LESS_SCRAPS") },
			{ "mod_portablecrystal", vars.eventExists("TRINKET:LOOT_SUPER_SCRAPS") },
			{ "mod_mainthack", vars.eventExists("TRINKET:MAINTENANCE_EXPERT") },
			{ "mod_effectivedismaintle", vars.eventExists("TRINKET:MORE_SCRAPS") },
			{ "mod_splinterdodge", vars.eventExists("TRINKET:ORB_BLOCK") },
			{ "mod_defrag", vars.eventExists("TRINKET:ORB_RECOVERY") },
			{ "mod_asmaswill", vars.eventExists("TRINKET:PACIFIC") },
			{ "mod_heartsfav", vars.eventExists("TRINKET:QUICK_RECHARGE") },
			{ "mod_nacreoverload", vars.eventExists("TRINKET:SCRAP_ATTACK") },
			{ "mod_thinnerframe", vars.eventExists("TRINKET:SHIELD_DEC") },
			{ "mod_protoverlay", vars.eventExists("TRINKET:SHIELD_INC") },
			{ "mod_splitprocess", vars.eventExists("TRINKET:SLOW_ENERGY") },
			{ "mod_blackwidow", vars.eventExists("TRINKET:SPIDER_BERSERKER") },
			{ "mod_highvoltage", vars.eventExists("TRINKET:STAGGER_ATTACK") },
			{ "mod_sunsail", vars.eventExists("TRINKET:TURBO_GLIDE") },
			{ "mod_extracoating", vars.eventExists("TRINKET:VAMPIRE") },
			
			{ "dialog_rad_kidnapping", (vars.eventExists("DIALOG:TXT_RAD_KIDNAPPING") || vars.eventExists("DIALOG:TXT_RAD_KIDNAPPING_NEWFACE")) },
			{ "dialog_flick", vars.eventExists("DIALOG:VO_ST_HALYN_MEETING_FLICK") },
			
			{ "candle_0", vars.eventExists("CANDLE:0") },
			{ "candle_1", vars.eventExists("CANDLE:1") },
			{ "candle_2", vars.eventExists("CANDLE:2") },
			{ "candle_3", vars.eventExists("CANDLE:3") },
			{ "candle_4", vars.eventExists("CANDLE:4") },
			{ "candle_5", vars.eventExists("CANDLE:5") },
			{ "candle_6", vars.eventExists("CANDLE:6") },
			{ "candle_7", vars.eventExists("CANDLE:7") },
			{ "candle_8", vars.eventExists("CANDLE:8") },
			{ "candle_9", vars.eventExists("CANDLE:9") },
			{ "candle_10", vars.eventExists("CANDLE:10") },
			{ "candle_11", vars.eventExists("CANDLE:11") },
			
			{ "atkpower_0", vars.eventExists("ATTACK_POWER:0") },
			{ "atkpower_1", vars.eventExists("ATTACK_POWER:1") },
			{ "atkpower_2", vars.eventExists("ATTACK_POWER:2") },
			{ "atkpower_3", vars.eventExists("ATTACK_POWER:3") },
			{ "atkpower_4", vars.eventExists("ATTACK_POWER:4") },
			
			{ "cp_nexus", vars.eventExists("CHECKPOINT:cp_HUB_main_down_P1") },			
			{ "cp_citygates", vars.eventExists("CHECKPOINT:CP_city_entrance") },
			{ "cp_cityhall", vars.eventExists("CHECKPOINT:cp_LQ_city_hall") },
			{ "cp_bloodsanctum", vars.eventExists("CHECKPOINT:cp_Liho") },
			{ "cp_belltower", vars.eventExists("CHECKPOINT:cp_GA_bou_chill_S2") },
			{ "cp_promenadeentrance", vars.eventExists("CHECKPOINT:Cp_Entree_GA_Vin") },
			{ "cp_promenadetower", vars.eventExists("CHECKPOINT:GA_taunting_save") },
			{ "cp_redacted1", vars.eventExists("CHECKPOINT:cp_ST_security_spider_P1") },
			{ "cp_redacted2", vars.eventExists("CHECKPOINT:CP_ST_security_glide_P1") },
			{ "cp_vaultsshuttle", vars.eventExists("CHECKPOINT:CP_ST_security_asc_P1") },
			{ "cp_canopy", vars.eventExists("CHECKPOINT:cp_ga_roof_leaves_P3") },
			{ "cp_dwellings", vars.eventExists("CHECKPOINT:CP_LQ_SSX_tricky") },
			{ "cp_celestialbay", vars.eventExists("CHECKPOINT:cp_TW_mid_core_P2") },
			{ "cp_library", vars.eventExists("CHECKPOINT:cp_de_la_honte") },
			{ "cp_crucible", vars.eventExists("CHECKPOINT:cp_cuves_main_P1") },
			{ "cp_lab", vars.eventExists("CHECKPOINT:hacker_room_save") },
			{ "cp_vaults", vars.eventExists("CHECKPOINT:CP_ST_tube_main_save") },
			{ "cp_manufactory", vars.eventExists("CHECKPOINT:CP_ST_tube_path1_P1") },
			{ "cp_pit", vars.eventExists("CHECKPOINT:CP_ST_pearl_hill") },
			
			{ "os_nexus", vars.eventExists("OVERSEER:cp_HUB_main_down_P1") },			
			{ "os_citygates", vars.eventExists("OVERSEER:CP_city_entrance") },
			{ "os_cityhall", vars.eventExists("OVERSEER:cp_LQ_city_hall") },
			{ "os_bloodsanctum", vars.eventExists("OVERSEER:cp_Liho") },
			{ "os_belltower", vars.eventExists("OVERSEER:cp_GA_bou_chill_S2") },
			{ "os_promenadeentrance", vars.eventExists("OVERSEER:Cp_Entree_GA_Vin") },
			{ "os_promenadetower", vars.eventExists("OVERSEER:GA_taunting_save") },
			{ "os_redacted1", vars.eventExists("OVERSEER:cp_ST_security_spider_P1") },
			{ "os_redacted2", vars.eventExists("OVERSEER:CP_ST_security_glide_P1") },
			{ "os_vaultsshuttle", vars.eventExists("OVERSEER:CP_ST_security_asc_P1") },
			{ "os_canopy", vars.eventExists("OVERSEER:cp_ga_roof_leaves_P3") },
			{ "os_dwellings", vars.eventExists("OVERSEER:CP_LQ_SSX_tricky") },
			{ "os_celestialbay", vars.eventExists("OVERSEER:cp_TW_mid_core_P2") },
			{ "os_crucible", vars.eventExists("OVERSEER:cp_cuves_main_P1") },
			{ "os_lab", vars.eventExists("OVERSEER:hacker_room_save") },
			{ "os_vaults", vars.eventExists("OVERSEER:CP_ST_tube_main_save") },
			{ "os_manufactory", vars.eventExists("OVERSEER:CP_ST_tube_path1_P1") },
			
			{ "key_belltower", vars.eventExists("KEY:BELL_TOWER_PASS_GARDEN") },
			{ "key_roots", vars.eventExists("KEY:ROOTS_CORRIDOR") },
			{ "key_glasshouse", vars.eventExists("KEY:GLASSHOUSE_KEY") },
			{ "key_friendlyinvite", vars.eventExists("KEY:SPIDY_KEY") }
			
		};
		return splits;
	});
	
	vars.CheckDataFunc = (Func<bool>)(() =>
	{
		print("[Autosplitter] Checking Save Data! " + vars.args.Name);
		string temp = File.ReadAllText(vars.args.FullPath);
		if (!vars.hackermet && temp.Contains("plotpoints.hacker.met_at_least_once = bool(true)")) {
			print("[Autosplitter] Variable: plotpoints.hacker.met_at_least_once = bool(true)");
			vars.hackermet = true;
		}
		string pattern = @"key\s*=\s*String\(""([^""]+)""\)";
		System.Text.RegularExpressions.MatchCollection matches = System.Text.RegularExpressions.Regex.Matches(temp, pattern);

		List<string> matchList = new List<string>();
		vars.NewestList.Clear();

		foreach (System.Text.RegularExpressions.Match match in matches)
		{
			string value = match.Groups[1].Value;
			matchList.Add(value);
			if (!vars.OldList.Contains(value))
			{
				vars.NewestList.Add(value);
			}
		}
		
		if (settings["debug"]) {
			foreach (string s in vars.NewestList)
			{
				print("[Autosplitter] New Save Entry: " + s);
			}
		}
		
		vars.OldList = matchList;
		vars.CheckData = false;
		vars.delay = 0;
		
		return true;
	});
}

update
{
	if (timer.CurrentPhase == TimerPhase.NotRunning && vars.stopwatch.ElapsedMilliseconds > 0) {
		vars.stopwatch.Reset();
		vars.pastSplits.Clear();
		vars.OldList.Clear();
		vars.CheckData = false;
		vars.delay = 0;
		vars.hackermet = false;
	}
}

start
{	
	if(vars.CheckData && File.Exists(vars.args.FullPath)) {
		vars.CheckDataFunc();
		if (vars.eventExists("CODE:START_GAME")) {
			print("[Autosplitter] Starting timer! found: CODE:START_GAME");
			return true;
		}
	}
}

reset
{
	
}

split {
	
	if (!vars.CheckData || !File.Exists(vars.args.FullPath))
		return;
	
	if (vars.CheckData && vars.delay < 8) {
		vars.delay++;
		return;
	}	
	vars.CheckDataFunc();
	
	var splits = vars.GetSplitList();
	foreach (var split in splits)
	{
		if (settings[split.Key] && split.Value && !vars.pastSplits.Contains(split.Key))
		{
			vars.pastSplits.Add(split.Key);
			print("[Autosplitter] Split: " + split.Key);
			return true;
		}
	}
}

gameTime
{
	if (current.gametime > 0 && !vars.stopwatch.IsRunning) {
		vars.stopwatch.Start();		
	} else if (current.gametime == 0 && vars.stopwatch.IsRunning) {
		vars.stopwatch.Stop();
	}
	return TimeSpan.FromMilliseconds(vars.stopwatch.ElapsedMilliseconds);
}

isLoading
{
	return true;
}

shutdown
{
	try {
		if (vars.watcher != null)
			vars.watcher.Deleted -= vars.myhandler;
	}
	catch (Exception ex) {
		print("[Autosplitter] No watcher to unsubscribe from handler... Cool.");
	}
}