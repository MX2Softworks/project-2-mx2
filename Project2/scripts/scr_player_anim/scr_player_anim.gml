/// @description Controls the current animation of the player.

prev_sprite = sprite_index;

// Idling.
	if (current_hspd == 0 && on_ground && !sliding && !rolling && !down_held) {
		if (prev_sprite == spr_player_crouch) {
			if (sprite_index != spr_player_stand) {
				image_index = 0;
			}
			sprite_index = spr_player_stand;
			anim_loop = false;
			anim_transition = true;
		} else if (!anim_transition) {
			if (sprite_index != spr_player_idle) {
				image_index = 0;
			}
			sprite_index = spr_player_idle;
			anim_loop = true;
		}
	}

// Running.
	if (current_hspd != 0 && on_ground && !sliding && !rolling && !down_held) {
		if (sprite_index != spr_fahad_player_test_1) {
			image_index = 0;
		}
		sprite_index = spr_fahad_player_test_1;
		anim_loop = true;
	}
	
// Jumping
	if (up && on_ground) {
		if (sprite_index != spr_player_jump) {
			image_index = 0;
		}
		sprite_index = spr_player_jump;
		anim_loop = false;
	}

// Falling.
	if (jumppeak && !dashing && !wall_grab && !wall_slide) {
		if (sprite_index != spr_player_fall) {
			image_index = 0;
		}
		sprite_index = spr_player_fall;
		anim_loop = false;
	}

// Sliding.
	if (sliding) {
		if (sprite_index != spr_player_slide) {
			image_index = 0;
		}
		sprite_index = spr_player_slide;
		anim_loop = false;
	}

// Rolling.
	if (rolling) {
		if (sprite_index != spr_player_roll) {
			image_index = 0;
		}
		sprite_index = spr_player_roll;
		anim_loop = true;
	}

// Crouching.
	if (on_ground && down_held && !sliding && !rolling) {
		if (prev_sprite == spr_player_slide) {
			if (sprite_index != spr_player_slide_to_crouch) {
				image_index = 0;
			}
			sprite_index = spr_player_slide_to_crouch;
			anim_loop = false;
			anim_transition = true;
		} else if (!anim_transition) {
			if (prev_sprite == spr_player_roll || prev_sprite == spr_player_slide_to_crouch) {
				sprite_index = spr_player_crouch;
				image_index = image_number - 1;
			}
			if (sprite_index != spr_player_crouch) {
				image_index = 0;
			}
			sprite_index = spr_player_crouch;
			anim_loop = false;
		}
	}

// Wall Slide.
	if (wall_slide) {
		if (sprite_index != spr_player_wall_slide) {
			image_index = 0;
		}
		sprite_index = spr_player_wall_slide;
		anim_loop = false;
	}

// Wall Grab.
	if (wall_grab) {
		sprite_index = spr_player_wall_slide;
		image_index = image_number - 1;
		anim_loop = false;
	}

// Dashing Horizontally.
	if (dashing && (dash_right || dash_left)) {
		if (sprite_index != spr_player_dash_horizontal) {
			image_index = 0;
		}
		sprite_index = spr_player_dash_horizontal;
		anim_loop = true;
	}

// Dash Vertically.
	if (dashing && dash_up) {
		if (sprite_index != spr_player_dash) {
			image_index = 0;
		}
		sprite_index = spr_player_dash;
		anim_loop = true;
	}


// Slow down the animation if time is slowed.
	if (anim_loop || image_speed != 0 || prev_sprite != sprite_index) {
		if (charging) {
			image_speed = 1 / charge_slow;
		} else {
			if (sprinting) {
				image_speed = 1.5;
			} else {
				image_speed = 1;
			}
		}
	}

// Make sure the sprite is facing the direction of movement.
	if (previous_hspd != 0) {
		image_xscale = sign(previous_hspd);
	}