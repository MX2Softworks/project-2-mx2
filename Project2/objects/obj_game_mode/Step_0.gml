/// @description Check Paused

// Override the controls for a gamepad
gp_id = 0;
threshold = .5;

//Switch 
if(keyboard_check_pressed(vk_escape) || (gamepad_is_connected(gp_id) && gamepad_button_check_pressed(gp_id, gp_start))){
    
    global.pauseActive = !global.pauseActive;     
}

if(global.pauseActive){
    if(!instance_exists(obj_pause_menu)){
        instance_create(0, 0, obj_pause_menu); 
        audio_pause_all();
    } 
}
else{
    if(instance_exists(obj_pause_menu)){
        with(obj_pause_menu){
            instance_destroy(); 
        }
        audio_resume_all();
    }
    if (global.resume_frames > 0) {
        global.resume_frames--;
    }
}


