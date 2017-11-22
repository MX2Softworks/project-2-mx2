//This allows us to click and place the chaser to different places on the map. 
if(mouse_check_button_pressed(mb_left) && instance_position(mouse_x, mouse_y, self)){

	selected = !selected;
}

//Toggles the ability to see the traversable regions. 
if (keyboard_check_pressed(ord("P"))) {
    debug_toggle = !debug_toggle;
}

//Allows us to change the chunk size. 
if(keyboard_check_pressed(ord("1")) && chunk_size < 48) {

	chunk_size += 8;
	regen_graph = true; 
}

if(keyboard_check_pressed(ord("2")) && chunk_size > 8) {

	chunk_size -= 8;
	regen_graph = true; 
}

//Moves the chaser if it is selected.
if(selected){

	x = mouse_x;
	y = mouse_y;
	return;
}

if(global.re_grid){
	break_point = true;
}

//Regenerates the graph the chunk size changes. 
if(regen_graph || global.re_grid){
	
	regen_graph = false;
	
	on_ground_list = "";
	at_ceiling_list = "";
	wall_jump_list = "";
	search_check = false;

	end_x = -1;
	end_y = -1;
	start_x = -1;
	start_y = -1; 
	max_value = 2000000000

	character_height = floor( 32/ chunk_size);
	max_character_jump_height = floor(32 * 4 / chunk_size)

	nodes = ""; //a list of a (list of nodes) in our graph. 
	touched_locations = ""; //places we've modified, used in optimizations.
	open_list = "";
	closed_list = "";
	stop = false;
	stopped = false;
	formula = "man";
	H_estimate = 2;
	search_limit  = 1;
	is_open = 1;
	is_closed= 2;
	
	//Promoted local variables to member variables to avoid recreation between calls
	H                       = 0;
	location                = 0;
	new_location_xy         = 0;
	node                    = 0;
	location_x              = 0;
	location_y              = 0;
	new_location_x          = 0;
	new_location_y          = 0;
	closed_node_counter     = 0;
	found                   = false;
	direction_vector = [[0,-1],[1,0], [0,1], [-1,0], [1,-1], [1,1], [-1,1], [-1,-1]]
	end_location_xy         = 0;
	new_G                   = 0;
	node_list 				= 0;
	grid[0, 0]				= 0;
	grid_x_dim = floor(room_width/chunk_size);
	grid_y_dim = floor(room_height/chunk_size);

	//Go through the level and mark any chunk that does not have a solid present as a valid chunk. 
	counter = 0;
	for(var x_index = 0; x_index < grid_x_dim; x_index++){
		for(var y_index = 0; y_index < grid_y_dim; y_index++){
		
			var solid_at_grid = (  instance_position(x_index*chunk_size, y_index*chunk_size, obj_solid) 
		                    || instance_position(x_index*chunk_size + chunk_size/2,  y_index*chunk_size + chunk_size/2, obj_solid) 
							|| instance_position(x_index*chunk_size + chunk_size -1, y_index*chunk_size + chunk_size-1, obj_solid)); 
			if(solid_at_grid){
				grid[x_index, y_index] = 0;
			}
			else{
				grid[x_index, y_index] = 1;
			}
			counter++;
		}
	}

	//nodes = new list of pathFinderNodeFast with length of grid_x_dim * grid_y_dim
	if (nodes == "" || ds_list_size(nodes) != (grid_x_dim * grid_y_dim))
	{
		//init nodes
	
		if(nodes != ""){
	
			for(var index = 0; index < ds_list_size(nodes); index++){
				node_list = nodes[|index];
				ds_list_destroy(node_list);
			}
			ds_list_destroy(nodes);
		}
		nodes = ds_list_create();
		for(var index = 0; index < grid_x_dim * grid_y_dim; index++){
			nodes[|index] =  ds_list_create();
		}
	
		//init touched_locations
		if(touched_locations != "")
		{
			ds_stack_clear(touched_locations);
			ds_stack_destroy(touched_locations);
		}
	    touched_locations = ds_stack_create(); //touched_locations = new stack of ints that is the size of grid_x_dim * grid_y_dim
	
		//init closed list
		if(closed_list != ""){
			ds_list_clear(closed_list);
		}
		closed_list = ds_list_create(); //closed_list is a list of 2d vectors with grid_x_dim * grid_y_dim vectors in it.
		for(var index = 0; index < grid_x_dim * grid_y_dim; index++){
			closed_list[|index] = [-1, -1]
		}
	}

	for (var i = 0; i < ds_list_size(nodes); ++i){
		ds_list_clear(nodes[|i]);
	}

	if(open_list != ""){

		while(ds_priority_size(open_list) > 0){
			ds_priority_delete_min(open_list);
		}
		ds_priority_destroy(open_list);
	}
	open_list = ds_priority_create(); //have to stack locations and compare their priorities. open list is a priority queue that compares based off of F value
}

