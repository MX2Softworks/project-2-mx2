//ACCELERATION: horizontal acceleration
	current_xacc = 2800 * direction_horizontal;

	// Limit acceleration when running normally.
	current_xacc = clamp(current_xacc, -2800, 2800);

	// Do not allow acceleration when colliding with a wall.
	if (place_meeting(current_x-1, current_y, obj_solid)) {
		current_xacc = clamp(current_xacc, 0, 2800);
	}
	if (place_meeting(current_x+1, current_y, obj_solid)) {
		current_xacc = clamp(current_xacc, -2800, 0);
	}

	// Slow the agent down if they stop giving input.
	if (direction_horizontal == 0) {
		if (sign(current_hspd) == 1)		current_xacc = -2800;
		else if (sign(current_hspd) == -1)	current_xacc = 2800;
		else								current_xacc = 0;
	}

	// Block the agent from moving outside the room.
	if (current_x < 50) {
		current_xacc = 0;
	} else if (current_x > (room_width - 50)) {
		current_xacc = 0;
	}
	if (current_x == 50) {
		current_xacc = max(0, current_xacc);
	} else if (current_x = (room_width - 50)) {
		current_xacc = min(0, current_xacc);
	}

//ACCELERATION: vertical acceleration
	if (!on_ground) {
		if (up_released) jump_hold_stop = true; // Directional input while in mid-air
	
		if (wall_slide) { // Change acceleration based on the mid-air state
			if (wall_grab)	current_yacc = 0;
			else			current_yacc = 600; // Halve gravity's intensity when sliding down the wall.
		} 
		else if (!jumppeak && !jump_hold_stop) { // In the air not at the jump peak
			current_yacc = 1200;
		} 
		else { // In the air at the jump peak
			current_yacc = previous_yacc + (12000 * global.dt);
			current_yacc = clamp(current_yacc, 0, 3600);
		}
	} else { // Apply normal gravity.
		current_yacc = 1200;
	}

	// Limit acceleration if colliding with the ceiling.
	if (place_meeting(current_x, current_y-1, obj_solid)) {
		current_yacc = max(current_yacc, 0);
	}

	//block agent from moving outside the room.
	if (current_y < 20) {
		current_yacc = 0;
	} else if (current_y > (room_height - 20)) {
		current_yacc = 0;
	}
	if (current_y == 20) {
		current_yacc = max(0, current_yacc);
	} else if (current_y = (room_height - 20)) {
		current_yacc = min(0, current_yacc);
	}