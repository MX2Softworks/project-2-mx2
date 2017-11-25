// Move the player out of all objects, if any, when they are spawned.
scr_fix_spawn(obj_all);

// General initialization.
script_execute(scr_general_init);

// Pathfinding
	wait_for_wall_jump = false;
	prev_node_wall_jump = false;
	direction_to_next = [0,0];
	current_index = -1;
	current_node = "";
	next_node = "";
	prev_node = "";
	path = ds_list_create();
	path_updated = false;
	//create a pathfinder object for itself.
	pathfinder = instance_create_depth(self.x, self.y, self.depth, obj_pathfinder)
	var agent_id = id;
	with(pathfinder){
		self.my_agent = agent_id;
		self.max_character_jump_height = self.character_height * 2;
	}
	curr_chunk_x = floor(x/pathfinder.chunk_size);
	curr_chunk_y = floor(y/pathfinder.chunk_size);

// Movement Parameters.
	max_speed = 500;
	//sprint_mod = 1.75;

// Movement.
	jump_hold_stop = false;
	//fast_fall = false;
    wall_slide = false; 
    start_slide = true;
    jumppeak = false;
	wall_grab = false;
	wall_push = false;
	sliding = false;
	rolling = false;
    wall_jump = false; 
	slowing = false;
    dashing = false;
	dash_init_hspd = false;
	dash_init_vspd = false;
	dash_up = false;
	dash_right = false;
	dash_left = false;
    dash_count = 0;
	charging = false;
	charge_time = 0;
	charge_power = 0;
	charge_start_time = 0;
	charge_slow = 20;
	sprinting = false;

// Input variables
    direction_horizontal = 0;
    direction_vertical = 0;
    right = false;
    right_held = false;
    right_released = false;
    left = false;
    left_held = false;
    left_released = false;
    up = false; 
    up_held = false;
    up_released = false;
    stick_up_held = false;
    stick_up = false;
    stick_up_released = false;
    down = false;
    down_held = false;
    down_released = false;
/*  dash = false;
    dash_held = false;
    dash_released = false;
    charge_dash = false;
    charge_dash_held = false;
    charge_dash_released = false; 
    sprint = false;
	grab = false; */
    diag_ul = false;
    diag_ul_held = false;
    diag_ul_released = false;
    diag_ur = false;
    diag_ur_held = false;
    diag_ur_released = false;
    diag_dl = false;
    diag_dl_held = false;
    diag_dl_released = false;
    diag_dr = false;
    diag_dr_held = false;
    diag_dr_released = false;
// Controller only input variables.
    gp_id = 0;
    threshold = .5;
    threshold_diag = 1.05;
    controller_alarm = 1;
    magnitude = 0;
    x_axis = 0;
    y_axis = 0;
	
