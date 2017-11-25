	// Check to see if we hit our jump peak.
	if (current_vspd > 0) {
		jumppeak = true;
		wall_jump = false;
	}

	// Check to see if we are about to wall slide.
	if (((!(place_meeting(previous_x+1, previous_y, obj_solid) && place_meeting(current_x+1, current_y, obj_solid)) 
	&& !(place_meeting(previous_x-1, previous_y, obj_solid) && place_meeting(current_x-1, current_y, obj_solid)) 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)) 
	&& !on_ground && jumppeak) 
	|| (jumppeak && (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)))) 
	&& start_slide) {
		current_vspd = 0;
		start_slide = false;
	}
	
	if (wall_jump) {
		wall_slide = false;
	} else {
		wall_slide = true;
	}
	
	if (on_ground || (!place_meeting(current_x+1, current_y, obj_solid) && !place_meeting(current_x-1, current_y, obj_solid))) {
		wall_slide = false;
	}