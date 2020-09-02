//Made by Coltaho 2/5/2020
//Updated by JohnnyGo 9/2/2020

state("emuhawk") {
	//Add 0x11D880 to RAM watch address to get these
	byte4 igtAOB : "octoshock.dll", 0x1EA81C;
}

state("RXC2") {
	byte4 igtAOB : 0x3DD7814, 0x178;
}

state("ePSXe", "v2.0.5") {
	byte4 igtAOB : "ePSXe.exe", 0xB4EFBC;
}


state("Dolphin", "v5.0") {
	//got the first offset from the RE2 Dolphin autosplitter (https://www.speedrun.com/re2/thread/izb1f/)
	//got the second offset by subtracting the address I found in Cheat Engine from the game memory start (Dolphin.exe+DCE040)
	byte4 igtAOB: "Dolphin.exe", 0xDCE040, 0xB369B4;
}

startup {
	refreshRate = 1;
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man X6 AutoSplitter v2.0 by Coltaho and JohnnyGo", "infosection");
	settings.Add("info0", true, "- Compare against Game Time, does not autosplit", "infosection");
	settings.Add("info1", true, "- Supported emulators : Bizhawk, ePSXe, Dolphin, and PC XLC", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
	settings.Add("info3", true, "- Website : https://github.com/Johnny-Go/Autosplitters", "infosection");
}

init {
	print("--Setting init variables!--");
	refreshRate = 60;
	vars.igt = 0;
}

update {
	//print("--IGT: " + vars.igt);
	
	//reverse bytes for Dolphin
	if(current.igtAOB[0] <= 0) {
		Array.Reverse(current.igtAOB);
	}
	vars.igt = BitConverter.ToUInt32(current.igtAOB, 0);
}

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromMilliseconds((1000.0 / 60.0) * vars.igt);
}