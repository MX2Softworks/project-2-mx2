/// @description If Game is Paused

//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}


/// Execute the enemy pathfinder script

script_execute(scr_enemy_pathfinder);
