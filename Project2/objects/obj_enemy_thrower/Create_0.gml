/// @description  Initialize the enemy thrower

sprite_index = spr_thrower;
strength = 5;
range = 1000;
timer = 0;
duration = 0;
soundplayed = 0;

// Create the audio emitter
    audio_em = audio_emitter_create();
    
scr_fix_spawn(obj_all);

