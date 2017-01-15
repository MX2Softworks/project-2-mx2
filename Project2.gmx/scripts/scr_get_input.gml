/// scr_get_input()

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

sprint = keyboard_check(vk_shift);
dash = keyboard_check_pressed(ord("F"));

// Override the controls for a gamepad
gp_id = 0;
threshold = .9;

if (gamepad_is_connected(gp_id)) {

    // Alarm is called so reset pressed and released
    if (controller_alarm <= 0) {
        left = false;
        right = false;
        up = false;
        down = false;
        
        left_released = false;
        right_released = false;
        up_released = false;
        down_released = false;
        
        // Reset alarm
        controller_alarm = 1;
    }
    
    // Set inputs
    sprint = gamepad_button_check(gp_id, gp_shoulderrb);
    dash = gamepad_button_check(gp_id, gp_shoulderlb);
    
    up = gamepad_button_check_pressed(gp_id, gp_face1);
    up_held = gamepad_button_check(gp_id, gp_face1);
    up_released = gamepad_button_check_released(gp_id, gp_face1);

    // Left
    if (!left_held && gamepad_axis_value(gp_id, gp_axislh) <= -threshold) {
        // Left pressed
        left_held = true;
        left = true;
        left_released = false;
        controller_alarm -= 1;
    } else if (left_held && gamepad_axis_value(gp_id, gp_axislh) > -threshold) {
        // Left released
        left_held = false;
        left = false;
        left_released = true;
        controller_alarm -= 1;
    }
    
    // Right
    if (!right_held && gamepad_axis_value(gp_id, gp_axislh) >= threshold) {
        // Right pressed
        right_held = true;
        right = true;
        right_released = false;
        controller_alarm -= 1;
    } else if (right_held && gamepad_axis_value(gp_id, gp_axislh) < threshold) {
        // Right released
        right_held = false;
        right = false;
        right_released = true;
        controller_alarm -= 1;
    }
    
    /*
    // Up
    if (!up_held && gamepad_axis_value(gp_id, gp_axislv) <= -threshold) {
        // Up pressed
        up_held = true;
        up = true;
        up_released = false;
        controller_alarm -= 1;
    } else if (up_held && gamepad_axis_value(gp_id, gp_axislv) > -threshold) {
        // Up released
        up_held = false;
        up = false;
        up_released = true;
        controller_alarm -= 1;
    }
    */
    
    // Down
    if (!down_held && gamepad_axis_value(gp_id, gp_axislv) >= threshold) {
        // Down pressed
        down_held = true;
        down = true;
        down_released = false;
        controller_alarm -= 1;
    } else if (down_held && gamepad_axis_value(gp_id, gp_axislv) < threshold) {
        // Down released
        down_held = false;
        down = false;
        down_released = true;
        controller_alarm -= 1;
    }
}
