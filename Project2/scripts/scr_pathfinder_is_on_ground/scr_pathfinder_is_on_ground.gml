var pathfinder = argument0;
var loc_x = argument1;
var loc_y = argument2;

if(!is_undefined(pathfinder) && loc_x > -1 && loc_x < pathfinder.grid_x_dim && loc_y + 1 > -1 && loc_y + 1 < pathfinder.grid_y_dim){

	if(pathfinder.grid[loc_x, loc_y+1] == 0) return true;
}
return false;