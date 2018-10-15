state("game") {
	int myhp : 0xB87A20, 0x468, 0x183C; //Mega Man's current health
	int stage : 0xB87660, 0x150; //Stage Select(0 block, 8 tundra, 4 is all Wily stages)
	int wilystage : 0xC3F6C0, 0x3B48; //Wily stage select
	int bosshp : 0xB87660, 0x120, 0x4628; //Boss health (56 or 28 depending on difficulty)
	int enemyid : 0xC3EF58, 0x230, 0x1840;  //Enemy ID? (can be shared with other enemies)
	int ydform : 0xC3EF58, 0x230, 0x187C;  //Yellow Devil form indicator?
	int selectedindex : 0xC3EF58, 0x358, 0x4688; //Currently selected index on main menu
	int selecteddifficulty : 0xC3EF58, 0x358, 0x4684; //Selected difficulty on main menu
	int igt : 0xC3F6C0, 0x3888; //frame counter starts slightly after difficulty select, resets on main menu
	int roomid : 0xB87F60, 0x78C; //Room ID
	int xpos : 0xC3EF58, 0x1D0, 0x1878; // X Pos
	int ypos : 0xC3EF58, 0x1D0, 0x187C; // Y Pos
}

startup {
	print("--Starting up!--");
	vars.stopwatch = new Stopwatch();
	refreshRate = 1;
	settings.Add("onteleport", true, "Split on teleport instead of on kill");
	settings.Add("blank", true, "---Just Info Below--");
	settings.Add("info", false, "MM11 Autosplitter v1.6 by Coltaho");
	settings.Add("info0", true, "Now splits on capsule teleport out of Wily 3 (refights)!", info);
	settings.Add("info1", false, "- Website : https://github.com/Coltaho/Autosplitters", "info");
	settings.SetToolTip("main", "Pretty cool, right?");
}

init {
	if (modules.First().ModuleMemorySize != 234926080) {
		throw new Exception("--This isn't Mega Man 11!");
	} else {
		print("--Found Mega Man 11");
		refreshRate = 70;
		vars.ydteleport = 15500;
		vars.lastroomtime = 0;
		vars.currentroomtime = 0;
		vars.roomstart = 0;
		vars.formattedigt = "";
		vars.formattedcurrentroomtime = "";
		vars.formattedlastroomtime = "";
		vars.refightkills = 0;
	}
}

update {
	if (current.igt != 0) {
		if (current.roomid != old.roomid) {
			vars.lastroomtime = current.igt - vars.roomstart;
			vars.roomstart = current.igt;
		}
		vars.currentroomtime = current.igt - vars.roomstart;
		vars.formattedigt = "(H:M:S:Frames) " + (current.igt / 60 / 60 / 60 % 60) + ":" + (current.igt / 60 / 60 % 60).ToString("D2") + ":" + (current.igt / 60 % 60).ToString("D2") + ":" + (current.igt % 60).ToString("D2");
		vars.formattedcurrentroomtime = (vars.currentroomtime / 60 / 60).ToString("D2") + ":" + (vars.currentroomtime / 60 % 60).ToString("D2") + ":" + (vars.currentroomtime % 60).ToString("D2");
		vars.formattedlastroomtime = (vars.lastroomtime / 60 / 60).ToString("D2") + ":" + (vars.lastroomtime / 60 % 60).ToString("D2") + ":" + (vars.lastroomtime % 60).ToString("D2");
	} else {
		vars.currentroomtime = 0;
		vars.lastroomtime = 0;
		vars.roomstart = 0;
		vars.formattedigt = "IGT Not Started";
		vars.formattedcurrentroomtime = "IGT Not Started";
	}
	
	//If we kill a boss on a refight, increment refight counter
	if (current.wilystage == 3 && current.myhp > 0 && current.bosshp <= 0 && old.bosshp > 0) {
		vars.refightkills++;
	}
	
	//If we left wily 3 or gameovered, reset refight kills to 0
	if (current.wilystage == 3 && current.xpos == 0 && current.ypos == 0) {
		vars.refightkills = 0;
	}
	print("--Health: " + current.myhp + " | stage: " + current.stage + " | wilystage: " + current.wilystage + " | Boss Health: " + current.bosshp + " | EnemyID: " + current.enemyid + " | Position: " + current.xpos + ", " + current.ypos + " | Refight Kills: " + vars.refightkills);
		
	if (current.selecteddifficulty == 2 && current.selectedindex == 2 && old.selectedindex == 0) {
		print("--We appear to be selecting a difficulty!");
		
		//Set stage select to 4, so that when we start we can watch for it to be set to 0 to start timer
		game.WriteBytes((game.ReadPointer((IntPtr)0x140B87660) + 0x150), new byte[] {0x4}); 
	}
}

start {
	return (current.igt == 0 && current.stage == 0 && old.stage == 4);
}

reset {
	return (current.igt == 0 && old.igt > 0);
}

split {	
	//Split on last boss kill hit
	if (current.wilystage == 4 && current.enemyid == 5 && current.myhp > 0 && current.bosshp <= 0 && old.bosshp > 0)
		return true;
	//split on boss kill hit unless on refights
	if (current.wilystage < 3 && current.myhp > 0 && current.bosshp <= 0 && old.bosshp > 0) {
		//if on teleport, start a stopwatch	
		if (settings["onteleport"]) {
			vars.stopwatch.Restart();
			if (current.wilystage == 1 && old.ydform == 34) {
				vars.ydteleport = 11500;
			}
			else {
				vars.ydteleport = 15500;
			}
		} else {
			return true;
		}
	}
	
	//Split if we are standing on final capsule after 8 robos are killed
	if (vars.refightkills == 8 && current.xpos == 74 && current.ypos == 58) {
		vars.refightkills = 0;
		vars.stopwatch.Restart();
		return true;
	}
	
	//split if stopwatch is ready
	if ((current.wilystage == 0 && vars.stopwatch.ElapsedMilliseconds > 16500) || (current.wilystage == 1 && vars.stopwatch.ElapsedMilliseconds > vars.ydteleport) //11.5 if killed small, 15.5 if killed big
	 || (current.wilystage == 2 && vars.stopwatch.ElapsedMilliseconds > 11750) || (current.wilystage == 3 && vars.stopwatch.ElapsedMilliseconds > 250)) {
		vars.stopwatch.Reset();
		return true;
	}
}
