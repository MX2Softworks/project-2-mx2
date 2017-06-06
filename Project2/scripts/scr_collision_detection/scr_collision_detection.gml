/// @description General purpose script used for collision detection.
/// @param {obj} collision The object you are checking collisions against.

/// Required instance variables:
///		current_x, previous_x, xrem, current_y, previous_y, yrem, collision_x, collision_y

var collision = argument0;

// Horizontal Collisions
var movedis_x = current_x-previous_x;
// Save remainder to avoid decimal imprecision.
if (sign(movedis_x) == 1) {
	xrem += movedis_x - floor(movedis_x);
	movedis_x = floor(movedis_x);
} else {
	xrem += movedis_x - ceil(movedis_x);
	movedis_x = ceil(movedis_x);
}
if (abs(xrem) >= 1) {
	movedis_x += sign(xrem);
	xrem -= sign(xrem);
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
	yrem += movedis_y - floor(movedis_y);
	movedis_y = floor(movedis_y);
} else {
	yrem += movedis_y - ceil(movedis_y);
	movedis_y = ceil(movedis_y);
}
if (abs(yrem) >= 1) {
	movedis_y += sign(yrem);
	yrem -= sign(yrem);
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