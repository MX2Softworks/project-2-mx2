/// Executed each timestep.

// Move the player out of any walls, if they are stuck in them.
scr_fix_spawn(obj_solid);

// Get the keyboard or gamepad input.
scr_get_input();

// Call the render script for the player.
script_execute(scr_render, obj_solid, scr_player_accel, scr_player_velo_mod, scr_player_state, scr_player_anim);
