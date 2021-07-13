function NineSliceBoxStretched(_sprite, _x1, _y1, _x2, _y2, _index) {

	/// @desc NineSliceBoxStretched(sprite, x1, y1, x2, y2, index);
	/// @arg sprite
	/// @arg x1 left
	/// @arg y1 top
	/// @arg x2 right
	/// @arg y2 bottom
	/// @arg index image index

	var _size = sprite_get_width(_sprite) / 3;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;

	// MIDDLE
	draw_sprite_part_ext(_sprite, _index, _size, _size, 1, 1, _x1+_size, _y1+_size, _w-(_size*2), _h-(_size*2), c_white, draw_get_alpha());

	// CORNERS
	//top left
	draw_sprite_part(_sprite, _index, 0, 0, _size, _size, _x1, _y1);
	//top right
	draw_sprite_part(_sprite, _index, _size*2, 0, _size, _size, _x1+_w-_size, _y1);
	//bottom left
	draw_sprite_part(_sprite, _index, 0, _size*2, _size, _size, _x1, _y1+_h-_size);
	//bottom right
	draw_sprite_part(_sprite, _index, _size*2, _size*2, _size, _size, _x1+_w-_size, _y1+_h-_size);

	//EDGES
	//left edge
	draw_sprite_part_ext(_sprite, _index, 0, _size, _size, 1, _x1, _y1+_size, 1, _h-(_size*2), c_white, draw_get_alpha());
	//right edge
	draw_sprite_part_ext(_sprite, _index, _size*2, _size, _size, 1, _x1+_w-_size, _y1+_size , 1, _h-(_size*2), c_white, draw_get_alpha());
	//top edge
	draw_sprite_part_ext(_sprite, _index, _size, 0, 1, _size, _x1+_size, _y1, _w-(_size*2), 1, c_white, draw_get_alpha());
	//bottom edge
	draw_sprite_part_ext(_sprite, _index, _size, _size*2, 1, _size, _x1+_size, _y1+_h-(_size), _w-(_size*2), 1, c_white, draw_get_alpha());
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
	draw_set_alpha(1.0);
}

function DrawHelp(text, oX, oY, w, h) {
	draw_set_alpha(0.666);
	draw_set_colour(c_white);
	draw_rectangle(oX - w / 2, oY - h / 2, oX + w / 2, oY + h / 2, false);
	draw_set_font(fText10)
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_colour(c_black);
	draw_text(oX, oY - h / 2, text);
	draw_set_alpha(1.0);
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
	} else if (room == rCave) {
		return "Dangerous Cave";
	}
}

function CurrentTimeString() {
	return string(current_year) + "_" + string(current_month) + "_" + string(current_day) + "_" + string(current_hour) + "_" + string(current_minute) + "_" + string(current_second);
}

function GetSavePath(filename, _latest) {
	var _dir_name = global.saveFolder;
	if (_latest) {
		// var _folderName = "save" + string(_slot) + ".sav";
		_dir_name = "save" + string(global.gameSaveSlot) + ".sav";
	} 
	if !directory_exists(_dir_name) {
		directory_create(_dir_name);
	}
	var _path = _dir_name + "\\" + filename + ".json";
	return _path;
}

function GetSavePathWithSlot(filename, _dir_name) {
	if !directory_exists(_dir_name) {
		directory_create(_dir_name);
	}
	var _path = _dir_name + "\\" + filename + ".json";
	return _path;
}

function ReadJsonBufferWithSlot(_filename, _dir_name) {
	var _path = GetSavePathWithSlot(_filename, _dir_name);
	var _buffer = buffer_load(_path);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	show_debug_message("File (" + _filename + ") succesfully read!");
	
	return _string;
}

function SaveJsonBuffer(_string, _filename) {
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	var _path = GetSavePath(_filename, false);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _path);
	buffer_delete(_buffer);

	show_debug_message("File (" + _filename + ") succesfully written!");
}

function ReadJsonBuffer(_filename, _latest) {
	var _path = GetSavePath(_filename, _latest);
	var _buffer = buffer_load(_path);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	show_debug_message("File (" + _filename + ") succesfully read!");
	
	return _string;
}

function CopyJsonBuffer(filename) {
	var _path = GetSavePath(filename, false);
	var _buffer = buffer_load(_path);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	var _path = GetSavePath(filename, true);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _path);
	buffer_delete(_buffer);
	
	show_debug_message("File (" + filename + ") succesfully copied!");
}

function CopyDefaultJsonBuffer(filename, newname) {
	var _path = GetSavePath(filename, false);
	var _buffer = buffer_load(_path);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	var _path = GetSavePath(newname, true);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _path);
	buffer_delete(_buffer);
	
	show_debug_message("File (" + filename + ") succesfully copied!");
}

function GetCurrentRoomName() {
	if (global.iMap == 0) {
		var roomname = room_get_name(room);
	} else {
		var roomname = room_get_name(global.lastRoom);
	}
	
	return roomname;
}

function RoomToAreaName(_room) {
	switch(_room) {
		case "rCave": return "Dangerous Cave"; break;
		case "rBeach": return "Beach"; break;
		case "rBeachShip": return "Ship Harbour"; break;
		case "rBeachTent": return "Inside tent"; break;
		case "rBeachCamp": return "Camping site"; break;
		default: return "Unknown Area"; break;
	}
}