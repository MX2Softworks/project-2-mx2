/// @description Modifies the acceleration of the chasing AI.

/// Horizontal Acceleration.
	if (new_state == "state_jump_right" || new_state == "state_accel_right") {
		current_xacc = previous_xacc + (115200 * global.dt) * 1;
	}

	if (new_state == "state_jump_left" || new_state == "state_accel_left") {
		current_xacc = previous_xacc + (115200 * global.dt) * -1;
	}

	// Limit acceleration when moving horizontally normally.
	current_xacc = clamp(current_xacc, -2800, 2800);


/// Vertical Acceleration.
	if (new_state == "state_peak") {
		current_yacc = previous_yacc + (12000 * global.dt);
		current_yacc = clamp(current_yacc, 0, 3600);
	} else {
		current_yacc = 1200;
	}