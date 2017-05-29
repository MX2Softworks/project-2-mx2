/// @description If Game is Paused

accumulator += global.frame_time;

//Pause Animations if Pause Game
if(instance_exists(obj_game_mode) && global.pauseActive == true){
    if(image_speed != 0){
        speed_before_pause = image_speed;
        image_speed = 0;
    }
    exit;  
}
else if(instance_exists(obj_game_mode) && global.pauseActive == false){
    if(image_speed == 0 && speed_before_pause != 0){
        image_speed = speed_before_pause; 
        speed_before_pause = 0; 
    }
}

/// Execute the state
scr_fix_spawn(obj_solid)
scr_get_input();
script_execute(state);

/// Key Collection

// Pick up key 1
if (place_meeting(x, y, obj_key_1) && pickup_item) {
    global.key_1_collected = true;
    with (instance_find(obj_key_1, 0)) {
        instance_destroy();
    }
}
// Pick up key 2
if (place_meeting(x, y, obj_key_2) && pickup_item) {
    global.key_2_collected = true;
    with (instance_find(obj_key_2, 0)) {
        instance_destroy();
    }
}
// Pick up key 4
if (place_meeting(x, y, obj_key_3) && pickup_item) {
    global.key_3_collected = true;
    with (instance_find(obj_key_3, 0)) {
        instance_destroy();
    }
}

/// Door Collision Events

switch(room) {
    case rm_one:
        // In hub room
        if (place_meeting(x, y, obj_door_1) && open_door && global.key_1_collected) {
            room_goto(rm_two);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_one;
        }
        if (place_meeting(x, y, obj_door_2) && open_door && global.key_2_collected) {
            room_goto(rm_three);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_one;
        }
        if (place_meeting(x, y, obj_door_3) && open_door && global.key_3_collected) {
            room_goto(rm_four);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_one;
        }
        break;
    case rm_two:
        // In room two
        if (place_meeting(x, y, obj_door_0) && open_door) {
            room_goto(rm_one);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_two;
        }
        break;
    case rm_three:
        // In room three
        if (place_meeting(x, y, obj_door_0) && open_door) {
            room_goto(rm_one);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_three;
        }
        break;
    case rm_four:
        // In room four
        if (place_meeting(x, y, obj_door_0) && open_door) {
            room_goto(rm_one);
            audio_emitter_gain(audio_em, .5);
            audio_play_sound_on(audio_em, snd_gong, false, 8);
            global.last_room = rm_four;
        }
        break;
}

///Animations
//Horizontal animations if no vertical speed. 
    
    //Switches to idle if hspd and vspd are 0 and the player is in the running animation
    //Reset the max speed to normal, in case the player was rolling. 
    if(hspd == 0 && vspd == 0 && ( sprite_index == spr_fahad_player_test_1 
       || ((sprite_index == spr_player_slide_to_crouch && !down_held && !down && !diag_dl && !diag_dr)
       && !place_meeting(x, y-8, obj_solid))
       )
      ){ 
        sprite_index = spr_player_idle; 
        maxspd = 8; 
        image_index = 0; 
        is_rolling = 0;
        is_sliding = 0; 
    }
    //Switches to running if we have any hspd but aren't jumping/falling.
    //Reset max speed to normal, in case the player was previously rolling.
    else if(hspd != 0 && vspd == 0 && !diag_dl_held && !diag_dr_held
            && (sprite_index == spr_player_idle || sprite_index == spr_fahad_player_test_1 || sprite_index == spr_player_wall_slide)
           ){
        sprite_index = spr_fahad_player_test_1; 
        maxspd = 8;   
        image_speed = .13*abs(hspd)/4 * (delta_time)/(1/60*1000000); //animation speed is a factor of our speed. 
        is_rolling = 0;
        is_sliding = 0;
    }
    
//Jumping and falling animation based on previous animation conditions. 
    
    //Switches to jump animation if we are moving upwards and haven't already switched.
    if(vspd < 0 && (sprite_index == spr_fahad_player_test_1 || sprite_index == spr_player_idle || sprite_index == spr_player_slide || sprite_index == spr_player_fall
        || sprite_index == spr_player_wall_slide || ((sprite_index == spr_player_slide_to_crouch || sprite_index == spr_player_roll) 
        && !place_meeting(x, y-8, obj_solid))) 
      ){
        is_rolling = 0;
        is_sliding = 0; 
        sprite_index = spr_player_jump;
        image_index = 0; 
        image_speed = (delta_time)/(1/9*1000000); 
    }
    //Stops jump animation on the last frame.
    else if(vspd < 0 && sprite_index == spr_player_jump && image_index > image_number-1){
        image_speed = 0; 
        image_index = 2;
        is_rolling = 0;
        is_sliding = 0;  
    }
    //Switches to the falling animation if the player is moving downwards and hasn't already switched. 
    else if(vspd > 0 && sprite_index != spr_player_fall && sprite_index != spr_player_wall_slide){ 
        sprite_index = spr_player_fall;
        image_speed = 0; 
        image_index = 0;
        is_rolling = 0;
        is_sliding = 0; 
        
    }
    //Starts playing the falling animation once the player hits the ground or if the player has finished a dash. 
    else if(vspd == 0 
            && ((sprite_index == spr_player_fall && image_index == 0) || 
               ((sprite_index == spr_player_dash  ||  sprite_index == spr_player_dash_horizontal) 
               && dashed == false && image_speed == 0))
           ){
        sprite_index = spr_player_fall;
        image_index = 0; 
        image_speed = (delta_time)/(1/15*1000000);
        is_rolling = 0;
        is_sliding = 0;  
    }
    //Switches back to idle once the falling animation finishes. 
    else if(floor(vspd) == 0 && sprite_index == spr_player_fall && image_index > image_number-1){
        sprite_index = spr_player_idle; 
        image_index = 0;
        is_rolling = 0;
        is_sliding = 0; 
    }
    
