/// Modifies the velocity after the verlet calculation.

// Horizontal Speed
// Limit max speed.
	current_hspd = clamp(current_hspd, -500, 500);

// Input stopped and player slowed down so set speed to 0.
	if (direction_horizontal == 0 && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
	}

// Make sure the sprite is facing the direction of movement.
	if (previous_hspd != 0) {
		image_xscale = sign(previous_hspd);
	}


// Vertical Speed
// Player is on the ground. Can reset variables.
	if (on_ground) {
		current_vspd = 0;
		jumppeak = false;
		jump_hold_stop = false;
	}

// Player jumped so set current vspd to jump speed.
	if (up && on_ground == true) {
		current_vspd = -450;
	}

// Check to see if we hit our jump peak.
	if (current_vspd >= 0) {
		jumppeak = true;
	}

// Check to see if we are about to wall slide.
	if (!(place_meeting(previous_x+1, previous_y, obj_solid) && place_meeting(current_x+1, current_y, obj_solid)) 
	&& !(place_meeting(previous_x-1, previous_y, obj_solid) && place_meeting(current_x-1, current_y, obj_solid)) 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid))) {
		current_vspd = 0;
	}