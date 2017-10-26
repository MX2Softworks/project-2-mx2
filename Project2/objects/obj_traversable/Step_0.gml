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

if(obj_player && obj_simple_chaser_test && keyboard_check_pressed(ord("U"))){ 
	
	clock = 0.0;
	var timestamp = get_timer(); 
	
	//reset our path every step.
	ds_list_clear(path_to_goal);
	ds_list_clear(open_list);
	ds_list_clear(closed_list);
	
	
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
							player_chunk_x = curr_x; 
							player_chunk_y = curr_y; 
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
	
	//If we are taking too long, end prematurely.
	if((get_timer() - timestamp)/1000000 > global.frame_time){
		continuing = true;
		return; 
	}
	
	if(level_map[player_chunk_x, player_chunk_y] != 1){
	
		clock += global.frame_time;
		return;
	}
	
	
	//calculate the chaser's position on the level_map
	chaser_chunk_x = floor(obj_simple_chaser_test.x/chunk_size);
	chaser_chunk_y = floor(obj_simple_chaser_test.y/chunk_size);
	
	//if the chaser is reachable, add their position to the goal list. 
	if(level_map[chaser_chunk_x, chaser_chunk_y] == 1){
		ds_list_add(path_to_goal, [chaser_chunk_x, chaser_chunk_y, 1]);
	}
		
///calculate a path to the player. 

		
	ds_list_add(open_list, [chaser_chunk_x, chaser_chunk_y]); 
		
	//came_from of [x,y] is the parent of that node in the path. 
	//g_score is the cost from the start to each node.
	//f_score is g_score + h(x)
	//h(x) is the linear straight-line distance to goal --> sqrt( sqr(x2 - x1) + sqr(y2 - y1))
	//max_value is an approximation for the maximum 32 bit integer value. 
		
	//initialize values.
	for(var x_index = 0; x_index < level_map_width; x_index++){
		for(var y_index = 0; y_index < level_map_height; y_index++){
			came_from[x_index, y_index] = [0,0];
			g_score[x_index, y_index] = max_value;
			f_score[x_index, y_index] = max_value;
		}
	}
	
	//If we are taking too long, end prematurely. 
	if((get_timer() - timestamp)/1000000 > global.frame_time){
		continuing = true; 
		return; 
	}
	
	//initialize g_score and f_score of start.
	g_score[chaser_chunk_x, chaser_chunk_y] = 0; 
	f_score[chaser_chunk_x, chaser_chunk_y] = sqrt(sqr(player_chunk_x - chaser_chunk_x) + sqr(player_chunk_y - chaser_chunk_y))
	var q = 0
	while(!ds_list_empty(open_list)){
		//Set current to node with lowest f_score
		var current = open_list[|0];
		for(var index = 1; index < ds_list_size(open_list); index++){
			var candidate = open_list[|index];
			if(f_score[candidate[0], candidate[1]] < f_score[current[0], current[1]]){
				current = candidate; 
			}
		}
			
		//If goal is found, create a path to the goal. 
		if(current[0] == player_chunk_x && current[1] == player_chunk_y){
			//clear the path to the goal and add the goal point. 
			ds_list_clear(path_to_goal); 
			var path_point = current;
			ds_list_add(path_to_goal, [path_point[0], path_point[1], 1]); 
				
			//walk the path backwards until the point is the goal, then add it. 
			while(path_point[0] != chaser_chunk_x && path_point[1] != chaser_chunk_y){
				path_point = came_from[path_point[0], path_point[1]];
				ds_list_insert(path_to_goal,0,[path_point[0], path_point[1], 1]); 
			}
			clock += global.frame_time; 
			return;
		}
			
		ds_list_add(closed_list, [current[0], current[1]]); 
		for(var index = 0; index < ds_list_size(open_list); index++){
			var candidate = open_list[|index];
			if(candidate[0] == current[0] && candidate[1] == current[1]){
				ds_list_delete(open_list, index);
				break;
			}
		}
			
		//for each neighbor of current
		for(var x_index = -1+current[0]; x_index < 2+current[0]; x_index++){
			for(var y_index = -1+current[1]; y_index < 2+current[1]; y_index++){
				q++;
				//if not traversable, go to next neighbor. 
				var traversable = (x_index > -1 && y_index > -1 && level_map[x_index, y_index] == 1);
				if(! traversable){ 
					continue; 
				}
					
				//if already visited, go to next neighbor. 
				var in_closed_list = false;
				for(var index = 0; index < ds_list_size(closed_list); index++){
					var candidate = closed_list[|index];
					if(candidate[0] == x_index && candidate[1] == y_index){
						in_closed_list = true;
						break;
					}
				}
				if(in_closed_list){
					continue; 
				}
					
				//Add the node to the open list if unvisited.
				var in_open_list = false;
				for(var index = 0; index < ds_list_size(open_list); index++){
					var candidate = open_list[|index];
					if(candidate[0] == x_index && candidate[1] == y_index){
						in_open_list = true;
						break;
					}
				}
				if(!in_open_list){ ds_list_add(open_list, [x_index, y_index]); }
					
				//if the g_score of this neighbor from this current path is worse, go to next neighbor. 
				var tentative_g_score = g_score[current[0], current[1]] + 1;
				if(tentative_g_score >= g_score[x_index, y_index]){ 
					continue; 
				}
					
				//Otherwise, this is the best path until now. 
				came_from[x_index, y_index] = [current[0], current[1]];
				g_score[x_index, y_index] = tentative_g_score; 
				f_score[x_index, y_index] = g_score[x_index, y_index] + sqrt(sqr(player_chunk_x - x_index) + sqr(player_chunk_y - y_index));
			}
		}
		
		//If we are taking too long, end prematurely. 
		if((get_timer() - timestamp)/1000000 > global.frame_time){
			continuing = true;
			return; 
		}
		
	}
}

clock += global.frame_time;
continuing = false; 