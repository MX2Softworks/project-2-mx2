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

