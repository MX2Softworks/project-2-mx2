/// scr_get_input()

// Override the controls for a gamepad
gp_id = 0;
threshold = .8;

if (global.resume_frames <= 0) {
    if (!gamepad_is_connected(gp_id)) {
    
        right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
        right_held = keyboard_check(vk_right) || keyboard_check(ord("D"));
        right_released = keyboard_check_released(vk_right) || keyboard_check_released(ord("D"));
        
        left = keyboard_check_pressed(vk_left)   || keyboard_check_pressed(ord("A"));
        left_held = keyboard_check(vk_left)   || keyboard_check(ord("A")); 
        left_released = keyboard_check_released(vk_left)   || keyboard_check_released(ord("A"));
        
        up = keyboard_check_pressed(vk_up)     || keyboard_check_pressed(ord("W")); 
        up_held = keyboard_check(vk_up)        || keyboard_check(ord("W")); 
        up_released = keyboard_check_released(vk_up)     || keyboard_check_released(ord("W")); 
        
        down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
        down_held = keyboard_check(vk_down)    || keyboard_check(ord("S"));
        down_released = keyboard_check_released(vk_down) || keyboard_check_released(ord("S"));
        
        direction_vertical = max(down, down_held) - max(up, up_held); 
        direction_horizontal = max(right, right_held) - max(left, left_held); 
        
        sprint = keyboard_check(vk_shift);
        dash = keyboard_check_pressed(ord("F"));
        dash_held = keyboard_check(ord("F"));
        dash_released = keyboard_check_released(ord("F"));
        charge_dash = keyboard_check_pressed(ord("G"));
        charge_dash_held = keyboard_check(ord("G"));
        charge_dash_released = keyboard_check_released(ord("G"));
        
        wall_push = keyboard_check_pressed(ord("H"));
        
        open_door = keyboard_check_pressed(ord("C"));
        
        pickup_item = keyboard_check_pressed(ord("C"));
    }
    
    if (gamepad_is_connected(gp_id)) {
    
        // Used for diagonals
        magnitude = point_distance(0, 0, gamepad_axis_value(gp_id, gp_axislh), gamepad_axis_value(gp_id, gp_axislv));
        x_axis = gamepad_axis_value(gp_id, gp_axislh);
        y_axis = gamepad_axis_value(gp_id, gp_axislv);
    
        // Alarm is called so reset pressed and released
        if (controller_alarm <= 0) {
            
            left = false;
            right = false;
            up = false;
            down = false;
            stick_up = false;
            
            stick_up = false;
            stick_up_released = false; 
            
            left_released = false;
            right_released = false;
            up_released = false;
            down_released = false;
            stick_up_released = false;
            
            diag_ul = false;
            diag_ur = false;
            diag_dl = false;
            diag_dr = false;
            
            diag_ul_released = false;
            diag_ur_released = false;
            diag_dl_released = false;
            diag_dr_released = false;
    
            // Reset alarm
            controller_alarm = 1;
        }
        
        // Set inputs
        sprint = gamepad_button_check(gp_id, gp_shoulderrb);
        dash = gamepad_button_check_pressed(gp_id, gp_shoulderl);
        dash_held = gamepad_button_check(gp_id, gp_shoulderl);
        dash_released = gamepad_button_check_released(gp_id, gp_shoulderl);
        charge_dash = gamepad_button_check_pressed(gp_id, gp_shoulderlb);
        charge_dash_held = gamepad_button_check(gp_id, gp_shoulderlb);
        charge_dash_released = gamepad_button_check_released(gp_id, gp_shoulderlb);
        
        wall_push = gamepad_button_check_pressed(gp_id, gp_face3);
        
        open_door = gamepad_button_check_pressed(gp_id, gp_face4);
        
        pickup_item = gamepad_button_check_pressed(gp_id, gp_face4);
        
        up = gamepad_button_check_pressed(gp_id, gp_face1);
        up_held = gamepad_button_check(gp_id, gp_face1);
        up_released = gamepad_button_check_released(gp_id, gp_face1);
    
        // Left
        if (!left_held && x_axis <= -threshold && magnitude < threshold_diag) {
            // Left pressed
            left_held = true;
            left = true;
            left_released = false;
            controller_alarm -= 1;
        } else if ((left_held && x_axis > -threshold) || diag_ul_held == true || diag_dl_held == true) {
            // Left released
            left_held = false;
            left = false;
            left_released = true;
            controller_alarm -= 1;
        }
        
        // Right
        if (!right_held && x_axis >= threshold && magnitude < threshold_diag) {
            // Right pressed
            right_held = true;
            right = true;
            right_released = false;
            controller_alarm -= 1;
        } else if ((right_held && x_axis < threshold) || diag_ur_held == true || diag_dr_held == true) {
            // Right released
            right_held = false;
            right = false;
            right_released = true;
            controller_alarm -= 1;
        }
        
        // Up
        if (!stick_up_held && y_axis <= -threshold && magnitude < threshold_diag) {
            // Up pressed
            stick_up_held = true;
            stick_up = true;
            stick_up_released = false;
            controller_alarm -= 1;
        } else if ((stick_up_held && y_axis > -threshold) || diag_ul_held == true || diag_ur_held == true) {
            // Up released
            stick_up_held = false;
            stick_up = false;
            stick_up_released = true;
            controller_alarm -= 1;
        }
        
        // Down
        if (!down_held && y_axis >= threshold && magnitude < threshold_diag) {
            // Down pressed
            down_held = true;
            down = true;
            down_released = false;
            controller_alarm -= 1;
        } else if ((down_held && y_axis < threshold) || diag_dl_held == true || diag_dr_held == true) {
            // Down released
            down_held = false;
            down = false;
            down_released = true;
            controller_alarm -= 1;
        }
        
        // Diagonal Up Left
        if (!diag_ul_held && x_axis < 0 && y_axis < 0 && magnitude >= threshold_diag) {
            // Up Left pressed
            diag_ul_held = true;
            diag_ul = true;
            diag_ul_released = false;
            controller_alarm -= 1;
        } else if (diag_ul_held && magnitude < threshold_diag) {
            // Up Left released
            diag_ul_held = false;
            diag_ul = false;
            diag_ul_released = true;
            controller_alarm -= 1;
        }
        
        // Diagonal Up Right
        if (!diag_ur_held && x_axis > 0 && y_axis < 0 && magnitude >= threshold_diag) {
            // Up Right pressed
            diag_ur_held = true;
            diag_ur = true;
            diag_ur_released = false;
            controller_alarm -= 1;
        } else if (diag_ur_held && magnitude < threshold_diag) {
            // Up Right released
            diag_ur_held = false;
            diag_ur = false;
            diag_ur_released = true;
            controller_alarm -= 1;
        }
        
        // Diagonal Down Left
        if (!diag_dl_held && x_axis < 0 && y_axis > 0 && magnitude >= threshold_diag) {
            // Down Left pressed
            diag_dl_held = true;
            diag_dl = true;
            diag_dl_released = false;
            controller_alarm -= 1;
        } else if (diag_dl_held && magnitude < threshold_diag) {
            // Down Left released
            diag_dl_held = false;
            diag_dl = false;
            diag_dl_released = true;
            controller_alarm -= 1;
        }
        
        // Diagonal Down Right
        if (!diag_dr_held && x_axis > 0 && y_axis > 0 && magnitude >= threshold_diag) {
            // Down Right pressed
            diag_dr_held = true;
            diag_dr = true;
            diag_dr_released = false;
            controller_alarm -= 1;
        } else if (diag_dr_held && magnitude < threshold_diag) {
            // Down Right released
            diag_dr_held = false;
            diag_dr = false;
            diag_dr_released = true;
            controller_alarm -= 1;
        }
        
        direction_vertical = max(down, down_held, diag_dr, diag_dr_held, diag_dl, diag_dl_held) - max(up, up_held, diag_ur, diag_ur_held, diag_ul, diag_ul_held); 
        direction_horizontal = max(right, right_held, diag_ur, diag_ur_held, diag_dr, diag_dr_held) - max(left, left_held, diag_ul, diag_ul_held, diag_dl, diag_dl_held); 
    }
}
