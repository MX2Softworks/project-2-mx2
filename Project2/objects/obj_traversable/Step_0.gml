if (keyboard_check_pressed(ord("P"))) {
    debug_toggle = !debug_toggle;
}

if(keyboard_check_pressed(ord("1")) && chunk_size < 128) {

	chunk_size += 16;
	regen_graph = true; 
}

if(keyboard_check_pressed(ord("2")) && chunk_size > 16) {

	chunk_size -= 16;
	regen_graph = true; 
}

if(regen_graph){

	regen_graph = false;
	ds_list_destroy(solids_list);
	ds_list_destroy(flattened_level);
	scr_navigable_terrain();
}
