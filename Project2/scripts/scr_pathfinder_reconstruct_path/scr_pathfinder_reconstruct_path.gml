var filter_on = argument0;

//we will store the path in the closed list.
ds_list_clear(closed_list);
var pos_x = end_x;
var pos_y = end_y;
		
var prev_node_temp = [-1,-1,-1,-1,-1,-1,-1]; //pathfinder node.
node_list = nodes[|end_location_xy]; //pathfinder node.
var node_temp = node_list[|0];
		
var temp_loc = [end_x, end_y];
var prev_node = [end_x, end_y];

var loc_xy = node_temp[PNF.PY] * grid_x_dim + node_temp[PNF.PX]; //loc_xy is the XY position of the node to be processed next. 
		
//keep going until you hit the start node. 
while (temp_loc[0] != node_temp[PNF.PX] || temp_loc[1] != node_temp[PNF.PY]){

	//get the next pathfinder node
	node_list = nodes[|loc_xy];
	var next_node_temp = node_list[|node_temp[PNF.PZ]]; 
	if(filter_on){
		//initalize some values used in the if conditional.
			
			var closed_list_last = -1;
			var closed_list_last_x = -1;
			var closed_list_last_y = -1;
			if(ds_list_size(closed_list) -1 > -1){
				closed_list_last= closed_list[| ds_list_size(closed_list) - 1];
				closed_list_last_x = closed_list_last[0];
				closed_list_last_y = closed_list_last[1];
			}
			
			//checks if left neighbor or right neighbor are on ground.
			var adjacent_on_ground = false
			if((temp_loc[0] -1 > -1 && temp_loc[1] + 1 < grid_y_dim && grid[temp_loc[0] - 1, temp_loc[1] + 1] == 0) || (temp_loc[0] +1 < grid_x_dim && temp_loc[1] + 1 <= grid_y_dim && grid[temp_loc[0] - 1, temp_loc[1] + 1] == 0))
				{ adjacent_on_ground = true; }
			
			//check if node is a wall_jump.
			var wall_jump = false;
			if((temp_loc[0] +1 < grid_x_dim && grid[temp_loc[0] +1, temp_loc[1]] == 0) || (temp_loc[0] - 1 > -1 && grid[temp_loc[0] -1, temp_loc[1]] == 0)) wall_jump = true;
				
		//Now let's start the filtering process. The start node will get added to the list at the very end, after all other items have been dealt with. 
		//Since we're going from the end node, let's be sure to include that one in our final path:
		if (ds_list_size(closed_list) == 0 //add the ending node.
			|| (node_temp[PNF.jump_length] == 3)  
			|| (next_node_temp[PNF.jump_length] != 0 && node_temp[PNF.jump_length] == 0)   //mark jumps starts
			|| (node_temp[PNF.jump_length] == 0 && prev_node_temp[PNF.jump_length] != 0)   //mark landings
			|| (temp_loc[1] > closed_list_last_y && temp_loc[1] > node_temp[PNF.PY])
			|| (temp_loc[1] < closed_list_last_y && temp_loc[1] < node_temp[PNF.PY])
			|| (adjacent_on_ground == true && temp_loc[1] != closed_list_last_y && temp_loc[0] != closed_list_last_x))
			|| (wall_jump)
			{ds_list_add(closed_list, temp_loc);}
	}
	else{
		ds_list_add(closed_list, temp_loc);
	}
	prev_node = temp_loc;
	pos_x = node_temp[PNF.PX];
	pos_y = node_temp[PNF.PY];
	prev_node_temp = node_temp;
	node_temp = next_node_temp;	
	loc_xy = node_temp[PNF.PY] * grid_x_dim + node_temp[PNF.PX];
	temp_loc = [pos_x, pos_y];
}
			
//ds_list_add(closed_list, temp_loc);
stopped = true;
highlight_path = true;
search_check = true;
return;