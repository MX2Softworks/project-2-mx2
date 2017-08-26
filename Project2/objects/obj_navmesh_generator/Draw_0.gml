/// 

// Draw the platforms.
for (var i = 0; i < ds_list_size(platform_nodes); i++) {
	var temp_node = platform_nodes[| i];
	draw_rectangle(temp_node[| 0], temp_node[| 1], temp_node[| 0]+temp_node[| 2]-1, temp_node[| 1]+ai_mask_height, true);
}

for (var i = 0; i < ds_list_size(platform_nodes); i++) {
	var temp_node = platform_nodes[| i];
	draw_set_color(c_fuchsia);
	draw_text(temp_node[| 0], temp_node[| 1], string_format(i, 2, 0));
	draw_text(300, 100+(50*i), "i: " + string_format(i, 2, 0) + ", x: " + string_format(temp_node[| 0], 4, 0) + ", y: " + string_format(temp_node[| 1], 4, 0));
}