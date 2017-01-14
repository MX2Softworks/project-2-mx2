// sets up directional variables
hspd = hdir * maxspd;
vspd = vdir * maxspd;

// x tracking
if(obj_player.x > x)
{    
    hdir = 1;
}
else
{
    hdir = -1;
}

// y tracking
if(obj_player.y > y)
{
    vdir = 1;
}
else
{
    vdir = -1;
}

x += hspd;
y += vspd;
