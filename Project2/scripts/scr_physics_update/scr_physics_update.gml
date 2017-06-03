/// @description Update the physics of an object over 1/60 of a second.
/// @param {obj} collision The object you are checking collisions against.
/// @param {str} scr_accel The script name of the acceleration update for the current object.

// Uses velocities and accelerations calculated from the prior update.

var collision = argument0;
var scr_accel = argument1;

// First calculate the new position and check for collisions.

	// Assume current speeds and accelerations are set from last update.
	// Set the new previous positions to our current position before moving.
	previous_x = current_x;
	previous_y = current_y;

	// Using the passed velocities and accelerations calculate our next position.
	current_x = previous_x + current_hspd * global.dt + (1/2) * previous_xacc * global.dt * global.dt;
	current_y = previous_y + current_vspd * global.dt + (1/2) * previous_yacc * global.dt * global.dt;

	// Now that we have our next position, do collision detection.
	// Horizontal Collisions
	var movedis_x = current_x-previous_x;
	// Save remainder to avoid decimal imprecision.
	if (sign(movedis_x) == 1) {
		xrem = movedis_x - floor(movedis_x);
		movedis_x = floor(movedis_x);
	} else {
		xrem = movedis_x - ceil(movedis_x);
		movedis_x = ceil(movedis_x);
	}
	var increment = 0;
	var mask_width = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index);
	while (abs(increment) < abs(movedis_x)) {
		// Check to see if less than half of the sprite is left to check.
		if ((abs(movedis_x)-abs(increment)) < mask_width) {
			// Can check the full distance.
			increment = movedis_x;
		} else {
			increment += mask_width * sign(movedis_x);
		}
		if (place_meeting(previous_x+increment, previous_y, collision)) {
			// If the path is not free, walk the increment back until it is.
			while (place_meeting(previous_x+increment, previous_y, collision)) {
				increment = increment - sign(increment);
			}
			// Moving by increment will no longer collide. Set new movedis_x.
			movedis_x = increment;
		}
		// else path is still free check further.
	}
	// movedis_x now has the full distance you can travel stored in it.
	current_x = previous_x + movedis_x;

	// Vertical Collisions
	var movedis_y = current_y-previous_y;
	// Save remainder to avoid decimal imprecision.
	if (sign(movedis_y) == 1) {
		yrem = movedis_y - floor(movedis_y);
		movedis_y = floor(movedis_y);
	} else {
		yrem = movedis_y - ceil(movedis_y);
		movedis_y = ceil(movedis_y);
	}
	increment = 0;
	var mask_height = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index);
	while (abs(increment) < abs(movedis_y)) {
		// Check to see if less than half of the sprite is left to check.
		if ((abs(movedis_y)-abs(increment)) < mask_height) {
			// Can check the full distance.
			increment = movedis_y;
		} else {
			increment += mask_height * sign(movedis_y);
		}
		if (place_meeting(current_x, previous_y+increment, collision)) {
			// If the path is not free, walk the increment back until it is.
			while (place_meeting(current_x, previous_y+increment, collision)) {
				increment = increment - sign(increment);
			}
			// Moving by increment will no longer collide. Set new movedis_y.
			movedis_y = increment;
		}
		// else path is still free check further.
	}
	// movedis_y now has the full distance you can travel stored in it.
	current_y = previous_y + movedis_y;

	// Check if we are colliding at our new position.
	if (place_meeting(current_x+sign(movedis_x), current_y, collision)) {
		collision_x = true;
	} else {
		collision_x = false;
	}
	if (place_meeting(current_x, current_y+sign(movedis_y), collision)) {
		collision_y = true;
	} else {
		collision_y = false;
	}


// Calculate the new accelerations.
// Will be used to calculate position next update.
	script_execute(scr_accel);


// Using the new acceleration, calculate the current speed.
// Will be used to calculate position next update.
	current_hspd = current_hspd + (current_xacc + previous_xacc) / 2 * global.dt;
	current_vspd = current_vspd + (current_yacc + previous_yacc) / 2 * global.dt;


// Set previous acceleration to current acceleration.
	previous_xacc = current_xacc;
	previous_yacc = current_yacc;