/// @description  Calculate the delta value

// Time passed since the last frame in seconds.
// delta_time / 1000000 = 1 / framerate
global.frame_time = delta_time / 1000000;

// Limit the lowest framerate to 4 fps.
if (global.frame_time > .25) {
	// 1 / 4 = .25 = 4 frames per second
	global.frame_time = .25;
}

///Manual Room Speed Control

if(keyboard_check_pressed(vk_numpad0)){
    room_speed = 5
}
else if(keyboard_check_pressed(vk_numpad1)){
    room_speed = 10
}
else if(keyboard_check_pressed(vk_numpad2)){
    room_speed = 30
}
else if(keyboard_check_pressed(vk_numpad3)){
    room_speed = 60
}
else if(keyboard_check_pressed(vk_numpad4)){
    room_speed = 120
}
else if(keyboard_check_pressed(vk_numpad5)){
    room_speed = 240
}

