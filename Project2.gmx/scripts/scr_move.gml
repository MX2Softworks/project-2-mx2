/// scr_move(collision_object)

/*
NOTE:  THIS ONLY CHECKS COLLISIONS WITH THE ENVIRONMENT NOT OTHER CHARACTERS.
*/

var collision_object = argument0;

// Check if there is a horizontal collision
var movedis_x = sign(hspd);
var pathfree_x = true;
if(hspd !=0){
    while(abs(movedis_x) <= abs(hspd)){
        if(place_meeting(x+movedis_x, y, obj_solid)){
            pathfree_x = false; 
        }
        movedis_x += sign(hspd); 
    }
}
if (!pathfree_x) {
    // Something is in the character's path so move 1 pixel at a time
    while (!place_meeting(x+sign(hspd), y, obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
} 
else {
    x += hspd;
}

// Check if there is a vertical collision
var movedis_y = sign(vspd);
var pathfree_y = true;
if(vspd != 0){
    while(abs(movedis_y) <= abs(vspd)){
        if(place_meeting(x, y+movedis_y, obj_solid)){
            pathfree_y = false; 
        }
        movedis_y += sign(vspd); 
    }
}
if (!pathfree_y) {
    // Something is in the character's path so move 1 pixel at a time
    while (!place_meeting(x, y+/*(16*sign(vspd))+*/sign(vspd), obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
} else {
    y += vspd;
}
