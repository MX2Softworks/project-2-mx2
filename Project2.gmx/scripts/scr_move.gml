/// scr_move(collision_object)

/*
NOTE:  THIS ONLY CHECKS COLLISIONS WITH THE ENVIRONMENT NOT OTHER CHARACTERS.
*/


var collision_object = argument0;

// Check if there is a horizontal collision
var movedis_x = sign(hspd);
var pathfree_x = true;
while (movedis_x <= hspd && hspd != 0) {
    if (place_meeting(x+(16*sign(hspd))+movedis_x, y, obj_solid)) {
        pathfree_x = false;
    }
    movedis_x += sign(hspd);
}
if (!pathfree_x) {
    while (!place_meeting(x+(16*sign(hspd))+sign(hspd), y, obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
} else {
    x += hspd;
}

// Check if there is a vertical collision
var movedis_y = sign(vspd);
var pathfree_y = true;
while (movedis_y <= vspd && vspd != 0) {
    if (place_meeting(x, y+(16*sign(vspd))+movedis_y, obj_solid)) {
        pathfree_y = false;
    }
    movedis_y += sign(vspd);
}
if (!pathfree_y) {
    while (!place_meeting(x, y+(16*sign(vspd))+sign(vspd), obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
} else {
    y += vspd;
}
