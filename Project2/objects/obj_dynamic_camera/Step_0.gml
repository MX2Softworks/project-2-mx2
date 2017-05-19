/// @description Controls camera movement

if(instance_exists(obj_game_mode)){
    //Fullscreen
    if((keyboard_check_pressed(vk_f2) || global.fullscreen == true) && full_screen == false){
        full_screen = true;
        global.fullscreen = true; 
        window_set_fullscreen(true); 
    }
    else if((keyboard_check_pressed(vk_f2) || global.fullscreen == false) && full_screen == true){
        full_screen = false;
        global.fullscreen = false; 
        window_set_fullscreen(false); 
    }
    
    //Vsync
    if(global.vsync == true && v_sync == false){
        v_sync = true; 
        global.vsync = true; 
        display_reset(0, true); 
    }
    else if(global.vsync == false && v_sync == true){
        v_sync = false; 
        global.vsync = false;
        display_reset(0, false);  
    }
}


//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}

var x_to, y_to; 

if(instance_exists(obj_player)){
    if((obj_player.is_sliding == 1 || obj_player.wall_slide == 1)){ 
        shake = .4
    } 
    else if(obj_player.charge_dash_held && obj_player.can_dash && obj_player.dash_count < 3 && obj_player.dash_charge_mode){
        if(obj_player.charge_dash){
            shake = 0;
        }
        else{
            shake = obj_player.dash_held_frames/71
        }
    }
    else{
        shake *= .9;     
    }
    
    x_to = obj_player.x + obj_player.direction_horizontal*abs(obj_player.hspd);
    y_to = obj_player.y + obj_player.direction_vertical*abs(obj_player.vspd);
    
    x += (x_to-x)/5;
    y += (y_to-y)/2;
}

__view_set( e__VW.XView, 0, -(__view_get( e__VW.WView, 0 )/2) + x ); 
__view_set( e__VW.YView, 0, -(__view_get( e__VW.HView, 0 )/2) + y );   

__view_set( e__VW.XView, 0, clamp(__view_get( e__VW.XView, 0 ), 0, room_width-__view_get( e__VW.WView, 0 ) ));
__view_set( e__VW.YView, 0, clamp(__view_get( e__VW.YView, 0 ), 0, room_height-__view_get( e__VW.HView, 0 ) )); 

__view_set( e__VW.XView, 0, __view_get( e__VW.XView, 0 ) + (random_range(-shake*(__view_get( e__VW.WView, 0 )/500), shake*(__view_get( e__VW.WView, 0 )/500)) ));
__view_set( e__VW.YView, 0, __view_get( e__VW.YView, 0 ) + (random_range(-shake*(__view_get( e__VW.HView, 0 )/500), shake*(__view_get( e__VW.WView, 0 )/500)) )); 



