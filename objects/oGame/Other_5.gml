/// @description Save Room state// comment here
show_debug_message("Exit: " + room_get_name(room));
if (instance_exists(oPlayer)) {
	show_debug_message("Exit: " + string(oPlayer.x));
	show_debug_message("Exit: " + string(oPlayer.y));
}

if (global.iMap == 0) {
	var roomname = room_get_name(room);
} else {
	var roomname = room_get_name(global.lastRoom);
}
if (!global.gameLoaded) {
//	SaveGame(roomname);
}