/// @description Update the physics of an object over 1/60 of a second.
/// @param {obj} collision The object you are checking collisions against.
/// @param {str} scr_accel The script name of the acceleration update for the current object.

// First calculate the new position and check for collisions.
scr_update_position(obj_solid);


// Calculate the new accelerations.
// Will be used to calculate position next update.


// Using the new acceleration, calculate the current speed.
// Will be used to calculate position next update.


// Set previous acceleration to current acceleration.
