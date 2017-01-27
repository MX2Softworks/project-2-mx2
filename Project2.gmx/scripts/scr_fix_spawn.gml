/// scr_fix_spawn();

var incr = 1;
var out_of_wall = false;
while (place_meeting(x, y, obj_all)) {
    // Check up
    if ((!place_meeting(x, y-incr, obj_all)) && !out_of_wall && (x > 16) && (x < room_width-16) && (y-incr > 16) && (y-incr < room_height-16)) {
        y -= (incr + 1);
        out_of_wall = true;
    }
    // Check right
    if ((!place_meeting(x+incr, y, obj_all)) && !out_of_wall && (x+incr > 16) && (x+incr < room_width-16) && (y > 16) && (y < room_height-16)) {
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down
    if ((!place_meeting(x, y+incr, obj_all)) && !out_of_wall && (x > 16) && (x < room_width-16) && (y+incr > 16) && (y+incr < room_height-16)) {
        y += (incr + 1);
        out_of_wall = true;
    }
    // Check left
    if ((!place_meeting(x-incr, y, obj_all)) && !out_of_wall && (x-incr > 16) && (x-incr < room_width-16) && (y > 16) && (y < room_height-16)) {
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-right
    if ((!place_meeting(x+incr, y-incr, obj_all)) && !out_of_wall && (x+incr > 16) && (x+incr < room_width-16) && (y-incr > 16) && (y-incr < room_height-16)) {
        y -= (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-right
    if ((!place_meeting(x+incr, y+incr, obj_all)) && !out_of_wall && (x+incr > 16) && (x+incr < room_width-16) && (y+incr > 16) && (y+incr < room_height-16)) {
        y += (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-left
    if ((!place_meeting(x-incr, y+incr, obj_all)) && !out_of_wall && (x-incr > 16) && (x-incr < room_width-16) && (y+incr > 16) && (y+incr < room_height-16)) {
        y += (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-left
    if ((!place_meeting(x-incr, y-incr, obj_all)) && !out_of_wall && (x-incr > 16) && (x-incr < room_width-16) && (y-incr > 16) && (y-incr < room_height-16)) {
        y -= (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    incr += 1;
}
