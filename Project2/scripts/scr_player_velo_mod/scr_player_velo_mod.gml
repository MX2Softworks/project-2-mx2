/// Modifies the velocity after the verlet calculation.

/// Horizontal Speed
// Limit max speed.
	current_hspd = clamp(current_hspd, -500, 500);
// Do not allow horizontal speed when colliding with a wall.
	if (place_meeting(current_x-1, current_y, obj_solid)) {
		current_hspd = clamp(current_hspd, 0, 500);
	}
	if (place_meeting(current_x+1, current_y, obj_solid)) {
		current_hspd = clamp(current_hspd, -500, 0);
	}

// Input stopped and player slowed down so set speed to 0.
	if (direction_horizontal == 0 && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
	}

// Make sure the sprite is facing the direction of movement.
	if (previous_hspd != 0) {
		image_xscale = sign(previous_hspd);
	}

// Player pushed off the wall.
	if (wall_push) {
		if (place_meeting(current_x-1, current_y, obj_solid)) {
			current_hspd = 350;
		} else if (place_meeting(current_x+1, current_y, obj_solid)) {
			current_hspd = -350;
		}
	}

// Player is holding onto the wall.
	if (wall_grab) {
		current_hspd = 0;
	}


/// Vertical Speed
// Player is on the ground. Can reset variables.
	if (on_ground) {
		current_vspd = 0;
		jumppeak = false;
		jump_hold_stop = false;
		fast_fall = false;
		wall_grab = false;
	}

// Player jumped so set current vspd to jump speed.
	if (up && on_ground == true) {
		current_vspd = -450;
	}

// Player wall jumped.
	if (wall_slide && up) {
		wall_jump = true;
		jumppeak = false;
		jump_hold_stop = false;
		current_vspd = -450;
	}

// Player is holding onto the wall.
	if (wall_grab) {
		current_vspd = 0;
	}


/// State Checks
// Check to see if we hit our jump peak.
	if (current_vspd >= 0) {
		jumppeak = true;
		wall_jump = false;
	}

// Check to see if we are about to wall slide.
	if (((!(place_meeting(previous_x+1, previous_y, obj_solid) && place_meeting(current_x+1, current_y, obj_solid)) 
	&& !(place_meeting(previous_x-1, previous_y, obj_solid) && place_meeting(current_x-1, current_y, obj_solid)) 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)) 
	&& !on_ground) 
	|| (jumppeak 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)))) 
	&& start_slide) {
		current_vspd = 0;
		start_slide = false;
	}
	if (!start_slide) {
		if (wall_jump) {
			wall_slide = false;
			start_slide = true;
		} else {
			wall_slide = true;
		}
	}
	if (on_ground || (!place_meeting(current_x+1, current_y, obj_solid) && !place_meeting(current_x-1, current_y, obj_solid))) {
		wall_slide = false;
		start_slide = true;
	}