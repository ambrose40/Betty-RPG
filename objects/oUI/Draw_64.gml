/// @description Draw GUI

// Draw Player health
var _playerHealth = global.playerHealth;
var _playerHealthMax = global.playerHealthMax;
var _playerHealthFrac = frac(_playerHealth);
_playerHealth -= _playerHealthFrac;

for (var i = 1; i <= _playerHealthMax; i++) 
{
	var _imageIndex = (i > _playerHealth);
	if (i == _playerHealth + 1) 
	{
		_imageIndex += (_playerHealthFrac > 0);
		_imageIndex += (_playerHealthFrac > 0.25);
		_imageIndex += (_playerHealthFrac > 0.5);
	}
	draw_sprite(sHealth, _imageIndex, 8 + ((i-1) * 16), 8);
}

// Draw Player Energy
var _playerEnergy = global.playerEnergy;
var _playerEnergyMax = global.playerEnergyMax;
var _playerEnergyFrac = frac(_playerEnergy);
_playerEnergy -= _playerEnergyFrac;

for (var i = 1; i <= _playerEnergyMax; i++) 
{
	var _imageIndex = (i > _playerEnergy);
	if (i == _playerEnergy + 1) 
	{
		_imageIndex += (_playerEnergyFrac > 0);
		_imageIndex += (_playerEnergyFrac > 0.25);
		_imageIndex += (_playerEnergyFrac > 0.5);
	}
	draw_sprite(sEnergy, _imageIndex, RESOLUTION_W - ((_playerEnergyMax-i) * 16) - 24, 8);
}

// Draw captions
if (global.gamePaused) && (global.iMap == 0) {
	DrawCaption("PAUSE", "", RESOLUTION_W / 2, RESOLUTION_H / 2, 100, 40);
} else if (global.iMap == 1) {
	DrawCaption("MAP", GetRoomName(global.lastRoom), RESOLUTION_W / 2, RESOLUTION_H / 2, 100, 40);
} else if (oPlayer.state == PlayerStateDead) {
	DrawCaption("GAME OVER", global.deathReason, RESOLUTION_W / 2, RESOLUTION_H / 2, 100, 40);
}

if (oGame.gifRecord) {
	DrawCaption("REC", "*", RESOLUTION_W - 35, RESOLUTION_H - 15, 55, 25);
}

if (keyboard_check(vk_f1)) {
	DrawCaption("F1 - Help\nM - Map\nR - Restart game\nT - Show mission\nCtrl - Main attack\nTab - Defence\nHome - Meditate", "",  RESOLUTION_W / 2, RESOLUTION_H / 2, RESOLUTION_W - 8 , RESOLUTION_H - 8);
}