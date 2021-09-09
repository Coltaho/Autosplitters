//Made by Coltaho 2/5/2020
//Updated by JohnnyGo 9/2/2020
//Autosplitter added by JohnnyGo 9/6/2021

/* Level data
0 is Intro
1 is Yammark
2 is Wolfang
3 is Heatnix
4 is Shark Part 1 (Stage 0); Shark Part 2 (Stage 1)
5 is Scaravich
6 is Turtloid
7 is Sheldon
8 is Mijinion
9 is ?
10 is ?
11 is Cutscenes
12 is Boss Rush (Stage 0); Sigma (Stage 1)
13 is Level Select (Stage 0); Boss Portraits (Stage 1)
14 is Title Screen
15 is Status Report (Stage 0); Credits (Stage 1)
16 is Nightmare Mother
17 is High Max
18 is Gate
19 is Nightmare Area (Stage 0 is Yammark; Stage 1 is Wolfang)
20 is Nightmare Area (Stage 0 is Heatnix; Stage 1 is Shark)
21 is Nightmare Area (Stage 0 is Scaravich; Stage 1 is Turtloid)
22 is Nightmare Area (Stage 0 is Sheldon; Stage 1 is Mijinion)
*/

/* Trigger Exit values
0 is Normal
1 is Warp with no fFanfare, like out of the intro
16 is Warp with farfare, like after a boss
64 is fade to black, teleporter after the refights
65 moves to the nightmare stage, or finishes the stage
128 for refight teleporters, or restarts the stage
*/

state("emuhawk") { //2.3.1
	//Add 0x11D880 to RAM watch address to get these
	uint gameTime: "octoshock.dll", 0x1EA81C;
	uint demoTime: "octoshock.dll", 0x1EAC7C;
	byte level: "octoshock.dll", 0x1EA75C; //see comment above
	byte stage: "octoshock.dll", 0x1EA75D;
	byte playerHealth: "octoshock.dll", 0x1B497C;
	byte bossHealth: "octoshock.dll", 0x1AC824;
	byte triggerExit: "octoshock.dll", 0x1EA75F; //see comment above
	byte teleporting: "octoshock.dll", 0x1B498A; //normally set to 7 (3 for XLC2, 216 for Dolphin), set to 0 on teleport after boss, level select, boss door transitions, and some other times
	byte gameStart1: "octoshock.dll", 0x1EAC79; //2 when choice is made on initial three options
	byte gameStart2: "octoshock.dll", 0x1EAC7A; //0, changes based on title option currently selected
	byte gameStart3: "octoshock.dll", 0x1EAE1E; //142 (144 for XLC2), changes based on title option currently selected
	byte gameStart4: "octoshock.dll", 0x1EAE57; //0, changes based on title option currently selected
}

state("RXC2") {
	uint gameTime: 0x3DD7814, 0x178;
	float demoTime: 0x3DD7814, 0x24, 0x14;
	byte level: 0x3DD7814, 0xB8;
	byte stage: 0x3DD7814, 0xB9;
	byte playerHealth: 0x3DD7858, 0x130;
	byte bossHealth: 0x3DD7858, 0x7AC;
	byte triggerExit: 0x3DD7814, 0xBB;
	byte teleporting: 0x3DD7858, 0x157;
	byte gameStart1: 0x3DD7814, 0x38, 0xD;
	byte gameStart2: 0x338CA34, 0x23C, 0xC0, 0x266;
	byte gameStart3: 0x338CA34, 0xD74, 0x14, 0x8;
	byte gameStart4: 0x3DD7814, 0x24, 0xE;
}

state("ePSXe", "v2.0.5") {
	uint gameTime: "ePSXe.exe", 0xB4EFBC;
	uint demoTime: "ePSXe.exe", 0xB4F41C;
	byte level: "ePSXe.exe", 0xB4EEFC;
	byte stage: "ePSXe.exe", 0xB4EEFD;
	byte playerHealth: "ePSXe.exe", 0xB1911C;
	byte bossHealth: "ePSXe.exe", 0xB10FC4;
	byte triggerExit: "ePSXe.exe", 0xB4EEFF;
	byte teleporting: "ePSXe.exe", 0xB1912A;
	byte gameStart1: "ePSXe.exe", 0xB4F419;
	byte gameStart2: "ePSXe.exe", 0xB4F41A;
	byte gameStart3: "ePSXe.exe", 0xB4F5BE;
	byte gameStart4: "ePSXe.exe", 0xB4F5F7;
}

state("Dolphin", "v5.0") {
	//Dolphin uses big endian 
	//got the first offset from the RE2 Dolphin autosplitter (https://www.speedrun.com/re2/thread/izb1f/)
	//got the second offset by subtracting the address I found in Cheat Engine from the game memory start (Dolphin.exe+DCE040)
	uint gameTime: "Dolphin.exe", 0xDCE040, 0xB369F0; //converted these to uints so we can do easy comparisons for the autosplitter
	uint demoTime: "Dolphin.exe", 0xDCE040, 0xB36D90;
	byte level: "Dolphin.exe", 0xDCE040, 0xB36930;
	byte stage: "Dolphin.exe", 0xDCE040, 0xB36931;
	byte playerHealth: "Dolphin.exe", 0xDCE040, 0xB3682C;
	byte bossHealth: "Dolphin.exe", 0xDCE040, 0xB348DC;
	byte triggerExit: "Dolphin.exe", 0xDCE040, 0xB36933;
	byte teleporting: "Dolphin.exe", 0xDCE040, 0xB36839;
	byte gameStart1: "Dolphin.exe", 0xDCE040, 0xB36D8D;
	byte gameStart2: "Dolphin.exe", 0xDCE040, 0xB28E0B;
	byte gameStart3: "Dolphin.exe", 0xDCE040, 0xB28DD1;
	byte gameStart4: "Dolphin.exe", 0xDCE040, 0xB36D8E;
}

