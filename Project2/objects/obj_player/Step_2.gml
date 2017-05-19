/// @description If Game is Paused

//Pause Animations if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    if(image_speed != 0){
        speed_before_pause = image_speed;
        image_speed = 0;
    }
    exit;  
}
else{
    if(image_speed == 0 && speed_before_pause != 0){
        image_speed = speed_before_pause; 
        speed_before_pause = 0; 
    }
}

/// Adds motion blur during dashes. 

//Creates a blur object if it does not exist. 
if(!instance_exists(obj_blur)){
    instance_create(0, 0, obj_blur);   
}
//Adds blur
if(instance_exists(obj_blur) && (abs(hspd) > 12 || abs(vspd) > 13)){
    d3d_set_fog(1,c_navy,0,0);
    surface_set_target(global.motion_blur);
    draw_sprite_ext(sprite_index,image_index,x-__view_get( e__VW.XView, 0 ),y-__view_get( e__VW.YView, 0 ),image_xscale,image_yscale,image_angle,image_blend,image_alpha);
    surface_reset_target();
    d3d_set_fog(0,c_navy,0,0);
    
}




