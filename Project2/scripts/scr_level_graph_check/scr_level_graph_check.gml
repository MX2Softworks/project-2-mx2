/// @description Checks each node in the current level and adds the accessible ones to a list.

// The list of accessible nodes.
accessible_nodes = ds_list_create();

// Add the starting node. The starting position is determined by the spawn of the object.
starting_node = ds_list_create();
ds_list_add(starting_node, obj_generic_chaser.x, obj_generic_chaser.y);
ds_list_add(accessible_nodes, starting_node);

// Create the queue.
unchecked_nodes = ds_queue_create();

// Add the starting node to the queue.
ds_queue_enqueue(unchecked_nodes, starting_node);

// Find all the accessible nodes.
while (!ds_queue_empty(unchecked_nodes)) {
	
}