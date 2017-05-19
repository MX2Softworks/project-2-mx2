// sets up directional variables
hspd = dir * maxspd;

// apply gravity
vspd += grav;

// moves in the direction of the player if within a certain distance
if(instance_exists(obj_player))
{
    
    if(obj_player.x > x)
    {
        dir = -1;
    }
    else
    {
        dir = 1;
    }
}


// horizontal collision
// horizontal collision
    // checks to see if wall in front
    if (place_meeting(x + hspd, y, obj_solid))
    {
        // collision prediction
        while(!place_meeting(x + sign(hspd), y, obj_solid))
        {
            x += sign(hspd);
        }
        
        hspd = 0;
        dir *= -1;
    }
    
// vertical collision
   // checks to see if on floor
    if (place_meeting(x, y + vspd, obj_solid))
    {
        // collision prediction
        while(!place_meeting(x, y + sign(vspd), obj_solid))
        {
            y += sign(vspd);
        }
        
        vspd = 0;
        dir *= -1;
    }
    
// apply movement
x += hspd;
y += vspd;
