/// @description Checks to see if the object is currently on the ground.
/// @param {real} x_pos The current x position of the object.
/// @param {real} y_pos The current y position of the object.

var x_pos = argument0;
var y_pos = argument1;

// Perform the check.
	if (place_meeting(x_pos, y_pos+2, obj_solid)) {
		on_ground = true;
	} else {
		on_ground = false;
	}