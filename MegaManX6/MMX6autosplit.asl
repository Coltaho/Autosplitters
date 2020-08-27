//Made by Coltaho 2/5/2020

state("emuhawk") {
	//Add 0x11D880 to RAM watch address to get these
	uint igt : "octoshock.dll", 0x1EA81C;
}

state("RXC2") {
	uint igt : 0x3DD7814, 0x178;
}

state("ePSXe") {
	uint igt : "ePSXe.exe", 0xB4EFBC;
}

startup {
	refreshRate = 1;
	
	settings.Add("infosection", true, "---Info---");
	settings.Add("info", true, "Mega Man X6 AutoSplitter v1.1 by Coltaho", "infosection");
	settings.Add("info0", true, "- Compare against Game Time, does not autosplit", "infosection");
	settings.Add("info1", true, "- Supported emulators : Bizhawk, ePSXe, and PC XLC", "infosection");
	settings.Add("info2", true, "- Website : https://github.com/Coltaho/Autosplitters", "infosection");
}

init {
	print("--Setting init variables!--");
	refreshRate = 60;
}

update {
	// print("--IGT: " + current.igt);
}

isLoading {
	return true;
}

gameTime {
	return TimeSpan.FromMilliseconds((1000.0 / 60.0) * current.igt);
}
