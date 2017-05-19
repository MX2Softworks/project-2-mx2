/// @description If Game is Paused

//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}


if(instance_exists(obj_player)){
    if(obj_player.vspd < 0 || place_meeting(x, y, obj_player)){
    
        platform = instance_create(x, y, obj_platform);
        platform.image_xscale = image_xscale;
        platform.image_yscale = image_yscale;  
        instance_destroy(); 
    }
}

