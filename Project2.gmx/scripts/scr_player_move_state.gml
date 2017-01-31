/// scr_player_move_state()

//Horizontal Movement
    
    //Apply normal acceleration in the direction opposite of the wall if the player wall jumps. 
    //Also increase the wall jump counter by the delta time.
    if(wall_jump == true){
        hspd = min(abs(hspd)+((acc*(1+(sprint/2.0)))*global.delta), maxspd*(1+(sprint/2.0))) * sign(hspd); 
        wall_jump_counter += (1 * global.delta); 
    }
    //Slide if the player has horizontal speed but is holding down. 
    else if(wall_slide == true){
       // do nothing, but prevent other horizontal accelerations
    }
    else if(is_sliding == 1){
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
    //If the wall jump counter is greater than than the max, stop applying horizontal acceleration in the direction 
    //opposite of the wall
    if(wall_jump_counter >= wall_jump_counter_max && sign(direction_horizontal) == -sign(hspd)){
        
        wall_jump = false;
        wall_jump_counter = 0; 
    }

//Vertical Movement

    //Determine whether the player has reached peak jump height.
    if(vspd >= 0) {
        // For the first 20 frames after a dash the fall is less drastic
        if (fall_frames > 0) {
            jumppeak = 0;
            fall_frames -= 1;
        } else {
            jumppeak = 1;
        }
    }
    else if(vspd < 0){
        //Variable jump height based off of how long the jump button is held. 
        if(up_held == 0 && dashed == false){ vspd = max(vspd, -jumpheight/4); }
        jumppeak = 0;
    } 
    

    //Wall Sliding
    //Set wall_sliding to true if we are touching a wall in midair.
    if((place_meeting(x-1, y, obj_solid) || place_meeting(x+1, y, obj_solid)) && !place_meeting(x, y+1, obj_solid) && !place_meeting(x, y, obj_solid) && !place_meeting(x, y, obj_platform)){
        wall_slide = true;
    }
    //If we are no longer wall sliding, swap our sprite's direction. 
    else if(wall_slide == true && (!place_meeting(x-1, y, obj_solid) || !place_meeting(x+1, y, obj_solid) || place_meeting(x, y+1, obj_solid))){
        wall_slide = false;
        hspd = -sign(image_xscale); 
    }
    //If we are not touching a wall then set wall sliding to false. 
    else {
        wall_slide = false; 
    }
    
    // If sliding you can push off the wall.
    if (wall_slide == true) {
        if (wall_push && push_frames <= 0) {
            push_frames = 5;
        }
        if (push_frames > 0) {
            if (push_frames == 5) {
                hspd =  -5 * sign(image_xscale);
            } else {
                hspd =  5 * sign(image_xscale);
            }
            push_frames -= 1;
            if (push_frames == 0) {
                wall_slide = false; 
            }
        }
    }
        
    //Constantly apply gravity. 
    if(vspd <= 15){
    
        //Apply gravity at the normal rate if the player is not wall sliding. 
        if(wall_slide == false) {
            vspd += (grav * (jumppeak*3 + 1)) *  global.delta;
            start_slide = true; 
        } else {
            if (start_slide) {
                vspd = 0;
                start_slide = false;
            } else {
                // Eliminates sliding until you hit the peak, else apply at the normal rate. 
                if (jumppeak == 1) {
                    vspd += grav/2 * global.delta; //wall sliding applies a smaller acceleration
                } else {
                    vspd += (grav * (jumppeak*3 + 1)) *  global.delta;
                }
            }
        }
    }
    
    //Wall jumping
    if(wall_slide && up){
        vspd = up * -jumpheight*1.2; 
        hspd =  -1 * sign(image_xscale);
        wall_slide = false; 
        wall_jump = true; 
    }

    //Jump only if on a solid object. If our sprite is not standing, then check to make sure that we have atleast 8 pixels of headroom before we allow a jump. 
    if(place_meeting(x, y+1, obj_solid) 
    && !(place_meeting(x, y-8, obj_solid) && (sprite_index == spr_player_roll || sprite_index == spr_player_slide || sprite_index == spr_player_crouch || sprite_index == spr_player_slide_to_crouch))) {
        vspd = up * -jumpheight; 
        dash_count = 0;
        dash_frames_v = 0;
        dash_frames_h = 0;
        can_dash = false;
        dashed = false;
        dashing = false;
        wall_slide = false;
        start_slide = false;
        wall_jump = false; 
        jumppeak = 0;
        dash_held_frames = 0;
        dash_distance_mod = 0;
        dash_charge_mode = false;
    } else {
        can_dash = true;
    }
    
    //Vertical speed maximums/minimums. 
    if(vspd > 15) { vspd = 15;}
    else if(vspd < -15) { vspd = -15; } 
    
// After Dash Float
    if (float_frames > 0) {
        // Reset speeds
        vspd = 0;
        hspd = 0;
        // Check the direction we are floating in
        if (v_float) {
            // Bounce off wall
            if (place_meeting(x, y-1, obj_solid)) {
                switch_up = true;
                float_frames /= 2;
            }
            // Move slightly in the direction of the float
            if (switch_up) {
                vspd += float_frames * .05;
            } else {
                vspd -= float_frames * .05;
            }
        } else if (h_float_left) {
            // Bounce off wall
            if (place_meeting(x-1, y, obj_solid)) {
                switch_left = true;
                float_frames /= 2;
            }
            // Move slightly in the direction of the float
            if (switch_left) {
                hspd += float_frames * .05;
            } else {
                hspd -= float_frames * .05;
            }
        } else if (h_float_right) {
            // Bounce off wall
            if (place_meeting(x+1, y, obj_solid)) {
                switch_right = true;
                float_frames /= 2;
            }
            // Move slightly in the direction of the float
            if (switch_right) {
                hspd -= float_frames * .05;
            } else {
                hspd += float_frames * .05;
            }
        }
        float_frames -= 1;
        // Exit float
        if (diag_dr_held || diag_dl_held) {
            float_frames = 0;
        }
        // After the float set fall frames
        if (float_frames == 0) {
            dashing = false;
            fall_frames = 20;
        }
        start_slide = true;
    } else {
        // Reset switch variables
        switch_left = false;
        switch_right = false;
        switch_up = false;
    }
    
// Dash Mode
    if (charge_dash) {
        // Switch modes
        dash_charge_mode = true;
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
            wall_jump = false;
            wall_slide = false; 
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
                wall_jump = false;
                wall_slide = false; 
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
                wall_jump = false;
                wall_slide = false; 
            } else {
                // Not dashing at all
                if (dash_count < 3) {
                    // Can dash again
                    if ((((charge_dash_released && dash_charge_mode) || dash) && !(charge_dash_released && dash)) && (right_held || (diag_ur_held && abs(x_axis) >= abs(y_axis)) || (diag_dr_held && abs(x_axis) >= abs(y_axis)))) {
                        // Wants to dash right
                        if (dash_charge_mode) {
                            // Charge Dash
                            if (dash_distance_mod > 0) {
                                dash_frames_h += dash_distance_mod;
                                hspd = dash_speed;
                                vspd = 0;
                                dashed = true;
                                dashing = true;
                                wall_jump = false;
                                wall_slide = false; 
                            }
                        } else {
                            // Normal Dash
                            dash_frames_h += 5;
                            dash_count += 1;
                            hspd = dash_speed;
                            vspd = 0;
                            dashed = true;
                            dashing = true;
                            dash_charge_mode = false;
                            wall_jump = false;
                            wall_slide = false; 
                        }
                        // Colliding with wall at the start of the dash
                        if (place_meeting(x+1, y, obj_solid)) {
                            dash_frames_h = 0;
                            float_frames = 40;
                            h_float_right = true;
                            h_float_left = false;
                            v_float = false;
                        }
                    } else if ((((charge_dash_released && dash_charge_mode) || dash) && !(charge_dash_released && dash)) && (left_held || (diag_ul_held && abs(x_axis) >= abs(y_axis)) || (diag_dl_held && abs(x_axis) >= abs(y_axis)))) {
                        // Wants to dash left
                        if (dash_charge_mode) {
                            // Charge Dash
                            if (dash_distance_mod > 0) {
                                dash_frames_h -= dash_distance_mod;
                                hspd = -dash_speed;
                                vspd = 0;
                                dashed = true;
                                dashing = true;
                                wall_jump = false;
                                wall_slide = false; 
                            }
                        } else {
                            // Normal Dash
                            dash_frames_h -= 5;
                            dash_count += 1;
                            hspd = -dash_speed;
                            vspd = 0;
                            dashed = true;
                            dashing = true;
                            dash_charge_mode = false;
                            wall_jump = false;
                            wall_slide = false; 
                        }
                        // Colliding with wall at the start of the dash
                        if (place_meeting(x-1, y, obj_solid)) {
                            dash_frames_h = 0;
                            float_frames = 40;
                            h_float_left = true;
                            v_float = false;
                            h_float_right = false;
                        }
                    } else if ((((charge_dash_released && dash_charge_mode) || dash) && !(charge_dash_released && dash)) && ((up_held && !gamepad_is_connected(0)) || (stick_up_held && gamepad_is_connected(0)) || (diag_ul_held && abs(y_axis) > abs(x_axis)) || (diag_ur_held && abs(y_axis) > abs(x_axis)))) {
                        // Wants to dash up
                        if (dash_charge_mode) {
                            // Charge Dash
                            if (dash_distance_mod > 0) {
                                dash_frames_v += dash_distance_mod;
                                vspd = -dash_speed * .6;
                                hspd = 0;
                                dashed = true;
                                dashing = true;
                                wall_jump = false;
                                wall_slide = false; 
                            }
                        } else {
                            // Normal Dash
                            dash_frames_v += 5;
                            dash_count += 1;
                            vspd = -dash_speed * .6;
                            hspd = 0;
                            dashed = true;
                            dashing = true;
                            dash_charge_mode = false;
                            wall_jump = false;
                            wall_slide = false; 
                        }
                        // Colliding with wall at the start of the dash
                        if (place_meeting(x, y-1, obj_solid)) {
                            dash_frames_v = 0;
                            float_frames = 40;
                            v_float = true;
                            h_float_left = false;
                            h_float_right = false;
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
        // Charge mode
        if (can_dash) {
            // In mid-air
            if (dash_count < 3) {
                if (charge_dash_held) {
                    // Charge the dash
                    if (dash_held_frames < 71) {
                        dash_held_frames += 1;
                        dash_distance_mod = dash_held_frames div 12;
                        vspd /= 6;
                        hspd /= 1.75;
                    }
                } else if (charge_dash_released) {
                    // Reset the charge for the next dash
                    dash_held_frames = 0;
                    dash_distance_mod = 0;
                    dash_count += 1;
                    dash_charge_mode = false;
                }
            }
        }
    } else {
        // Reset charge values
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




