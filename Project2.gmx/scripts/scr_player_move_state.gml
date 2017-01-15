/// scr_player_move_state()

//Determine direction of movement based off of inputs. 
    direction_vertical = max(down, down_held) - max(up, up_held); 
    direction_horizontal = max(right, right_held) - max(left, left_held); 

//Horizontal Movement
    
    //Slide if we have horizontal speed but are holding down. 
    if(is_sliding == 1){
        hspd = max(abs(hspd) - ((acc*.25)*global.delta), 0) * sign(hspd);   
    }
    //We check to see if we are attempting to change direction, or if we stop giving input. If so, slow down. 
    else if(direction_horizontal == 0 || (hspd > 0 && direction_horizontal == -1) || (hspd < 0 && direction_horizontal == 1)){ 
        hspd = max(abs(hspd) - ((acc*1.5)*global.delta), 0) * sign(hspd);
    }
    //Otherwise, apply acceleration as normal. 
    else{
        hspd = min(abs(hspd)+((acc*(1+(sprint/2.0)))*global.delta), maxspd*(1+(sprint/2.0))) * direction_horizontal; 
    } 

//Vertical Movement
    //Determine whether the player has reached peak jump height.
    if(vspd >= 0){ jumppeak = 1; }
    else if(vspd < 0)
    {
        //Variable jump height based off of how long the jump button is held. 
        if(up_held == 0 && dashed == false){ vspd = max(vspd, -jumpheight/4); }
        jumppeak = 0;
    } 
    
    //Constantly apply gravity. 
    if(vspd < 15){
        vspd += (grav * (jumppeak*3 + 1)) * global.delta;
    }
    
    //Jump only if on a solid object. 
    if(place_meeting(x, y+1, obj_solid)) {
        vspd = up * -jumpheight; 
        dash_count = 0;
        dash_frames_v = 0;
        dash_frames_h = 0;
        can_dash = false;
        dashed = false;
    } else {
        can_dash = true;
    }
    
    //Fast fall
    if(down) vspd += 12 * global.delta;
    
    //Vertical speed maximums/minimums. 
    if(vspd > 15) { vspd = 15;}
    else if(vspd < -15) { vspd = -15; } 
    
// Mid-Air Dashing
    if (can_dash) {
        // In mid-air
        if (dash_frames_v != 0) {
            // Dashing up
            vspd = -dash_speed;
            hspd = 0;
            dash_frames_v -= 1;
        } else {
            // Not dashing up
            if (dash_frames_h > 0) {
                // Dashing right
                hspd = dash_speed;
                vspd = 0;
                dash_frames_h -= 1;
            } else if (dash_frames_h < 0) {
                // Dashing left
                hspd = -dash_speed;
                vspd = 0;
                dash_frames_h += 1;
            } else {
                // Not dashing at all
                if (dash_count < 3) {
                    // Can dash again
                    if (dash && right_held) {
                        // Wants to dash right
                        dash_frames_h += 5;
                        dash_count += 1;
                        hspd = dash_speed;
                        vspd = 0;
                        dashed = true;
                    } else if (dash && left_held) {
                        // Wants to dash left
                        dash_frames_h -= 5;
                        dash_count += 1;
                        hspd = -dash_speed;
                        vspd = 0;
                        dashed = true;
                    } else if (dash && up_held) {
                        // Wants to dash up
                        dash_frames_v += 5;
                        dash_count += 1;
                        vspd = -dash_speed;
                        hspd = 0;
                        dashed = true;
                    } else {
                        // Isnt dashing and doesnt want to dash
                    }
                } else {
                    // Cant dash anymore
                }
            }
        }
    } else {
        // Cant dash
    }
    
//Update our sprite so it faces the proper direction. 
    if (hspd != 0) {
        image_xscale = sign(hspd);
    }
    
scr_move(obj_solid);




