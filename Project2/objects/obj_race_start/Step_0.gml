//Start timer if the player touches it. 
    if(place_meeting(x, y, obj_player)){ 
        global.race_begin = true;
        global.race_timer = 0;
    } 

//Incriment timer by the time each frame. 
    if(global.race_begin == true){ 
        global.race_timer += (delta_time/1000000);
    }

