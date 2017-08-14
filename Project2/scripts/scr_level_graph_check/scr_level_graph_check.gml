/// @description Checks each node in the current level and adds the accessible ones to a list.

// The list of accessible nodes.
accessible_nodes = ds_list_create();

// Create the starting node. The starting position is determined by the spawn of the object.
starting_node = ds_list_create();
ds_list_add(starting_node, x, y, 0, 0, 0, 0, "state_idle");

// Create the queue.
unchecked_nodes = ds_queue_create();

// Add the starting node to the queue.
ds_queue_enqueue(unchecked_nodes, starting_node);

// Find all the accessible nodes.
while (!ds_queue_empty(unchecked_nodes)) {
	// Pop the current node list.
	current_node = ds_queue_dequeue(unchecked_nodes);
	
	// Generate neighbors.
	script_execute(scr_generate_neighbors_generic);
		
	// Add the current node to the accessible list.
	var unique_accessible_node = true;
	for (var i = 0; i < ds_list_size(accessible_nodes); i++) {
		var temp_nd = accessible_nodes[| i];
		if ((floor(temp_nd[| 0]) == floor(current_node[| 0])) 
		&& (floor(temp_nd[| 1]) == floor(current_node[| 1]))) {
			for (var k = 0; k < (ds_list_size(temp_nd) - 6); k++) {
				var temp_ind = k + 6;
				if (temp_nd[| temp_ind] == current_node[| 6]) {
					unique_accessible_node = false;
					break;
				}
			}
			if (!unique_accessible_node) {
				break;
			}
			ds_list_add(temp_nd, current_node[| 6]);
			unique_accessible_node = false;
			break;
		}
	}
	if (unique_accessible_node) {
		ds_list_add(accessible_nodes, current_node);
	} else {
		ds_list_destroy(current_node);
	}
}