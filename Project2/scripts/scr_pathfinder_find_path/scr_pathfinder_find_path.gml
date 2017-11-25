
	//supplied parameters.
	var start_x = argument0;
	var start_y = argument1;
	var end_x = argument2;
	var end_y = argument3;
	
	var filter_on = argument4;
	var debug = argument5;
	
	closed_node_counter = 0;
	//if we finished a previous search, a previous search is invalid, or we search too long. 
	if( (found && stopped) || (!found && !stopped) || search_counter > 10){
	
		search_counter = 0;
		//initialize list of on_ground and at_ceiling nodes if not already.
		//these lists are only used for debug purposes. 
		if(on_ground_list == ""){
			on_ground_list = ds_list_create();
		}
		if(at_ceiling_list == ""){
			at_ceiling_list = ds_list_create();
		}
		if(wall_jump_list == ""){
			wall_jump_list = ds_list_create(); 
		}
	
		highlight_path = false; //used to draw path.
	
		//go through every node in touched locations and reset it.
		while (ds_stack_empty(touched_locations) == false){
			var pop = ds_stack_pop(touched_locations)
			node_list = nodes[|pop];
			ds_list_clear(node_list);
			nodes[|pop] = node_list;
	
			if (grid[end_x, end_y] == 0)
				return null;
		}
	
		//if end goal is untraversable or blocked, return null
		if(grid[end_x, end_y] == 0){ return null; }
	
		found = false; 
		stop = false; 
		stopped = false;
		closed_node_counter = 0;
		is_open += 2; 
		is_closed += 2;
		search_limit = 1500;
	
		//make a new location
		location = [-1,-1]
		location[L.xy] = start_y * grid_x_dim + start_x
		location[L.z] = 0
		end_location_xy = end_y * grid_x_dim + end_x
	
		//init the first location to put in the graph.
		var first_node = [-1,-1,-1,-1,-1,-1,-1];
		first_node[PNF.G] = 0;
		first_node[PNF.F] = H_estimate;
		first_node[PNF.PX] = start_x;
		first_node[PNF.PY] = start_y;
		first_node[PNF.PZ] = 0;
		first_node[PNF.status] = is_open;
		var starting_jump = false;
		
		//if the first_node is a ground node or we can wall slide. (aka there is an obj_solid directly underneath) then set its jump value to 0.
		if(start_y + 1 < grid_y_dim && grid[start_x, start_y + 1] == 0){
			first_node[PNF.jump_length] = 0;
			if(debug){
				var elem = [start_x, start_y]
				ds_list_add(on_ground_list, elem);
			}
			starting_jump = true;
		}
		//if we can wall jump, also set the jump_length to 0
		if((start_x + 1 < grid_x_dim && grid[start_x +1, start_y] == 0) || (start_x - 1 > -1 && grid[start_x -1, start_y] == 0)) {
			first_node[PNF.jump_length] = 0;
			if(debug){
				var elem = [start_x, start_y]
				ds_list_add(wall_jump_list, elem);
			}
			starting_jump = true;
		}
		//otherwise, use a falling value for the jump value.
		if(starting_jump == false){
			first_node[PNF.jump_length] = (max_character_jump_height * speed_factor);
		}

		//add the first node and its location to the open_list and touched_locations
		nodes_list = nodes[|location[L.xy]];
		ds_list_add(nodes_list, first_node)
		nodes[|location[L.xy]] = nodes_list;
		ds_stack_push(touched_locations, location[L.xy]);
		ds_priority_add(open_list, location, first_node[PNF.F]);
	
	}
	else {
		stopped = false;
		stop = false;
		closed_node_counter = 0;
	}
	
	while(ds_priority_size(open_list) > 0){
		
		if(found) break;
		location = ds_priority_find_min(open_list);
		ds_priority_delete_min(open_list);
		
		//Is it in closed list? means this node was already processed
		node_list = nodes[|location[L.xy]]
		node = node_list[|location[L.z]]
		if(! is_array(node)  ){
			break_point = true;
			continue;
		}
		
		//If its in the closed list, skip it. 
		if (node[PNF.status] == is_closed)
			continue;
		
		//get the coordinates from the location
		location_x = floor(location[L.xy] % grid_x_dim)
		location_y = floor(location[L.xy] / grid_x_dim)

		//if we are at the end, end. 
		if (location[L.xy] == end_location_xy){
			node_list = nodes[|location[L.xy]];
			node = node_list[|location[L.z]];
			node[PNF.status] = is_closed;
			node_list[|location[L.z]] = node;
			nodes[|location[L.xy]] = node_list;
			found = true; 
			
		}
		
		//if we hit our search limit, terminate.
		if (!found && closed_node_counter > search_limit){
			stopped = true; 
			exit;
		}
		
		/*grandparent_wall_jump = false;
		if(node[PNF.PY] + 1 < grid_y_dim && grid[node[PNF.PX], node[PNF.PX] + 1] != 0 && (node[PNF.PX] +1 < grid_x_dim && grid[node[PNF.PX] +1, node[PNF.PY]] == 0) || (node[PNF.PX] - 1 > -1 && grid[node[PNF.PX] -1, node[PNF.PY]] == 0)){
			grandparent_wall_jump = true;
		}*/
		
		parent_wall_jump = false;
		if(location_y + 1 < grid_y_dim && grid[location_x, location_y + 1] != 0 && (location_x +1 < grid_x_dim && grid[location_x +1, new_location_y] == 0) || (location_x - 1 > -1 && grid[location_x -1, location_y] == 0)){
			//parent_wall_jump = true;
		}
		
		for (var i=0; diagonal_valid ? (i < 8) : (i < 4); i++) /*if diagonals are allowed then 8 neighbors, else then 4*/ {
			
			if(found) break;
			
			var dir = direction_vector[i];
			new_location_x = location_x + dir[0];
			new_location_y = location_y + dir[1];
			
			//if out of bounds, continue.
			if(new_location_x < 0 || new_location_x >= grid_x_dim || new_location_y < 0 || new_location_y >= grid_y_dim || grid[new_location_x, new_location_y] == 0)
			{
				continue;
			}
			new_location_xy  = new_location_y * grid_x_dim + new_location_x;
			
			//determine if node is on ground.
			var on_ground = false; 
			var at_ceiling = false;
			var wall_jump = false;
			
			//determine if successor is on ground.
			if(new_location_y + 1 < grid_y_dim && grid[new_location_x, new_location_y + 1] == 0) { 
				on_ground = true; 
				if(debug){
					var elem = [new_location_x, new_location_y];
					var dont_add = false;
					for(var index = 0; index < ds_list_size(on_ground_list); index++){
						var comp = on_ground_list[|index];
						if(comp[0] == elem[0] && comp[1] == elem[1]){
							dont_add = true;
							break;
						}
					}
					if(!dont_add){
						ds_list_add(on_ground_list, elem);
					}
				}
			}
			//determine if successor is on ceiling.
			if(new_location_y - character_height < 0 || grid[new_location_x, new_location_y - character_height] == 0) { 
				at_ceiling = true;
				if(debug){
					var elem = [new_location_x, new_location_y];
					var dont_add = false;
					for(var index = 0; index < ds_list_size(at_ceiling_list); index++){
						var comp = at_ceiling_list[|index];
						if(comp[0] == elem[0] && comp[1] == elem[1]){
							dont_add = true;
							break;
						}
					}
					if(!dont_add){
						ds_list_add(at_ceiling_list, elem);
					}
				}	
			}
			//determine if successor is a wall_jump.
			if(!on_ground && ((new_location_x +1 < grid_x_dim && grid[new_location_x +1, new_location_y] == 0) || (new_location_x - 1 > -1 && grid[new_location_x -1, new_location_y] == 0))) { 
				wall_jump = true;
				if(debug){
					var elem = [new_location_x, new_location_y];
					var dont_add = false;
					for(var index = 0; index < ds_list_size(wall_jump_list); index++){
						var comp = wall_jump_list[|index];
						if(comp[0] == elem[0] && comp[1] == elem[1]){
							dont_add = true;
							break;
						}
					}
					if(!dont_add){
						ds_list_add(wall_jump_list, elem);
					}
				}
			}
			
			//calculate a proper jump_length value for the successor
			node_list = nodes[|location[L.xy]];
			var old_loc_node = node_list[|location[L.z]];
			var jump_length = old_loc_node[PNF.jump_length]; //jump length of parent. 
			var new_jump_length = jump_length;
			
			if (at_ceiling)
			{
				//we've hit the ceiing so go straight down.
				if (new_location_x != location_x)	new_jump_length = max(max_character_jump_height * speed_factor + 1, jump_length + 1);
				//we can move one cell to the left or right.
				else								new_jump_length = max(max_character_jump_height * speed_factor, jump_length + speed_factor);
			}
			else if (on_ground){
				//we can jump again, so reset jump value. 
				new_jump_length = 0;
			}
			else if (wall_jump && jump_length > speed_factor + 1){
				new_jump_length = speed_factor;
			}
			//we are jumping up.
			else if (new_location_y < location_y){ // if new location is above the previous
				
				//first jump is always two block up instead of one up and optionally one to either right or left.
				if (jump_length < speed_factor)				new_jump_length = speed_factor+1;
				//If we are at a speed factor interval, we must move up. 
				else if (jump_length % speed_factor == 0)	new_jump_length = jump_length + speed_factor;
				//moving sideways, increase the new jump length. 
				else										new_jump_length = jump_length + 1;
			}
			//we are falling.
			else if (new_location_y > location_y){
				//if we are at a speed factor interval, we must move down.
				if (jump_length % speed_factor == 0)								new_jump_length = max(max_character_jump_height * speed_factor, jump_length + speed_factor);
				//we can move sideways. 
				else																new_jump_length = max(max_character_jump_height * speed_factor, jump_length + 1);
			}
			//this node is a sideways movement in the air. 
			else if (!on_ground && new_location_x != location_x)	new_jump_length = jump_length + 1;
			
			//If the parent node is either to the left or right, and we move sideways when we are supposed to be at the 
			//speed factor interval, skip that successor.
			if (jump_length >= 0 && jump_length % speed_factor == (speed_factor-1) && location_x != new_location_x)	continue;
			
			//if we're falling and successor's height is bigger than ours, skip that successor
			if (jump_length >= max_character_jump_height * speed_factor && new_location_y < location_y)	continue;

			//if the parent node was a wall jump, and the current node has the same x, skip that successor.
			//if(parent_wall_jump && new_location_x == location_x && new_location_y < location_y)	continue;

			//if successor is a wall jump and the node below the successor was a wall jump, skip that successor
			var direct_wall_ascend = false;
			if(new_location_y + 2 < grid_y_dim){
				var below_xy = (new_location_y + 1) * grid_x_dim + new_location_x;
				node_list = nodes[|below_xy];
				
				for(var j = 0; j < ds_list_size(node_list); j++){
					node = node_list[|j]
					if(!is_undefined(node) 
					&& (grid[new_location_x, new_location_y + 2] != 0) //check if node below is not a ground node
					&& ((new_location_x +1 < grid_x_dim && grid[new_location_x +1, new_location_y + 1] == 0) || (new_location_x - 1 > -1 && grid[new_location_x -1, new_location_y + 1] == 0))
					&& node[PNF.jump_length] == 0) { 
						direct_wall_ascend = true;
						break;
					}
				}
			}
			//if(direct_wall_ascend)	continue;
			
			//If the character is falling and the successor node is above the parent, skip that successor.
				//If the successor's jump value is larger than the fall threshold (max * speed_factor + 6), 
				//then we should stop allowing the direction change on every even jump value.
				
			if (new_jump_length >= max_character_jump_height * speed_factor + gravity_threshold && new_location_x != location_x 
			&& ((new_jump_length - (max_character_jump_height * speed_factor + gravity_threshold)) % (speed_factor * 4) > speed_factor 
			&& ((new_jump_length - (max_character_jump_height * speed_factor + gravity_threshold)) % (speed_factor * 4) < speed_factor*2)))
				continue;
				
		/*  This will prevent the algorithm giving incorrect values when the character is falling really fast, 
			because in that case instead of (speed_factor-1) blocks to the side and 1 block down, it would need to move (speed_factor-1) blocks 
			to the side and 2 or more blocks down. (Right now, the character can move (speed_factor +1 up to speed_factor * 2 -1) 
			blocks to the side after it starts falling, and then we allow it to move sideways every 4 blocks traversed vertically.)  */
				
			node_list = nodes[|new_location_xy];
			if (ds_list_size(node_list) > 0){
				var lowest_jump = max_value;
				could_move_sideways = false;
				
				for (var j = 0; j < ds_list_size(node_list); ++j)
				{
					node = node_list[|j]
					//take new node if the jump length is better.
					if (node[PNF.jump_length] < lowest_jump)
						lowest_jump = node[PNF.jump_length];

					//can jump to the side while ascending or falling.
					if (node[PNF.jump_length] % speed_factor < (speed_factor - 1) && node[PNF.jump_length] < max_character_jump_height * speed_factor + gravity_threshold)
						could_move_sideways = true;
				}

				//skip this successor if any other nodes at that location are cheaper or allow you to move sideways. 
				if (lowest_jump <= new_jump_length && (new_jump_length % speed_factor != 0 || new_jump_length >= max_character_jump_height * speed_factor + gravity_threshold || could_move_sideways))
					continue;
			}
			
			//calculate the new g
			node_list = nodes[|location[L.xy]];
			node = node_list[|location[L.z]];
			new_G = node[PNF.G] + grid[new_location_x, new_location_y] + new_jump_length / 4;  //we add new_jump_length / 4 to make 
																							  //non-jumping preferable to the AI.
																							  
			if((wall_jump) || (parent_wall_jump)) new_G += max(new_jump_length * 4, speed_factor * 3);
			
			//initialize H based on heuristic variables 
			switch(formula){
				case "man": H = H_estimate * (abs(new_location_x - end_x) + abs(new_location_y - end_y));
			}
			
			//create new node to add
			var new_node =  [-1,-1,-1,-1,-1,-1,-1];
			new_node[PNF.jump_length] = new_jump_length;
			new_node[PNF.PX] = location_x;
			new_node[PNF.PY] = location_y;
			new_node[PNF.PZ] = location[L.z];
			new_node[PNF.G] = new_G;
			new_node[PNF.F] = new_G + H;
			new_node[PNF.status] = is_open;
			
			//if node_list at new_location_xy is empty, add it to the touched locations. 
			node_list = nodes[|new_location_xy];
			if (ds_list_size(node_list) == 0)
				ds_stack_push(touched_locations, new_location_xy);
			
			//add the node to the node_list at new_location_xy
			node_list = nodes[|new_location_xy];
			ds_list_add(node_list, new_node);
			nodes[|new_location_xy] = node_list
			
			//add to the open list.
			var temp_location = [new_location_xy, ds_list_size(node_list) - 1];
			ds_priority_add(open_list, temp_location, new_node[PNF.F]);
		}
		
		//finished searching through all the neighbors. 
		//mark this node as in the closed list.
		node_list = nodes[|location[L.xy]];
		node = node_list[|location[L.z]];
		node[PNF.status] = is_closed;
		node_list[|location[L.z]] = node;
		nodes[|location[L.xy]] = node_list;
		closed_node_counter++;
	}	
	if (found){
		scr_pathfinder_reconstruct_path(filter_on);
		return;
	}
		
	stopped = true;
	search_counter++;
	return;