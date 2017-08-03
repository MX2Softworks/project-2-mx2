// Executed each timestep.

// Move the player out of any walls, if they are stuck in them.
scr_fix_spawn(obj_solid);

// Get the keyboard or gamepad input.
scr_get_input();

// Call the render script for the player.
script_execute(scr_render, obj_solid, scr_player_accel, scr_player_velo_mod, scr_player_state, scr_player_anim);


///// Sound Effects

////Jump
//if((up && place_meeting(x, y+10, obj_solid) && vspd < 0) 
//   || (up && wall_jump && wall_jump_counter < wall_jump_counter_max)
//  ){
//    audio_emitter_gain(audio_em, 1);
//    audio_play_sound_on(audio_em, snd_jump_0, false, 10);
//}

////Slide
//if(((sprite_index == spr_player_wall_slide && image_index > 1) || (sprite_index == spr_player_slide && image_index > 1)) && !audio_is_playing(snd_slide)){
//    audio_emitter_gain(audio_em, .06);
//    audio_play_sound_on(audio_em, snd_slide, false, 10);
//}
//else if(sprite_index != spr_player_wall_slide && sprite_index != spr_player_slide && audio_is_playing(snd_slide)){
//    audio_stop_sound(snd_slide); 
//}




