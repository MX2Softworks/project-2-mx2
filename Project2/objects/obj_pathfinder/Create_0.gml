my_agent = ""
selected = false;
debug_toggle = false;

//assume default values if no agent claims the pathfinder
if(my_agent == ""){
	chunk_size = 32;
	character_height = floor( 32/ chunk_size);
	max_character_jump_height = character_height * 2;
	gravity_threshold = 6; //used in the pathfinding algorithm to simulate the effects of gravity on jump_length
	speed_factor = 3; //a greater speed factor allows the algorithm to jump further 

}
else{
	
	//initialize values according to the agent's values. 
	// @debug: currently, we will use the same values. 
	chunk_size = 32;
	character_height = floor( 32/ chunk_size);
	max_character_jump_height = character_height * 2;
	gravity_threshold = 6; //used in the pathfinding algorithm to simulate the effects of gravity on jump_length
	speed_factor = 3; //a greater speed factor allows the algorithm to jump further 
}

self.depth = 1;
scr_pathfinder_init(300, false);