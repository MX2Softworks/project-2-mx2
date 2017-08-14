/// Draw debug text to screen.

draw_set_halign(fa_left); 
draw_set_valign(fa_left);
draw_set_color(c_red);
 
// Calculations to display a more stable fps
    frames1 += 1;
    fps_total1 += round(fps_real);
    fps_avg1 = fps_total1 div frames1;
    // Reset if a second passed
    if (frames1 == 30) {
        frames1 = 0;
        fps_total1 = 0;
        frames2 += 1;
        fps_total2 += fps_avg1;
        fps_avg2 = fps_total2 div frames2;
        // Reset if a minute has passed to avoid out of bounds
        if (frames2 == 60) {
            frames2 = 0;
            fps_total2 = 0;
        }
    }

if (keyboard_check(ord("O"))) {
// Text drawn to screen. 
	draw_text(10, 12, string_hash_to_newline("fps: "+string_format(fps_avg2, 2, 2)));
    
	draw_text(10, 36, string_hash_to_newline("direction: "+string_format(obj_player.direction_horizontal, 1, 0)+","+string_format(obj_player.direction_vertical, 1, 0)));
    
	draw_text(10, 48, "XACC: " + string_format(obj_player.current_xacc, 5, 2));
	draw_text(10, 60, "XSPD: " + string_format(obj_player.current_hspd, 5, 2));
	draw_text(10, 72, "YACC: " + string_format(obj_player.current_yacc, 5, 2));
	draw_text(10, 84, "YSPD: " + string_format(obj_player.current_vspd, 5, 2));
	
	draw_text(window_get_width()-150, 200, "L: Debug Line");
	
	draw_text(10, 96, string_hash_to_newline("xcoor: "+string_format(obj_player.x, 2, 2)));
	draw_text(10, 108, string_hash_to_newline("ycoor: "+string_format(obj_player.y, 2, 2)));
       
	draw_text(10, 156, string_hash_to_newline("dash_count: "+string_format(obj_player.dash_count, 2, 2)));
	draw_text(10, 212, string_hash_to_newline("gamepad: "+string_format(gamepad_button_check(0, gp_shoulderrb), 2, 2)));
	draw_text(10, 224, string_hash_to_newline("magnitude: "+string_format(obj_player.magnitude, 2, 2)));
	draw_text(10, 236, string_hash_to_newline("threshold: "+string_format(obj_player.threshold, 2, 2)));
	draw_text(10, 248, string_hash_to_newline("left: "+string_format(obj_player.left, 2, 2)));
	draw_text(10, 260, string_hash_to_newline("left_held: "+string_format(obj_player.left_held, 2, 2)));
	draw_text(10, 272, string_hash_to_newline("left_released: "+string_format(obj_player.left_released, 2, 2)));
	draw_text(10, 284, string_hash_to_newline("x_axis: "+string_format(gamepad_axis_value(0, gp_axislh), 2, 2)));
    
	draw_text(10, 296, string_hash_to_newline("ul: "+string_format(obj_player.diag_ul_held, 2, 2)));
	draw_text(10, 308, string_hash_to_newline("ur: "+string_format(obj_player.diag_ur_held, 2, 2)));
	draw_text(10, 320, string_hash_to_newline("dl: "+string_format(obj_player.diag_dl_held, 2, 2)));
	draw_text(10, 332, string_hash_to_newline("dr: "+string_format(obj_player.diag_dr_held, 2, 2)));
	draw_text(10, 344, string_hash_to_newline("right: "+string_format(obj_player.right_held, 2, 2)));
	draw_text(10, 356, string_hash_to_newline("up: "+string_format(obj_player.stick_up, 2, 2)));
	draw_text(10, 368, string_hash_to_newline("down: "+string_format(obj_player.down, 2, 2)));
	draw_text(10, 380, string_hash_to_newline("y_axis: "+string_format(gamepad_axis_value(0, gp_axislv), 2, 2)));
    
	draw_text(10, 416, string_hash_to_newline("sprite_index: "+string_format(obj_player.sprite_index, 1, 0)));
	
	draw_text(10, 428, string_hash_to_newline("on_ground: "+string_format(obj_player.on_ground, 2, 2)));
	
	draw_text(10, 440, string_hash_to_newline("charge_time: "+string_format(obj_player.charge_time, 2, 2)));
	draw_text(10, 452, string_hash_to_newline("frame_time: "+string_format(delta_time/1000000, 6, 6)));
	draw_text(10, 464, string_hash_to_newline("down_held: "+string_format(obj_player.down_held, 6, 6)));
	draw_text(10, 476, string_hash_to_newline("image_index: "+string_format(obj_player.image_index, 6, 6)));
	
	draw_text(10, 488, string_hash_to_newline("accessible_nodes: "+string_format(ds_list_size(obj_generic_chaser.accessible_nodes), 6, 6)));
	
	//for (var i = 0; i < ds_list_size(obj_generic_chaser.accessible_nodes); i++) {
	//	var temp_list = obj_generic_chaser.accessible_nodes[| i];
	//	for (var j = 0; j < ds_list_size(temp_list); j++) {
	//		draw_text(200 + (i*150), 100 + (j*30), string_format(temp_list[| j], 4, 2));
	//	}
	//}


// Dash Charge
    draw_set_halign(fa_left);    
    if (obj_player.charge_time >= 500000) {
        draw_rectangle_colour(window_get_width()-120, 20, window_get_width()-100, 60, c_maroon, c_maroon, c_maroon, c_maroon, false);
    }
    if (obj_player.charge_time >= 1000000) {
        draw_rectangle_colour(window_get_width()-100, 20, window_get_width()-80, 60, c_red, c_red, c_red, c_red, false);
    }
    if (obj_player.charge_time >= 1500000) {
        draw_rectangle_colour(window_get_width()-80, 20, window_get_width()-60, 60, c_yellow, c_yellow, c_yellow, c_yellow, false);
    }
    if (obj_player.charge_time >= 2000000) {
        draw_rectangle_colour(window_get_width()-60, 20, window_get_width()-40, 60, c_lime, c_lime, c_lime, c_lime, false);
    }
    if (obj_player.charge_time >= 2500000) {
        draw_rectangle_colour(window_get_width()-40, 20, window_get_width()-20, 60, c_green, c_green, c_green, c_green, false);
    }
    if (obj_player.charge_time >= 2000000) {
        draw_set_colour(c_red);
        draw_rectangle(window_get_width()-150, 25, window_get_width()-145, 45, false);
        draw_rectangle(window_get_width()-150, 50, window_get_width()-145, 55, false);
        draw_set_colour(c_gray);
        draw_rectangle(window_get_width()-150, 25, window_get_width()-145, 45, true);
        draw_rectangle(window_get_width()-150, 50, window_get_width()-145, 55, true);
    }
    draw_set_colour(c_gray);
    draw_rectangle(window_get_width()-120, 20, window_get_width()-19, 60, true);
    draw_rectangle(window_get_width()-119, 21, window_get_width()-20, 59, true);
    draw_rectangle(window_get_width()-100, 20, window_get_width()-99, 60, false);
    draw_rectangle(window_get_width()-80, 20,  window_get_width()-79, 60, false);
    draw_rectangle(window_get_width()-60, 20,  window_get_width()-59, 60, false);
    draw_rectangle(window_get_width()-40, 20,  window_get_width()-39, 60, false);
}