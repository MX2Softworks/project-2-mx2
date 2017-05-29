/// @description scr_move_new(collision_object)
/// @function  scr_move_new
/// @param collision_object

var collision_object = argument0;

// Assume current speeds and accelerations are set from last step.
// Set the new previous positions to our current position before moving.
previous_x = current_x;
previous_y = current_y;

current_x = previous_x + current_hspd/*	CONTINUE HERE */;