selected = false;
debug_toggle = false;
chunk_size = 32;
character_height = floor( 32/ chunk_size);
max_character_jump_height = character_height * 3;
gravity_threshold = 6; //used in the pathfinding algorithm to simulate the effects of gravity on jump_length
speed_factor = 3; //a greater speed factor allows the algorithm to jump further 

self.depth = 1;
scr_pathfinder_init(300, false);