/// @desc Layer Management
global.iCamera = instance_create_layer(0,0,layer,oCamera);

layer_set_visible("Col", false);
PlayMainMusic();
var roomname = room_get_name(room);

if (roomname == "rBeach") {
	LoadRoom(roomname, global.isLatest[ROOMS.R_BEACH]);
}
if (roomname == "rBeachCamp") {
	LoadRoom(roomname, global.isLatest[ROOMS.R_BEACH_CAMP]);
}
if (roomname == "rBeachShip") {
	LoadRoom(roomname, global.isLatest[ROOMS.R_BEACH_SHIP]);
}
if (roomname == "rBeachTent") {
	LoadRoom(roomname, global.isLatest[ROOMS.R_BEACH_TENT]);
}
