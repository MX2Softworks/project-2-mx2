/// @description  Calculate the delta value

global.delta = (0.00006*delta_time);

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

