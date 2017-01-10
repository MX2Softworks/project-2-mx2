/// scr_player_move_state()

if (right || left) {
    hspd += (right - left)*2;
    
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
