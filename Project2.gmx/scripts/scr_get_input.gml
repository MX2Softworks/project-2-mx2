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
var gp_id = 0;
var thresh = .5;

if (gamepad_is_connected(gp_id)) {
    right = gamepad_axis_value(gp_id, gp_axislh) > thresh;
    left = gamepad_axis_value(gp_id, gp_axislh) < -thresh;
    right_pressed = gamepad_button_check_pressed(gp_id, 
    left_pressed = 
    
    sprint =  
    
    up =  
    down = 
    up_held =  
    down_held = 
    
    dash = 
    
    right_previous = gamepad_axis_value(gp_id, gp_axislh);
}
