/// @description 

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

if (global.targetXPlayer != -1)
{
	x = global.targetXPlayer;
	y = global.targetYPlayer;
	direction = global.targetDirectionPlayer;
}