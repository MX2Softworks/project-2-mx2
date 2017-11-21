old_depth = depth
depth = -10

if(debug_toggle){
	for(var x_index = 0; x_index < grid_x_dim; x_index++){
		for(var y_index = 0; y_index < grid_y_dim; y_index++){
			if(grid[x_index, y_index] == 1){
				draw_rectangle_color(x_index * chunk_size, y_index*chunk_size, x_index*chunk_size + chunk_size, y_index*chunk_size + chunk_size, c_green, c_green, c_green, c_green, true);
			}
			else{
				draw_rectangle_color(x_index * chunk_size, y_index*chunk_size, x_index*chunk_size + chunk_size, y_index*chunk_size + chunk_size, c_aqua, c_aqua, c_aqua, c_aqua, false);
			}
		}
	}
}

if(highlight_path){

	for(var index = 0; index < ds_list_size(closed_list); index++){
		var node = closed_list[|index];
		draw_rectangle_color(node[0] * chunk_size, node[1]*chunk_size, node[0]*chunk_size + chunk_size, node[1]*chunk_size + chunk_size, c_red, c_red, c_red, c_red, false);
	}
}

depth = old_depth
draw_self()