//Made by Coltaho 3/14/2019

state("fceux", "v2.2.3")
{
	int crc : 0x3F4CBC;
	
	//MM1
	byte one_bosshp : 0x436B04, 0x6C1;
	byte one_myhp : 0x436B04, 0x6A; //28 is max
	byte one_mylives : 0x436B04, 0xA6;
	byte one_soundfx : 0x436B04, 0xEF; //3 is common
	byte one_stage : 0x436B04, 0x31; //10 is start/gameover screen
	byte one_orb : 0x436B04, 0x501; //158 after orb grab/wily stages last boss kill
	byte one_timer : 0x436B04, 0x3C; //Timer that tends to decrement waiting for animations
	byte one_xpos : 0x436B04, 0x22;
	byte one_bossid : 0x436B04, 0xAC; //10 is last wily phase
	
	//MM2
	byte two_bosshp : 0x436B04, 0x6C1;
	byte two_myhp : 0x436B04, 0x6C0;
	byte two_mylives : 0x436B04, 0xA8;
	byte two_mytitlescreen : 0x436B04, 0x04B0;
	byte two_mycontroller : 0x436B04, 0x0025;
	byte two_soundfx : 0x436B04, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte two_stage : 0x436B04, 0x2A; //12 is boss rush, 13 is alien
	
	//MM3
	byte three_enemyhp : 0x436B04, 0x4FF;
	byte three_secondenemyhp : 0x436B04, 0x4FE; //used for gemini
	byte three_enemyid : 0x436B04, 0x4DF; //Number the enemy appears in the stage, 255 if despawned
	byte three_secondenemyid : 0x436B04, 0x4DE;
	byte three_myhp : 0x436B04, 0xA2; //128 is dead (disregards high bit)
	byte three_soundfx : 0x436B04, 0x702; //58 is teleport
	byte three_stage : 0x436B04, 0x22;
	byte three_screen : 0x436B04, 0xCB; //1 on intro screen
	
	//MM4
	byte four_enemyhp : 0x436B04, 0x467;
	byte four_enemyid : 0x436B04, 0x44F; //Number the enemy appears in the stage, 255 if despawned
	byte four_myhp : 0x436B04, 0xB0; //128 is dead (disregards high bit)
	byte four_soundfx : 0x436B04, 0x702; //65 is teleport
	byte four_stage : 0x436B04, 0x22;
	byte four_screen : 0x436B04, 0xCB; //1 on intro screen
	byte four_selection : 0x436B04, 0x200; //151 on Game Start
	byte four_levelscreen : 0x436B04, 0xF9; //actual screen num in stage
	
	// MM5
	byte five_enemyhp : 0x436B04, 0x458;
	byte five_enemyid : 0x436B04, 0x440; //Number the enemy appears in the stage, 255 if despawned
	byte five_myhp : 0x436B04, 0xB0; //128 is dead (disregards high bit)
	byte five_soundfx : 0x436B04, 0x702; //68 to 66 is teleport
	byte five_stage : 0x436B04, 0x26; //goes 0 at reset then to 16 during intro
	byte five_screenassets : 0x436B04, 0x611; // 0 if on start screen
	byte five_otherscreenassets : 0x436B04, 0x18B;
	byte five_selection : 0x436B04, 0x200; //151 on Game Start
	byte five_levelscreen : 0x436B04, 0xF9; //actual screen num in stage
	byte five_controller : 0x436B04, 0x16; //controller 1 inputs held
	int five_timer : 0x436B04, 0x10; //timer for things
	
	byte six_myhp : 0x3B1388, 0x3E5;
	byte six_mylives : 0x3B1388, 0xA9;
	byte six_bosshp : 0x3B1388, 0x3ED;
	byte six_stage : 0x3B1388, 0x51;
	byte six_currentscreen : 0x3B1388, 0x92;
	byte six_mycontroller : 0x3B1388, 0x40;
	byte six_mymenuselection : 0x3B1388, 0x5B1;
	byte six_soundfx : 0x3B1388, 0x702; //current/last played sound
}

