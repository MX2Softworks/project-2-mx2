/// @description Calculates the players acceleration based on the state of the player.

/// Horizontal Acceleration
// Determine how to accelerate when wall sliding.
	if (wall_slide && !dashing) {
		if ((wall_push && place_meeting(current_x-1, current_y, obj_solid)) 
		|| (wall_push && place_meeting(current_x+1, current_y, obj_solid))) {
			// Wall push (unneccesary)
			wall_grab = false;
		} else if (((grab && place_meeting(current_x+1, current_y, obj_solid)) 
		|| (grab && place_meeting(current_x-1, current_y, obj_solid))) 
		&& !fast_fall) {
			// Wall grab
			wall_grab = true;
			current_xacc = 0;
		} else {
			wall_grab = false;
			current_xacc = 0;
		}
	} else {
		// Not wall sliding, can move normally horizontally.
		current_xacc = previous_xacc + (115200 * global.dt) * direction_horizontal;
		// Limit acceleration when running normally.
		current_xacc = clamp(current_xacc, -2800, 2800);
		if (!dashing) {
			// Do not allow acceleration when colliding with a wall.
			if (place_meeting(current_x-1, current_y, obj_solid)) {
				current_xacc = clamp(current_xacc, 0, 2800);
			}
			if (place_meeting(current_x+1, current_y, obj_solid)) {
				current_xacc = clamp(current_xacc, -2800, 0);
			}
		} else {
			if (dash_up) {
				current_xacc = 0;
				previous_xacc = 0;
			}
			// Bounced off the wall from a dash.
			if ((dash_right || dash_left) 
			&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid))) {
				current_xacc = current_xacc * -1;
			}
		}
		
		// Player is sliding or rolling.
		if (on_ground && (direction_horizontal != 0 && ((down_held && !gamepad_is_connected(gp_id)) || ((diag_dl_held || diag_dr_held) && gamepad_is_connected(gp_id))))) {
			if (sign(current_hspd) == 1 && !rolling) {
				// Sliding.
				sliding = true;
				current_xacc = -1400;
			} else if (sign(current_hspd) == -1 && !rolling) {
				// Sliding.
				sliding = true;
				current_xacc = 1400;
			} else {
				// Rolling.
				sliding = false;
				rolling = true;
			}
		} else {
			sliding = false;
			rolling = false;
		}
		
		// Slow the player down if they stop giving input.
		if ((direction_horizontal == 0 && !dashing) || (dashing && !dash_up)) {
			if (sign(current_hspd) == 1) {
				if (wall_jump) {
					current_xacc = -150;
				} else {
					current_xacc = -2800;
				}
			} else if (sign(current_hspd) == -1) {
				if (wall_jump) {
					current_xacc = 150;
				} else {
					current_xacc = 2800;
				}
			} else {
				// current_hspd = 0
				current_xacc = 0;
			}
		}
	}


/// Vertical Acceleration
	if (!on_ground) {
		// Directional input while in mid-air
		if (up_released) {
			jump_hold_stop = true;
		}
		if (down) {
			fast_fall = true;
			wall_grab = false;
		}
		// Change acceleration based on the mid-air state
		if (fast_fall) {
			// Increase gravity to pull faster
			current_yacc = previous_yacc + (96000 * global.dt);
			current_yacc = clamp(current_yacc, 0, 7200);
		} else if (dashing) {
			// Dashing.
			if (dash_right || dash_left) {
				current_yacc = 0;
				previous_yacc = 0;
			} else {
				current_yacc = 1200;
			}
		} else if (wall_slide) {
			if (wall_grab) {
				// Stop any acceleration when sliding.
				current_yacc = 0;
			} else {
				// Halve gravity's intensity when sliding down the wall.
				current_yacc = 600;
			}
		} else if (!jumppeak && !jump_hold_stop) {
			// In the air not at the jump peak
			current_yacc = 1200;
		} else {
			// In the air at the jump peak
			current_yacc = previous_yacc + (12000 * global.dt);
			current_yacc = clamp(current_yacc, 0, 3600);
		}
	} else {
		// Apply normal gravity.
		current_yacc = 1200;
	}

// Limit acceleration if colliding with the ceiling.
	if (!dashing) {
		if (place_meeting(current_x, current_y-1, obj_solid)) {
			current_yacc = max(current_yacc, 0);
		}
	}