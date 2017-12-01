/// @description AI navmesh.

for (var i = 0; i < instance_number(obj_solid); i++) {
	var selected_solid = instance_find(obj_solid, i);
	
	if (collision_rectangle(selected_solid.x, selected_solid.y-32, selected_solid.x+31, selected_solid.y-1, obj_all, false, false) == noone) {
		draw_set_color(c_red);
		draw_text(selected_solid.x, selected_solid.y-16, string(i));
		draw_rectangle(selected_solid.x, selected_solid.y-32, selected_solid.x+31, selected_solid.y-1, true);
	}
	
	draw_set_color(c_lime);
	draw_text(selected_solid.x, selected_solid.y, string(i));
}

// To combine the squares:
// Check the bottom left and bottom right coordinates.
// Cases:
//		Collide Left:	Right end of platform.
//		Collide Right:	Left end of platform.
//		Collide Both:	Middle of platform.
//		No Collide:		Full platform.
// Store platforms in list to connect them.