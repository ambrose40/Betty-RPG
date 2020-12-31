function BotStateFree() {
	//Movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	BotCollision();

	//Update Sprite Index
	var _oldSprite = sprite_index;
	if (inputMagnitude != 0)
	{
		direction = inputDirection
		sprite_index = spriteRun;
		global.playerEnergy -= 0.0001;
	} else sprite_index = spriteIdle;
	if (_oldSprite != sprite_index) localFrame = 0;

	//Update Image Index
	BotAnimateSprite();
}
