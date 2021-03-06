enum L{
	xy = 0,
	z = 1
}

enum PNF{
	F = 0,
	G = 1,
	PX = 2,
	PY = 3,
	PZ = 4,
	status = 5,
	jump_length =6

}

 
//Diagonals = true;
//mPunishChangeDirection  = false;
//mTieBreaker = false;
//mHeavyDiagonals  = false;
//completed_time  = 0;

on_ground_list = "";
at_ceiling_list = "";
wall_jump_list = "";
search_counter = 0;

find_path = false;
highlight_path = false;
regen_graph = false;

end_x = -1;
end_y = -1;
start_x = -1;
start_y = -1; 
max_value = 2000000000

nodes = ""; //a list of a (list of nodes) in our graph. 
touched_locations = ""; //places we've modified, used in optimizations.
open_list = "";
closed_list = "";
stop = false;
stopped = false;
formula = "man";
H_estimate = 2;
search_limit  = argument0;
is_open = 1;
is_closed= 2;
	
//Promoted local variables to member variables to avoid recreation between calls
H                       = 0;
location                = 0;
new_location_xy         = 0;
node                    = 0;
location_x              = 0;
location_y              = 0;
new_location_x          = 0;
new_location_y          = 0;
closed_node_counter     = 0;
found                   = false;
diagonal_valid			= argument1;
direction_vector		= [[0,-1],[1,0], [0,1], [-1,0], [1,-1], [1,1], [-1,1], [-1,-1]]
end_location_xy         = 0;
new_G                   = 0;
node_list 				= 0;
grid[0, 0]				= 0;
grid_x_dim = floor(room_width/chunk_size);
grid_y_dim = floor(room_height/chunk_size);

//Go through the level and mark any chunk that does not have a solid present as a valid chunk. 
counter = 0;
for(var x_index = 0; x_index < grid_x_dim; x_index++){
	for(var y_index = 0; y_index < grid_y_dim; y_index++){
		
		var solid_at_grid = (  instance_position(x_index*chunk_size, y_index*chunk_size, obj_solid) 
		                    || instance_position(x_index*chunk_size + chunk_size/2,  y_index*chunk_size + chunk_size/2, obj_solid) 
							|| instance_position(x_index*chunk_size + chunk_size -1, y_index*chunk_size + chunk_size-1, obj_solid)); 
		if(solid_at_grid){
			grid[x_index, y_index] = 0;
		}
		else{
			grid[x_index, y_index] = 1;
		}
		counter++;
	}
}

//nodes = new list of pathFinderNodeFast with length of grid_x_dim * grid_y_dim
if (nodes == "" || ds_list_size(nodes) != (grid_x_dim * grid_y_dim))
{
	//init nodes
	
	if(nodes != ""){
	
		for(var index = 0; index < ds_list_size(nodes); index++){
			node_list = nodes[|index];
			ds_list_destroy(node_list);
		}
		ds_list_destroy(nodes);
	}
	nodes = ds_list_create();
	for(var index = 0; index < grid_x_dim * grid_y_dim; index++){
		nodes[|index] =  ds_list_create();
	}
	
	//init touched_locations
	if(touched_locations != "")
	{
		ds_stack_clear(touched_locations);
		ds_stack_destroy(touched_locations);
	}
    touched_locations = ds_stack_create(); //touched_locations = new stack of ints that is the size of grid_x_dim * grid_y_dim
	
	//init closed list
	if(closed_list != ""){
		ds_list_clear(closed_list);
	}
	closed_list = ds_list_create(); //closed_list is a list of 2d vectors with grid_x_dim * grid_y_dim vectors in it.
	for(var index = 0; index < grid_x_dim * grid_y_dim; index++){
		closed_list[|index] = [-1, -1]
	}
}

for (var i = 0; i < ds_list_size(nodes); ++i){
	ds_list_clear(nodes[|i]);
}

if(open_list != ""){

	while(ds_priority_size(open_list) > 0){
		ds_priority_delete_min(open_list);
	}
	ds_priority_destroy(open_list);
}
open_list = ds_priority_create(); //have to stack locations and compare their priorities. open list is a priority queue that compares based off of F value