draw_set_halign(fa_left); 
draw_set_valign(fa_left);

view_w = __view_get( e__VW.WView, 0 )/2;
view_h = __view_get( e__VW.HView, 0 )/3; 

if(menu == menu_options.pause_menu){
    string_w = string_width(string_hash_to_newline("Game Paused"))/2; 
    string_h = string_height(string_hash_to_newline("Game Paused"))/2;
    
    //Draw title
    draw_text_colour(wind_w - string_w, wind_h - string_h, string_hash_to_newline("Game Paused"), c_white, c_white, c_ltgray, c_ltgray, 1);
    
    //Draw all options and the option the player is over as highlighted. 
    if(floor(cursor) == pause_options.continue_game){
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Continue"), c_yellow, c_white, c_yellow, c_white, 1);
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*2 + 10 +6, 6, c_yellow, c_white, false);
        
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Options"), c_white, c_white, c_ltgray, c_ltgray, 1);
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Quit"), c_white, c_white, c_ltgray, c_ltgray, 1); 
    }
    else if(floor(cursor) == pause_options.options_game){
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Continue"), c_white, c_white, c_ltgray, c_ltgray, 1);
        
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Options"), c_yellow, c_white, c_yellow, c_white, 1);
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*4 + 20 +6, 6, c_yellow, c_white, false);
        
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Quit"), c_white, c_white, c_ltgray, c_ltgray, 1); 
    }
    else if(floor(cursor) == pause_options.quit_game){
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Continue"), c_white, c_white, c_ltgray, c_ltgray, 1);
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Options"), c_white, c_white, c_ltgray, c_ltgray, 1);
        
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Quit"), c_yellow, c_white, c_yellow, c_white, 1);
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*6 + 30 +6, 6, c_yellow, c_white, false); 
    }
}
else if(menu == menu_options.options_menu){
    string_w = string_width(string_hash_to_newline("Options"))/2;
    string_h = string_height(string_hash_to_newline("Options"))/2;
    
    //Draw title
    draw_text_colour(wind_w - string_w, wind_h - string_h, string_hash_to_newline("Options"), c_white, c_white, c_ltgray, c_ltgray, 1);
    
    //Draw all options and the option the player is over as highlighted. 
    if(floor(cursor) == options_options.fullscreen){
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Fullscreen: "), c_yellow, c_white, c_yellow, c_white, 1);
        //Fullscreen
        if(instance_exists(obj_game_mode) && global.fullscreen == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Yes"), c_yellow, c_white, c_yellow, c_white, 1);
        }
        else if(instance_exists(obj_game_mode) && global.fullscreen == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("No"), c_yellow, c_white, c_yellow, c_white, 1);
        }
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*2 + 10 +6, 6, c_yellow, c_white, false);
        //Vsync
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Vsync: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        if(instance_exists(obj_game_mode) && global.vsync == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.vsync == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        //Debug
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Show Debug: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        if(instance_exists(obj_game_mode) && global.debug == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.debug == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        
    }
    else if(floor(cursor) == options_options.vsync){
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Fullscreen: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        //Fullscreen
        if(instance_exists(obj_game_mode) && global.fullscreen == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.fullscreen == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        //Vsync
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Vsync: "), c_yellow, c_white, c_yellow, c_white, 1);
        if(instance_exists(obj_game_mode) && global.vsync == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Yes"), c_yellow, c_white, c_yellow, c_white, 1);
        }
        else if(instance_exists(obj_game_mode) && global.vsync == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("No"), c_yellow, c_white, c_yellow, c_white, 1);
        }
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*4 + 20 +6, 6, c_yellow, c_white, false);
        //Debug
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Show Debug: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        if(instance_exists(obj_game_mode) && global.debug == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.debug == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }  
    }
    else if(floor(cursor) == options_options.debug){
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Fullscreen: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        //Fullscreen
        if(instance_exists(obj_game_mode) && global.fullscreen == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.fullscreen == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        //Vsync
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Vsync: "), c_white, c_white, c_ltgray, c_ltgray, 1);
        if(instance_exists(obj_game_mode) && global.vsync == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        else if(instance_exists(obj_game_mode) && global.vsync == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
        }
        //Debug
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Show Debug: "), c_yellow, c_white, c_yellow, c_white, 1);
        if(instance_exists(obj_game_mode) && global.debug == true){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("Yes"),  c_yellow, c_white, c_yellow, c_white, 1);
        }
        else if(instance_exists(obj_game_mode) && global.debug == false){
            draw_text_colour(wind_w - string_w + 20 + string_width(string_hash_to_newline("Show Debug: ")) + 10, wind_h - string_h + string_h*6 + 30, string_hash_to_newline("No"),  c_yellow, c_white, c_yellow, c_white, 1);
        }
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*6 + 30 +6, 6, c_yellow, c_white, false);
    } 
    
}
else if(menu == menu_options.quit_menu){
    string_w = string_width(string_hash_to_newline("Are you sure you want to quit?"))/2;
    string_h = string_height(string_hash_to_newline("Are you sure you want to quit?"))/2;

    //Draw title
    draw_text_colour(wind_w - string_w, wind_h - string_h, string_hash_to_newline("Are you sure you want to quit?"), c_white, c_white, c_ltgray, c_ltgray, 1);
    
    //Draw all options and the option the player is over as highlighted. 
    if(floor(cursor) == quit_options.yes){
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Yes"), c_yellow, c_white, c_yellow, c_white, 1);
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*2 + 10 +6, 6, c_yellow, c_white, false);
        
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("No"), c_white, c_white, c_ltgray, c_ltgray, 1);
    }
    else if(floor(cursor) == quit_options.no){
        draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*2 + 10, string_hash_to_newline("Yes"), c_white, c_white, c_ltgray, c_ltgray, 1);
        
    /**/draw_text_colour(wind_w - string_w + 20, wind_h - string_h + string_h*4 + 20, string_hash_to_newline("No"), c_yellow, c_white, c_yellow, c_white, 1);
        draw_circle_colour(wind_w - string_w + 6, wind_h - string_h + string_h*4 + 20 +6, 6, c_yellow, c_white, false);
    } 
}



/* */
/*  */
