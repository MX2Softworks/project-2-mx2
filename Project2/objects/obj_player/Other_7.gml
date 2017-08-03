/// Controls the looping of animations.

// Prevent a non-looping animation from looping.
	if (!anim_loop) {
		image_speed = 0;
		image_index = image_number - 1;
	}

// Mark a transition animation as ended.
	if (anim_transition) {
		anim_transition = false;
	}