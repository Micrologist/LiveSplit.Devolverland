state("Devolverland_Expo-Win64-Shipping", "Release Version")
{
    float xPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D0;
    float yPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D4;
    float zPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D8;
}

state("Devolverland_Expo-Win64-Shipping", "Patch 1")
{
    float xPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D0;
    float yPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D4;
    float zPos : 0x03BD5830, 0x30, 0x250, 0x290, 0x1D8;
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
    double oldX = Math.Floor(old.xPos);
    double oldY = Math.Floor(old.yPos);
    double oldZ = Math.Floor(old.zPos);
    if(oldX == -50023.0 && oldY == -7076.0 && oldZ == 746.0)
    {
        double curX = Math.Floor(current.xPos);
        double curY = Math.Floor(current.yPos);
        double curZ = Math.Floor(current.zPos);
        if(curX != oldX || curY != oldY || curZ != oldZ)
        {
            vars.split = false;
            return true;
        }
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
                vars.split = true;
            }
        }
    }
    if(vars.split && current.xPos == old.xPos)
    {
        vars.split = false;
        return true;
    }
}


reset
{
    double curX = Math.Floor(current.xPos);
    double curY = Math.Floor(current.yPos);
    double curZ = Math.Floor(current.zPos);
    if(curX == -50023.0 && curY == -7076.0 && curZ == 746.0)
        return true;
}