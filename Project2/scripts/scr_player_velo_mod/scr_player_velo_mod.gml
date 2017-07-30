/// Modifies the velocity after the verlet calculation.

/// Horizontal Speed
// Limit max speed.
	if (rolling) {
		current_hspd = clamp(current_hspd, -100, 100);
	} else {
		current_hspd = clamp(current_hspd, -500, 500);
	}
// Do not allow horizontal speed when colliding with a wall.
	if (place_meeting(current_x-1, current_y, obj_solid)) {
		if (rolling) {
			current_hspd = clamp(current_hspd, 0, 100);
		} else {
			current_hspd = clamp(current_hspd, 0, 500);
		}
	}
	if (place_meeting(current_x+1, current_y, obj_solid)) {
		if (rolling) {
			current_hspd = clamp(current_hspd, -100, 0);
		} else {
			current_hspd = clamp(current_hspd, -500, 0);
		}
	}

// Input stopped and player stopped so set speed to 0.
	if ((direction_horizontal == 0 || sliding) && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
		current_xacc = 0;
		sliding = false;
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
	
// Player jumped off the wall.
	if (!on_ground 
	&& (place_meeting(current_x-1, current_y, obj_solid) || place_meeting(current_x+1, current_y, obj_solid)) 
	&& up) {
		wall_jump = true;
		if (place_meeting(current_x-1, current_y, obj_solid)) {
			current_hspd = 500;
		} else if (place_meeting(current_x+1, current_y, obj_solid)) {
			current_hspd = -500;
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
		wall_jump = false;
		dash_count = 0;
		dashing = false;
	}

// Player jumped so set current vspd to jump speed.
	if (up && on_ground) {
		current_vspd = -450;
	}

// Player wall jumped.
	if (!on_ground 
	&& (place_meeting(current_x-1, current_y, obj_solid) || place_meeting(current_x+1, current_y, obj_solid)) 
	&& up) {
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
		if (dash_up) {
			dashing = false;
		}
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
	
// Check to see if we are dashing.
	if (!on_ground && dash && dash_count < 3) {
		dashing = true;
		script_execute(scr_dash_direction);
		if (dash_right || dash_left || dash_up) {
			dash_count++;
		}
	}