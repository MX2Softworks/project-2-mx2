pathfinder = argument0;
loc_x = argument1;
loc_y = argument2;


if(loc_x > 0 && loc_x < pathfinder.grid_x_dim-1 && loc_y > 0 && loc_y < pathfinder.grid_y_dim-1){
	if(pathfinder.grid[loc_x - 1, loc_y] == 0){
		return 1;
	}
	if(pathfinder.grid[loc_x + 1, loc_y] == 0){
		return 2;
	}
}

return 0;