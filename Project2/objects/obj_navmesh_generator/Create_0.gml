/// Last instance to load in a room.

// The mask information of the AI.
ai_mask_height = obj_generic_chaser.mask_height;
ai_mask_width = obj_generic_chaser.mask_width;

// Scale the sprite to the height of the AI's mask.
image_yscale = ai_mask_height;
image_xscale = 32;

// Create the list for the platform nodes.
platform_nodes = ds_list_create();

time_passed = current_time;

// Check the level for platforms. As of now all platforms must be at least 32 pixels in length.
var new_platform = true;
for (var i = 0; i < instance_number(obj_solid); i++) {
	var current_obj = instance_find(obj_solid, i);
	if (!place_meeting(current_obj.x, current_obj.y - ai_mask_height, obj_solid)) {
		// No collision; valid platform.
		new_platform = true;
		for (var j = 0; j < ds_list_size(platform_nodes); j++) {
			var partial_plat = platform_nodes[| j];
			if (((partial_plat[| 0] + partial_plat[| 2]) == current_obj.x) && (partial_plat[| 1] == (current_obj.y - ai_mask_height))) {
				// Add new part onto the end of the current platform.
				var new_plat = ds_list_create();
				ds_list_add(new_plat, partial_plat[| 0], partial_plat[| 1], (partial_plat[| 2] + 32));
				ds_list_set(platform_nodes, j, new_plat);
				ds_list_destroy(partial_plat);
				new_platform = false;
				break;
			} else if (((partial_plat[| 0] - 32) == current_obj.x) && (partial_plat[| 1] == (current_obj.y - ai_mask_height))) {
				// Add new part onto the front of the current platform.
				var new_plat = ds_list_create();
				ds_list_add(new_plat, (partial_plat[| 0] - 32), partial_plat[| 1], (partial_plat[| 2] + 32));
				ds_list_set(platform_nodes, j, new_plat);
				ds_list_destroy(partial_plat);
				new_platform = false;
				break;
			}
		}
		if (new_platform) {
			// Add a new partial platform to the platform nodes list.
			var temp_plat = ds_list_create();
			ds_list_add(temp_plat, current_obj.x, (current_obj.y - ai_mask_height), 32);
			ds_list_add(platform_nodes, temp_plat);
		}
	} else {
		// Collided with something try walking it back a pixel at a time.
		
	}
}
// For the last time try to combine platforms.
for (var i = 0; i < ds_list_size(platform_nodes); i++) {
	var current_plat = platform_nodes[| i];
	for (var j = 0; j < ds_list_size(platform_nodes); j++) {
		var compare_plat = platform_nodes[| j];
		if (((current_plat[| 0] + current_plat[| 2]) == compare_plat[| 0]) && (current_plat[| 1] == compare_plat[| 1])) {
			// Add compare plat to the end of the current plat.
			var new_plat = ds_list_create();
			ds_list_add(new_plat, current_plat[| 0], current_plat[| 1], (current_plat[| 2] + compare_plat[| 2]));
			ds_list_set(platform_nodes, i, new_plat);
			ds_list_destroy(current_plat);
			current_plat = platform_nodes[| i];
			ds_list_delete(platform_nodes, j);
			ds_list_destroy(compare_plat);
			if (i > j) {
				i--;
			}
			j--;
		} else if (((current_plat[| 0] - compare_plat[| 2]) == compare_plat[| 0]) && (current_plat[| 1] == compare_plat[| 1])) {
			// Add compare plat to the front of the current plat.
			var new_plat = ds_list_create();
			ds_list_add(new_plat, compare_plat[| 0], current_plat[| 1], (current_plat[| 2] + compare_plat[| 2]));
			ds_list_set(platform_nodes, i, new_plat);
			ds_list_destroy(current_plat);
			current_plat = platform_nodes[| i];
			ds_list_delete(platform_nodes, j);
			ds_list_destroy(compare_plat);
			if (i > j) {
				i--;
			}
			j--;
		}
	}
}

//var platform_start_x = 0;
//var platform_start_y = 0;
//var platform_width = 0;
//var new_platform = true;
//for (var j = ai_mask_height; j < room_height; j++) {
//	for (var i = 0; i < room_width; i++) {
//		if (position_meeting(i, j, obj_solid) && !place_meeting(i, j-ai_mask_height, obj_solid)) {
//			// Part of a platform.
//			if (new_platform) {
//				platform_start_x = i;
//				platform_start_y = j-ai_mask_height;
//				new_platform = false;
//			}
//			platform_width++;
//		} else {
//			// Not part of a platform.
//			if (!new_platform) {
//				// Save platform.
//				var new_node = ds_list_create();
//				// Add: start_x, start_y, width
//				ds_list_add(new_node, platform_start_x, platform_start_y, platform_width);
//				ds_list_add(platform_nodes, new_node);
//				new_platform = true;
//				platform_width = 0;
//			}
//		}
//	}
//}

time_passed = current_time - time_passed;