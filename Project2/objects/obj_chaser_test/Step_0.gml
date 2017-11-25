scr_fix_spawn(obj_solid);

//calculate current chunk.
curr_chunk_x = floor((x+(sprite_width/2))/pathfinder.chunk_size);
curr_chunk_y = floor((y+sprite_height-1)/pathfinder.chunk_size);

//if we finished a search, reset path.
if(timer > 1.5 && on_ground){
	timer = 0;
	ds_list_clear(pathfinder.closed_list);
	pathfinder.found = false;
	pathfinder.stopped = false;
	pathfinder.stop = false;
	current_node = ""; 
	current_index = -1; 
	prev_node = ""; 
	next_node = "";	
	ds_list_clear(path); 
	path_updated = true;
	pathfinder.find_path = true;
}


if(pathfinder.found == true && path_updated = true){
	path_updated = false;
	ds_list_clear(path);
	ds_list_copy(path, pathfinder.closed_list);
	current_node = "";
	next_node = "";
	prev_node = "";
	current_index = ds_list_size(path) - 1;
}

//if we've reached a node later along our path before we are supposed to.
for(var j = current_index; j > 0; j--){
	var temp_node = path[|0];
	if(scr_pathfinder_is_on_ground(pathfinder, temp_node[0], temp_node[1])
	  && curr_chunk_x == temp_node[0] && curr_chunk_y == temp_node[1] && on_ground){
		  
		current_index = j;
		prev_node = path[|j+1];
		current_node = path[|j];
		current_index--;
		next_node = path[|j]
		
	}
	
}

//if we have a path,but no destination, set one.
if(current_node == "" && ds_list_size(path) > 0){

	current_node = path[|current_index];
	current_index--;
	next_node = path[|current_index];
	
	if(!is_undefined(next_node)){
		//get direction from current node to next. 
		direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
		//normalize.
		direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
		}
}

//if we overshoot a node, but the next node is on the ground and we have reached the next node, then take it.
if(!is_undefined(current_node) && current_node != "" && !is_undefined(next_node) && next_node != ""){

	if(scr_pathfinder_is_on_ground(pathfinder, next_node[0], next_node[1])
	   && curr_chunk_y <= next_node[1] && on_ground == true){
			prev_node = current_node;
			current_node = path[|current_index];
			current_index--;
			next_node = path[|current_index];
			if(!is_undefined(next_node)){
				//get direction from current node to next. 
				direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
				//normalize.
				direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
			}
	   }
}

//once we reach the current node, set the new current node to next node in path.
if(!is_undefined(current_node) && current_node != "" 
   && curr_chunk_x == current_node[0] && curr_chunk_y == current_node[1] && ds_list_size(path) > 0
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
			path_updated = false;
			ds_list_clear(pathfinder.closed_list);
			ds_list_clear(path);
			timer += global.frame_time;
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

/*if(!is_undefined(current_node) && current_node != "" && jumppeak && curr_chunk_x == current_node[0] && curr_chunk_y > current_node[1]){
	current_node = ""; 
	current_index = -1; 
	prev_node = ""; 
	next_node = "";
	path_updated = false;
	ds_list_clear(pathfinder.closed_list);
	ds_list_clear(path); 
	exit; 
}*/

//prevent us from trying to use a null node for movement.
if(current_node == "" || is_undefined(current_node)) {
	previous_xacc = 0;
	current_xacc  = 0;
	previous_hsp  = 0;
	current_hspd  = 0;
	direction_horizontal = 0;
	x_rem = 0;
	script_execute(scr_render, obj_solid, scr_enemy_accel, scr_enemy_velo_mod, scr_enemy_state, "");	
	timer += global.frame_time;
	exit;
}

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

//if our path upwards causes a collision.
if(!is_undefined(current_node) && current_node != "" && current_node[1] < curr_chunk_y && current_node[0] == curr_chunk_x
  && place_meeting(x, y-30, obj_solid)){
	
	
	if(!place_meeting(x+(sprite_width/2), y-30, obj_solid)){
		direction_horizontal = -1;
	}
	if(!place_meeting(x-(sprite_width/2), y-30, obj_solid)){
		direction_horizontal = 1;
	}
	if(!place_meeting(x+(sprite_width), y-30, obj_solid)){
		direction_horizontal = -1;
	}
	if(!place_meeting(x-(sprite_width), y-30, obj_solid)){
		direction_horizontal = 1;
	}
	if(!place_meeting(x+(sprite_width*2), y-30, obj_solid)){
		direction_horizontal = -1;
	}
	if(!place_meeting(x-(sprite_width*2), y-30, obj_solid)){
		direction_horizontal = 1;
	}
}

if(is_wall_jump == 1 && place_meeting(x-1, y, obj_solid)) wait_for_wall_jump = false;
if(is_wall_jump == 2 && place_meeting(x+1, y, obj_solid)) wait_for_wall_jump = false;
	
script_execute(scr_render, obj_solid, scr_enemy_accel, scr_enemy_velo_mod, scr_enemy_state, "");	

if(place_meeting(x,y, obj_death)){
	

	ds_list_clear(path);
	script_execute(scr_reset_room); 
}

	
timer += global.frame_time;

	
	