scr_fix_spawn(obj_solid);

prev_horizontal = direction_horizontal;

if(place_meeting(x,y, obj_death)){
	

	ds_list_clear(path);
	script_execute(scr_reset_room); 
}


//calculate current chunk.
curr_chunk_x = round((x)/pathfinder.chunk_size);
curr_chunk_y = round((y)/pathfinder.chunk_size);

//if we finished a search, reset path.
if(timer > 1 && on_ground){
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

//set the path for the agent to follow.
if(pathfinder.found == true && path_updated = true){
	path_updated = false;
	ds_list_clear(path);
	ds_list_copy(path, pathfinder.closed_list);
	current_node = "";
	next_node = "";
	prev_node = "";
	current_index = ds_list_size(path);
}

//if we've reached a node later along our path before we are supposed to.
/*
for(var j = current_index+1; j > 0; j--){
	var temp_node = path[|0];
	if(scr_pathfinder_is_on_ground(pathfinder, temp_node[0], temp_node[1])
	  && curr_chunk_x == temp_node[0] && curr_chunk_y == temp_node[1]){
		
		current_index = j;
		prev_node = path[|j+1];
		current_node = path[|j];
		next_node = path[|j - 1]
		
	}
	
}*/

//if we have a path,but no destination, set one.
if(current_node == "" && ds_list_size(path) > 0){

	//check to make sure destination is not in mid-air. Should prevent agent suicide. 
	var j =  0;
	var temp_node = path[|j];
	while(j < ds_list_size(path) && scr_pathfinder_is_on_ground(pathfinder, temp_node[0], temp_node[1]) == false){
		ds_list_delete(path, j);
		j++;
	}
	current_index--;
	current_node = path[|current_index];
	next_node = path[|current_index -1];
	
	if(!is_undefined(next_node) && !is_undefined(current_node)){
		//get direction from current node to next. 
		direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
		//normalize.
		direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
		}
}

/*
//if we overshoot a node, but the next node is on the ground and we have reached the next node, then take it.
if(!is_undefined(current_node) && current_node != "" && !is_undefined(next_node) && next_node != ""){

	if(scr_pathfinder_is_on_ground(pathfinder, next_node[0], next_node[1])
	   && curr_chunk_y == next_node[1] && on_ground == true){
			prev_node = current_node;
			current_index--;
			current_node = path[|current_index];
			next_node = path[|current_index - 1];
			if(!is_undefined(next_node)){
				//get direction from current node to next. 
				direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
				//normalize.
				direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
			}
	   }
}*/

if(current_index == 4){
	break_point = true;
}

//if the node requires a wall jump, make contact with the wall.
if(!is_undefined(current_node) && current_node != ""){
	var is_wall_jump = scr_pathfinder_is_wall_jump(pathfinder, current_node[0], current_node[1]);
	
	if(is_wall_jump != 0){
		break_point = true;
	}
	
	//if the node is a wall jump and the agent has collided or wall jumped, then don't wait.
	if((is_wall_jump == 0 || curr_chunk_x != current_node[0] || curr_chunk_y != current_node[1] 
	   || (is_wall_jump == 1 && place_meeting(x-1, y, obj_solid)) 
	   || (is_wall_jump == 2 && place_meeting(x+1, y, obj_solid)) || wall_jump )){
		wait_for_wall_jump = false;
	}
	//if the node is a wall jump, the agent is there, and the agent hasn't wall jumped yet, then wait.
	else if( is_wall_jump != 0 && curr_chunk_x == current_node[0] && curr_chunk_y == current_node[1] && !wall_jump){
		wait_for_wall_jump = true;
	}
	//if the next node is below (i.e. we are moving downwards, then don't wait.
	if(!is_undefined(next_node) && next_node != "" 
	&& is_wall_jump && next_node[1] > current_node[1]){
		wait_for_wall_jump = false;
	}

}

//once we reach the current node, set the new current node to next node in path.
if(!is_undefined(current_node) && current_node != "" 
   && curr_chunk_x == current_node[0] && curr_chunk_y == current_node[1] && ds_list_size(path) > 0
   && !wait_for_wall_jump){
	
	//if((pathfinder.grid[current_node[0], current_node[1]+1] == 0 && on_ground == true)
	//   || (pathfinder.grid[current_node[0], current_node[1]+1] == 1)){
		prev_node = current_node;
		current_index--;
		current_node = path[|current_index];
		
		
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
		
		next_node = path[|current_index - 1];
		
		if(!is_undefined(next_node)){
			//get direction from current node to next. 
			direction_to_next = [next_node[0] - current_node[0], next_node[1] - current_node[1]];
	
			//normalize.
			direction_to_next = [direction_to_next[0]/abs(direction_to_next[0]), direction_to_next[1]/abs(direction_to_next[1])]
		}
	//}
}

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


//if this node and the next are wall jumps, then hold for the wall jump.
if(is_wall_jump && !is_undefined(next_node) && next_node[1] < current_node[1] && next_node[0] == current_node[0]
   && scr_pathfinder_is_wall_jump(pathfinder, next_node[0], next_node[1]) && !on_ground 
   && wall_jump){
	if(is_wall_jump == 1)	direction_horizontal = -1;
	else					direction_horizontal = +1;
}
else if((is_wall_jump == 2 && wait_for_wall_jump) || current_node[0]/*+current_hspd*/ > curr_chunk_x){
			direction_horizontal =  1;
		}
else if((is_wall_jump == 1 && wait_for_wall_jump) || current_node[0]/*+current_hspd*/ < curr_chunk_x){
			direction_horizontal = -1;
		}
else if(curr_chunk_x == current_node[0]){ direction_horizontal =  0;}

//simulate vertical input.
if(current_node[1] < curr_chunk_y)		{
	up = 1; up_released = 0; up_held = 1;
}
else									{
	up = 0; up_held = 0; up_released = 1;
}

//if a node is in the same x chunk as the agent, but is not on ground
// and the agent is still on ground, move the agent in the direction of the chunk.
if(current_node[0] == curr_chunk_x 
   && !scr_pathfinder_is_on_ground(pathfinder, current_node[0], current_node[1])
   && on_ground){
	direction_horizontal = prev_horizontal;
	if(direction_horizontal == 0){
	
		if(place_meeting(x+sprite_width, y+(sprite_height/2), obj_solid)){
			direction_horizontal = +1;
		}
		if(place_meeting(x-sprite_width, y+(sprite_height/2), obj_solid)){
			direction_horizontal = -1;
		}
	}
}
/*
//if next node is above the current and current is mid air.
if(!is_undefined(next_node) && next_node[1] < current_node[1] 
&& !scr_pathfinder_is_on_ground(pathfinder, current_node[0], current_node[1])
&& !scr_pathfinder_is_wall_jump(pathfinder, current_node[0], current_node[1])
&& !scr_pathfinder_is_wall_jump(pathfinder, next_node[0], next_node[1])){
	up = 1; up_released = 0; up_held = 1;
}

//if next node is equal to the current and the current is in mid air.
else*/ if(!is_undefined(next_node) && next_node[1] == current_node[1] 
     && !scr_pathfinder_is_on_ground(pathfinder, current_node[0], current_node[1])){
	up = 1; up_released = 0; up_held = 1; 
}

//if the next node is on the ground, and the current is in mid-air;
if(!is_undefined(next_node) && scr_pathfinder_is_on_ground(pathfinder, next_node[0], next_node[1])
   && !scr_pathfinder_is_on_ground(pathfinder, current_node[0], current_node[1])
   && !scr_pathfinder_is_wall_jump(pathfinder, current_node[0], current_node[1])
   && curr_chunk_y <= current_node[1]){

	if(next_node[0] > current_node[0]){
	
		direction_horizontal = 1;
	}
	if(next_node[0] < current_node[0]){
		direction_horizontal = -1;
	}
	
	prev_node = current_node;
	current_index--;
	current_node = path[|current_index];
	next_node = path[|current_index - 1];
}

//if our path upwards causes a collision.
if(!is_undefined(current_node) && current_node != "" && current_node[1] < curr_chunk_y && current_node[0] == curr_chunk_x
  && place_meeting(x, y-30, obj_solid)){
	
	if(!place_meeting(x+(sprite_width/2), y-30, obj_solid) 
	|| !place_meeting(x+(sprite_width), y-30, obj_solid) 
	|| !place_meeting(x+(sprite_width*2), y-30, obj_solid)){
		direction_horizontal = +1;
	}
	if(!place_meeting(x-(sprite_width/2), y-30, obj_solid) 
	  || !place_meeting(x-(sprite_width), y-30, obj_solid)
	  || !place_meeting(x-(sprite_width*2), y-30, obj_solid)){
		direction_horizontal = -1;
	}
}

//if the current_node is directly below us and we are in the same x:
//check the block below us to the left and right, if one is empty, fall
//and land on the current.
if(!is_undefined(current_node) && current_node[0] == curr_chunk_x && curr_chunk_y < current_node[1]
   && on_ground){
	
	if(!place_meeting(x+(sprite_width/2), y+30, obj_solid) 
	|| !place_meeting(x+(sprite_width), y+30, obj_solid) 
	|| !place_meeting(x+(sprite_width*2), y+30, obj_solid)){
		direction_horizontal = +1;
	}
	if(!place_meeting(x-(sprite_width/2), y+30, obj_solid) 
	  || !place_meeting(x-(sprite_width), y+30, obj_solid)
	  || !place_meeting(x-(sprite_width*2), y+30, obj_solid)){
		direction_horizontal = -1;
	}
}

//if a node is out of reach, don't bother jumping. 
if(current_node[1] < curr_chunk_y - (pathfinder.max_character_jump_height * pathfinder.speed_factor)){
	//node is out of our reach. 
	up = false;
	up_held = false;
	up_release = false;
}

script_execute(scr_render, obj_solid, scr_enemy_accel, scr_enemy_velo_mod, scr_enemy_state, "");	
	
timer += global.frame_time;

	
	