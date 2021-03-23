function PlayerStateDead() {
	if (sprite_index != sPlayerDie && sprite_index != sPlayerDead) {
		PlayDeathMusic();
		if (oPlayer.coinsAmount > 0) {
			var _array = array_create(oPlayer.coinsAmount, oCoin);
			DropItems(x, y, _array);
		} 
		
		if (global.playerAmmo[ITEM.BOMB] > 0) {
			var _array = array_create(global.playerAmmo[ITEM.BOMB], oBombDrop);
			DropItems(x, y, _array);
			global.playerAmmo[ITEM.BOMB] = 0;
		} 
		
	}
	hSpeed = 0;
	vSpeed = 0;
	
	// if just arriving in this state
	if (sprite_index != sPlayerDie) && (sprite_index != sPlayerDead) {
		// update the sprite
		sprite_index = sPlayerDie;
		image_index = 0;
		image_speed = 0.8;
	}
	
	// Animation ending this frame?
	if (image_index + image_speed > image_number) {
		if (sprite_index == sPlayerDie) {
			image_speed = max(0, image_speed - 0.03);
			if (image_speed < 0.07) {
				image_index = 0;
				sprite_index = sPlayerDead;
				image_speed = 1.0;
			}
		} else {
			image_speed = 0;
			image_index = image_number - 1;
			global.targetXPlayer = -1;
			global.targetYPlayer = -1;
			
			RoomTransition(TRANS_TYPE.SLIDE, room);
		}
	}
}