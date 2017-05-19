/// @description If Game is Paused

//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}


/// Execute the script

// sets up directional variables
hspd = dir * maxspd * (0.00006*delta_time);
if(place_meeting(x + hspd, y, obj_moving_platform_bound))
{
     // pixel perfect collision
        while(!place_meeting(x + sign(hspd), y, obj_moving_platform_bound))
        {
            x += sign(hspd);
        }
        
        hspd = 0;
        dir *= -1;
    
}
if(instance_exists(obj_player)){
    if(place_meeting(x, y-1, obj_player)){
        inst = instance_place(x, y-1, obj_player);
        obj_player.hspd_platform = hspd; 
    }
}

if(instance_exists(obj_enemy_patrol)){
    if(place_meeting(x, y-1, obj_enemy_patrol)){
        inst = instance_place(x, y-1, obj_enemy_patrol);
        (inst).hspd_platform = hspd;  
    }
}


/*

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
    }*/
    
// apply movement
x += hspd;
y += vspd;

/* */
/*  */
