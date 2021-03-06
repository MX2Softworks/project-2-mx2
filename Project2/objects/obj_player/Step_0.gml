/// Executed each timestep.

if(keyboard_check_pressed(vk_tab)){
	if(room == rm_1_1)	room_goto(rm_1_2);
	else room_goto(rm_1_1);
}

// Move the player out of any walls, if they are stuck in them.
scr_fix_spawn(obj_solid);

// Get the keyboard or gamepad input.
scr_get_input();

// Call the render script for the player.
script_execute(scr_render, obj_solid, scr_player_accel, scr_player_velo_mod, scr_player_state, scr_player_anim);

if(place_meeting(x,y, obj_death)){

	script_execute(scr_reset_room); 
}

if(keyboard_check_pressed(vk_f1)){
	fullscreen = !fullscreen;
	window_set_fullscreen(fullscreen);
}

if(on_ground){
	last_on_ground = [x,y];
}