//Sliding Animations
    
    //Switches to the sliding animation if the player presses down and hasn't already been switched. 
    if((down_held || diag_dr_held || diag_dl_held) && place_meeting(x, y+16, obj_solid) && hspd != 0 
        && sprite_index != spr_player_slide && sprite_index != spr_player_crouch 
        && sprite_index != spr_player_slide_to_crouch && sprite_index != spr_player_roll
      ){
        sprite_index = spr_player_slide;
        image_index = 0;
        image_speed = (delta_time)/(1/15*1000000);
        is_sliding = 1;
        is_rolling = 0;
    }
    //Stops the sliding animation on the slide 
    if(sprite_index == spr_player_slide && image_index >= 3 && image_index < 4){
        image_index = 3; 
        image_speed = 0;
        is_sliding = 1;
        is_rolling = 0; 
    }
    //Reverses the sliding animation if the player lets go of the down key. 
    if(!down && !down_held && !diag_dl_held && !diag_dr_held && hspd == 0 
       && sprite_index == spr_player_slide && image_index <= (image_number/2)
       && !place_meeting(x, y-8, obj_solid)
      ){
        image_index = image_number-1 - image_index; 
        image_speed = (delta_time)/(1/15*1000000);
        is_sliding = 1;
        is_rolling = 0; 
    }
    //Switches to the idle animation if the down key is not being pressed and the sliding animation has finished.
    else if(!down && !down_held && !diag_dl_held && !diag_dr_held && sprite_index == spr_player_slide && image_index > image_number-1
            && !place_meeting(x, y-8, obj_solid)
           ){
        sprite_index = spr_player_idle;  
        image_index = 0; 
        is_sliding = 0;
        is_rolling = 0;  
    }
    
//Crouching Animation

    //Switches to the crouching animation if the player presses down, isn't moving, and hasn't already been switched.
    if((down || down_held || diag_dl_held || diag_dr_held) 
    && place_meeting(x, y+1, obj_solid) && hspd == 0 && sprite_index != spr_player_crouch 
        && sprite_index != spr_player_roll && sprite_index != spr_player_slide && sprite_index != spr_player_slide_to_crouch 
      ){
        sprite_index = spr_player_crouch; 
        image_index = 0;
        image_speed = (delta_time)/(1/9*1000000);
        is_sliding = 0;
        is_rolling = 0; 
    }
    //Stops the crouching animation on the squat.
    else if(sprite_index == spr_player_crouch && image_index > 2 && image_index < 3 && is_rolling == 0){
        image_index = 2;
        image_speed = 0;
        is_sliding = 0;
        is_rolling = 0; 
    }
    //Reverse the crouching animation if the player lets go of the down key. 
    else if(((!down && !down_held && !diag_dl_held && !diag_dr_held && hspd == 0) || (diag_ur_held || diag_ul_held)) 
            && sprite_index == spr_player_crouch && image_index <= (image_number/2)
            && !place_meeting(x, y-8, obj_solid) 
           ){
        image_index = image_number-1 - image_index; 
        image_speed = (delta_time)/(1/15*1000000);
        is_sliding = 0;
        is_rolling = 0; 
    }
    //Switches to the idle animation if the down key is not being pressed and the crouching animation has finished.
    else if(!down && !down_held && !diag_dl_held && !diag_dr_held 
            && sprite_index == spr_player_crouch && image_index > image_number-1 
            && !place_meeting(x, y-8, obj_solid) 
           ){
        sprite_index = spr_player_idle; 
        image_index = 0;
        is_sliding = 0;
        is_rolling = 0;   
    }
    
//Slide to Crouch Animation  

    //Switches the slide animation to the slide-to-crouch animation if hspd is 0 and the player is holdling/pressing down.
    if((down || down_held || diag_dl_held || diag_dr_held || place_meeting(x, y-8, obj_solid)) && hspd == 0 
       && sprite_index == spr_player_slide && image_index == 3
      ){
        sprite_index = spr_player_slide_to_crouch;
        image_index = 0;  
        image_speed = (delta_time)/(1/9*1000000); 
        is_sliding = 0;
        is_rolling = 0; 
         
    }
    //Switches to the crouch animation once the slide-to-crouch animation finishes. 
    else if((down || down_held || diag_dr || diag_dl || place_meeting(x, y-8, obj_solid)) && hspd == 0 
            && sprite_index == spr_player_slide_to_crouch && image_index > image_number-1
           ){
        image_speed = 0; 
        sprite_index = spr_player_crouch;
        image_index = 2;   
        is_sliding = 0;
        is_rolling = 0;
    }
     
