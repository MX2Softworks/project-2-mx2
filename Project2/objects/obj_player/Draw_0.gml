/// Drawing.

// Required when overwriting the draw event.
    draw_self();
    
// Collision Mask
    draw_rectangle_colour(obj_player.bbox_left, obj_player.bbox_top, obj_player.bbox_right, obj_player.bbox_bottom, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, true);

