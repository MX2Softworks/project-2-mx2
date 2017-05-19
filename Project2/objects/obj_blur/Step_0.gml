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

if(window_width != window_get_width() || window_height != window_get_height()){
    window_width = window_get_width();
    window_height = window_get_height(); 
    
    screen_width = __view_get( e__VW.WView, view_current );  
    screen_height = __view_get( e__VW.HView, view_current ); 
    global.motion_blur = surface_create(screen_width,screen_height);
    temp = surface_create(screen_width,screen_height);
    
    surface_set_target(global.motion_blur);
    draw_clear_alpha(c_white,0) ;//Actually any color would do
    surface_reset_target();
    surface_set_target(temp);
    draw_clear_alpha(c_white,0);
    surface_reset_target();
    
    cam_last_X = __view_get( e__VW.XView, view_current );
    cam_last_Y = __view_get( e__VW.YView, view_current );
    
}


dif_X = cam_last_X-__view_get( e__VW.XView, 0 );
dif_Y = cam_last_Y-__view_get( e__VW.YView, 0 );

//Copyroutine
surface_set_target(temp); //This part moves the trail in camera
if(surface_exists(temp)){
    draw_surface_ext(global.motion_blur,dif_X,dif_Y,1,1,0,c_white,0.94); 
    surface_copy(global.motion_blur,0,0,temp);
}
surface_reset_target();
surface_set_target(temp); //We clear the temp-surface
draw_clear_alpha(c_white,0);
surface_reset_target();
//End of copyroutine

cam_last_X = __view_get( e__VW.XView, 0 );
cam_last_Y = __view_get( e__VW.YView, 0 );


