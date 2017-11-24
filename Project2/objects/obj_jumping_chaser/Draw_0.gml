draw_self();


if(self.debug_toggle){
	for(var x_index = 0; x_index < self.grid_x_dim; x_index++){
		for(var y_index = 0; y_index < self.grid_y_dim; y_index++){
			if(self.grid[x_index, y_index] == 1){
				draw_rectangle_color(x_index * self.chunk_size, y_index*chunk_size, x_index*chunk_size + chunk_size, y_index*chunk_size + chunk_size, c_green, c_green, c_green, c_green, true);
			}
			else{
				draw_rectangle_color(x_index * self.chunk_size, y_index*chunk_size, x_index*chunk_size + chunk_size, y_index*chunk_size + chunk_size, c_aqua, c_aqua, c_aqua, c_aqua, false);
			}
		}
	}
	if(ds_stack_size(touched_locations) > 0){

		var temp_list = ds_list_create();
		var max_index = ds_stack_size(touched_locations)
		for(var index = 0; index < max_index; index++){
			var loc_xy = ds_stack_pop(touched_locations);
			var loc_x = floor(loc_xy % grid_x_dim);
			var loc_y = floor(loc_xy / grid_x_dim);
			draw_rectangle_color(loc_x * chunk_size, loc_y *chunk_size, loc_x *chunk_size + chunk_size, loc_y *chunk_size + chunk_size, c_yellow, c_yellow, c_yellow, c_yellow, true);
			ds_list_add(temp_list, loc_xy);
		}
	
		for(var index = ds_list_size(temp_list) - 1; index > -1; index--){
			var loc_xy = temp_list[|index];
			ds_stack_push(touched_locations, loc_xy);
		}
		ds_list_clear(temp_list);
		ds_list_destroy(temp_list);
		draw_once = false;
	}
}

if(on_ground_list != "" && ds_list_size(on_ground_list) > 0){
	for(var index = 0; index < ds_list_size(on_ground_list); index++){
		var elem = on_ground_list[|index];
		var loc_x = elem[0];
		var loc_y = elem[1];
		draw_rectangle_color(loc_x * chunk_size, loc_y *chunk_size, loc_x *chunk_size + chunk_size, loc_y *chunk_size + chunk_size, c_orange, c_orange, c_orange, c_orange, false);
	}
}

if(at_ceiling_list != "" && ds_list_size(at_ceiling_list) > 0){
	for(var index = 0; index < ds_list_size(at_ceiling_list); index++){
		var elem = at_ceiling_list[|index];
		var loc_x = elem[0];
		var loc_y = elem[1];
		draw_rectangle_color(loc_x * chunk_size, loc_y *chunk_size, loc_x *chunk_size + chunk_size, loc_y *chunk_size + chunk_size, c_navy, c_navy, c_navy, c_navy, false);
	}
}

if(wall_jump_list != "" && ds_list_size(wall_jump_list) > 0){
	for(var index = 0; index < ds_list_size(wall_jump_list); index++){
		var elem = wall_jump_list[|index];
		var loc_x = elem[0];
		var loc_y = elem[1];
		draw_rectangle_color(loc_x * chunk_size, loc_y *chunk_size, loc_x *chunk_size + chunk_size, loc_y *chunk_size + chunk_size, c_lime, c_lime, c_lime, c_lime, false);
	}
}

if(highlight_path){
	for(var index = 0; index < ds_list_size(closed_list); index++){
		var node = closed_list[|index];
		draw_rectangle_color(node[0] * chunk_size, node[1]*chunk_size, node[0]*chunk_size + chunk_size, node[1]*chunk_size + chunk_size, c_red, c_red, c_red, c_red, true);
	}
}
