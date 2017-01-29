/// scr_load_objects();

// Initialize objects if they don't exist
    if(!instance_exists(obj_delta_tracker)){
        instance_create(0, 0, obj_delta_tracker);
    }
    
    if(!instance_exists(obj_debugtext)){
        instance_create(0, 0, obj_debugtext);
    }
    
    if(!instance_exists(obj_game_mode)){
        instance_create(0, 0, obj_game_mode); 
    }
    
    if (!instance_exists(obj_sound_player)) {
        instance_create(0, 0, obj_sound_player);
    }
    
    if (!instance_exists(obj_dynamic_camera)) {
        instance_create(0, 0, obj_dynamic_camera);
    }
