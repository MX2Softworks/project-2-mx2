/// @description Initialize variables.

//Pause Options

    //menu_options determines which nested layer the player is in. 
    enum menu_options{
        pause_menu,
        options_menu,
        quit_menu 
    };
    
    //First layer: pause
    enum pause_options{
        continue_game,
        options_game,
        quit_game 
    }; 
    
    //Second layer: options
    enum options_options{
        fullscreen,
        vsync, 
        debug
    }; 
    
    //Third layer: quit
    enum quit_options{
        yes,
        no
    }; 
    
// Display variables    
    wind_w = window_get_width()/2;
    wind_h = window_get_height()/3;

    string_w = string_width(string_hash_to_newline("Game Paused"))/2; 
    string_h = string_height(string_hash_to_newline("Game Paused"))/2;
    
// Navigation variables    
    menu = menu_options.pause_menu;
    cursor = pause_options.continue_game; 

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

// Create the audio emitter
    audio_em = audio_emitter_create();

