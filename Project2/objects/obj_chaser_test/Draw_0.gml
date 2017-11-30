draw_self();


if(current_node != "" && !is_undefined(current_node)){
	draw_rectangle_colour(	current_node[0] * pathfinder.chunk_size, 
							current_node[1] * pathfinder.chunk_size, 
							current_node[0] * pathfinder.chunk_size + pathfinder.chunk_size, 
							current_node[1] * pathfinder.chunk_size + pathfinder.chunk_size,
							c_red, c_red, c_red, c_red,
							false);
}

draw_rectangle_color( curr_chunk_x * pathfinder.chunk_size,
					  curr_chunk_y * pathfinder.chunk_size,
					  curr_chunk_x * pathfinder.chunk_size + pathfinder.chunk_size,
					  curr_chunk_y * pathfinder.chunk_size + pathfinder.chunk_size,
					  c_purple, c_purple, c_purple, c_purple, 
					  false);


/*if(!is_undefined(path) && path != ""){
	for(var i = 0; i < ds_list_size(path); i++){
		
		var node = path[|i];
		draw_rectangle_colour(node[0] * pathfinder.chunk_size, 
							  node[1] * pathfinder.chunk_size, 
							  node[0] * pathfinder.chunk_size + pathfinder.chunk_size, 
							  node[1] * pathfinder.chunk_size + pathfinder.chunk_size,
							  c_blue, c_blue, c_blue, c_blue,
							  false);

	}
}*/

for(var i = 0; i < ds_list_size(full_path); i++){
		
		var node = full_path[|i];
		draw_set_alpha(.25);
		draw_rectangle_colour(node[0] * pathfinder.chunk_size, 
							  node[1] * pathfinder.chunk_size, 
							  node[0] * pathfinder.chunk_size + pathfinder.chunk_size, 
							  node[1] * pathfinder.chunk_size + pathfinder.chunk_size,
							  c_blue, c_blue, c_blue, c_blue,
							  true);
					
		draw_set_alpha(1);
}
