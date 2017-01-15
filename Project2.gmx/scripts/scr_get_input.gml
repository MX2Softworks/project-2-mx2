/// scr_get_input()

right = keyboard_check(vk_right) || keyboard_check(ord("D"));
left = keyboard_check(vk_left)   || keyboard_check(ord("A"));
right_pressed = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
left_pressed = keyboard_check_pressed(vk_left)   || keyboard_check_pressed(ord("A"));

sprint = keyboard_check(vk_shift); 

up = keyboard_check_pressed(vk_up)     || keyboard_check_pressed(ord("W")); 
down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
up_held = keyboard_check(vk_up)        || keyboard_check(ord("W")); 
down_held = keyboard_check(vk_down)    || keyboard_check(ord("S"));

dash = keyboard_check_pressed(ord("F"));

// Override the controls for a gamepad
gp_id = 0;
threshold = .5;

if (gamepad_is_connected(gp_id)) {

    // Alarm is called so reset pressed and released
    if (controller_alarm <= 0) {
        stick_left_pressed = false;
        stick_right_pressed = false;
        stick_up_pressed = false;
        stick_down_pressed = false;
        
        stick_left_released = false;
        stick_right_released = false;
        stick_up_released = false;
        stick_down_released = false;
        
        // Reset alarm
        controller_alarm = 1;
    }
    
    // Set inputs
    sprint = gamepad_button_check(gp_id, gp_shoulderrb);
    dash = gamepad_button_check(gp_id, gp_shoulderlb);

    // Left
    if (!stick_left_held && gamepad_axis_value(gp_id, gp_axislh) <= -threshold) {
        // Left pressed
        stick_left_held = true;
        stick_left_pressed = true;
        stick_left_released = false;
        controller_alarm -= 1;
    } else if (stick_left_held && gamepad_axis_value(gp_id, gp_axislh) > -threshold) {
        // Left released
        stick_left_held = false;
        stick_left_pressed = false;
        stick_left_released = true;
        controller_alarm -= 1;
    }
    
    // Right
    if (!stick_right_held && gamepad_axis_value(gp_id, gp_axislh) >= threshold) {
        // Right pressed
        stick_right_held = true;
        stick_right_pressed = true;
        stick_right_released = false;
        controller_alarm -= 1;
    } else if (stick_right_held && gamepad_axis_value(gp_id, gp_axislh) < threshold) {
        // Right released
        stick_right_held = false;
        stick_right_pressed = false;
        stick_right_released = true;
        controller_alarm -= 1;
    }
    
    // Up
    if (!stick_up_held && gamepad_axis_value(gp_id, gp_axislv) >= threshold) {
        // Up pressed
        stick_up_held = true;
        stick_up_pressed = true;
        stick_up_released = false;
        controller_alarm -= 1;
    } else if (stick_up_held && gamepad_axis_value(gp_id, gp_axislv) < threshold) {
        // Up released
        stick_up_held = false;
        stick_up_pressed = false;
        stick_up_released = true;
        controller_alarm -= 1;
    }
    
    // Down
    if (!stick_down_held && gamepad_axis_value(gp_id, gp_axislv) <= -threshold) {
        // Down pressed
        stick_down_held = true;
        stick_down_pressed = true;
        stick_down_released = false;
        controller_alarm -= 1;
    } else if (stick_down_held && gamepad_axis_value(gp_id, gp_axislv) > -threshold) {
        // Down released
        stick_down_held = false;
        stick_down_pressed = false;
        stick_down_released = true;
        controller_alarm -= 1;
    }
}
