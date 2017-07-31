/// @description Update the object's position in the room.
/// @param {obj} collision The object you are checking collisions against.
/// @param {str} scr_accel The script name of the acceleration update for the current object.
/// @param {str} scr_velo_mod The script name of the optional script to modify the velocity after verlet.

var collision = argument0;
var scr_accel = argument1;
var scr_velo_mod = argument2;

// Add delta time to the accumulator.
	if (charging) {
		accumulator += global.frame_time / 10;
	} else {
		accumulator += global.frame_time;
	}
	
// Update physics potentially multiple times to keep up to date.
	while (accumulator >= global.dt) {
		scr_physics_update(collision, scr_accel, scr_velo_mod);
		
		accumulator -= global.dt;
	}
	
// Calculate interpolation value based on the leftover time in accumulator.
	var interp_alpha = accumulator / global.dt;
	
// Update position of the object in the room.
	x = lerp(previous_x, current_x, interp_alpha);
	y = lerp(previous_y, current_y, interp_alpha);


// FOR TESTING
	if (keyboard_check(ord("R"))) {
		current_x = room_start_x;
		previous_x = room_start_x;
		current_y = room_start_y;
		previous_y = room_start_y;
	}