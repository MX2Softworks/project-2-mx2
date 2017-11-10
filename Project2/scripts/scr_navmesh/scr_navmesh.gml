/// @description AI navmesh.

for (var i = 0; i < instance_number(obj_solid); i++) {
	var selected_solid = instance_find(obj_solid, i);
	
	draw_set_color(c_lime);
	draw_text(selected_solid.x, selected_solid.y, string(i));
}