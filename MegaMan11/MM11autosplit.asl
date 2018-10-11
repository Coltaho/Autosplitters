state("game") {
	int myhp : 0xB87A20, 0x468, 0x183C; //Mega Man's current health
	int stage : 0xB87660, 0x150; //Stage Select(0 block, 8 tundra, 4 is all Wily stages)
	int wilystage : 0xC3F6C0, 0x3B48; //Wily stage select
	int bosshp : 0xB87660, 0x120, 0x4628; //Boss health (56 or 28 depending on difficulty)
	int enemyid : 0xC3EF58, 0x230, 0x1840;  //Enemy ID? (can be shared with other enemies)
	int selectedindex : 0xC3EF58, 0x358, 0x4688; //Currently selected index on main menu
	int selecteddifficulty : 0xC3EF58, 0x358, 0x4684; //Selected difficulty on main menu
}

startup {
	print("--Starting up!--");
	refreshRate = 1;
	settings.Add("main", true, "MM11 Autosplitter v1.0 by Coltaho");
	settings.Add("main0", true, "- Website : https://github.com/Coltaho/Autosplitters", "main");
	settings.Add("main1", true, "Currently can only split on boss kill! Resets timer when selecting start.", "main");
	settings.SetToolTip("main", "Pretty cool, right?");
}

init {
	if (modules.First().ModuleMemorySize != 234926080) {
		throw new Exception("--This isn't Mega Man 11!");
	} else {
		print("--Found Mega Man 11");
		refreshRate = 60;
	}
}

update {
	print("--Health: " + current.myhp + " | stage: " + current.stage + " | wilystage: " + current.wilystage + " | Boss Health: " + current.bosshp + " | EnemyID: " + current.enemyid);
	
	if (current.selecteddifficulty == 2 && current.selectedindex == 2 && old.selectedindex == 0) {
		print("--We appear to be selecting a difficulty!");
		
		//Set stage select to 4, so that when we start we can watch for it to be set to 0 to start timer
		game.WriteBytes((game.ReadPointer((IntPtr)0x140B87660) + 0x150), new byte[] {0x4}); 
	}
}

start {
	return (current.stage == 0 && old.stage == 4);
}

reset {
	return (current.selectedindex == 1 && old.selectedindex == 0 && current.selecteddifficulty == 2);
}

split {	
	if (current.wilystage < 3 && current.myhp > 0 && current.bosshp <= 0 && old.bosshp > 0)
		return true;
	if (current.wilystage == 4 && current.enemyid == 5 && current.myhp > 0 && current.bosshp <= 0 && old.bosshp > 0)
		return true;
}
