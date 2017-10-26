
//this will determine how far away from a solid block is considered navigable. 
// -move_distance is used to keep the navigable region relatively constant. 
h_move_distance = 128;
v_move_distance = 96; 
var h_max_distance = ceil(1.0 * h_move_distance/chunk_size);
var v_max_distance = ceil(1.0 * v_move_distance/chunk_size);

//A list containing coordinates of all obj_solids separated into chunks. 
solids_list = ds_list_create();
flattened_level = ds_list_create();

//the level map is a temporary 2d representation used to populate the falttened level list
//flattened level contains a given node's x and y coordinates and a value to determine whether it is navigable.
//	-the current navigable value is 1
//var level_map;

level_map[0, 0] = 0;
level_map_width = floor(room_width/chunk_size);
level_map_height = floor(room_height/chunk_size);

for(var x_index = 0; x_index < level_map_width; x_index++){
	for(var y_index = 0; y_index < level_map_height; y_index++){
		level_map[x_index, y_index] = 0; 
	}
}

//Go through all solid objects, create a level map and populate the solids list. 
for(var index = 0; index < instance_number(obj_solid); index++){
	
	//a reference to a solid object. 
	var solid_ref = instance_find(obj_solid, index);	
	
	//determines how many chunk the object itself takes up, minimum of 1 chunk. 
	var chunk_height = ceil(1.0 * solid_ref.sprite_height/chunk_size);
	var chunk_width = ceil(1.0 * solid_ref.sprite_width/chunk_size);
	
	
	for (var height_index = 0; height_index < chunk_height; height_index++){
		for(var width_index = 0; width_index < chunk_width; width_index++){
			if(level_map[floor(solid_ref.x/chunk_size+chunk_width), floor(solid_ref.y/chunk_size+chunk_height)] != 2){
				level_map[floor(solid_ref.x/chunk_size+chunk_width), floor(solid_ref.y/chunk_size+chunk_height)] = 2;
				ds_list_add(solids_list, [floor(solid_ref.x/chunk_size+width_index), floor(solid_ref.y/chunk_size+height_index)]);
			}
		}
	}
}

//Generate navigable nodes. 
for(var index = 0; index < ds_list_size(solids_list); index++){
	var node = solids_list[|index];
	for(x_index = -1 * h_max_distance; x_index < h_max_distance + 1 + h_max_distance; x_index++){
		for(y_index = -1 * v_max_distance; y_index <= 0; y_index++){
			
			var curr_x = node[0]+x_index;
			var curr_y = node[1]+y_index;
			var valid = curr_x >= 0 && curr_x < level_map_width && curr_y >= 0 && curr_y < level_map_height;
			
			if(valid && !instance_position(curr_x*chunk_size, curr_y*chunk_size, obj_solid)){
				if(level_map[curr_x, curr_y] != 1){
					level_map[curr_x, curr_y] = 1;
					ds_list_add(flattened_level, [curr_x, curr_y, 1]);
				}
			}
		}
	}
}