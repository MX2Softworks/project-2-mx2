/// Used to add to the debug path.

if (keyboard_check_pressed(ord("O"))) {
    debug_toggle = !debug_toggle
}


if (keyboard_check_pressed(ord("L"))) {
	draw_debug_line = !draw_debug_line;
	if (draw_debug_line) {
		if (path_exists(player_path_id)) {
			path_delete(player_path_id);
		}
		player_path_id = path_add();
		player_x = obj_player.x;
		player_y = obj_player.y;
		path_set_closed(player_path_id, false);
	}
}

if (draw_debug_line) {
	if (obj_player.previous_x != obj_player.current_x || obj_player.previous_y != obj_player.current_y) {
		path_add_point(player_path_id, obj_player.x, obj_player.y, 1);
	}
}