//check the player's current location to see if we should restart our search or continue a previous one.
var temp_x = 0; 
var temp_y = 0; 
	
if(obj_player){
	temp_x = floor(obj_player.x / chunk_size);
	temp_y = floor(obj_player.y / chunk_size); 
}	

//start a search if we press U or if a previous search from last frame is going. 
if(keyboard_check_pressed(ord("U")) || !((found && stopped) || (!found && !stopped) || (temp_x != end_x  || temp_y != end_y))){
	
	closed_node_counter = 0;
	
	//if we finished a previous search, a previous search is invalid, or the player moved. 
	if( (found && stopped) || (!found && !stopped) || (temp_x != end_x  || temp_y != end_y) ){
	
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
		start_x = floor(x / chunk_size);
		start_y = floor(y /chunk_size);
		end_x = 7
		end_y = 7
		
		if(obj_player){ 
			end_x = floor(obj_player.x / chunk_size);
			end_y = floor(obj_player.y / chunk_size);
		}
	
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
			var elem = [start_x, start_y]
			ds_list_add(on_ground_list, elem);
			starting_jump = true;
		}
		//if we can wall jump, also set the jump_length to 0
		if((start_x + 1 < grid_x_dim && grid[start_x +1, start_y] == 0) || (start_x - 1 > -1 && grid[start_x -1, start_y] == 0)) {
			first_node[PNF.jump_length] = 0;
			var elem = [start_x, start_y]
			ds_list_add(wall_jump_list, elem);
			starting_jump = true;
		}
		//otherwise, use a falling value for the jump value.
		if(starting_jump == false){
			first_node[PNF.jump_length] = (max_character_jump_height * 2);
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
		
		for (var i=0; i < 8; i++) /*if diagonals are allowed then 8 neighbors, else then 4*/ {
			
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
			
			//determine if node is on ground.
			if(new_location_y + 1 < grid_y_dim && grid[new_location_x, new_location_y + 1] == 0) { 
				on_ground = true; 
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
			//determine if node is on ceiling.
			if(new_location_y - character_height < 0 || grid[new_location_x, new_location_y - character_height] == 0) { 
				at_ceiling = true;
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
			//determine if node is a wall_jump.
			if((new_location_x +1 < grid_x_dim && grid[new_location_x +1, new_location_y] == 0) || (new_location_x - 1 > -1 && grid[new_location_x -1, new_location_y] == 0)) { 
				wall_jump = true;
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
			
			//calculate a proper jump_length value for the successor
			node_list = nodes[|location[L.xy]];
			var old_loc_node = node_list[|location[L.z]];
			var jump_length = old_loc_node[PNF.jump_length];
			var new_jump_length = jump_length;
			
			if (at_ceiling)
			{
				if (new_location_x != location_x)	new_jump_length = max(max_character_jump_height * 2 + 1, jump_length + 1);
				else								new_jump_length = max(max_character_jump_height * 2, jump_length + 2);
			}
			else if (on_ground){
				new_jump_length = 0;
			}
			//we are jumping up.
			else if (new_location_y < location_y){ // if new location is above the previous
				
				//first jump is always two block up instead of one up and optionally one to either right or left
				if (jump_length < 2)					new_jump_length = 3;
				else if (jump_length % 2 == 0)			new_jump_length = jump_length + 2;
				else if (wall_jump && jump_length > 3)	new_jump_length = 0;
				else									new_jump_length = jump_length + 1;
			}
			//we are falling.
			else if (new_location_y > location_y){
				if (jump_length % 2 == 0)	new_jump_length = max(max_character_jump_height * 2, jump_length + 2);
				else						new_jump_length = max(max_character_jump_height * 2, jump_length + 1);
			}
			else if (!on_ground && new_location_x != location_x)	new_jump_length = jump_length + 1;
			//this is based off of the way jump lengths are calculated
			if (jump_length >= 0 && jump_length % 2 != 0 && location_x != new_location_x)
				continue;
			
			//if we're falling and succeor's height is bigger than ours, skip that successor
			if (jump_length >= max_character_jump_height * 2 && new_location_y < location_y)
				continue;

			//TODO: determine where the value of '6' comes from here. 
			//TODO: determine where the value of '8' and '3' come from here. 
			if (new_jump_length >= max_character_jump_height * 2 + 6 && new_location_x != location_x && (new_jump_length - (max_character_jump_height * 2 + 6)) % 8 != 3)
				continue;
			
			//calculate the new g
			node_list = nodes[|location[L.xy]];
			node = node_list[|location[L.z]];
			new_G = node[PNF.G] + grid[new_location_x, new_location_y] + new_jump_length / 4;
			
			
			node_list = nodes[|new_location_xy];
			if (ds_list_size(node_list) > 0){
				var lowest_jump = max_value;
				could_move_sideways = false;
				
				for (var j = 0; j < ds_list_size(node_list); ++j)
				{
					node = node_list[|j]
					//take new node if the jump length is better 
					if (node[PNF.jump_length] < lowest_jump)
						lowest_jump = node[PNF.jump_length];

					//can jump to the side
					if (node[PNF.jump_length] % 2 == 0 && node[PNF.jump_length] < max_character_jump_height * 2 + 6)
						could_move_sideways = true;
				}

				if (lowest_jump <= new_jump_length && (new_jump_length % 2 != 0 || new_jump_length >= max_character_jump_height * 2 + 6 || could_move_sideways))
					continue;
			}
			
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
		
		node_list = nodes[|location[L.xy]];
		node = node_list[|location[L.z]];
		node[PNF.status] = is_closed;
		node_list[|location[L.z]] = node;
		nodes[|location[L.xy]] = node_list;
		closed_node_counter++;
	}	
	if (found){
		
		//we will store the path in the closed list.
		ds_list_clear(closed_list);
		var pos_x = end_x;
		var pos_y = end_y;
		
		var prev_node_temp = [-1,-1,-1,-1,-1,-1,-1]; //pathfinder node.
		node_list = nodes[|end_location_xy]; //pathfinder node.
		var node_temp = node_list[|0];
		
		var temp_loc = [end_x, end_y];
		var prev_node = [end_x, end_y];

		var loc_xy = node_temp[PNF.PY] * grid_x_dim + node_temp[PNF.PX]; //loc_xy is the XY position of the node to be processed next. 
		
		//keep going until you hit the start node. 
		while (temp_loc[0] != node_temp[PNF.PX] || temp_loc[1] != node_temp[PNF.PY]){
			
			//get the next pathfinder node
			node_list = nodes[|loc_xy];
			var next_node_temp = node_list[|node_temp[PNF.PZ]]; 

			//initalize some values used in the if conditional.
			/*
				var closed_list_last = -1;
				var closed_list_last_x = -1;
				var closed_list_last_y = -1;
				if(ds_list_size(closed_list) -1 > -1){
					closed_list_last= closed_list[| ds_list_size(closed_list) - 1];
					closed_list_last_x = closed_list_last[0];
					closed_list_last_y = closed_list_last[1];
				}
			
				//checks if left neighbor or right neighbor are on ground.
				var adjacent_on_ground = false
				if((temp_loc[0] -1 > -1 && temp_loc[1] + 1 < grid_y_dim && grid[temp_loc[0] - 1, temp_loc[1] + 1] == 0) || (temp_loc[0] +1 < grid_x_dim && temp_loc[1] + 1 <= grid_y_dim && grid[temp_loc[0] - 1, temp_loc[1] + 1] == 0))
					{ adjacent_on_ground = true; }
			
			*/
			//Now let's start the filtering process. The start node will get added to the list at the very end, after all other items have been dealt with. 
			//Since we're going from the end node, let's be sure to include that one in our final path:
			
			/*if (ds_list_size(closed_list) == 0 //add the ending node.
				|| (node_temp[PNF.jump_length] == 3)  
				|| (next_node_temp[PNF.jump_length] != 0 && node_temp[PNF.jump_length] == 0)   //mark jumps starts
				|| (node_temp[PNF.jump_length] == 0 && prev_node_temp[PNF.jump_length] != 0)          //mark landings
				|| (temp_loc[1] > closed_list_last_y && temp_loc[1] > node_temp[PNF.PY])
				|| (temp_loc[1] < closed_list_last_y && temp_loc[1] < node_temp[PNF.PY])
				|| (adjacent_on_ground == true && temp_loc[1] != closed_list_last_y && temp_loc[0] != closed_list_last_x))
				{ ds_list_add(closed_list, temp_loc); }*/
			ds_list_add(closed_list, temp_loc);
		
			prev_node = temp_loc;
			pos_x = node_temp[PNF.PX];
			pos_y = node_temp[PNF.PY];
			prev_node_temp = node_temp;
			node_temp = next_node_temp;	
			loc_xy = node_temp[PNF.PY] * grid_x_dim + node_temp[PNF.PX];
			temp_loc = [pos_x, pos_y];
		}
			
		ds_list_add(closed_list, temp_loc);
		stopped = true;
		highlight_path = true;
		search_check = true;
		exit;
	}
		
	stopped = true;
	exit;
}

