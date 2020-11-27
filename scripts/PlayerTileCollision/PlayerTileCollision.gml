function PlayerTileCollision() {
	var _collision = false;
		
	//Horizontal Tiles
	if (tilemap_get_at_pixel(collisionMap, oPlayer.x + oPlayer.hSpeed, oPlayer.y))
	{
		_collision = true;
	}

	//Vertical Tiles
	if (tilemap_get_at_pixel(collisionMap, oPlayer.x, oPlayer.y + oPlayer.vSpeed))
	{
		_collision = true;
	}

	return _collision;
}
