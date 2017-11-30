//SPEED : horizontal speed.
	current_hspd = clamp(current_hspd, -1 * max_speed, max_speed);
	
	//Do not allow horizontal speed when colliding with a wall.
	if (place_meeting(current_x-1, current_y, obj_solid)) current_hspd = clamp(current_hspd, 0, max_speed);
	if (place_meeting(current_x+1, current_y, obj_solid)) current_hspd = clamp(current_hspd, -1 * max_speed, 0);
	
	//testing whether getting rid of acceleration would help out. 
	if(direction_horizontal == 0 /*|| (sign(direction_horizontal) != sign(previous_hspd) && previous_hspd != 0)*/){
		current_xacc = 0;
		current_hspd = 0;
		xrem = 0;
	}
	
	//if the direction horizontal is 0 and the sign of the previous does not match the current, we should reset to 0
	if ((direction_horizontal == 0 ) && sign(previous_hspd) != sign(current_hspd)) {
		current_hspd = 0;
		current_xacc = 0;
		xrem = 0;
	}

	// Agent pushed off the wall.
	if (wall_push) {
		if (place_meeting(current_x-1, current_y, obj_solid)) {
			current_hspd = 350;
		} else if (place_meeting(current_x+1, current_y, obj_solid)) {
			current_hspd = -350;
		}
	}
	
	// Agent jumped off the wall.
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
	
	// Agent is holding onto the wall.
	if (wall_grab) {
		current_hspd = 0;
	}
	
	// Block agent from moving from outside the room.
	if (current_x < 50) {
		current_x = 50;
		current_hspd = 0;
	} else if (current_x > (room_width - 50)) {
		current_x = room_width - 50;
		current_hspd = 0;
	}
	if (current_x == 50) {
		current_hspd = max(0, current_hspd);
	} else if (current_x = (room_width - 50)) {
		current_hspd = min(0, current_hspd);
	}
	
//SPEED: vertical speed
	// Agent is on the ground. Can reset variables.
	if (on_ground) {
		current_vspd = 0;
		yrem = 0;
		jumppeak = false;
		jump_hold_stop = false;
		wall_grab = false;
		wall_jump = false;
	}

	// Do not allow vertical speed when colliding with the ceiling.
	if (place_meeting(current_x, current_y-1, obj_solid)) {
		current_vspd = max(current_vspd, 0);
		yrem = 0;
	}

	// Agent jumped so set current vspd to jump speed.
	if (up && on_ground) {
		current_vspd = -500;
		wall_slide = false
		sliding = false
		rolling = false
	}

	// Agent wall jumped.
	if (!on_ground 
	&& (place_meeting(current_x-1, current_y, obj_solid) || place_meeting(current_x+1, current_y, obj_solid)) 
	&& up) {
		wall_jump = true;
		wall_slide = false;
		jumppeak = false;
		jump_hold_stop = false;
		current_vspd = -500;
	}

	// Agent is holding onto the wall.
	if (wall_grab) {
		current_vspd = 0;
	}

	// Block agent from moving from outside the room.
	if (current_y < 20) {
		current_y = 20;
		current_vspd = 0;
	} else if (current_y > (room_height - 20)) {
		current_y = room_height - 20;
		current_vspd = 0;
	}
	if (current_y == 20) {
		current_vspd = max(0, current_vspd);
	} else if (current_y = (room_height - 20)) {
		current_vspd = min(0, current_vspd);
	}