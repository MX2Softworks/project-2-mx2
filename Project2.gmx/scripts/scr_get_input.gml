/// scr_get_input()

right = keyboard_check(vk_right) || keyboard_check(ord("D"));
left = keyboard_check(vk_left)   || keyboard_check(ord("A"));
sprint = keyboard_check(vk_shift); 
up = keyboard_check_pressed(vk_up)     || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space); 
down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
up_held = keyboard_check(vk_up)        || keyboard_check(ord("W"))         || keyboard_check(vk_space); 
down_held = keyboard_check(vk_down)    || keyboard_check(ord("D"));
