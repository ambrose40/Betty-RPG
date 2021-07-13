function DrawPlayerHealth(_health, _healthMax, _x, _y) {
	// Draw Player health
	var _playerHealth = _health;
	var _playerHealthMax = _healthMax;
	var _playerHealthFrac = frac(_playerHealth);
	_playerHealth -= _playerHealthFrac;

	for (var i = 1; i <= _playerHealthMax; i++) {
		var _imageIndex = (i > _playerHealth);
		if (i == _playerHealth + 1) {
			_imageIndex += (_playerHealthFrac > 0);
			_imageIndex += (_playerHealthFrac > 0.25);
			_imageIndex += (_playerHealthFrac > 0.5);
		}
		draw_sprite(sHealth, _imageIndex, _x + ((i-1) * 14), _y);
	}
}

function DrawPlayerCoins(_xx, _yy, _amount) {
	// Draw Player coins
	// Coin icon
	draw_sprite(sCoinUI, 0, _xx, _yy);

	// Coin text
	draw_set_color(c_black);
	draw_set_font(fText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	_xx += sprite_get_width(sCoinUI) + 4;
	_yy = _yy - 4;

	var _str = string(_amount);
	draw_text(_xx + 1, _yy, _str);
	draw_text(_xx - 1, _yy, _str);
	draw_text(_xx, _yy + 1, _str);
	draw_text(_xx, _yy - 1, _str);
	draw_set_color(c_white);
	draw_text(_xx, _yy, _str);
}