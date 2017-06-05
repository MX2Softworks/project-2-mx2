/// Calculates the players acceleration based on the state of the player.

// cur = prev + 120
current_xacc = previous_xacc + (7200 * global.dt) * direction_horizontal;
current_yacc = previous_yacc + (7200 * global.dt) * direction_vertical;

if (current_xacc > 720) {
	current_xacc = 720;
}
if (current_xacc < -720) {
	current_xacc = -720;
}

if (current_yacc > 600) {
	current_yacc = 600;
}
if (current_yacc < -600) {
	current_yacc = -600;
}