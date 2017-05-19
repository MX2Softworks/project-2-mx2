scr_get_input(); 

//Reassign variables if display size changes. 
if(wind_w != window_get_width()/2){
    wind_w = window_get_width()/2;
}
if(wind_h != window_get_height()/3){
    wind_h = window_get_height()/3;
}


//Keyboard Selection Highlight
    if((!gamepad_is_connected(gp_id) && up) || (gamepad_is_connected(gp_id) && stick_up)){
            cursor = floor(cursor) - 1; 
    }
    else if(down){
            cursor = floor(cursor) + 1; 
    }

//Pause Menu
    if(menu == menu_options.pause_menu){
        string_w = string_width(string_hash_to_newline("Game Paused"))/2; 
        string_h = string_height(string_hash_to_newline("Game Paused"))/2;
        
        //Mouse Cursor selection Highlight
        if(window_mouse_get_x() > wind_w - string_w && window_mouse_get_x() < wind_w + string_w){
            //Continue
            if(window_mouse_get_y() > wind_h - string_h + string_h * 2 + 10 && window_mouse_get_y() < wind_h - string_h + string_h * 4 + 20){
                cursor = pause_options.continue_game;  
            }
            //Options
            else if(window_mouse_get_y() > wind_h - string_h + string_h * 4 + 20 && window_mouse_get_y() < wind_h - string_h + string_h * 6 + 30){
                cursor = pause_options.options_game;
            }
            //Quit
            else if(window_mouse_get_y() > wind_h - string_h + string_h * 6 + 40 && window_mouse_get_y() < wind_h - string_h + string_h * 8 + 50){
                cursor = pause_options.quit_game; 
            }
        }     
        
        //Universal keyboard Selection, Gamepad Selection, and Mouse Selection
        //Continue
        if((keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right) || (floor(cursor) == pause_options.continue_game && keyboard_check_pressed(vk_enter)))
          ||(gamepad_is_connected(gp_id) && (gamepad_button_check_pressed(gp_id, gp_face2) || (floor(cursor) == pause_options.continue_game && up)))
          ||(floor(cursor) == pause_options.continue_game && mouse_check_button_pressed(mb_left))){
            // Wait 1/12 of a second before resuming input.
            global.resume_frames = 5;
            global.pauseActive = false; 
        }
        //Options
        else if((floor(cursor) == pause_options.options_game && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == pause_options.options_game && up))
               || (floor(cursor) == pause_options.options_game && mouse_check_button_pressed(mb_left))){
              menu = menu_options.options_menu; 
              cursor = options_options.fullscreen;  
        }
        //Quit
        else if((floor(cursor) == pause_options.quit_game && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == pause_options.quit_game && up))
               || (floor(cursor) == pause_options.quit_game && mouse_check_button_pressed(mb_left))){
                menu = menu_options.quit_menu; 
                cursor = quit_options.no; 
        }
        
        //Cursor wrapping 
        if(cursor < pause_options.continue_game){
            cursor = pause_options.quit_game; 
        }
        else if(cursor > pause_options.quit_game){
            cursor = pause_options.continue_game; 
        }
    }
//Options Menu
    else if(menu == menu_options.options_menu){
        string_w = string_width(string_hash_to_newline("Options"))/2;
        string_h = string_height(string_hash_to_newline("Options"))/2;
        
        //Mouse Cursor selection Highlight
        if(window_mouse_get_x() > wind_w - string_w && window_mouse_get_x() < wind_w + string_w  + string_width(string_hash_to_newline("Show Debug: ")) + 10){
            //Fullscreen
            if(window_mouse_get_y() > wind_h - string_h + string_h * 2 + 10 && window_mouse_get_y() < wind_h - string_h + string_h * 4 + 20){
                cursor = options_options.fullscreen;  
            } 
            //Vsync
            else if(window_mouse_get_y() > wind_h - string_h + string_h * 4 + 20 && window_mouse_get_y() < wind_h - string_h + string_h * 6 + 30){
                cursor = options_options.vsync;  
            }
            //Debug
            else if(window_mouse_get_y() > wind_h - string_h + string_h * 6 + 30 && window_mouse_get_y() < wind_h - string_h + string_h * 8 + 40){
                cursor = options_options.debug;  
            }
        }
        
        //Fullscreen
        if((floor(cursor) == options_options.fullscreen && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == options_options.fullscreen && up))
               || (floor(cursor) == options_options.fullscreen && mouse_check_button_pressed(mb_left))){
            if(instance_exists(obj_game_mode)){
                global.fullscreen = !global.fullscreen;     
            } 
        }
        //Vsync
        else if((floor(cursor) == options_options.vsync && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == options_options.vsync && up))
               || (floor(cursor) == options_options.vsync && mouse_check_button_pressed(mb_left))){
            if(instance_exists(obj_game_mode)){
                global.vsync = !global.vsync;     
            } 
        }
        //Debug
        else if((floor(cursor) == options_options.debug && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == options_options.debug && up))
               || (floor(cursor) == options_options.debug && mouse_check_button_pressed(mb_left))){
            if(instance_exists(obj_game_mode)){
                global.debug = !global.debug;     
            } 
        }
        //Back
        else if((keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right))
          ||(gamepad_is_connected(gp_id) && (gamepad_button_check_pressed(gp_id, gp_face2)))){ 
            menu = menu_options.pause_menu; 
            cursor = pause_options.continue_game; 
        }
        
        //Cursor wrapping 
        if(cursor < options_options.fullscreen){
            cursor = options_options.debug; 
        }
        else if(cursor > options_options.debug){
            cursor = options_options.fullscreen; 
        }
    }
//Quit Menu
    else if(menu == menu_options.quit_menu){
        string_w = string_width(string_hash_to_newline("Are you sure you want to quit?"))/2;
        string_h = string_height(string_hash_to_newline("Are you sure you want to quit?"))/2;
        
        //Mouse Cursor selection Highlight
        if(window_mouse_get_x() > wind_w - string_w && window_mouse_get_x() < wind_w + string_w){
            //Yes
            if(window_mouse_get_y() > wind_h - string_h + string_h * 2 + 10 && window_mouse_get_y() < wind_h - string_h + string_h * 4 + 20){
                cursor = quit_options.yes;  
            }
            //No 
            else if(window_mouse_get_y() > wind_h - string_h + string_h * 4 + 20 && window_mouse_get_y() < wind_h - string_h + string_h * 6 + 30){
                cursor = quit_options.no;  
            }
        }
        
        //Yes
        if((floor(cursor) == quit_options.yes && keyboard_check_pressed(vk_enter))
               || (gamepad_is_connected(gp_id) && (floor(cursor) == quit_options.yes && up))
               || (floor(cursor) == quit_options.yes && mouse_check_button_pressed(mb_left))){
              game_end(); 
        }
        //No
        else if((keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right) || (floor(cursor) == quit_options.no && keyboard_check_pressed(vk_enter)))
          ||(gamepad_is_connected(gp_id) && (gamepad_button_check_pressed(gp_id, gp_face2) || (floor(cursor) == quit_options.no && up)))
          ||(floor(cursor) == quit_options.no && mouse_check_button_pressed(mb_left))){ 
            menu = menu_options.pause_menu; 
            cursor = pause_options.continue_game; 
        }
        
         //Cursor wrapping 
        if(cursor < quit_options.yes){
            cursor = quit_options.no; 
        }
        else if(cursor > quit_options.no){
            cursor = quit_options.yes; 
        }
    }

    
    
    