//Rolling Animation

    //Switches to the rolling animation if down is being pressed and there is any horizontal speed and the player is in the crouching animation. 
    //Lower max speed to 3 when rolling.
    if((((down || down_held || diag_dl_held || diag_dr_held || place_meeting(x, y-8, obj_solid)) && (left || right)) 
       || (place_meeting(x, y+1, obj_solid) && !diag_ur_held && !diag_ul_held && (direction_horizontal != 0 || diag_dl_held || diag_dr_held || hspd != 0))) 
       && (sprite_index == spr_player_crouch || sprite_index == spr_player_slide_to_crouch)
      ){
        sprite_index = spr_player_roll;
        image_index = 0;
        image_speed = (delta_time)/(1/20*1000000); 
        is_sliding = 0;
        is_rolling = 1; 
        maxspd = 3;
    }
    //Switches to the crouching animation if the speed of the horizontal movement is 0.
    //Reset max speed to normal.  
    else if(sprite_index == spr_player_roll && (( hspd == 0 && direction_horizontal == 0) || (diag_ur_held || diag_ul_held)) && image_index > image_number-1){
        sprite_index = spr_player_crouch; 
        image_index = 2;
        image_speed = 0; 
        is_rolling = 0; 
        maxspd = 8; 
    }
    //If the rolling animation has not finished and the speed is 0, set the speed to 3 times the direction of the previous movement. 
    //Lower max speed to 3 when rolling.
    else if(sprite_index == spr_player_roll && ((hspd == 0 && direction_horizontal == 0) || (diag_ur_held || diag_ul_held)) && image_index <= image_number-1){
        hspd = 0; 
        if(!place_meeting(x+(3*sign(image_xscale)), y, obj_solid) 
           && !place_meeting(x+(2*sign(image_xscale)), y, obj_solid) 
           && !place_meeting(x+(1*sign(image_xscale)), y, obj_solid)){ 
            x += 3 * sign(image_xscale) * global.delta; 
        }
        is_rolling = 1;
        maxspd = 3; 
    }
    
//Dashing Animation

    //Switches to dash animation when the dash movement occurs and we have not already switched.
    if(dashed && (dash || charge_dash_released) && dash_count <= 3){
    
        if (dash_count == 3) {
            dash_count += 1;
        }
        
        if(((left_held || (diag_ul_held && abs(x_axis) >= abs(y_axis)) || (diag_dl_held && abs(x_axis) >= abs(y_axis))) 
           || (right_held || (diag_ur_held && abs(x_axis) >= abs(y_axis)) || (diag_dr_held && abs(x_axis) >= abs(y_axis))))
          ){ 
            sprite_index = spr_player_dash_horizontal; 
            image_index = 0;
            image_speed = (delta_time)/(1/60*1000000);  
        }
        else { 
            sprite_index = spr_player_dash; 
            image_index = 0;
            image_speed = (delta_time)/(1/30*1000000);  
        }
               
    }
    //Slows the dash speed down every frame once the player has switched to the dash animation.
    else if((sprite_index == spr_player_dash || sprite_index == spr_player_dash_horizontal)
            && !dash && !charge_dash_released){
        image_speed *= .955
    }
    
//Wall Slide
    
    //Switches to the wall slide animation when the player begins wall sliding
    if(wall_slide && sprite_index == spr_player_fall){
        sprite_index = spr_player_wall_slide; 
        image_index = 0;
        image_speed = (delta_time)/(1/15*1000000);
        is_rolling = 0; 
        is_sliding = 0; 
    }
    //Stops the animation on the last frame
    else if(wall_slide && sprite_index == spr_player_wall_slide && image_index > image_number-1){
        image_speed = 0;
        image_index = image_number-1;
    }
    else if(!wall_slide && vspd > 0 && sprite_index == spr_player_wall_slide)
    {
        sprite_index = spr_player_fall;
        image_index = 0;
        image_speed = 0; 
    } 
    
    

/// Sound Effects

//Jump
if((up && place_meeting(x, y+10, obj_solid) && vspd < 0) 
   || (up && wall_jump && wall_jump_counter < wall_jump_counter_max)
  ){
    audio_emitter_gain(audio_em, 1);
    audio_play_sound_on(audio_em, snd_jump_0, false, 10);
}

//Slide
if(((sprite_index == spr_player_wall_slide && image_index > 1) || (sprite_index == spr_player_slide && image_index > 1)) && !audio_is_playing(snd_slide)){
    audio_emitter_gain(audio_em, .06);
    audio_play_sound_on(audio_em, snd_slide, false, 10);
}
else if(sprite_index != spr_player_wall_slide && sprite_index != spr_player_slide && audio_is_playing(snd_slide)){
    audio_stop_sound(snd_slide); 
}




