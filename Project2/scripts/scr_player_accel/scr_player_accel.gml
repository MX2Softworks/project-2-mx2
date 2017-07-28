/// Calculates the players acceleration based on the state of the player.

/// Horizontal Acceleration
// Determine how to accelerate when wall sliding.
	if (wall_slide) {
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
		// Do not allow acceleration when colliding with a wall.
		if (place_meeting(current_x-1, current_y, obj_solid)) {
			current_xacc = clamp(current_xacc, 0, 2800);
		}
		if (place_meeting(current_x+1, current_y, obj_solid)) {
			current_xacc = clamp(current_xacc, -2800, 0);
		}
		
		// Slow the player down if they stop giving input.
		if (direction_horizontal == 0) {
			if (sign(current_hspd) == 1) {
				current_xacc = -2800;
			} else if (sign(current_hspd) == -1) {
				current_xacc = 2800;
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