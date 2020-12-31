function NineSliceBoxStretched(argument0, argument1, argument2, argument3, argument4, argument5) {

	/// @desc NineSliceBoxStretched(sprite, x1, y1, x2, y2);
	/// @arg sprite
	/// @arg x1 left
	/// @arg y1 top
	/// @arg x2 right
	/// @arg y2 bottom
	/// @arg index image index

	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _index = argument5;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;

	// MIDDLE
	draw_sprite_part_ext(argument0, _index, _size, _size, 1, 1, _x1+_size, _y1+_size, _w-(_size*2), _h-(_size*2), c_white,1);

	// CORNERS
	//top left
	draw_sprite_part(argument0, _index, 0, 0, _size, _size, _x1, _y1);
	//top right
	draw_sprite_part(argument0, _index, _size*2, 0, _size, _size, _x1+_w-_size, _y1);
	//bottom left
	draw_sprite_part(argument0, _index, 0, _size*2, _size, _size, _x1, _y1+_h-_size);
	//bottom right
	draw_sprite_part(argument0, _index, _size*2, _size*2, _size, _size, _x1+_w-_size, _y1+_h-_size);

	//EDGES
	//left edge
	draw_sprite_part_ext(argument0, _index, 0, _size, _size, 1, _x1, _y1+_size, 1, _h-(_size*2), c_white,1);
	//right edge
	draw_sprite_part_ext(argument0, _index, _size*2, _size, _size, 1, _x1+_w-_size, _y1+_size , 1, _h-(_size*2), c_white, 1);
	//top edge
	draw_sprite_part_ext(argument0, _index, _size, 0, 1, _size, _x1+_size, _y1, _w-(_size*2), 1, c_white,1);
	//bottom edge
	draw_sprite_part_ext(argument0, _index, _size, _size*2, 1, _size, _x1+_size, _y1+_h-(_size), _w-(_size*2), 1, c_white,1);
}

function DrawCaption(text, subText, oX, oY, w, h) {
	draw_set_alpha(0.666);
	draw_set_colour(c_white);
	draw_rectangle(oX - w / 2, oY - h / 2, oX + w / 2, oY + h / 2, false);
	draw_set_font(fText)
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_colour(c_black);
	draw_text(oX, oY - h / 3, text);
	if (subText != "") {
		draw_set_font(fText11)
		draw_text(oX, oY + h / 8, subText);
	}
	draw_set_alpha(1);
}

function DrawHelp(text, oX, oY, w, h) {
	draw_set_alpha(0.666);
	draw_set_colour(c_white);
	draw_rectangle(oX - w / 2, oY - h / 2, oX + w / 2, oY + h / 2, false);
	draw_set_font(fText)
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_colour(c_black);
	draw_text(oX, oY - h / 2, text);
	draw_set_alpha(1);
}

function GetRoomName(room) {
	if (room == rBeach) {
		return "Beach";
	} else if (room == rBeachCamp) {
		return "Camping site";
	} else if (room == rBeachShip) {
		return "Ship Harbor";
	} else if (room == rBeachTent) {
		return "Inside tent";
	}
}