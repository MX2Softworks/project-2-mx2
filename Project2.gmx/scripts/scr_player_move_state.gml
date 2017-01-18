/// scr_player_move_state()

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

     //To prevent hspd from stopping when we jump and slide
    if(vspd != 0 && is_sliding == 1){
        hspd = min(abs(hspd)+((acc*(1+(sprint/2.0)))*global.delta), maxspd*(1+(sprint/2.0))) * direction_horizontal;
    }


    //Determine whether the player has reached peak jump height.
    if(vspd >= 0) {
        if (fall_frames > 0) {
            jumppeak = 0;
            fall_frames -= 1;
        } else {
            jumppeak = 1;
        }
    }
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
        jumppeak = 0;
    } else {
        can_dash = true;
    }
    
    //Vertical speed maximums/minimums. 
    if(vspd > 15) { vspd = 15;}
    else if(vspd < -15) { vspd = -15; } 
    
// After Dash Float
    if (float_frames > 0) {
        vspd = 0;
        hspd = 0;
        if (v_float) {
            if (place_meeting(x, y-1, obj_solid)) {
                switch_up = true;
                float_frames /= 2;
            }
            if (switch_up) {
                vspd += float_frames * .05;
            } else {
                vspd -= float_frames * .05;
            }
        } else if (h_float_left) {
            if (place_meeting(x-1, y, obj_solid)) {
                switch_left = true;
                float_frames /= 2;
            }
            if (switch_left) {
                hspd += float_frames * .05;
            } else {
                hspd -= float_frames * .05;
            }
        } else if (h_float_right) {
            if (place_meeting(x+1, y, obj_solid)) {
                switch_right = true;
                float_frames /= 2;
            }
            if (switch_right) {
                hspd -= float_frames * .05;
            } else {
                hspd += float_frames * .05;
            }
        }
        float_frames -= 1;
        if (float_frames == 0) {
            fall_frames = 20;
        }
    } else {
        switch_left = false;
        switch_right = false;
        switch_up = false;
    }
    
// Dash Mode
    if (switch_dash_mode) {
        if (dash_charge_mode) {
            dash_charge_mode = false;
        } else {
            dash_charge_mode = true;
        }
    }
    if (dash_charge_mode) {
        dash_activate = dash_released;
    } else {
        dash_activate = dash;
    }
    
// Mid-Air Dashing
    if (can_dash) {
        // In mid-air
        if (dash_frames_v != 0) {
            // Dashing up
            vspd = -dash_speed * .6;
            hspd = 0;
            dash_frames_v -= 1;
            if (dash_frames_v == 0) {
                float_frames = 40;
                v_float = true;
            }
            h_float_left = false;
            h_float_right = false;
        } else {
            // Not dashing up
            if (dash_frames_h > 0) {
                // Dashing right
                hspd = dash_speed;
                vspd = 0;
                dash_frames_h -= 1;
                if (dash_frames_h == 0) {
                    float_frames = 40;
                    h_float_right = true;
                }
                h_float_left = false;
                v_float = false;
            } else if (dash_frames_h < 0) {
                // Dashing left
                hspd = -dash_speed;
                vspd = 0;
                dash_frames_h += 1;
                if (dash_frames_h == 0) {
                    float_frames = 40;
                    h_float_left = true;
                }
                v_float = false;
                h_float_right = false;
            } else {
                // Not dashing at all
                if (dash_count < 3) {
                    // Can dash again
                    if (dash_activate && (right_held || (diag_ur_held && abs(x_axis) >= abs(y_axis)) || (diag_dr_held && abs(x_axis) >= abs(y_axis)))) {
                        // Wants to dash right
                        if (dash_charge_mode) {
                            if (dash_distance_mod > 0) {
                                dash_frames_h += dash_distance_mod;
                                hspd = dash_speed;
                                vspd = 0;
                                dashed = true;
                            }
                        } else {
                            dash_frames_h += 5;
                            dash_count += 1;
                            hspd = dash_speed;
                            vspd = 0;
                            dashed = true;
                        }
                    } else if (dash_activate && (left_held || (diag_ul_held && abs(x_axis) >= abs(y_axis)) || (diag_dl_held && abs(x_axis) >= abs(y_axis)))) {
                        // Wants to dash left
                        if (dash_charge_mode) {
                            if (dash_distance_mod > 0) {
                                dash_frames_h -= dash_distance_mod;
                                hspd = -dash_speed;
                                vspd = 0;
                                dashed = true;
                            }
                        } else {
                            dash_frames_h -= 5;
                            dash_count += 1;
                            hspd = -dash_speed;
                            vspd = 0;
                            dashed = true;
                        }
                    } else if (dash_activate && ((up_held && !gamepad_is_connected(0)) || (stick_up_held && gamepad_is_connected(0)) || (diag_ul_held && abs(y_axis) > abs(x_axis)) || (diag_ur_held && abs(y_axis) > abs(x_axis)))) {
                        // Wants to dash up
                        if (dash_charge_mode) {
                            if (dash_distance_mod > 0) {
                                dash_frames_v += dash_distance_mod;
                                vspd = -dash_speed * .6;
                                hspd = 0;
                                dashed = true;
                            }
                        } else {
                            dash_frames_v += 5;
                            dash_count += 1;
                            vspd = -dash_speed * .6;
                            hspd = 0;
                            dashed = true;
                        }
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
    
    // Dash Charge
    if (dash_charge_mode) {
        if (can_dash) {
            if (dash_count < 3) {
                if (dash_held) {
                    if (dash_held_frames <= 75) {
                        dash_held_frames += 1;
                    }
                    dash_distance_mod = dash_held_frames div 15;
                    vspd = 0;
                    hspd = 0;
                } else if (dash_released) {
                    dash_held_frames = 0;
                    dash_distance_mod = 0;
                    dash_count += 1;
                }
            }
        }
    } else {
        dash_held_frames = 0;
        dash_distance_mod = 0;
    }
    
    // Fast fall
    if(down) {
        vspd += 12 * global.delta;
        float_frames = 0;
    }
    
//Update our sprite so it faces the proper direction. 
    if (hspd != 0) {
        image_xscale = sign(hspd);
    }
    
scr_move(obj_solid);




