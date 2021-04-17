/// @desc Layer Management
global.iCamera = instance_create_layer(0,0,layer,oCamera);

layer_set_visible("Col", false);
PlayMainMusic();
var roomname = room_get_name(room);
LoadRoom(roomname);