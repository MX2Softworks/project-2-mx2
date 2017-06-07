/// 

if (path_exists(player_path_id)) {
	path_delete(player_path_id);
}

player_path_id = path_add();
player_x = obj_player.x;
player_y = obj_player.y;
path_set_closed(player_path_id, false);