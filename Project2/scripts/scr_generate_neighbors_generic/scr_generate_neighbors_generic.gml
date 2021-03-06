/// @description Using the current will generate a list of possible nodes.

// Holds the previous state.
var previous_state = current_node[| 6];

// Holds the new state.
new_state = "state_idle";

// Initialize physics variables.
current_x = 0;
current_y = 0;
previous_x = 0;
previous_y = 0;
current_hspd = 0;
current_vspd = 0;
previous_hspd = 0;
previous_vspd = 0;
current_xacc = 0;
current_yacc = 0;
previous_xacc = 0;
previous_yacc = 0;
full_check = false;

if (previous_state == "state_idle") {
	// Set accelerations and speeds to 0.
	ds_list_set(current_node, 2, 0);
	ds_list_set(current_node, 3, 0);
	ds_list_set(current_node, 4, 0);
	ds_list_set(current_node, 5, 0);
	// Jumped.
	new_state = "state_jump";
	script_execute(scr_create_neighbor_node);
	// Jumped right.
	new_state = "state_jump_right";
	script_execute(scr_create_neighbor_node);
	// Jumped left.
	new_state = "state_jump_left";
	script_execute(scr_create_neighbor_node);
	// Accelerated right.
	new_state = "state_accel_right";
	script_execute(scr_create_neighbor_node);
	// Accelerated left.
	new_state = "state_accel_left";
	script_execute(scr_create_neighbor_node);
	
} else if (previous_state == "state_jump") {
	// Not at jump peak.
	new_state = "state_not_peak";
	script_execute(scr_create_neighbor_node);
	// Jump peak.
	new_state = "state_peak";
	script_execute(scr_create_neighbor_node);
	
} else if (previous_state == "state_jump_right") {
	// Not at the jump peak, moving right.
	new_state = "state_not_peak_accel_right";
	script_execute(scr_create_neighbor_node);
	// Just hit the jump peak, slowing right.
	new_state = "state_peak_decel_right";
	script_execute(scr_create_neighbor_node);
	
} else if (previous_state == "state_jump_left") {
	// Not at the jump peak, moving left.
	new_state = "state_not_peak_accel_left";
	script_execute(scr_create_neighbor_node);
	// Just hit the jump peak, slowing left.
	new_state = "state_peak_decel_left";
	script_execute(scr_create_neighbor_node);

} else if (previous_state == "state_accel_right") {

} else if (previous_state == "state_accel_left") {

} else if (previous_state == "state_not_peak") {
	// Not at the jump peak.
	if (current_node[| 3] <= 0) {
		new_state = "state_not_peak";
		script_execute(scr_create_neighbor_node);
	}
	// Just hit the jump peak.
	new_state = "state_peak";
	script_execute(scr_create_neighbor_node);
	
} else if (previous_state == "state_peak") {
	script_execute(scr_on_ground_check, current_node[| 0], current_node[| 1]);
	if (on_ground) {
		// On ground.
		new_state = "state_idle";
		script_execute(scr_create_neighbor_node);
	} else {
		// Past jump peak.
		new_state = "state_peak";
		script_execute(scr_create_neighbor_node);
	}
	
} else if (previous_state == "state_not_peak_accel_right") {
	// Not at the jump peak.
	if (current_node[| 3] <= 0) {
		new_state = "state_not_peak_accel_right";
		script_execute(scr_create_neighbor_node);
	}
	// Just hit the jump peak.
	new_state = "state_peak_decel_right";
	script_execute(scr_create_neighbor_node);
	
} else if (previous_state == "state_peak_decel_right") {
	script_execute(scr_on_ground_check, current_node[| 0], current_node[| 1]);
	if (on_ground) {
		// On ground.
		new_state = "state_idle";
		script_execute(scr_create_neighbor_node);
	} else {
		if (current_node[| 2] <= 0) {
			// Stopped. Set speed to 0. Switch state.
			ds_list_set(current_node, 2, 0);
			new_state = "state_peak";
			script_execute(scr_create_neighbor_node);
		} else {
			// Past jump peak.
			new_state = "state_peak_decel_right";
			script_execute(scr_create_neighbor_node);
		}
	}

} else if (previous_state == "state_not_peak_accel_left") {
	// Not at the jump peak.
	if (current_node[| 3] <= 0) {
		new_state = "state_not_peak_accel_left";
		script_execute(scr_create_neighbor_node);
	}
	// Just hit the jump peak.
	new_state = "state_peak_decel_left";
	script_execute(scr_create_neighbor_node);

} else if (previous_state == "state_peak_decel_left") {
	script_execute(scr_on_ground_check, current_node[| 0], current_node[| 1]);
	if (on_ground) {
		// On ground.
		new_state = "state_idle";
		script_execute(scr_create_neighbor_node);
	} else {
		if (current_node[| 2] >= 0) {
			// Stopped. Set speed to 0. Switch state.
			ds_list_set(current_node, 2, 0);
			new_state = "state_peak";
			script_execute(scr_create_neighbor_node);
		} else {
			// Past jump peak.
			new_state = "state_peak_decel_left";
			script_execute(scr_create_neighbor_node);
		}
	}

} else if (previous_state == "state_decel_right") {

} else if (previous_state == "state_decel_left") {

}