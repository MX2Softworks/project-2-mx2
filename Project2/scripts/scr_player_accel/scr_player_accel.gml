/// Calculates the players acceleration based on the state of the player.

// Horizontal Acceleration
// cur = prev + 120
	current_xacc = previous_xacc + (115200 * global.dt) * direction_horizontal;
	if (!on_ground) {
		current_yacc = previous_yacc + (720 * global.dt);
	} else {
		current_yacc = 0;
	}

// Limit acceleration when running normally.
	if (current_xacc > 2880) {
		current_xacc = 2880;
	}
	if (current_xacc < -2880) {
		current_xacc = -2880;
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


// Vertical Acceleration
// 
	if (current_yacc > 600) {
		current_yacc = 600;
	}
	if (current_yacc < -600) {
		current_yacc = -600;
	}