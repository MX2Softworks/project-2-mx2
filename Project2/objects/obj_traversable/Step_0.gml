if (keyboard_check_pressed(ord("P"))) {
    debug_toggle = !debug_toggle;
}

if(keyboard_check_pressed(ord("1")) && chunk_size < 48) {

	chunk_size += 8;
	regen_graph = true; 
}

if(keyboard_check_pressed(ord("2")) && chunk_size > 8) {

	chunk_size -= 8;
	regen_graph = true; 
}

if(regen_graph){

	regen_graph = false;
	ds_list_destroy(solids_list);
	ds_list_destroy(flattened_level);
	scr_navigable_terrain();
}

//create path to player!

if(obj_player){
	
	//reset our path every step.
	ds_list_clear(path_to_goal); 
	
	
	//calculate the player's position on the level_map
	player_chunk_x = floor(obj_player.x/chunk_size);
	player_chunk_y = floor(obj_player.y/chunk_size);
	
	//if the player is reachable, add their position to the goal list. 
	if(level_map[player_chunk_x, player_chunk_y] == 1){
		ds_list_add(path_to_goal, [player_chunk_x, player_chunk_y, 1]);
	}
	
	//otherwise add their closest valid position.
	else{
		
		//search through space, ignoring previously searched regions. 
		var search_radius = floor(250/chunk_size);
		var bound_x_start = 0;
		var bound_x_end = 0;
		var bound_y_start = 0;
		var bound_y_end = 0; 
		
		//begin searching with a radius of 1. If we cannot find something close, we expand radius. 
		for(var radius = 1; radius < search_radius; radius++){
			for(var search_x = -radius; search_x <= radius; search_x++){
				for(var search_y = -radius; search_y <= radius; search_y++){
					
					//only care about valid indices in the search bounds.  
					
					var curr_x = player_chunk_x+search_x;
					var curr_y = player_chunk_y+search_y;
					
					var valid = (curr_x > -1 && curr_x < level_map_width && curr_y > -1 && curr_y < level_map_height);
					var in_bounds = ((search_x < bound_x_start || search_x > bound_x_end) && (search_y < bound_y_start || search_y > bound_y_end));
					
					if(valid && in_bounds){
						if(level_map[curr_x, curr_y] == 1){
							ds_list_add(path_to_goal, [curr_x, curr_y, 1]);
							search_x = search_radius + 1;
							search_y = search_radius + 1;
							radius = search_radius + 1;
							break;
						}
					}
				}
			}
		}
	}
	
	if(obj_simple_chaser_test){
		//calculate the chaser's position on the level_map
		chaser_chunk_x = floor(obj_simple_chaser_test.x/chunk_size);
		chaser_chunk_y = floor(obj_simple_chaser_test.y/chunk_size);
	
		//if the chaser is reachable, add their position to the goal list. 
		if(level_map[chaser_chunk_x, chaser_chunk_y] == 1){
			ds_list_add(path_to_goal, [chaser_chunk_x, chaser_chunk_y, 1]);
		}
		
	}

}