state("fceux", "v2.6.4")
{
	int crc : 0x3F4CBC;
	
	//MM1
	byte one_bosshp : 0x3DA4EC, 0x6C1;
	byte one_myhp : 0x3DA4EC, 0x6A; //28 is max
	byte one_mylives : 0x3DA4EC, 0xA6;
	byte one_soundfx : 0x3DA4EC, 0xEF; //3 is common
	byte one_stage : 0x3DA4EC, 0x31; //10 is start/gameover screen
	byte one_orb : 0x3DA4EC, 0x501; //158 after orb grab/wily stages last boss kill
	byte one_timer : 0x3DA4EC, 0x3C; //Timer that tends to decrement waiting for animations
	byte one_xpos : 0x3DA4EC, 0x22;
	byte one_bossid : 0x3DA4EC, 0xAC; //10 is last wily phase
	
	//MM2
	byte two_bosshp : 0x3DA4EC, 0x6C1;
	byte two_myhp : 0x3DA4EC, 0x6C0;
	byte two_mylives : 0x3DA4EC, 0xA8;
	byte two_mytitlescreen : 0x3DA4EC, 0x04B0;
	byte two_mycontroller : 0x3DA4EC, 0x0025;
	byte two_soundfx : 0x3DA4EC, 0xE2; //0xF1 to 0x35 is boss kill then teleport except for wily machine
	byte two_stage : 0x3DA4EC, 0x2A; //12 is boss rush, 13 is alien
	
	//MM3
	byte three_enemyhp : 0x3DA4EC, 0x4FF;
	byte three_secondenemyhp : 0x3DA4EC, 0x4FE; //used for gemini
	byte three_enemyid : 0x3DA4EC, 0x4DF; //Number the enemy appears in the stage, 255 if despawned
	byte three_secondenemyid : 0x3DA4EC, 0x4DE;
	byte three_myhp : 0x3DA4EC, 0xA2; //128 is dead (disregards high bit)
	byte three_soundfx : 0x3DA4EC, 0x702; //58 is teleport
	byte three_stage : 0x3DA4EC, 0x22;
	byte three_screen : 0x3DA4EC, 0xCB; //1 on intro screen
	
	//MM4
	byte four_enemyhp : 0x3DA4EC, 0x467;
	byte four_enemyid : 0x3DA4EC, 0x44F; //Number the enemy appears in the stage, 255 if despawned
	byte four_myhp : 0x3DA4EC, 0xB0; //128 is dead (disregards high bit)
	byte four_soundfx : 0x3DA4EC, 0x702; //65 is teleport
	byte four_stage : 0x3DA4EC, 0x22;
	byte four_screen : 0x3DA4EC, 0xCB; //1 on intro screen
	byte four_selection : 0x3DA4EC, 0x200; //151 on Game Start
	byte four_levelscreen : 0x3DA4EC, 0xF9; //actual screen num in stage
	
	// MM5
	byte five_enemyhp : 0x3DA4EC, 0x458;
	byte five_enemyid : 0x3DA4EC, 0x440; //Number the enemy appears in the stage, 255 if despawned
	byte five_myhp : 0x3DA4EC, 0xB0; //128 is dead (disregards high bit)
	byte five_soundfx : 0x3DA4EC, 0x702; //68 to 66 is teleport
	byte five_stage : 0x3DA4EC, 0x26; //goes 0 at reset then to 16 during intro
	byte five_screenassets : 0x3DA4EC, 0x611; // 0 if on start screen
	byte five_otherscreenassets : 0x3DA4EC, 0x18B;
	byte five_selection : 0x3DA4EC, 0x200; //151 on Game Start
	byte five_levelscreen : 0x3DA4EC, 0xF9; //actual screen num in stage
	byte five_controller : 0x3DA4EC, 0x16; //controller 1 inputs held
	int five_timer : 0x3DA4EC, 0x10; //timer for things
	
	byte six_myhp : 0x3DA4EC, 0x3E5;
	byte six_mylives : 0x3DA4EC, 0xA9;
	byte six_bosshp : 0x3DA4EC, 0x3ED;
	byte six_stage : 0x3DA4EC, 0x51;
	byte six_currentscreen : 0x3DA4EC, 0x92;
	byte six_mycontroller : 0x3DA4EC, 0x40;
	byte six_mymenuselection : 0x3DA4EC, 0x5B1;
	byte six_soundfx : 0x3DA4EC, 0x702; //current/last played sound
}

