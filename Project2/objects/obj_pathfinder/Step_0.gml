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


//Regenerates the graph the chunk size changes. 
if(regen_graph || global.re_grid){
	
	regen_graph = false;
	
	scr_pathfinder_init(300, false);
}

//check the player's current location to see if we should restart our search or continue a previous one.
	
if(obj_player && (search_counter > 10 || search_counter == 0)){
	end_x = floor(obj_player.x / chunk_size);
	end_y = floor(obj_player.y / chunk_size); 
}	

//start a search if we press U or if a previous search from last frame is going. 
if(keyboard_check_pressed(ord("U")) || !((found && stopped) || (!found && !stopped) || search_counter > 10)){
	
	scr_pathfinder_find_path(floor(x/chunk_size), floor(y/chunk_size), end_x, end_y, true, true);
}

