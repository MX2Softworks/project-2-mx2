/// @function  scr_move_new
/// @param collision_object

// Called at the beginning of the step.
// Uses velocities and accelerations calculated from the prior step.
// Calculates the new position and checks for collisions.


var collision_object = argument0;

// Assume current speeds and accelerations are set from last step.
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
	if ((abs(movedis_x)-abs(increment)) < (floor(mask_width / 2))) {
		// Can check the full distance.
		increment = movedis_x;
	} else {
		// Use floor in case of an odd sprite width to avoid missing a pixel.
		// Ex: 1.5 -> 1 -> 3 skipping 2.
		increment += (floor(mask_width / 2)) * sign(movedis_x);
	}
	if (place_meeting(previous_x+increment, previous_y, obj_solid)) {
		// If the path is not free, walk the increment back until it is.
		while (place_meeting(previous_x+increment, previous_y, obj_solid)) {
			increment = increment - sign(increment);
		}
		// Moving by increment will no longer collide. Set new movedis_x.
		movedis_x = increment;
	}
	// else path is still free check further.
}
// movedis_x now has the full distance you can travel stored in it.
current_x = previous_x + movedis_x;

// IMPORTANT:	DO ALL Y CHECKS AT THE NEW X POSITION!!!
//				THINK OF WHAT TO DO WITH REMAINDERS!!!
//				THINK OF HOW TO TREAT DIAGONAL COLLISIONS!!!


var mask_height = sprite_get_bbox_top(sprite_index) - sprite_get_bbox_bottom(sprite_index);