state("nestopia")
{
	int crc : 0x1AE0C8, 0x9C, 0x30, 0x38;
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	
	//MM1
	byte one_bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x729;
	byte one_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xD2;
	byte one_mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x10E;
	byte one_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x157;
	byte one_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x99;
	byte one_orb : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x569;
	byte one_timer : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA4;
	byte one_xpos : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8A;
	byte one_bossid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x114;
	
	//MM2
	byte two_bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x729;
	byte two_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x728;
	byte two_mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x110;
	byte two_mytitlescreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x518;
	byte two_mycontroller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8d;
	byte two_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xE2;
	byte two_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x2A;
	
	//MM3
	byte three_enemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x567;
	byte three_secondenemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x566;
	byte three_enemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x547;
	byte three_secondenemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x546;
	byte three_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x10A;
	byte three_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
	byte three_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x88;
	byte three_screen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x133;
	
	//MM4
	byte four_enemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4CF;
	byte four_enemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4B7;
	byte four_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x118;
	byte four_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
	byte four_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x88;
	byte four_screen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x133;
	byte four_selection : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x268;
	byte four_levelscreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x161;
	
	//MM5
	byte five_enemyhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4C0;
	byte five_enemyid : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x4A8;
	byte five_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x118;
	byte five_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
	byte five_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x8C;
	byte five_screenassets : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x679;
	byte five_otherscreenassets : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x1F3;
	byte five_selection : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x268;
	byte five_levelscreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x161;
	byte five_controller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x7E;
	int five_timer : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x78;
	
	byte six_myhp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x44D;
	byte six_mylives : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x111;
	byte six_bosshp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x455;
	byte six_stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xB9;
	byte six_currentscreen : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xFA;
	byte six_mycontroller : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA8;
	byte six_mymenuselection : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x619;
	byte six_soundfx : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x76A;
}

