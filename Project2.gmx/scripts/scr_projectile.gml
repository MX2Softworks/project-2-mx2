///If Game is Paused
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    audio_play_sound(snd_collision, 0, 0); 
    exit;  
}
else if(!thrown)
{   
    move_towards_point(obj_player.x, obj_player.y, speed);
    
    thrown = 1;
}
