/// scr_move(collision_object)

/*
NOTE:  THIS ONLY CHECKS COLLISIONS WITH THE ENVIRONMENT NOT OTHER CHARACTERS.
*/

var collision_object = argument0;

var hspd_total = hspd + hspd_platform;
var vspd_total = vspd + vspd_platform; 

// Check if there is a horizontal collision
var movedis_x = sign(hspd);
var pathfree_x = true;
if(hspd_total != 0){
    while(abs(movedis_x) <= ceil(abs(hspd_total*global.delta))){
        if(place_meeting(x+movedis_x, y, obj_solid)){
            pathfree_x = false; 
        }
        movedis_x += sign(hspd_total); 
    }
}
if (!pathfree_x) {
    // Something is in the character's path so move 1 pixel at a time
    while (!place_meeting(x+sign(hspd_total), y, obj_solid)) {
        x += sign(hspd_total);
    }
    hspd = 0;
} 
else {
    x += hspd_total * global.delta;
    // Collision safety net
    while (place_meeting(x, y, obj_solid)) {
        if (hspd_total != 0) {
            x -= sign(hspd_total);
        } else {
            scr_fix_spawn(obj_solid);
        }
    }
}

// Check if there is a vertical collision
var movedis_y = sign(vspd);
var pathfree_y = true;
if (vspd_total != 0) {
    while(abs(movedis_y) <= ceil(abs(vspd_total*global.delta))){
        if(place_meeting(x, y+movedis_y, obj_solid)){
            pathfree_y = false; 
        }
        movedis_y += sign(vspd_total); 
    }
}
if (!pathfree_y) {
    // Something is in the character's path so move 1 pixel at a time
    while (!place_meeting(x, y+sign(vspd_total), obj_solid)) {
        y += sign(vspd_total);
    }
    vspd = 0;
} else {
    y += vspd_total * global.delta;
    // Collision safety net
    while (place_meeting(x, y, obj_solid)) {
        if (vspd_total != 0) {
            y -= sign(vspd_total);
        } else {
            scr_fix_spawn(obj_solid);
        }
    }
}

hspd_platform = 0;
vspd_platform = 0; 
