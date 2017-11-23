/// Initialize delta tracker.

frame_counter = 0;
restart_counter = false;

// Fixed dt for updating physics 60 times a second.
global.dt = 1/60;

// Holds the time passed in seconds between frames.
global.frame_time = 0;

// Acts a signal for AI to redraw their grid. 
global.re_grid = false;