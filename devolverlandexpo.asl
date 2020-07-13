state("Devolverland_Expo-Win64-Shipping")
{
    float xPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D0;
    float yPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D4;
    float zPos : 0x03BD5430, 0x30, 0x250, 0x290, 0x1D8;

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
            return true;
    }
}

split
{
    if(current.yPos < -14000.0f && current.yPos > -14500.0f)
    {
        if(current.zPos > 200.0f && current.zPos < 600.0f)
        {
            if(current.xPos > -94000.0f && current.xPos < -93400.0f)
                return true;
        }
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