/// scr_player_move_state()

if (!place_meeting(x, y+1, obj_solid)) {
    vspd += grav;
}

if (up) {
    vspd += -16;
    
    if (vspd > 20) {
        vspd = 20;
    }
    if (vspd < -20) {
        vspd = -20;
    }
}

if (right || left) {
    hspd += (right - left)*2/*acc constant*/;
    
    if (hspd > maxspd) {
        hspd = maxspd;
    }
    if (hspd < -maxspd) {
        hspd = -maxspd;
    }
} else {
    // Apply friction here (player released left/right)
    hspd = 0;
}

if (hspd != 0) {
    image_xscale = sign(hspd);
}

scr_move(obj_solid);
