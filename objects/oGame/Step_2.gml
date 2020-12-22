/// @desc Pause the Game


if (keyboard_check_pressed(vk_pause)) {
	global.gamePaused = !global.gamePaused;
	if (global.gamePaused) {
		with (all) {
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}
	} else {
		with (all) {
			image_speed = gamePausedImageSpeed;	
		}
	}
}
if (global.gamePaused) {
	with (oPlayer) {
		// direction = global.targetDirection;
		vSpeed = 0;
		hSpeed = 0;
		oPlayer.image_speed = 0.13;
		if (z < 10) {
			z++;
		}
	}
	
} else {
	with (oPlayer) {
		if (z > 0) {
			z--;
		}
	}
}
