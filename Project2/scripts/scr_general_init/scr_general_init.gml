/// @description A script for the general initialization of objects.

// Movement.
	previous_hspd = 0;
    current_hspd = 0;
	previous_vspd = 0;
    current_vspd = 0;
	previous_x = x;
	current_x = x;
	previous_y = y;
	current_y = y;
	previous_xacc = 0;
    current_xacc = 0;
	previous_yacc = 1200;
    current_yacc = 1200;
    xrem = 0;
    yrem = 0;

// State.
	on_ground = true;

// Time step.
	accumulator = 0;

// Collisions.
	collision_x = false;
	collision_y = false;
