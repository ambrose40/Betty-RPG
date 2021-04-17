/// @description Save room state
if (!global.gameLoad) {
	var roomname = room_get_name(room);

	if (roomname == "rBeach" 
	|| roomname == "rBeachCamp" 
	|| roomname == "rBeachShip" 
	|| roomname == "rBeachTent") {
		SaveGame(roomname);
	}
}