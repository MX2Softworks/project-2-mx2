/// @description Update the physics of an object over 1/60 of a second.
/// @param {obj} collision The object you are checking collisions against.
/// @param {str} scr_accel The script name of the acceleration update for the current object.
/// @param {str} scr_velo_mod The script name of the optional script to modify the velocity after verlet.
/// @param {str} scr_state The script name of the state update code.

// Uses velocities and accelerations calculated from the prior update.

var collision = argument0;
var scr_accel = argument1;
var scr_velo_mod = argument2;
var scr_state = argument3;

// First calculate the new position and check for collisions.

	// Assume current speeds and accelerations are set from last update.
	// Set the new previous positions to our current position before moving.
	previous_x = current_x;
	previous_y = current_y;

	// Using the passed velocities and accelerations calculate our next position.
	current_x = previous_x + current_hspd * global.dt + (1/2) * previous_xacc * global.dt * global.dt;
	current_y = previous_y + current_vspd * global.dt + (1/2) * previous_yacc * global.dt * global.dt;

	// Now that we have our next position, do collision detection.
	script_execute(scr_collision_detection, collision);
	
	// Also update whether our new position is on the ground or not.
	script_execute(scr_on_ground_check, current_x, current_y);

// REMEMBER TO CLEAR REMAINDERS!!!!!!!!

// Calculate the new accelerations.
// Will be used to calculate position next update.
	script_execute(scr_accel);


// Using the new acceleration, calculate the current speed.
// Will be used to calculate position next update.
	previous_hspd = current_hspd;
	previous_vspd = current_vspd;
	
	current_hspd = previous_hspd + (current_xacc + previous_xacc) / 2 * global.dt;
	current_vspd = previous_vspd + (current_yacc + previous_yacc) / 2 * global.dt;
	
	script_execute(scr_velo_mod);


// Update our state variables.
	script_execute(scr_state);


// Set previous acceleration to current acceleration.
	previous_xacc = current_xacc;
	previous_yacc = current_yacc;