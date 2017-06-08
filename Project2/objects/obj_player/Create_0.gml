/// @description  Initialize the player

// Movement variables
	previous_hspd = 0;
    current_hspd = 0;
	previous_vspd = 0;
    current_vspd = 0;
	previous_x = x;
	current_x = x;
	previous_y = y;
	current_y = y;
	previous_xacc = 0;
    current_xacc = 0;
	previous_yacc = 1200;
    current_yacc = 1200;
	
	collision_x = false;
	collision_y = false;
	
	on_ground = true;
	jump_hold_stop = false;
	
    maxspd = 8;
    minspd = 0;
    jumpheight = 8;
    jumppeak = 0;
    hspd_platform = 0;
    vspd_platform = 0; 
    xrem = 0;
    yrem = 0;
    is_sliding = 0;
    is_rolling = 0;
	
// Timestep
	accumulator = 0;

// Wall Jumping
    wall_slide = false;  
    start_slide = false;
    wall_jump = false;   
    wall_jump_counter = 0;
    wall_jump_counter_max = 7;
    wall_push = false;
    push_frames = 0;
    
// Dash variables
    dash_count = 0;
    can_dash = false;
    dash_speed = 30;
    dash_frames_v = 0;
    dash_frames_h = 0;
    float_frames = 0;
    fall_frames = 0;
    v_float = false;
    h_float_left = false;
    h_float_right = false;
    switch_left = false;
    switch_right = false;
    switch_up = false;
    can_float = false;
    dashed = false;
    dash_held_frames = 0;
    dash_distance_mod = 0;
    dash_charge_mode = false;
    dash_activate = false;
    dashing = false;

// Input variables
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
    
    sprint = false;
    dash = false;
    dash_held = false;
    dash_released = false;
    charge_dash = false;
    charge_dash_held = false;
    charge_dash_released = false;
    
    direction_horizontal = 0;
    direction_vertical = 0; 
    
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
    
// Controller only variables
    gp_id = 0;
    threshold = .5;
    threshold_diag = 1.05;
    controller_alarm = 1;
    magnitude = 0;
    x_axis = 0;
    y_axis = 0;   
    
// Hub world
    pickup_item = false;
    open_door = false;

// Create the audio emitter
    audio_em = audio_emitter_create();
    
scr_fix_spawn(obj_all);

///Pause related variables
speed_before_pause = 0;


