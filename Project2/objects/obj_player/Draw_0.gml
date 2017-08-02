/// @description  Drawing

    draw_self();
    
// Collision Mask
    draw_rectangle_colour(obj_player.x-10, obj_player.y-15, obj_player.x+10, obj_player.y+14, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, true);

// Dash indicator
    if (charge_time > 0) {
        var charge_color;
		var charge_mod = charge_time % 500000;
        switch (charge_mod) {
            case 1:
                charge_color = c_maroon;
                break;
            case 2:
                charge_color = c_red;
                break;
            case 3:
                charge_color = c_yellow;
                break;
            case 4:
                charge_color = c_lime;
                break;
            case 5:
                charge_color = c_green;
                break;
            default:
                charge_color = c_green;
                break;
        }
        draw_rectangle_colour(obj_player.x-26, obj_player.y-26, obj_player.x+26, obj_player.y+26, charge_color, charge_color, charge_color, charge_color, true);
        draw_rectangle_colour(obj_player.x-26, obj_player.y-26, obj_player.x+26, obj_player.y-21, charge_color, charge_color, charge_color, charge_color, false);
        draw_rectangle_colour(obj_player.x-26, obj_player.y-26, obj_player.x-21, obj_player.y+26, charge_color, charge_color, charge_color, charge_color, false);
        draw_rectangle_colour(obj_player.x+21, obj_player.y-26, obj_player.x+26, obj_player.y+26, charge_color, charge_color, charge_color, charge_color, false);
        draw_rectangle_colour(obj_player.x-26, obj_player.y+21, obj_player.x+26, obj_player.y+26, charge_color, charge_color, charge_color, charge_color, false);
    }

