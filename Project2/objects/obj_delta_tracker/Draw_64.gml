// Draw the delta value to the screen.

draw_set_color(c_red);

draw_text(10, 144, string_hash_to_newline("delta_time: "+string_format(delta_time, 2, 2)));
draw_text(10, 168, string_hash_to_newline("room_speed: "+string_format(room_speed, 3, 0))); 