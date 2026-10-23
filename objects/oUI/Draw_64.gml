/// @description Draw GUI
// Keep health, energy, weapon and coins together in the top-left corner.
DrawPlayerHealth(global.playerHealth, global.playerHealthMax, 8, 8);

DrawPlayerCoins(8, 64, global.coinsAmount);

//Draw Item box
var _xx, _yy;
_xx = 8;
_yy = 40;

draw_sprite(sItemUIBox,0,_xx,_yy);
var _weaponText = "No weapon";
if (global.playerHasAnyItems) {
	draw_sprite(sItemUI,global.playerEquipped,_xx,_yy);
	switch (global.playerEquipped) {
		case ITEM.BOMB: _weaponText = "Bomb"; break;
		case ITEM.BOW: _weaponText = "Bow"; break;
		case ITEM.HOOK: _weaponText = "Hook"; break;
		default: _weaponText = "No weapon"; break;
	}
	if ((global.playerEquipped == ITEM.BOMB || global.playerEquipped == ITEM.BOW)
		&& global.playerAmmo[global.playerEquipped] != -1) {
		_weaponText += " x" + string(global.playerAmmo[global.playerEquipped]);
	}
}
var _textX = _xx + sprite_get_width(sItemUIBox) + 5;
var _textY = _yy + 2;
draw_set_font(fText10);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_black);
draw_text(_textX - 1, _textY, _weaponText);
draw_text(_textX + 1, _textY, _weaponText);
draw_text(_textX, _textY - 1, _weaponText);
draw_text(_textX, _textY + 1, _weaponText);
draw_set_colour(c_white);
draw_text(_textX, _textY, _weaponText);

// Draw Player energy
var _playerEnergy = global.playerEnergy;
var _playerEnergyMax = global.playerEnergyMax;
var _playerEnergyFrac = frac(_playerEnergy);
_playerEnergy -= _playerEnergyFrac;

for (var i = 1; i <= _playerEnergyMax; i++) {
	/*
	
	0.071428571
	0.142857143
	0.214285714
	0.285714286
	0.357142857
	0.428571429
	0.5
	0.571428571
	0.642857143
	0.714285714
	0.785714286
	0.857142857
	0.928571429

	*/
	var _imageIndex = (i > _playerEnergy);
	if (i == _playerEnergy + 1) {
		_imageIndex += (_playerEnergyFrac > 0);
		_imageIndex += (_playerEnergyFrac > 0.071428571);
		_imageIndex += (_playerEnergyFrac > 0.142857143);
		_imageIndex += (_playerEnergyFrac > 0.214285714);
		_imageIndex += (_playerEnergyFrac > 0.285714286);
		
		_imageIndex += (_playerEnergyFrac > 0.357142857);
		_imageIndex += (_playerEnergyFrac > 0.428571429);
		_imageIndex += (_playerEnergyFrac > 0.571428571);
		_imageIndex += (_playerEnergyFrac > 0.642857143);
		_imageIndex += (_playerEnergyFrac > 0.714285714);
		
		_imageIndex += (_playerEnergyFrac > 0.785714286);
		_imageIndex += (_playerEnergyFrac > 0.857142857);
		_imageIndex += (_playerEnergyFrac > 0.928571429);
	}
	draw_sprite(sEnergy, _imageIndex, 8 + ((i - 1) * 14), 22);
}

if (global.iMap == 1) {
	DrawCaption("MAP", GetRoomName(global.lastRoom), RESOLUTION_W / 2, RESOLUTION_H / 2, 100, 40);
} else if (!global.gamePaused && instance_exists(oPlayer) && oPlayer.state == PlayerStateDead) {
	DrawCaption("GAME OVER", global.deathReason, RESOLUTION_W / 2, RESOLUTION_H / 2, 100, 40);
}

// Show recording caption
if (oGame.gifRecord) {
	DrawCaption("REC", "*", RESOLUTION_W - 35, RESOLUTION_H - 15, 55, 25);
}
// Show help
if (keyboard_check(vk_f1)) {
	DrawHelp("F1 - Help\nF2 - Save game, F3 - Load game\nF4 - Save screenshot, G - Record GIF\nM - Map\nR - Restart game, T - Show mission\nCtrl - Main attack\nTab - Follow Betty\nHome - Rest\nQ/E - Previous/Next weapon\n1 - Bomb, 2 - Bow, 3 - Hook (unlocked)\nAlt - Use selected weapon\nSpace - Roll/Skip/Activate",  RESOLUTION_W / 2, RESOLUTION_H / 2, RESOLUTION_W - 8 , RESOLUTION_H - 8);
}

// Show stats
if (keyboard_check(ord("C"))) {
	DrawHelp("Coins: " + string(global.coinsAmount) + "\nHealth: " + string(global.playerHealth) + "\nEnergy: " + string(global.playerEnergy),  RESOLUTION_W / 2, RESOLUTION_H / 2, RESOLUTION_W - 8 , RESOLUTION_H - 8);
}

// Pause Screen
if (global.gamePaused && global.iMap == 0) {
	draw_set_color(c_black);
	draw_set_alpha(0.75);
	draw_rectangle(0, 0, RESOLUTION_W, RESOLUTION_H, false);
	draw_set_alpha(1.0);
	draw_set_color(c_white);
	draw_set_font(fText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(RESOLUTION_W * 0.5, RESOLUTION_H * 0.5, "...Game Paused...");
	for (var i = 0; i < array_length(pauseOption); i++) {
		var _print = "";
		if (i == pauseOptionSelected) {
			_print += "> " + pauseOption[i] + " <";
		} else {
			_print += pauseOption[i];
			draw_set_alpha(0.7);
		}
		draw_text(RESOLUTION_W * 0.5, RESOLUTION_H * 0.5 + (18 + (i * 12)), _print);
		draw_set_alpha(1.0);
	}
}
