// sets up directional variables
hspd = dir * maxspd;

// apply gravity
vspd += grav;

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
        
        if(fearofheights) && !position_meeting(x + (sprite_width / 2) * dir, y + (sprite_height / 2) + 8, obj_solid)
        {
            dir *= -1;
        }
    }
    
// apply movement
x += hspd;
y += vspd;
