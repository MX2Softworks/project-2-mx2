/// @description If Game is Paused

//Pause if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    exit;  
}


/// Destroy if the fireball leaves the room
instance_destroy();

