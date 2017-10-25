if(flattened_level && debug_toggle){

	for(var index = 0; index < ds_list_size(flattened_level); index++){
		var node = flattened_level[|index];
		if(node[2] == 1){
			draw_rectangle_colour(node[0]*chunk_size, node[1]*chunk_size, node[0]*chunk_size+chunk_size, node[1]*chunk_size+chunk_size,c_green, c_green, c_green, c_green, true)
		}
	}
	for(var index = 0; index < ds_list_size(path_to_goal); index++){
		var node = path_to_goal[|index];
		if(node[2] == 1){
			draw_rectangle_colour(node[0]*chunk_size, node[1]*chunk_size, node[0]*chunk_size+chunk_size, node[1]*chunk_size+chunk_size,c_red, c_red, c_red, c_red, false)
		}
	}
	
}