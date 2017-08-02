/// @description Moves an object out of a wall to the nearest open space.

var collision_object = argument0;

var incr = 1;
var out_of_wall = false;
while (place_meeting(x, y, collision_object)) {
    // Check up
    if ((!place_meeting(x, y-incr, collision_object)) && !out_of_wall && (x > sprite_width) && (x < room_width-sprite_width) && (y-incr > sprite_height) && (y-incr < room_height-sprite_height)) {
        y -= (incr + 1);
        out_of_wall = true;
    }
    // Check right
    if ((!place_meeting(x+incr, y, collision_object)) && !out_of_wall && (x+incr > sprite_width) && (x+incr < room_width-sprite_width) && (y > sprite_height) && (y < room_height-sprite_height)) {
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down
    if ((!place_meeting(x, y+incr, collision_object)) && !out_of_wall && (x > sprite_width) && (x < room_width-sprite_width) && (y+incr > sprite_height) && (y+incr < room_height-sprite_height)) {
        y += (incr + 1);
        out_of_wall = true;
    }
    // Check left
    if ((!place_meeting(x-incr, y, collision_object)) && !out_of_wall && (x-incr > sprite_width) && (x-incr < room_width-sprite_width) && (y > sprite_height) && (y < room_height-sprite_height)) {
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-right
    if ((!place_meeting(x+incr, y-incr, collision_object)) && !out_of_wall && (x+incr > sprite_width) && (x+incr < room_width-sprite_width) && (y-incr > sprite_height) && (y-incr < room_height-sprite_height)) {
        y -= (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-right
    if ((!place_meeting(x+incr, y+incr, collision_object)) && !out_of_wall && (x+incr > sprite_width) && (x+incr < room_width-sprite_width) && (y+incr > sprite_height) && (y+incr < room_height-sprite_height)) {
        y += (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-left
    if ((!place_meeting(x-incr, y+incr, collision_object)) && !out_of_wall && (x-incr > sprite_width) && (x-incr < room_width-sprite_width) && (y+incr > sprite_height) && (y+incr < room_height-sprite_height)) {
        y += (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-left
    if ((!place_meeting(x-incr, y-incr, collision_object)) && !out_of_wall && (x-incr > sprite_width) && (x-incr < room_width-sprite_width) && (y-incr > sprite_height) && (y-incr < room_height-sprite_height)) {
        y -= (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    incr += 1;
}