startup {
	refreshRate = 1;
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man X6 AutoSplitter v3.0 by Coltaho and JohnnyGo", "infosection");
	settings.Add("info0", true, "- IGT: Bizhawk, ePSXe, Dolphin, and Steam XLC2", "infosection");
	settings.Add("info1", true, "- Autosplit: Bizhawk, ePSXe, Dolphin, and Steam XLC2", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	settings.Add("info3", true, "- Website : https://github.com/Johnny-Go/Autosplitters", "infosection");
	
	//create settings
	settings.Add("useGameTime", true, "Updates the timer to use in game time");
	settings.SetToolTip("useGameTime", "Turn off if you don't want to track game time");
	settings.Add("autosplit", false, "Enables autosplitting for Bizhawk, Dolphin, ePSXe, and Steam XLC2");
	settings.SetToolTip("autosplit", "Turn on if you want to autosplit");

	//setup reset action
	LiveSplit.Model.Input.EventHandlerT<LiveSplit.Model.TimerPhase> resetAction = (s,e) =>
	{
		vars.firstPass = true;
		vars.convertedIGT = 0;
		vars.convertedDemoTime = 0;
		vars.finalBoss = false;
	};
	vars.resetAction = resetAction;
	timer.OnReset += vars.resetAction;
}

init {
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.firstPass = true;
	vars.convertedGameTime = 0;
	vars.convertedDemoTime = 0;
	vars.finalBoss = false;
}

start {
	if(settings["autosplit"])
	{
		//start timer when Game Start is selected
		if(old.gameStart1 == 1 && current.gameStart1 == 2 && current.gameStart2 == 0 && current.gameStart4 == 0
			&& (current.gameStart3 == 142 || current.gameStart3 == 144))
		{
			print("Starting timer");
			return true;
		}
	}
}

update {
	if(settings["useGameTime"])
	{
		//print("--IGT: " + vars.convertedGameTime);
		//print("--IGT: " + vars.convertedDemoTime);
		
		//reverse bytes for Dolphin
		if(game.ProcessName == "Dolphin")
		{
			//pull into variables so we can reverse without changing the current value
			var gameTimeBytes = BitConverter.GetBytes(current.gameTime);
			var demoTimeBytes = BitConverter.GetBytes(current.demoTime);
			Array.Reverse(gameTimeBytes);
			Array.Reverse(demoTimeBytes);
			vars.convertedGameTime = BitConverter.ToUInt32(gameTimeBytes, 0);
			vars.convertedDemoTime = BitConverter.ToUInt32(demoTimeBytes, 0);
		}
		//convert float to uint for XLC2
		else if(game.ProcessName == "RXC2")
		{
			vars.convertedGameTime = current.gameTime;
			vars.convertedDemoTime = (uint)current.demoTime;
		}
		//Bizhawk, ePSXe, don't do anything fancy
		else if (game.ProcessName == "EmuHawk" || game.ProcessName == "ePSXe")
		{
			vars.convertedGameTime = current.gameTime;
			vars.convertedDemoTime = current.demoTime;
		}
	}
	
	if(settings["autosplit"])
	{
		//flag to determine the final boss fight has started, resets the flag if you die
		if(current.level == 12 && current.stage == 1 && current.bossHealth == 127 && current.playerHealth > 0)
		{
			vars.finalBoss = true;
		}
		else if(current.level == 12 && current.stage == 1 && current.playerHealth == 0)
		{
			vars.finalBoss = false;
		}
	}
}

split {
	if(settings["autosplit"])
	{
		//after intro when exit is triggered (fade to black)
		if(current.level == 0 && current.triggerExit == 64 && old.triggerExit == 0)
		{
			return true;
		}
		
		//on teleport after boss kill
		if(current.level != 12 
			&& (current.triggerExit == 16 || current.triggerExit == 1)
			&& (current.teleporting == 0 && old.teleporting != 0))
		{
			return true;
		}
		
		//on teleport after refights (fade to black)
		if(current.level == 12 && current.stage == 0 && current.triggerExit == 64 && old.triggerExit == 0)
		{
			return true;
		}
		
		//after Sigma killed
		if(vars.finalBoss && current.level == 12 && current.stage == 1 && current.playerHealth > 0 && current.bossHealth == 0 && current.gameTime == old.gameTime)
		{
			vars.finalBoss = false;
			return true;
		}
	}
}

isLoading {
	if(settings["useGameTime"])
	{
		return true;
	}
}

gameTime {
	if(settings["useGameTime"])
	{
		//set the game time to 0 when starting (fixes the issue where time counts up around a 1/10th of a second before moving to game time)
		if(vars.firstPass)
		{
			vars.firstPass = false;
			return TimeSpan.FromMilliseconds(0);
		}

		//only update game time when not in the demo
		if(vars.convertedGameTime != 0 && vars.convertedDemoTime == 0)
		{
			return TimeSpan.FromMilliseconds((1000.0 / 60.0) * vars.convertedGameTime);
		}
	}
}

shutdown {
	//unload reset event
	timer.OnReset -= vars.resetAction;
}
