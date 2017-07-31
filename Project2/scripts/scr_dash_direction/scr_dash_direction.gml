/// Determines the direction of the dash.

// Dashing up.
	if (((up_held && !gamepad_is_connected(0)) || (stick_up_held && gamepad_is_connected(0))) 
	|| (diag_ul_held && abs(y_axis) > abs(x_axis)) 
	|| (diag_ur_held && abs(y_axis) > abs(x_axis))) {
		dash_up = true;
		dash_left = false;
		dash_right = false;
	}

// Dashing left.
	if (left_held 
	|| (diag_ul_held && abs(x_axis) >= abs(y_axis)) 
	|| (diag_dl_held && abs(x_axis) >= abs(y_axis))) {
		dash_left = true;
		dash_right = false;
		dash_up = false;
	}

// Dashing right.
	if (right_held 
	|| (diag_ur_held && abs(x_axis) >= abs(y_axis)) 
	|| (diag_dr_held && abs(x_axis) >= abs(y_axis))) {
		dash_right = true;
		dash_left = false;
		dash_up = false;
	}