/// @description If Game is Paused
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    speed = 0; 
    exit;  
}
else{
    speed = 5;
    scr_projectile(); 
}


