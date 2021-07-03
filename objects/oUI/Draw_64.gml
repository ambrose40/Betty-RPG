/// @description Draw GUI

// Draw Player health
var _playerHealth = global.playerHealth;
var _playerHealthMax = global.playerHealthMax;
var _playerHealthFrac = frac(_playerHealth);
_playerHealth -= _playerHealthFrac;

for (var i = 1; i <= _playerHealthMax; i++) {
	var _imageIndex = (i > _playerHealth);
	if (i == _playerHealth + 1) {
		_imageIndex += (_playerHealthFrac > 0);
		_imageIndex += (_playerHealthFrac > 0.25);
		_imageIndex += (_playerHealthFrac > 0.5);
	}
	draw_sprite(sHealth, _imageIndex, 8 + ((i-1) * 14), 8);
}

// Draw Player coins
var _xx, _yy;

// Coin icon
_xx = 28;
_yy = 31;

draw_sprite(sCoinUI, 0, _xx, _yy);

// Coin text
draw_set_color(c_black);
draw_set_font(fText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

_xx += sprite_get_width(sCoinUI) + 4;
_yy = 27;

var _str = string(global.coinsAmount);
draw_text(_xx+1, _yy, _str);
draw_text(_xx-1, _yy, _str);
draw_text(_xx, _yy+1, _str);
draw_text(_xx, _yy-1, _str);
draw_set_color(c_white);
draw_text(_xx, _yy, _str);

//Draw Item box
_xx = 8;
_yy = 27;

draw_sprite(sItemUIBox,0,_xx,_yy);
if (global.playerHasAnyItems) {
	draw_sprite(sItemUI,global.playerEquipped,_xx,_yy);

	if (global.playerAmmo[global.playerEquipped] != -1) {
		draw_set_font(fText11);
		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);
		draw_set_colour(c_white);
		draw_text(
		_xx + sprite_get_width(sItemUIBox)+1, 
		_yy + sprite_get_height(sItemUIBox)+1,
		string(global.playerAmmo[global.playerEquipped]));
	}
}

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
	draw_sprite(sEnergy, _imageIndex, RESOLUTION_W - ((_playerEnergyMax - i) * 14) - 24, 8);
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
	DrawHelp("F1 - Help\nF2 - Save game, F3 - Load game\nF4 - Save screenshot, G - Record GIF\nM - Map\nR - Restart game, T - Show mission\nCtrl - Main attack\nTab - Follow Betty\nHome - Rest\nAlt - Use item\nSpace - Roll/Skip/Activate",  RESOLUTION_W / 2, RESOLUTION_H / 2, RESOLUTION_W - 8 , RESOLUTION_H - 8);
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