scr_fix_spawn(obj_solid);

//calculate current chunk.
curr_chunk_x = floor((x)/pathfinder.chunk_size);
curr_chunk_y = floor((y+sprite_height-1)/pathfinder.chunk_size);

//if we finished a search, reset path.
if(pathfinder.found == true && path_updated = false && keyboard_check_pressed(ord("U"))){

	ds_list_clear(path);
	ds_list_copy(path, pathfinder.closed_list);
	//ds_list_delete(path,7);
	//ds_list_delete(path,7);
	current_node = "";	
	path_updated = true;
	current_index = ds_list_size(path) - 1;
}

//if we have a path,but no destination, set one.
if(current_node == "" && ds_list_size(path) > 0){

	current_node = path[|current_index];
	current_index--;
	next_node = path[|current_index];
	
	//get direction from current node to next. 
	direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
	//normalize.
	direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
}

//once we reach the current node, set the new current node to next node in path.
if(!is_undefined(current_node) && current_node != "" && curr_chunk_x == current_node[0] 
   && curr_chunk_y == current_node[1] && ds_list_size(path) > 0
   && !wait_for_wall_jump){
	
	if((pathfinder.grid[current_node[0], current_node[1]+1] == 0 && on_ground == true)
	   || (pathfinder.grid[current_node[0], current_node[1]+1] == 1)){
		prev_node = current_node;
		current_node = path[|current_index];
		current_index--;
		
		if(is_undefined(current_node)) {
			current_node = ""; 
			current_index = -1; 
			prev_node = ""; 
			next_node = ""; 
			ds_list_clear(path); 
			path_updated = false;
			exit; 
		}
		
		next_node = path[|current_index];
		
		if(!is_undefined(next_node)){
			//get direction from current node to next. 
			direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
			//normalize.
			direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
		}
	}
}

//prevent us from trying to use a null node for movement.
if(current_node == "" || !!is_undefined(current_node)) exit;

//INPUT
	var is_wall_jump = scr_pathfinder_is_wall_jump(pathfinder, current_node[0], current_node[1]);
	if( is_wall_jump != 0 && curr_chunk_x == current_node[0] && curr_chunk_y == current_node[1]){
		wait_for_wall_jump = true;
	}

	//simulate horizontal input.
	else if((is_wall_jump == 2 && wait_for_wall_jump) || current_node[0] > curr_chunk_x)		{direction_horizontal =  1;}
	else if((is_wall_jump == 1 && wait_for_wall_jump) || current_node[0] < curr_chunk_x)		{direction_horizontal = -1;}
	else																						{direction_horizontal =  0;}

	//simulate vertical input.
	if(current_node[1] < curr_chunk_y)		{up = 1; up_released = 0; up_held = 1;}
	else									{up = 0; up_held = 0; up_released = 1;}
	
	//if next node is above the current and current is mid air.
	if(!is_undefined(next_node) && next_node[1] < current_node[1] && pathfinder.grid[current_node[0], current_node[1]+1] == 1){
		up = 1; up_released = 0; up_held = 1;
	}
	//if next node is equal to the current and the current is in mid air.
	else if(!is_undefined(next_node) && next_node[1] == current_node[1] && pathfinder.grid[current_node[0], current_node[1]+1] == 1){
		up = 1; up_released = 0; up_held = 1; 
	}
	
	if(is_wall_jump == 1 && place_meeting(x-1, y, obj_solid)) wait_for_wall_jump = false;
	if(is_wall_jump == 2 && place_meeting(x+1, y, obj_solid)) wait_for_wall_jump = false;
	
	script_execute(scr_render, obj_solid, scr_enemy_accel, scr_enemy_velo_mod, scr_enemy_state, "");

if(place_meeting(x,y, obj_death)){
	

	ds_list_clear(path);
	script_execute(scr_reset_room); 
}

	


	
	