/// scr_player_move_state()

if (right || left) {
    hspd += (right - left)*2;
    hspd_dir = right - left;
    
    if (hspd > maxspd) {
        hspd = maxspd;
    }
    if (hspd < -maxspd) {
        hspd = -maxspd;
    }
}

if (hspd != 0) {
    image_xscale = sign(hspd);
}

scr_move(obj_solid);
