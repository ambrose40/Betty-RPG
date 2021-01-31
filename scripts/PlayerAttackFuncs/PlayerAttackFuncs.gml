function CalcAttack(argument0, _damage, _knockback) {
	//Use attack hitbox & check for hits
	mask_index = argument0;
	var hitByAttackNow = ds_list_create()
	var hits = instance_place_list(x,y,pEntity,hitByAttackNow,false);
	if (hits > 0) {
		for (var i = 0; i < hits; i++) {
			//if this instance has not yet been hit by this attack, hit it
			var hitID = hitByAttackNow[| i]
			if (ds_list_find_index(hitByAttack,hitID) == -1) {
				ds_list_add(hitByAttack,hitID);
				with (hitID) {
					if (object_is_ancestor(object_index,pEnemy)) {
						HurtEnemy(id, _damage, other.id, _knockback);
					}
					else if (entityHitScript != -1) script_execute(entityHitScript);
				}
			}
		}
	}
	ds_list_destroy(hitByAttackNow);
	mask_index = sPlayer;
}

function HurtEnemy(_enemy, _damage, _source, _knockback) 
{
	if (oPlayer.state != PlayerStateDead) {
		PlayBattleMusic();
	}
	with (_enemy) {
		if (state != ENEMYSTATE.DIE) {
			enemyHP -= _damage;
			flash = 1;
	
			//Hurt or dead?
			if (enemyHP <= 0) {
				state = ENEMYSTATE.DIE;
			} else {
				if (state != ENEMYSTATE.HURT) statePrevious = state;
				state = ENEMYSTATE.HURT;
			}

			image_index = 0;
			if (_knockback != 0) {
				var _knockDirection = point_direction(x,y,(_source).x,(_source).y);
				xTo = x - lengthdir_x(_knockback,_knockDirection);
				yTo = y - lengthdir_y(_knockback,_knockDirection);
			}
		}
	}
}

function AttackSlash() {
	global.playerEnergy -= 0.005;
	// Attack just started
	if (sprite_index != sPlayerAttackSlash) {
		// Set up animation
		sprite_index = sPlayerAttackSlash;
		localFrame = 0;
		image_index = 0;
	
		// Clear hit list
		if (!ds_exists(hitByAttack,ds_type_list)) hitByAttack = ds_list_create(); 
		ds_list_clear(hitByAttack);
	}
	
	CalcAttack(sPlayerAttackSlashHB, 5, 10);
	// Update sprite
	PlayerAnimateSprite();
	if (animationEnd) {
		state = PlayerStateFree;
		animationEnd = false;
	}
}

function AttackRest() {
	global.playerEnergy += 0.003;
	global.playerHealth += 0.001;
	
	if (global.playerEnergy >= global.playerEnergyMax) {
		global.playerEnergy = global.playerEnergyMax;
	}
	if (global.playerHealth >= global.playerHealthMax) {
		global.playerHealth = global.playerHealthMax;
	}

	// Update sprite
	if (keyRest) {
		global.iRested = 0;
	}

	if (global.iRested == 1) {
		image_speed -= 0.01;
		z--;
		if (z < 0) {
			z = 0;
			state = PlayerStateFree;
			animationEnd = false;
			global.iRested = 0;
			image_speed = 0;
		}
	} else {
		image_speed += 0.01;
		z = z + 1.6;
		
		if (z > 15) {
			z = 15;
		}
	}
	
	if (image_speed > 1) {
		global.iRested = 1;
		image_speed = 1;
	}
}

function AttackDefend() {
	global.playerEnergy -= 0.001;
	invulnerable = 10;
	// Attack just started
	if (sprite_index != sPlayerAttackDefend) {
		// Set up animation
		sprite_index = sPlayerAttackDefend;
		localFrame = 0;
		image_index = 0;
	
		// Clear hit list
		if (!ds_exists(hitByAttack,ds_type_list)) hitByAttack = ds_list_create(); 
		ds_list_clear(hitByAttack);
	}
	CalcAttack(sPlayerAttackSlashHB, 1, 30);
	// Update sprite
	PlayerAnimateSprite();
	if (animationEnd) {
		state = PlayerStateFree;
		animationEnd = false;
	}
}

function AttackSpin() {
// TODO: Implement another spinning attack procedure
}

