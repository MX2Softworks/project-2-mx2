/// @description Initialize objects and layers if they don't exist.

if(!instance_exists(obj_delta_tracker)){
	if (!layer_exists("Invisible")) {
		layer_create(500, "Invisible");
	}
    instance_create_layer(0, 0, "Invisible", obj_delta_tracker);
}
    
if(!instance_exists(obj_debugtext)){
    if (!layer_exists("Debug")) {
		layer_create(1000, "Debug");
	}
	instance_create_layer(0, 0, "Debug", obj_debugtext);
}