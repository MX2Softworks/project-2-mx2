draw_set_color(c_red);

direction_vertical = max(up, up_held) - up_released;

draw_text(10, 200, string_hash_to_newline("node index: "+string(current_index)));
draw_text(10, 215, string_hash_to_newline("direction: "+string(direction_horizontal)+", "+string(direction_vertical)));