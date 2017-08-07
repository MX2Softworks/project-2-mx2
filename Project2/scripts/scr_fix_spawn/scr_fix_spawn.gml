/// @description Moves an object out of a wall to the nearest open space.

var collision_object = argument0;

var mask_width = (sprite_get_bbox_right(sprite_index) + 1) - sprite_get_bbox_left(sprite_index);
var mask_height = (sprite_get_bbox_bottom(sprite_index) + 1) - sprite_get_bbox_top(sprite_index);

var incr = 1;
var out_of_wall = false;
while (place_meeting(x, y, collision_object)) {
    // Check up
    if ((!place_meeting(x, y-incr, collision_object)) && !out_of_wall && (x > mask_width) && (x < room_width-mask_width) && (y-incr > mask_height) && (y-incr < room_height-mask_height)) {
        y -= (incr + 1);
        out_of_wall = true;
    }
    // Check right
    if ((!place_meeting(x+incr, y, collision_object)) && !out_of_wall && (x+incr > mask_width) && (x+incr < room_width-mask_width) && (y > mask_height) && (y < room_height-mask_height)) {
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down
    if ((!place_meeting(x, y+incr, collision_object)) && !out_of_wall && (x > mask_width) && (x < room_width-mask_width) && (y+incr > mask_height) && (y+incr < room_height-mask_height)) {
        y += (incr + 1);
        out_of_wall = true;
    }
    // Check left
    if ((!place_meeting(x-incr, y, collision_object)) && !out_of_wall && (x-incr > mask_width) && (x-incr < room_width-mask_width) && (y > mask_height) && (y < room_height-mask_height)) {
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-right
    if ((!place_meeting(x+incr, y-incr, collision_object)) && !out_of_wall && (x+incr > mask_width) && (x+incr < room_width-mask_width) && (y-incr > mask_height) && (y-incr < room_height-mask_height)) {
        y -= (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-right
    if ((!place_meeting(x+incr, y+incr, collision_object)) && !out_of_wall && (x+incr > mask_width) && (x+incr < room_width-mask_width) && (y+incr > mask_height) && (y+incr < room_height-mask_height)) {
        y += (incr + 1);
        x += (incr + 1);
        out_of_wall = true;
    }
    // Check down-left
    if ((!place_meeting(x-incr, y+incr, collision_object)) && !out_of_wall && (x-incr > mask_width) && (x-incr < room_width-mask_width) && (y+incr > mask_height) && (y+incr < room_height-mask_height)) {
        y += (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    // Check up-left
    if ((!place_meeting(x-incr, y-incr, collision_object)) && !out_of_wall && (x-incr > mask_width) && (x-incr < room_width-mask_width) && (y-incr > mask_height) && (y-incr < room_height-mask_height)) {
        y -= (incr + 1);
        x -= (incr + 1);
        out_of_wall = true;
    }
    incr += 1;
}
