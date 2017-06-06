/// Modifies the velocity after the verlet calculation.

// Horizontal Speed
// Limit max speed.
	if (current_hspd > 500) {
		current_hspd = 500;
	} else if (current_hspd < -500) {
		current_hspd = -500;
	}

// Input stopped and player slowed down so set speed to 0.
	if (direction_horizontal == 0 && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
	}


// Vertical Speed
// Player jumped so set current vspd to jump speed.
	if (direction_vertical == -1 && on_ground == true) {
		current_vspd = -100;
	}