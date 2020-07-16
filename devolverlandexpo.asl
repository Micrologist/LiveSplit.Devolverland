state("Devolverland_Expo-Win64-Shipping", "Release Version")
{
    float xPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D0;
    float yPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D4;
    float zPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D8;

    float playerTime : 0x03BD5430, 0x30, 0x250, 0x288, 0xA0, 0x114;

    byte carrionCheck : 0x03BE30A0, 0x48, 0xA0, 0x2B8, 0x1C;
    byte carrionPlaying : 0x03BE30A0, 0x48, 0xA0, 0x2B8, 0x2B4;

    byte westCheck : 0x03BE30A0, 0x48, 0xA0, 0x2A8, 0x1C;
    byte westPlaying : 0x03BE30A0, 0x48, 0xA0, 0x2A8, 0x2B4;

    byte blightCheck : 0x03BE30A0, 0x48, 0xA0, 0x2E8, 0x1C;
    byte blightPlaying : 0x03BE30A0, 0x48, 0xA0, 0x2E8, 0x2B4;
    
    byte olijaCheck : 0x03BE30A0, 0x48, 0xA0, 0x2F0, 0x1C;
    byte olijaPlaying : 0x03BE30A0, 0x48, 0xA0, 0x2F0, 0x2B4;
    
    byte samCheck : 0x03BE30A0, 0x48, 0xA0, 0x2F8, 0x1C;
    byte samPlaying : 0x03BE30A0, 0x48, 0xA0, 0x2F8, 0x2B4;
    
    byte fallsCheck : 0x03BE30A0, 0x48, 0xA0, 0x300, 0x1C;
    byte fallsPlaying : 0x03BE30A0, 0x48, 0xA0, 0x300, 0x2B4;
    
    byte shadowCheck : 0x03BE30A0, 0x48, 0xA0, 0x310, 0x1C;
    byte shadowPlaying : 0x03BE30A0, 0x48, 0xA0, 0x310, 0x2B4;
}

state("Devolverland_Expo-Win64-Shipping", "Patch 1")
{
    float xPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D0;
    float yPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D4;
    float zPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D8;

    float playerTime : 0x03BD5830, 0x30, 0x250, 0x288, 0xA0, 0x114;

    byte carrionCheck : 0x03BE34A0, 0x48, 0xA0, 0x2B8, 0x1C;
    byte carrionPlaying : 0x03BE34A0, 0x48, 0xA0, 0x2B8, 0x2B4;

    byte westCheck : 0x03BE34A0, 0x48, 0xA0, 0x2A8, 0x1C;
    byte westPlaying : 0x03BE34A0, 0x48, 0xA0, 0x2A8, 0x2B4;

    byte blightCheck : 0x03BE34A0, 0x48, 0xA0, 0x2E8, 0x1C;
    byte blightPlaying : 0x03BE34A0, 0x48, 0xA0, 0x2E8, 0x2B4;
    
    byte olijaCheck : 0x03BE34A0, 0x48, 0xA0, 0x2F0, 0x1C;
    byte olijaPlaying : 0x03BE34A0, 0x48, 0xA0, 0x2F0, 0x2B4;
    
    byte samCheck : 0x03BE34A0, 0x48, 0xA0, 0x2F8, 0x1C;
    byte samPlaying : 0x03BE34A0, 0x48, 0xA0, 0x2F8, 0x2B4;
    
    byte fallsCheck : 0x03BE34A0, 0x48, 0xA0, 0x300, 0x1C;
    byte fallsPlaying : 0x03BE34A0, 0x48, 0xA0, 0x300, 0x2B4;
    
    byte shadowCheck : 0x03BE34A0, 0x48, 0xA0, 0x310, 0x1C;
    byte shadowPlaying : 0x03BE34A0, 0x48, 0xA0, 0x310, 0x2B4;
}

