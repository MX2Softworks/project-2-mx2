/// @description Modifies the velocity after the verlet calculation.

/// Horizontal Speed
// Limit max speed.
	if (rolling) {
		current_hspd = clamp(current_hspd, -100, 100);
	} else if (!dashing) {
		if (sprinting) {
			current_hspd = clamp(current_hspd, -750, 750);
		} else {
			current_hspd = clamp(current_hspd, -500, 500);
		}
	}
// Do not allow horizontal speed when colliding with a wall.
	if (!dashing) {
		if (place_meeting(current_x-1, current_y, obj_solid)) {
			if (rolling) {
				current_hspd = clamp(current_hspd, 0, 100);
			} else {
				if (sprinting) {
					current_hspd = clamp(current_hspd, 0, 750);
				} else {
					current_hspd = clamp(current_hspd, 0, 500);
				}
			}
		}
		if (place_meeting(current_x+1, current_y, obj_solid)) {
			if (rolling) {
				current_hspd = clamp(current_hspd, -100, 0);
			} else {
				if (sprinting) {
					current_hspd = clamp(current_hspd, -750, 0);
				} else {
					current_hspd = clamp(current_hspd, -500, 0);
				}
			}
		}
	}

// Input stopped and player stopped so set speed to 0.
	if ((((direction_horizontal == 0 || sliding) && !dashing) || (dashing && !dash_up)) && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
		current_xacc = 0;
		xrem = 0;
		sliding = false;
		dashing = false;
		dash_right = false;
		dash_left = false;
		dash_init_hspd = false;
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

// Player dashed.
	if (dashing && !dash_init_hspd) {
		if (dash_right) {
			current_hspd = 1000 * charge_power;
			dash_init_hspd = true;
		} else if (dash_left) {
			current_hspd = -1000 * charge_power;
			dash_init_hspd = true;
		} else if (dash_up) {
			current_hspd = 0;
			previous_hspd = 0;
		}
	}

// Player is holding onto the wall.
	if (wall_grab) {
		current_hspd = 0;
	}

// Bounced off the wall from a dash.
	if ((dashing && (dash_right || dash_left)) 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid))) {
		current_hspd = current_hspd * -1;
	}


/// Vertical Speed
// Player is on the ground. Can reset variables.
	if (on_ground) {
		current_vspd = 0;
		yrem = 0;
		jumppeak = false;
		jump_hold_stop = false;
		fast_fall = false;
		wall_grab = false;
		wall_jump = false;
		dash_count = 0;
		dashing = false;
		dash_init_hspd = false;
		dash_init_vspd = false;
	}

// Do not allow vertical speed when colliding with the ceiling.
	if (!dashing) {
		if (place_meeting(current_x, current_y-1, obj_solid)) {
			current_vspd = max(current_vspd, 0);
			yrem = 0;
		}
	}

// Player jumped so set current vspd to jump speed.
	if (up && on_ground && !rolling && !sliding && !down_held) {
		current_vspd = -450;
		wall_slide = false
	}

// Player wall jumped.
	if (!on_ground 
	&& (place_meeting(current_x-1, current_y, obj_solid) || place_meeting(current_x+1, current_y, obj_solid)) 
	&& up) {
		wall_jump = true;
		wall_slide = false;
		jumppeak = false;
		jump_hold_stop = false;
		current_vspd = -450;
	}

// Player dashed.
	if (dashing && !dash_init_vspd) {
		if (dash_right) {
			current_vspd = 0;
			previous_vspd = 0;
		} else if (dash_left) {
			current_vspd = 0;
			previous_vspd = 0;
		} else if (dash_up) {
			current_vspd = -600 * charge_power;
			dash_init_vspd = true;
		}
	}

// Player is holding onto the wall.
	if (wall_grab) {
		current_vspd = 0;
	}

// Bounced off the wall from a dash.
	if ((dashing && dash_up) && place_meeting(current_x, current_y-1, obj_solid)) {
		current_vspd = current_vspd * -1;
	}