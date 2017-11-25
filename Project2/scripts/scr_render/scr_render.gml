/// @description Update the object's position in the room.
/// @param {obj} collision The object you are checking collisions against.
/// @param {str} scr_accel The script name of the acceleration update for the current object.
/// @param {str} scr_velo_mod The script name of the optional script to modify the velocity after verlet.
/// @param {str} scr_state The script name of the state update code.
/// @param {str} scr_anim The script name of the code controlling this object's animations.

var collision = argument0;
var scr_accel = argument1;
var scr_velo_mod = argument2;
var scr_state = argument3;
var scr_anim = argument4;

// Add delta time to the accumulator.
	if (charging) {
		accumulator += global.frame_time / charge_slow;
	} else {
		accumulator += global.frame_time;
	}
	
// Update physics potentially multiple times to keep up to date.
	while (accumulator >= global.dt) {
		scr_physics_update(collision, scr_accel, scr_velo_mod, scr_state);
		if(scr_anim != "")	script_execute(scr_anim);
		script_execute(scr_reset_input);
		
		accumulator -= global.dt;
	}
	
// Calculate interpolation value based on the leftover time in accumulator.
	var interp_alpha = accumulator / global.dt;
	
// Update position of the object in the room.
	x = lerp(previous_x, current_x, interp_alpha);
	y = lerp(previous_y, current_y, interp_alpha);

