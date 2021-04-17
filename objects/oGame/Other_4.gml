/// @desc Layer Management
global.iCamera = instance_create_layer(0,0,layer,oCamera);

layer_set_visible("Col", false);
PlayMainMusic();
var roomname = room_get_name(room);

var _latest = global.gameLoad;

LoadRoom(roomname, _latest);
/*
if (_latest) {
	var _path = GetSavePath(roomname, _latest);
	file_delete(_path);
}
*/
