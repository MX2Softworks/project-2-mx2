if(global.pauseActive){
    if(draw_blend_counter < draw_blend_max){
        draw_blend_counter += delta_time/1000000 * 2; 
    }
    draw_set_alpha(draw_blend_counter); 
    draw_rectangle_colour(0, 0, window_get_width(), window_get_height(), c_black, 0, 0, 0, 0);
    draw_set_alpha(1);  
}
else{
    draw_blend_counter = 0; 
}

