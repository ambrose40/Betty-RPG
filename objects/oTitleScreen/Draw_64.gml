if (titleVisible > 0) {
	draw_sprite(sTitle, 0, 0, -RESOLUTION_H + titleVisible * RESOLUTION_H);
	draw_set_alpha(titleVisible * abs(sin(get_timer() * 0.000001 * pi)));
	draw_sprite(sTitle, 1, 0, 0);
	draw_set_alpha(1.0);
}

if (slotsVisible > 0) {
	// Draw save slots
	draw_set_alpha(slotsVisible);
	for (var _slot = 0; _slot <= 2; _slot++) {
		// Draw the boxes
		var _y = 16 + _slot * 48;
		var _x = 160;
		var _img = 2;
		
		if (slotSelected = _slot) {
			_img = 3;
			draw_sprite(sMenuPlayer, 0, _x - 32, _y + 24);
		}
		NineSliceBoxStretched(sTextBoxBg, _x, _y, 312, _y + 48, _img);
		
		// Draw the save data (if exists)
		draw_set_color(c_white);
		draw_set_font(fText);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		if (_loadData[_slot] == -1) { // empty save slot
			draw_text(_x + 8, _y + 8, "Start new game");
		} else {
			draw_text(_x + 8, _y + 8, RoomToAreaName(_loadData[_slot].currentRoom));
			
			// Draw health
			DrawPlayerHealth(_loadData[_slot].playerHealth, _loadData[_slot].playerHealthMax, _x + 48, _y + 24);
			
			// Draw money 
			DrawPlayerCoins(_x + 8, _y + 28, _loadData[_slot].coinsAmount);
		}
	}
	draw_set_alpha(1.0);
}