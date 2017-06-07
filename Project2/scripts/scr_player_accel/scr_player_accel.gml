/// Calculates the players acceleration based on the state of the player.

// Horizontal Acceleration
	current_xacc = previous_xacc + (115200 * global.dt) * direction_horizontal;

// Limit acceleration when running normally.
	current_xacc = clamp(current_xacc, -2800, 2800);

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


// Vertical Acceleration
	if (!on_ground) {
		if (!jumppeak) {
			// In the air not at the jump peak
			current_yacc = 1200;
		} else {
			// In the air at the jump peak
			current_yacc = previous_yacc + (12000 * global.dt);
			current_yacc = clamp(current_yacc, 0, 4800);
		}
	} else {
		current_yacc = 1200;
	}