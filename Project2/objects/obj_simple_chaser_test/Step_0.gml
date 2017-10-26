if(mouse_check_button_pressed(mb_left) && instance_position(mouse_x, mouse_y, self)){

	selected = !selected;
}

if(selected){

	x = mouse_x;
	y = mouse_y;
}