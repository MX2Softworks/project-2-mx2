/// scr_player_move_state()

//Determine direction of movement based off of inputs. 
    direction_vertical = max(down, down_held) - max(up, up_held); 
    direction_horizontal = right - left; 

//Horizontal Movement
    //We check to see if we are attempting to change direction, or if we stop giving input. If so, slow down. 
    if(direction_horizontal == 0 || (hspd > 0 && direction_horizontal == -1) || (hspd < 0 && direction_horizontal == 1)){ 
        hspd = max(abs(hspd) - (acc*1.5), 0) * sign(hspd); 
    }
    //Otherwise, apply acceleration as normal. 
    else{
        hspd = min(abs(hspd)+(acc*(1+(sprint/2.0))), maxspd*(1+(sprint/2.0))) * direction_horizontal; 
    } 

//Vertical Movement
    //Determine whether the player has reached peak jump height.
    if(vspd >= 0){ jumppeak = 1; }
    else if(vspd < 0)
    {
        //Variable jump height based off of how long the jump button is held. 
        if(up_held == 0){ vspd = max(vspd, -jumpheight/4); }
        jumppeak = 0;
    }
    
    //Constantly apply gravity. 
    if(vspd < 15){ vspd += grav * (jumppeak*8 + 1); }
    
    //Jump only if on a solid object. 
    if(place_meeting(x, y+1, obj_solid)) vspd = up * -jumpheight; 
    
    //Fast fall
    if(down) vspd += 12; 
    
    //Vertical speed maximums/minimums. 
    if(vspd > 15) { vspd = 15;}
    else if(vspd < -15) { vspd = -15; } 
    
//Update our sprite so it faces the proper direction. 
    if (hspd != 0) {
        image_xscale = sign(hspd);
    }

scr_move(obj_solid);




