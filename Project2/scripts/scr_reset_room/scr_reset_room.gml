// Resets the room to it's original state, without reseting the room

// Resets the player's coordinates to the start
obj_player.x = room_start_x;
obj_player.y = room_start_y;

// Resets the player's physics to avoid getting stuck at the spawn
script_execute(scr_general_init);

// Resets all deactivated instances
instance_activate_object(obj_door);

