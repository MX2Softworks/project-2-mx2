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
