if(current_node != "" && !is_undefined(current_node)){
	draw_rectangle_colour(	current_node[0] * pathfinder.chunk_size, 
							current_node[1] * pathfinder.chunk_size, 
							current_node[0] * pathfinder.chunk_size + pathfinder.chunk_size, 
							current_node[1] * pathfinder.chunk_size + pathfinder.chunk_size,
							c_red, c_red, c_red, c_red,
							false);
}

draw_self();