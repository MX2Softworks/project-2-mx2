// sets up directional variables
hspd = dir * maxspd * (0.00006*delta_time);

var hspd_total = hspd + hspd_platform;
var vspd_total = vspd + vspd_platform; 

// apply gravity
vspd_total += grav;

// horizontal collision
    // checks to see if wall in front
    if (place_meeting(x + hspd_total, y, obj_solid))
    {
        // collision prediction
        while(!place_meeting(x + sign(hspd_total), y, obj_solid))
        {
            x += sign(hspd_total);
        }
        
        hspd = 0;
        hspd_total = 0; 
        dir *= -1;
    }
    
// vertical collision
   // checks to see if on floor
    if (place_meeting(x, y + vspd_total, obj_solid))
    {
        // collision prediction
        while(!place_meeting(x, y + sign(vspd_total), obj_solid))
        {
            y += sign(vspd_total);
        }
        vspd = 0;
        vspd_total = 0
        
        if(fearofheights) && !position_meeting(x + (sprite_width / 2) * dir, y + (sprite_height / 2) + 8, obj_solid)
        {
            dir *= -1;
        }
    }


hspd_platform = 0;
vspd_platform = 0; 
    
// apply movement
x += hspd_total
y += vspd_total
