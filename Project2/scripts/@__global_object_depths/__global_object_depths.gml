// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = -10; // obj_debugtext
global.__objectDepths[1] = -1000; // obj_game_mode
global.__objectDepths[2] = -1001; // obj_pause_menu
global.__objectDepths[3] = 1000; // obj_blur
global.__objectDepths[4] = 0; // obj_enemy_thrower
global.__objectDepths[5] = 0; // obj_enemy_heavy
global.__objectDepths[6] = 0; // obj_fireball
global.__objectDepths[7] = 0; // obj_enemy_patrol
global.__objectDepths[8] = 0; // obj_sound_player
global.__objectDepths[9] = 0; // obj_platform_solid
global.__objectDepths[10] = -10; // obj_dynamic_camera
global.__objectDepths[11] = 0; // obj_saw_test
global.__objectDepths[12] = 0; // obj_enemy_pathfinder
global.__objectDepths[13] = 0; // obj_player
global.__objectDepths[14] = 0; // obj_delta_tracker
global.__objectDepths[15] = 0; // obj_moving_platform_bound
global.__objectDepths[16] = 0; // obj_solid
global.__objectDepths[17] = 0; // obj_platform
global.__objectDepths[18] = 0; // obj_moving_platform
global.__objectDepths[19] = 0; // obj_door_3
global.__objectDepths[20] = 0; // obj_door_2
global.__objectDepths[21] = 0; // obj_race_end
global.__objectDepths[22] = 0; // obj_race_start
global.__objectDepths[23] = 0; // obj_key_2
global.__objectDepths[24] = 0; // obj_key_3
global.__objectDepths[25] = 0; // obj_door_0
global.__objectDepths[26] = 0; // obj_key_1
global.__objectDepths[27] = 0; // obj_door_1
global.__objectDepths[28] = 0; // obj_all
global.__objectDepths[29] = 0; // obj_spawn_fireballs
global.__objectDepths[30] = 0; // obj_random_fireball


global.__objectNames[0] = "obj_debugtext";
global.__objectNames[1] = "obj_game_mode";
global.__objectNames[2] = "obj_pause_menu";
global.__objectNames[3] = "obj_blur";
global.__objectNames[4] = "obj_enemy_thrower";
global.__objectNames[5] = "obj_enemy_heavy";
global.__objectNames[6] = "obj_fireball";
global.__objectNames[7] = "obj_enemy_patrol";
global.__objectNames[8] = "obj_sound_player";
global.__objectNames[9] = "obj_platform_solid";
global.__objectNames[10] = "obj_dynamic_camera";
global.__objectNames[11] = "obj_saw_test";
global.__objectNames[12] = "obj_enemy_pathfinder";
global.__objectNames[13] = "obj_player";
global.__objectNames[14] = "obj_delta_tracker";
global.__objectNames[15] = "obj_moving_platform_bound";
global.__objectNames[16] = "obj_solid";
global.__objectNames[17] = "obj_platform";
global.__objectNames[18] = "obj_moving_platform";
global.__objectNames[19] = "obj_door_3";
global.__objectNames[20] = "obj_door_2";
global.__objectNames[21] = "obj_race_end";
global.__objectNames[22] = "obj_race_start";
global.__objectNames[23] = "obj_key_2";
global.__objectNames[24] = "obj_key_3";
global.__objectNames[25] = "obj_door_0";
global.__objectNames[26] = "obj_key_1";
global.__objectNames[27] = "obj_door_1";
global.__objectNames[28] = "obj_all";
global.__objectNames[29] = "obj_spawn_fireballs";
global.__objectNames[30] = "obj_random_fireball";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	if (objID >= 0) {
		global.__objectID2Depth[ objID ] = global.__objectDepths[i];
	} // end if
} // end for