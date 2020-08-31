function AttackSlash() {
	//Attack just started
	if (sprite_index != sPlayerAttackSlash) 
	{
		//Set up animation
		sprite_index = sPlayerAttackSlash;
		localFrame = 0;
		image_index = 0;
	
		//Clear hit list
		if (!ds_exists(hitByAttack,ds_type_list)) hitByAttack = ds_list_create(); 
		ds_list_clear(hitByAttack);
	}

	CalcAttack(sPlayerAttackSlashHB);

	///Update sprite
	PlayerAnimateSprite();

	if (animationEnd)
	{
		state = PlayerStateFree;
		animationEnd = false;
	}


}
