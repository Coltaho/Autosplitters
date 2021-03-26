//Made by Coltaho 1/13/2020
//Updated by JohnnyGo 9/7/2020

state("emuhawk") {
	//Add 0x11D880 to RAM watch address to get these
	byte level : "octoshock.dll", 0x1EF48C;
	uint igt : "octoshock.dll", 0x1EF634;
	uint demoTime : "octoshock.dll", 0x1EF7AC;
}

state("RXC2") {
	byte level : 0x33F7444, 0x64;
	float igt : 0x33F7444, 0x208;
	float demoTime : 0x33F7444, 0x230;
}

state("ePSXe", "v2.0.5") {
	byte level : "ePSXe.exe", 0xB53C2C;
	uint igt : "ePSXe.exe", 0xB53DD4;
	uint demoTime : "ePSXe.exe", 0xB53F4C;
}

state("Dolphin", "v5.0") {
	//got the first offset from the RE2 Dolphin autosplitter (https://www.speedrun.com/re2/thread/izb1f/)
	//got the second offset by subtracting the address I found in Cheat Engine from the game memory start (Dolphin.exe+DCE040)
	byte level : "Dolphin.exe", 0xDCE040, 0xB8FD18;
	byte4 igt : "Dolphin.exe", 0xDCE040, 0xB8FEC0;
	byte4 demoTime: "Dolphin.exe", 0xDCE040, 0xB8FECC;
}

state("x5") {
	byte level : "x5.exe", 0x39298C;
	uint igt : "x5.exe", 0x392B34;
	uint demoTime : "x5.exe", 0x38F1F4;
}

startup {
	refreshRate = 1;
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man X5 AutoSplitter v1.0 by Coltaho and JohnnyGo", "infosection");
	settings.Add("info0", true, "- Compare against Game Time, does not autosplit", "infosection");
	settings.Add("info1", true, "- Supported emulators/versions : Bizhawk, ePSXe, Dolphin, PC XLC, and Windows X5", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	settings.Add("info3", true, "- Website : https://github.com/Johnny-Go/Autosplitters", "infosection");
	
	//setup reset action
	LiveSplit.Model.Input.EventHandlerT<LiveSplit.Model.TimerPhase> resetAction = (s,e) =>
	{
		vars.firstPass = true;
		vars.convertedIGT = 0;
		vars.convertedDemoTime = 0;
	};
	vars.resetAction = resetAction;
	timer.OnReset += vars.resetAction;
}

init {
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.firstPass = true;
	vars.convertedIGT = 0;
	vars.convertedDemoTime = 0;
}

update {
	//print("--IGT: " + vars.convertedIGT);
	
	//reverse bytes and convert to uint for Dolphin
	if(game.ProcessName == "Dolphin") {
		Array.Reverse(current.igt);
		Array.Reverse(current.demoTime);
		vars.convertedIGT = BitConverter.ToUInt32(current.igt, 0);
		vars.convertedDemoTime = BitConverter.ToUInt32(current.demoTime, 0);
	}
	//convert float to uint for XLC2
	else if(game.ProcessName == "RXC2") {
		vars.convertedIGT = (uint)current.igt;
		vars.convertedDemoTime = (uint)current.demoTime;
	}
	//Bizhawk, ePSXe, Windows X5 don't do anything fancy
	else if (game.ProcessName == "EmuHawk" || game.ProcessName == "ePSXe" || game.ProcessName == "x5") {
		vars.convertedIGT = current.igt;
		vars.convertedDemoTime = current.demoTime;
	}
}

isLoading {
	return true;
}

gameTime {
	if(vars.firstPass) {
		vars.firstPass = false;
		return TimeSpan.FromMilliseconds(0);
	}
	if(vars.convertedIGT != 0 && current.level != 22 && vars.convertedDemoTime == 0) {
		return TimeSpan.FromMilliseconds((1000.0 / 60.0) * vars.convertedIGT);
	}
}

shutdown
{
	//unload reset event
	timer.OnReset -= vars.resetAction;
}