startup
{
    vars.splitOnStop = false;
    vars.doneSplits = new List<String>();
    vars.startTime = System.DateTime.Now;
    vars.startIfStopped = false;
    vars.setGameTime = true;

    settings.Add("split", false, "Split on watching trailers");
	settings.Add("carrion", true, "Carrion Trailer", "split");
	settings.Add("west", true, "Weird West Trailer", "split");
	settings.Add("blight", true, "Blightbound Trailer", "split");
	settings.Add("olija", true, "Olija Trailer", "split");
	settings.Add("sam", true, "Serious Sam Trailer", "split");
	settings.Add("falls", true, "Fall Guys Trailer", "split");
	settings.Add("shadow", true, "Shadow Warrior Trailer", "split");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This script relies on setting the comparison to \"Game Time\" for accurate time keeping.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Devolverland Expo",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	print("[DEVOLVERLAND ASL] Main Module Size: "+moduleSize.ToString());
	if (moduleSize == 67051520)
	{
		version = "Release Version";
	} 
	else if (moduleSize == 67055616)
	{
		version = "Patch 1";
	}
	else
	{
		version = "Unsupported: " + moduleSize.ToString();
		MessageBox.Show("This game version is currently not supported.", "LiveSplit Auto Splitter - Unsupported Game Version");
	}
}

update
{
	//Disable the script if the version is unknown
	if (version.Contains("Unsupported"))
		return false;
}

start
{
    if(current.xPos == 0)
        return false;
    
    if(!vars.startIfStopped && Math.Floor(current.xPos) == -50023.0 && Math.Floor(current.yPos) == -7076.0 && Math.Floor(current.zPos) == 746.0)
    {
        vars.startIfStopped = true;
    }

    if(vars.startIfStopped)
    {
        if(current.playerTime != old.playerTime)
        {
            vars.startTime = System.DateTime.Now + TimeSpan.FromSeconds(0.1f);
        } 
        else if (System.DateTime.Now >= vars.startTime)
        {
            vars.startIfStopped = false;
            vars.splitOnStop = false;
            vars.doneSplits = new List<String>();
            vars.setGameTime = true;
            return true;
        }
    }
}

gameTime
{
    if(vars.setGameTime)
    {
        vars.setGameTime = false;
        return TimeSpan.FromSeconds(0.15f);
    }
}

split
{
    if(current.yPos < -14000.0f && current.yPos > -14500.0f)
    {
        if(current.zPos > 200.0f && current.zPos < 600.0f)
        {
            if(current.xPos > -94000.0f && current.xPos < -93400.0f)
            {
                vars.splitOnStop = true;
            }
        }
    }
    if(vars.splitOnStop && current.xPos == old.xPos)
    {
        vars.splitOnStop = false;
        return true;
    }

    if(settings["carrion"] && !vars.doneSplits.Contains("carrion") && current.carrionCheck == 0x3 && current.carrionPlaying == 0x1)
    {
        vars.doneSplits.Add("carrion");
        print("splitting for carrion");
        return true;
    }
    if(settings["west"] && !vars.doneSplits.Contains("west") && current.westCheck == 0x3 && current.westPlaying == 0x1)
    {
        vars.doneSplits.Add("west");
        print("splitting for west");
        return true;
    }
    if(settings["blight"] && !vars.doneSplits.Contains("blight") && current.blightCheck == 0x3 && current.blightPlaying == 0x1)
    {
        vars.doneSplits.Add("blight");
        print("splitting for blight");
        return true;
    }
    if(settings["olija"] && !vars.doneSplits.Contains("olija") && current.olijaCheck == 0x3 && current.olijaPlaying == 0x1)
    {
        vars.doneSplits.Add("olija");
        print("splitting for olija");
        return true;
    }
    if(settings["sam"] && !vars.doneSplits.Contains("sam") && current.samCheck == 0x3 && current.samPlaying == 0x1)
    {
        vars.doneSplits.Add("sam");
        print("splitting for sam");
        return true;
    }
    if(settings["falls"] && !vars.doneSplits.Contains("falls") && current.fallsCheck == 0x3 && current.fallsPlaying == 0x1)
    {
        vars.doneSplits.Add("falls");
        print("splitting for falls");
        return true;
    }
    if(settings["shadow"] && !vars.doneSplits.Contains("shadow") && current.shadowCheck == 0x3 && current.shadowPlaying == 0x1)
    {
        vars.doneSplits.Add("shadow");
        print("splitting for shadow");
        return true;
    }
}

reset
{
    double curX = Math.Floor(current.xPos);
    double curY = Math.Floor(current.yPos);
    double curZ = Math.Floor(current.zPos);
    if(curX == -50023.0 && curY == -7076.0 && curZ == 746.0 && current.playerTime < 3.0f)
        return true;
}