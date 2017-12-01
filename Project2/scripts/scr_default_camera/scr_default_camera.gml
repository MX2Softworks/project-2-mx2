/// @description Setting up the default view and camera for following the player.

// Enable views.
view_enabled = true;

// Make viewport 0 visible.
view_set_visible(0, true);

// Set the size of the window.
view_set_wport(0, 960);
view_set_hport(0, 540);

// Resize and center the window.
window_set_rectangle((display_get_width() - view_wport[0]) * 0.5, (display_get_height() - view_hport[0]) * 0.5, view_wport[0], view_hport[0]);
surface_resize(application_surface, view_wport[0], view_hport[0]);

// Create the camera.
default_cam = camera_create_view(0, 0, room_width, room_height, 0, obj_player, -1, -1, 720, 540);

// Assign the created camera to the view.
view_set_camera(0, default_cam);