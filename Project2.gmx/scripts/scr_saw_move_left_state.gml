/// scr_saw_move_left_state()

var wall_on_right = place_meeting(x+1, y, obj_solid);
var wall_on_left = place_meeting(x-1, y, obj_solid);
var end_of_path_right = !position_meeting(x+16+1, y+16+1, obj_solid);
var end_of_path_left = !position_meeting(x-16-1, y+16+1, obj_solid);

if (wall_on_left || end_of_path_left) {
    // No more room to move to the left
    
    state = scr_saw_move_right_state;
    
    // Check to see if there is room to move right
    if (!wall_on_right && !end_of_path_right) {
        image_rotation *= -1;
    }
}

// Rotate the image
//image_angle += image_rotation;

// Move the saw
if (hspd > -maxspd) {
    hspd += -1;
}

// Check if there is a horizontal collision
var movedis_x = sign(hspd);
var pathfree_x = true;
if(hspd != 0) {
    while(abs(movedis_x) <= abs(hspd)){
        if((place_meeting(x+movedis_x, y, obj_solid)) || (!position_meeting(x-16+movedis_x, y+16+1, obj_solid))){
            pathfree_x = false; 
        }
        movedis_x += sign(hspd); 
    }
}
if (!pathfree_x) {
    // Something is in the character's path so move 1 pixel at a time
    while ((!place_meeting(x+sign(hspd), y, obj_solid)) && position_meeting(x-16+sign(hspd), y+16+1, obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
} 
else {
    x += hspd;
}
