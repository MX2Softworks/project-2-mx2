/// On creation.

// State.
	new_state = "state_idle";
	map_check = true;

// Mask information.
	mask_width = (sprite_get_bbox_right(sprite_index) + 1) - sprite_get_bbox_left(sprite_index);
	mask_height = (sprite_get_bbox_bottom(sprite_index) + 1) - sprite_get_bbox_top(sprite_index);

// Load general variables.
script_execute(scr_general_init);