/// scr_fix_spawn();

if (place_meeting(x, y, obj_all)) {
    var y_minus = 0;
    var y_plus = 0;
    var x_minus = 0;
    var x_plus = 0;
    var move_x = 0;
    var move_y = 0;
    while(position_meeting(x+x_minus, y, obj_all)) {
        x_minus -= 1;
    }
    while(position_meeting(x+x_plus, y, obj_all)) {
        x_plus += 1;
    }
    while(position_meeting(x, y+y_minus, obj_all)) {
        y_minus -= 1;
    }
    while(position_meeting(x, y+y_plus, obj_all)) {
        y_plus += 1;
    }
    if (abs(x_minus) <= abs(x_plus)) {
        // Move to the left out of the object
        if ((x + x_minus) > 16) {
            // Not out of the room
            move_x = x_minus;
        }
    } else {
        // Move to the right out of the object
        if ((x + x_plus) < (room_width-16)) {
            // Not out of the room
            move_x = x_plus;
        }
    }
    if (abs(y_minus) <= abs(y_plus)) {
        // Move up out of the object
        if ((y + y_minus) > 16) {
            // Not out of the room
            move_y = y_minus;
        }
    } else {
        // Move to the right out of the object
        if ((y + y_plus) < (room_height-16)) {
            // Not out of the room
            move_y = y_plus;
        }
    }
    
    // Spawned  with center out of wall
    if (move_x == 0) {
        if (!place_meeting(x+16, y, obj_all)) {
            x += 16;
        } else {
            x -= 16;
        }
    } else {
        x += move_x + (sign(move_x)*16);
    }
    if (move_y == 0) {
        if (!place_meeting(x, y+16, obj_all)) {
            y += 16;
        } else {
            y -= 16;
        }
    } else {
        y += move_y + (sign(move_y)*16);
    }
}
