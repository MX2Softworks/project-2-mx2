/// Modifies the velocity after the verlet calculation.

// Horizontal Speed
// Limit max speed.
	current_hspd = clamp(current_hspd, -500, 500);

// Input stopped and player slowed down so set speed to 0.
	if (direction_horizontal == 0 && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
	}


// Vertical Speed
// Player is on the ground. Can reset variables.
	if (on_ground) {
		current_vspd = 0;
		jumppeak = false;
	}

// Player jumped so set current vspd to jump speed.
	if (up && on_ground == true) {
		current_vspd = -450;
	}

// Check to see if we hit our jump peak.
	if (current_vspd >= 0) {
		jumppeak = true;
	}