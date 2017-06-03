// Draw the delta value to the screen

if(instance_exists(obj_game_mode)){
    //Debug
    if((keyboard_check_pressed(vk_f1) || global.debug == true) && on == false){
        on = true; 
        global.debug = true; 
    }
    else if((keyboard_check_pressed(vk_f1) || global.debug == false) && on == true){
        on = false; 
        global.debug = false;
    }
}


if(on){
    draw_set_colour(c_red);
    draw_text(10, 144, string_hash_to_newline("delta_time: "+string_format(delta_time, 2, 2)));
    draw_text(10, 168, string_hash_to_newline("room_speed: "+string_format(room_speed, 3, 0))); 
}

