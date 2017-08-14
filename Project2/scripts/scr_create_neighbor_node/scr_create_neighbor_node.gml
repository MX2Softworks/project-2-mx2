/// @description Creates the neighbor node.

// Create the new node.
	new_node = ds_list_create();

// Initialize the physics variables.
	current_x = current_node[| 0];
	current_y = current_node[| 1];
	current_hspd = current_node[| 2];
	current_vspd = current_node[| 3];
	previous_xacc = current_node[| 4];
	previous_yacc = current_node[| 5];

// Modified physics update.
	script_execute(scr_chasing_accel);
	previous_hspd = current_hspd;
	previous_vspd = current_vspd;
	current_hspd = previous_hspd + (current_xacc + previous_xacc) / 2 * global.dt;
	current_vspd = previous_vspd + (current_yacc + previous_yacc) / 2 * global.dt;
	script_execute(scr_chasing_velo);
	previous_x = current_x;
	previous_y = current_y;
	current_x = previous_x + current_hspd * global.dt + (1/2) * current_xacc * global.dt * global.dt;
	current_y = previous_y + current_vspd * global.dt + (1/2) * current_yacc * global.dt * global.dt;

// Adjust for collision.
	var movedis_x = current_x-previous_x;
	if (sign(movedis_x) == 1) {
		movedis_x = floor(movedis_x);
	} else {
		movedis_x = ceil(movedis_x);
	}
	var increment = 0;
	var mask_width = (sprite_get_bbox_right(sprite_index) + 1) - sprite_get_bbox_left(sprite_index);
	while (abs(increment) < abs(movedis_x)) {
		if ((abs(movedis_x)-abs(increment)) < mask_width) {
			increment = movedis_x;
		} else {
			increment += mask_width * sign(movedis_x);
		}
		if (place_meeting(previous_x+increment, previous_y, obj_solid)) {
			while (place_meeting(previous_x+increment, previous_y, obj_solid)) {
				increment = increment - sign(increment);
			}
			movedis_x = increment;
		}
	}
	current_x = previous_x + movedis_x;
	var movedis_y = current_y-previous_y;
	if (sign(movedis_y) == 1) {
		movedis_y = floor(movedis_y);
	} else {
		movedis_y = ceil(movedis_y);
	}
	increment = 0;
	var mask_height = (sprite_get_bbox_bottom(sprite_index) + 1) - sprite_get_bbox_top(sprite_index);
	while (abs(increment) < abs(movedis_y)) {
		if ((abs(movedis_y)-abs(increment)) < mask_height) {
			increment = movedis_y;
		} else {
			increment += mask_height * sign(movedis_y);
		}
		if (place_meeting(current_x, previous_y+increment, obj_solid)) {
			while (place_meeting(current_x, previous_y+increment, obj_solid)) {
				increment = increment - sign(increment);
			}
			movedis_y = increment;
		}
	}
	current_y = previous_y + movedis_y;

// Add to the new node.
	ds_list_add(new_node, current_x, current_y, current_hspd, current_vspd, current_xacc, current_yacc, new_state);

// Check if this node is not in the accessible list nor in the queue.
	var unique_node = true;
	for (var i = 0; i < ds_list_size(accessible_nodes); i++) {
		var temp_node = accessible_nodes[| i];
		if ((floor(temp_node[| 0]) == floor(new_node[| 0])) 
		&& (floor(temp_node[| 1]) == floor(new_node[| 1]))) {
			for (var k = 0; k < (ds_list_size(temp_node) - 6); k++) {
				var temp_index = k + 6;
				if (temp_node[| temp_index] == new_node[| 6]) {
					unique_node = false;
					break;
				}
			}
			if (!unique_node) {
				break;
			}
			ds_list_add(temp_node, new_node[| 6]);
			unique_node = false;
			break;
		}
	}
// If the node is still unique check the queue.
	if (unique_node) {
		for (var j = 0; j < ds_queue_size(unchecked_nodes); j++) {
			var popped_node = ds_queue_dequeue(unchecked_nodes);
			if ((floor(popped_node[| 0]) == floor(new_node[| 0])) 
			&& (floor(popped_node[| 1]) == floor(new_node[| 1])) 
			&& (popped_node[| 6] == new_node[| 6])) {
				unique_node = false;
				break;
			}
			ds_queue_enqueue(unchecked_nodes, popped_node);
		}
	}
// If the node is still unique add it to the queue.
	if (unique_node) {
		ds_queue_enqueue(unchecked_nodes, new_node);
	} else {
		// Duplicate node. Destroy it.
		ds_list_destroy(new_node);
	}