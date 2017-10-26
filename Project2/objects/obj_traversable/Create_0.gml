depth = 10;
regen_graph = false;
chunk_size = 32; 
debug_toggle = false; 
path_to_goal = ds_list_create();
path_interval = 1.5;
clock = 0.0

player_chunk_x = -1;
player_chunk_y = -1;

chaser_chunk_x = -1;
chaser_chunk_y = -1; 

closed_list = ds_list_create();
open_list = ds_list_create();

continuing = 0; 

came_from[0,0] = [0,0];
g_score[0,0] = -1;
f_score[0,0] = -1;
max_value = 2000000000

current = -1;

scr_navigable_terrain()