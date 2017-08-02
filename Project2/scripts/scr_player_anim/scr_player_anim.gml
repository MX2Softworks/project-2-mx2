/// @description Controls the current animation of the player.

// Idling.
	if (current_hspd == 0 && on_ground && !sliding && !rolling && !down_held) {
		if (sprite_index != spr_player_idle) {
			image_index = 0;
		}
		sprite_index = spr_player_idle;
	}

// Running.
	if (current_hspd != 0 && on_ground && !sliding && !rolling && !down_held) {
		if (sprite_index != spr_fahad_player_test_1) {
			image_index = 0;
		}
		sprite_index = spr_fahad_player_test_1;
	}


// Slow down the animation if time is slowed.
	if (charging) {
		image_speed = 1 / charge_slow;
	} else {
		image_speed = 1;
	}

// Make sure the sprite is facing the direction of movement.
	if (previous_hspd != 0) {
		image_xscale = sign(previous_hspd);
	}