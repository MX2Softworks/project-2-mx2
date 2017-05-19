/// @description  Spawn

switch(global.last_room) {
    case rm_two:
        obj_player.x = obj_door_1.x+16;
        obj_player.y = obj_door_1.y;
        break;
    case rm_three:
        obj_player.x = obj_door_2.x+16;
        obj_player.y = obj_door_2.y;
        break;
    case rm_four:
        obj_player.x = obj_door_3.x+16;
        obj_player.y = obj_door_3.y;
        break;
    default:
        break;
}

switch(room) {
    case rm_one:
        if (!instance_exists(obj_key_1) && global.key_1_collected != true) {
            instance_create(640, 320, obj_key_1);
        }
        break;
    case rm_two:
        if (!instance_exists(obj_key_2) && global.key_2_collected != true) {
            instance_create(992, 192, obj_key_2);
        }
        break;
    case rm_three:
        if (!instance_exists(obj_key_3) && global.key_3_collected != true) {
            instance_create(128, 384, obj_key_3);
        }
        break;
}

