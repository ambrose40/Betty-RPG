/// @desc Pause the Game

if (keyboard_check_pressed(vk_pause) && global.iMap == 0 && oUI.visible != false) {
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
	
	if (global.playerHealth <= 0) {
		with (oPlayer) state = PlayerStateDead;
	}
	
	if (global.playerEnergy <= 0) {
		global.deathReason = "Exhausted energy"
		with (oPlayer) state = PlayerStateDead;
	}
}

audio_sound_gain(global.snd, global.volume, 0);