startup
{
	settings.Add("optionsection", true, "---Options---");
	settings.Add("breakman", true, "(MM3) Split after the Breakman showdown", "optionsection");
	settings.Add("cossackfade", true, "(MM4) Split at fade out after Cossack 4", "optionsection");
	settings.Add("darkfade", true, "(MM5) Split at initial fade out after Dark 4", "optionsection");
		
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man 1-6 Autosplitter v1.0 by Coltaho", "infosection");
	settings.Add("info0", true, "- Supported emulators : FCEUX, Nestopia", "infosection");
	settings.Add("info1", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init
{
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.game = 0;
	vars.started_mm2 = false;
	vars.started_mm3 = false;
	vars.started_mm4 = false;
	vars.started_mm5 = false;
	vars.started_mm6 = false;
	vars.two_inBossFight = 0;
	vars.two_framecounter = 0;
	vars.three_waiting = false;
	vars.three_splitboss = false;
	vars.six_inBossFight = 0;
	vars.six_currentBossRush = 0;
	vars.six_iknowimdead = 0;
	vars.six_framecounter = 0;
	
	if (modules.First().ModuleMemorySize == 0x487000)
        version = "v2.2.3";
    else if (modules.First().ModuleMemorySize == 0x603000)
        version = "v2.6.4";
}

start {
	if (current.one_stage == 10 && current.one_timer != 0) {
		print("--Starting MM1!--");
		return true;
	}
}

update {
	//Reset variables if timer reset
	if (timer.CurrentPhase == TimerPhase.NotRunning) {
		vars.started_mm2 = false;
		vars.started_mm3 = false;
		vars.started_mm4 = false;
		vars.started_mm5 = false;
		vars.started_mm6 = false;
		vars.two_inBossFight = 0;
		vars.two_framecounter = 0;
		vars.three_waiting = false;
		vars.three_splitboss = false;
		vars.six_inBossFight = 0;
		vars.six_currentBossRush = 0;
		vars.six_iknowimdead = 0;
		vars.six_framecounter = 0;
	}
	
	//Rockman then Mega Man
	if (current.crc.ToString("X") == "D31DC910" || current.crc.ToString("X") == "6EE4BB0A" || current.crc.ToString("X") == "94476A70")
		vars.game = 1;
	else if (current.crc.ToString("X") == "6150517C" || current.crc.ToString("X") == "FCFC04D")
		vars.game = 2;
	else if (current.crc.ToString("X") == "D9F1E47C" || current.crc.ToString("X") == "603AAA57")
		vars.game = 3;
	else if (current.crc.ToString("X") == "F161A5D8" || current.crc.ToString("X") == "E0FFECCD" || current.crc.ToString("X") == "2BC67AA8" || current.crc.ToString("X") == "18A2E74F")
		vars.game = 4;
	else if (current.crc.ToString("X") == "FDDF2135" || current.crc.ToString("X") == "3EDCF7E8")
		vars.game = 5;
	else if (current.crc.ToString("X") == "2D664D99" || current.crc.ToString("X") == "988798A8")
		vars.game = 6;
	else
		vars.game = 0;
	// print("--Game CRC: " + current.crc.ToString("X") + " which is Mega Man " + vars.game + " | Timerphase: " + timer.CurrentPhase);
	if (current.crc != old.crc && vars.game != 0)
		print("--Game Changed! Currently on: Mega Man " + vars.game);
}

split
{
	switch ((int)vars.game)
	{
		case 1:
			if ((current.one_stage < 6 && current.one_orb == 158 && old.one_orb != 158) ||
				(current.one_stage >= 6 && current.one_stage != 9 && (current.one_orb == 172 || current.one_orb == 158) && current.one_myhp > 0 && current.one_bosshp == 0 && old.one_bosshp > 0) ||
				(current.one_stage == 9 && current.one_orb == 172 && current.one_myhp > 0 && current.one_bosshp == 0 && old.one_bosshp > 0 && current.one_bossid == 10)) {
				print("--MM1 Split--");
				return true;
			}
			break;
		case 2:
			//Split on start of MM2 once
			if (!vars.started_mm2 && old.two_mytitlescreen == 119 && current.two_mytitlescreen == 119 && old.two_mycontroller == 0 && current.two_mycontroller == 8) {
				print("--Starting MM2!--");
				vars.started_mm2 = true;
				vars.two_inBossFight = 0;
				vars.two_framecounter = 0;
				return true;
			}
			
			if (old.two_soundfx == 0xF1 && current.two_soundfx == 0x35) {
				print("--MM2 Teleport Split--");
				return true;
			}
			if (old.two_stage == 12 && current.two_stage == 13) {
				print("--MM2 Beat Wily Machine, moving to last stage--");
				return true;
			}
			if (current.two_stage == 13) {
				if (current.two_myhp == 0 && current.two_bosshp != 0 && vars.two_inBossFight == 1 && vars.two_framecounter <= 8) {
					vars.two_framecounter++;	//Accounts for a DKO by giving you 8 frames of leeway if you die before the boss does	
				} else if (current.two_myhp == 0 && current.two_bosshp != 0 && vars.two_inBossFight == 1 && vars.two_framecounter > 8) {
					vars.two_inBossFight = 0;
					print("--MM2 You died!--");
				}
				if (vars.two_inBossFight == 0) {
					if (current.two_bosshp == 28 && old.two_bosshp == 27) {
						print("--MM2 Starting LAST boss--");
						vars.two_inBossFight = 1;
					}
				} else {
					if (current.two_bosshp == 0) {
						vars.two_inBossFight = 0;
						print("--MM2 Yay LAST boss dead! Game Beaten!--");
						return true;
					}
				}
			}
			break;
		case 3:
			//Split on start of MM3 once
			if (!vars.started_mm3 && current.three_screen == 3 && old.three_screen == 1) {
				print("--Starting MM3!--");
				vars.started_mm3 = true;
				return true;
			}

			if (current.three_screen == 1 || current.three_myhp == 128 || current.three_enemyhp == 31) {
				vars.three_waiting = false;
			}
	
			if ((current.three_enemyid == 35 && current.three_stage == 1) || (current.three_enemyid == 39 && current.three_stage == 3) ||
				(current.three_enemyid == 45 && current.three_stage == 4) || (current.three_enemyid == 45 && current.three_stage == 7) || 
				(current.three_enemyid == 30 && current.three_stage == 0) || (current.three_enemyid == 74 && current.three_stage == 5) || 
				(current.three_enemyid == 40 && current.three_stage == 6) || (current.three_enemyid == 53 && current.three_stage == 11) ||
				(current.three_enemyid == 61 && current.three_stage == 9) || (current.three_enemyid == 62 && current.three_stage == 8) ||
				(current.three_enemyid == 36 && current.three_stage == 10) || (current.three_enemyid == 35 && current.three_stage == 13) ||
				(current.three_enemyid == 44 && current.three_stage == 14) || (current.three_enemyid == 4 && current.three_stage == 16)){
				vars.three_splitboss = true;
			} else {
				vars.three_splitboss = false;
			}
			
			if (!vars.three_waiting && vars.three_splitboss && current.three_myhp > 128 && current.three_enemyhp == 0 && old.three_soundfx != 58) {
				print("--MM3 Waiting for sound cue--");
				vars.three_waiting = true;
			}
			
			if (!vars.three_waiting && current.three_enemyid == 60 && current.three_stage == 2 && current.three_myhp > 128 && ((current.three_enemyhp == 0 && current.three_secondenemyhp == 14) || (current.three_enemyhp == 14 && current.three_secondenemyhp == 0))) {
				print("--MM3 Stupid Gemini... Waiting for sound cue--");
				vars.three_waiting = true;
			}
			
			if (!vars.three_waiting && current.three_stage == 12 && old.three_secondenemyid == 33 && current.three_secondenemyid == 255 && current.three_myhp > 128 && old.three_soundfx != 58) {
				print("--MM3 Stupid turtles... Waiting for sound cue--");
				vars.three_waiting = true;
			}
			
			if (!vars.three_waiting && current.three_stage == 17 && current.three_enemyid == 7 && old.three_enemyhp == 0 && current.three_enemyhp == 28) {
				print("--MM3 Stupid Gamma engaged... Waiting for kill--");
				vars.three_waiting = true;
			}
			
			if (vars.three_waiting && current.three_stage < 8 && old.three_soundfx == 42 && current.three_soundfx == 58) {
				vars.three_waiting = false;
				print("--MM3 Teleport Split during 8 Robos--");
				return true;
			}
	
			if (vars.three_waiting && current.three_stage >= 8 && old.three_soundfx == 43 && current.three_soundfx == 58) {
				vars.three_waiting = false;
				print("--MM3 Teleport Split after 8 Robos--");
				return true;
			}
			
			if ((old.three_stage == 15 || (settings["breakman"] && old.three_stage == 3)) && current.three_stage == 22) {
				print("--MM3 Breakman or Refight Split--");
				return true;
			}
			
			if (vars.three_waiting && current.three_stage == 17 && current.three_enemyid == 7 && current.three_myhp > 128 && current.three_enemyhp == 0) {
				vars.three_waiting = false;
				print("--MM3 Wily Gamma killed! Game beaten!--");
				return true;
			}	
			break;
		case 4:
			//Split  on start of MM4 once
			if (!vars.started_mm4 && current.four_screen == 2 && current.four_selection == 151 && current.four_soundfx == 6 && old.four_soundfx != 6) {
				print("--Starting MM4!--");
				vars.started_mm4 = true;
				return true;
			}
			
			if (old.four_soundfx == 67 && current.four_soundfx == 65 && !(current.four_levelscreen == 10 && current.four_stage == 3)) {
				print("--MM4 Teleport Split--");
				return true;
			}
			
			if (settings["cossackfade"] && old.four_stage == 11 && current.four_stage == 18 && current.four_soundfx == 0) {
				print("--MM4 Cossack 4 Split on Fade--");
				return true;
			}
			
			if (current.four_stage == 15 && old.four_enemyid == 6 && current.four_enemyid == 255 && current.four_enemyhp == 0 && old.four_enemyhp > 0 && current.four_myhp > 128) {
				print("--MM4 Wily Capsule killed! Game beaten!--");
				return true;
			}
			break;
		case 5:
			//Split  on start of MM5 once
			if (!vars.started_mm5 && old.five_screenassets == 0 && current.five_screenassets == 15 && old.five_otherscreenassets == 255 && current.five_otherscreenassets <= 4 && current.five_controller > 0) {
				print("--Starting MM5!--");
				vars.started_mm5 = true;
				return true;
			}
			
			if (old.five_soundfx == 68 && current.five_soundfx == 66) {
				print("--MM5 Teleport Split--");
				return true;
			}
			
			if (settings["darkfade"] && current.five_stage == 11 && old.five_levelscreen == 3 && current.five_levelscreen == 0 && current.five_myhp > 128) {
				print("--MM5 Dark 4 Split--");
				return true;
			}
			
			if (current.five_stage == 15 && current.five_levelscreen == 7 && old.five_enemyid == 255 && old.five_enemyhp > 0 && current.five_enemyhp == 0 && current.five_myhp > 128) {
				print("--MM5 Wily Capsule Dead Split! Game Beaten!--");
				return true;
			}
			break;
		case 6:
			//Split  on start of MM6 once
			if (!vars.started_mm6 && current.six_mymenuselection == 0 && current.six_currentscreen == 163 && current.six_soundfx == 63) {
				print("--Starting MM6!--");
				vars.started_mm6 = true;
				return true;
			}
			
			if (current.six_stage > 7 && current.six_stage != 14 && old.six_soundfx == 68 && current.six_soundfx == 66) {
				print("--MM6 Teleport Split--");
				return true;
			}
			
			if (current.six_stage <= 7 && old.six_soundfx == 65 && current.six_soundfx == 68) {
				print("--MM6 Teleport Split--");
				return true;
			}

			if (current.six_stage == 15) {
				if (settings["onteleport"] && current.six_myhp > 127 && vars.six_inBossFight == 1) {
					vars.six_inBossFight = 0;
					vars.six_currentBossRush = 0;
					print("--MM6 You Died during Wily Man!--");
				}
				if (vars.six_inBossFight == 0) {
					if ((current.six_bosshp == 22 && old.six_bosshp == 21) || (vars.six_currentBossRush == 2 && current.six_bosshp == 0 && old.six_bosshp == 255)) {
						if (vars.six_currentBossRush == 0) {
							print("--MM6 Starting LAST boss phase 1 of 3!--");
						} else {
							print("--MM6 Starting Phase " + (vars.six_currentBossRush + 1) + "!--");
						}
						vars.six_inBossFight = 1;
					}
				} else {
					if (current.six_bosshp == 255) {
						vars.six_inBossFight = 0;
						vars.six_currentBossRush++;
						print("--MM6 Yay Wily Phase " + vars.six_currentBossRush +  " is dead!--");
					}
				}
				if (vars.six_currentBossRush == 3) {
					vars.six_currentBossRush = 0;
					print("--MM6 Yay LAST boss is dead! You Win!--");
					return true;
				}
			}
			
			//Always split after refights to last stage transition
			if (old.six_stage == 14 && current.six_stage == 15) {
				print("--MM6 Stage Transition Split--");
				return true;
			}
			
			//Always split after Mr X 4 to next stage transition
			if (old.six_stage == 11 && current.six_stage == 12) {
				print("--MM6 Stage Transition Split--");
				return true;
			}
			break;
	}
}
