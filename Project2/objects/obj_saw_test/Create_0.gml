/// @description If Game is Paused

//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}


/// Initialize the Saw

hspd = 0;
vspd = 0;
maxspd = 2;
image_angle = 0;
image_rotation = 6;

state = choose(scr_saw_move_right_state, scr_saw_move_left_state);

scr_fix_spawn(obj_all);

