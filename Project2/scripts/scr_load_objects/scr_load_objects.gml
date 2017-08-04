/// @description Initialize objects if they don't exist.

if(!instance_exists(obj_delta_tracker)){
    instance_create(0, 0, obj_delta_tracker);
}
    
if(!instance_exists(obj_debugtext)){
    instance_create(0, 0, obj_debugtext);
}