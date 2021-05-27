if (!global.gamePaused) {
	// Bounce
	if (bounceCount != 0) {
		bounce += (pi * bounceSpeed);		
		if (bounce > pi) {
			bounce -= pi;
			bounceHeight *= 0.6;
			bounceCount--;
		}
		z = sin(bounce) * bounceHeight;
	} else {
		z = 0;
	}
	
	// Friction
	fric = 0.05;
	if (z == 0) {
		fric = 0.10;
	}
	
	// Move
	x += lengthdir_x(spd,direction);
	y += lengthdir_y(spd,direction);
	if (tilemap_get_at_pixel(collisionMap, x, y)) {
		spd = 0;
	}
	spd = max(spd-fric,0);
}