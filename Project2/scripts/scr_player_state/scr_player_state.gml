/// @description Updates state variables associated with the player.

// Check to see if we hit our jump peak.
	if (current_vspd > 0) {
		jumppeak = true;
		wall_jump = false;
		if (dash_up) {
			dashing = false;
			dash_up = false;
			dash_init_vspd = false;
		}
	}

// Check to see if we are about to wall slide.
	if (((!(place_meeting(previous_x+1, previous_y, obj_solid) && place_meeting(current_x+1, current_y, obj_solid)) 
	&& !(place_meeting(previous_x-1, previous_y, obj_solid) && place_meeting(current_x-1, current_y, obj_solid)) 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)) 
	&& !on_ground) 
	|| (jumppeak 
	&& (place_meeting(current_x+1, current_y, obj_solid) || place_meeting(current_x-1, current_y, obj_solid)))) 
	&& start_slide) {
		current_vspd = 0;
		start_slide = false;
	}
	if (!start_slide) {
		if (wall_jump) {
			wall_slide = false;
			start_slide = true;
		} else {
			wall_slide = true;
		}
	}
	if (on_ground || (!place_meeting(current_x+1, current_y, obj_solid) && !place_meeting(current_x-1, current_y, obj_solid))) {
		wall_slide = false;
		start_slide = true;
	}

// Check to see if we are sprinting.
	if (sprint && current_hspd != 0 && on_ground && !sliding && !rolling && !down_held) {
		sprinting = true;
	} else {
		sprinting = false;
	}
	
// Check to see if we are dashing.
	if (!on_ground && dash && dash_count < 3) {
		dashing = true;
		dash = false;
		charge_power = 1;
		dash_init_hspd = false;
		dash_init_vspd = false;
		script_execute(scr_dash_direction);
		if (dash_right || dash_left || dash_up) {
			dash_count++;
		}
	}

// If we are charging accumulate frame time.
	if (charging) {
		charge_time += delta_time*charge_slow;
	}

// Check to see if we are charge dashing.
	if (!on_ground && charge_dash && dash_count < 3) {
		charging = true;
		charge_dash = false;
		dash_count++;
	}

// Check to see if we stopped charging.
	if ((!charge_dash_held && charging) || charge_time >= 2500000) {
		charging = false;
		charge_power = charge_time / 2500000;
		charge_time = 0;
		dashing = true;
		dash_init_hspd = false;
		dash_init_vspd = false;
		script_execute(scr_dash_direction);
	}