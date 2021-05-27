function SaveGame(_filename) {
	var _roomname = GetCurrentRoomName();
	// Make save array
	var _saveData = array_create(0);
	var _fragData = array_create(0);
	var _saveLifted = noone;
	with (oFragment) {
		_saveFragment = {
			obj : object_get_name(object_index),
			y : y,
			x : x,
			xstart : xstart,
			ystart : ystart,
			image_speed : image_speed,
			image_xscale : image_xscale,
			z : z,
			depth : depth,
			direction : direction,
			visible : visible,
			persistent : persistent,
			bounce : bounce,
			bounceCount : bounceCount,
			bounceSpeed : bounceSpeed,
			bounceHeight : bounceHeight,
			deteriorate : deteriorate,
			deteriorateAfter : deteriorateAfter,
			deteriorateTime : deteriorateTime,
			spd : spd,
			fric : fric,
		};
		array_push(_fragData, _saveFragment);
	}
	
	// For every instance, create a struct and add it to the array
	with (pEntity) {
		var _saveEntity = {};
		if (object_is_ancestor(object_index, pEnemy)) {
			_saveEntity = {
				// general object part
				obj : object_get_name(object_index),
				y : y,
				x : x,
				xstart : xstart,
				ystart : ystart,
				image_speed : image_speed,
				image_xscale : image_xscale,
				z : z,
				depth : depth,
				direction : direction,
				visible : visible,
				persistent : persistent,
				// entity object part
				old_id : old_id,
				lifted : lifted,
				thrown : thrown,
				entityActivateArgs : entityActivateArgs,
				entityActivateScript : entityActivateScript,
				entityActivateType : entityActivateType,
				entityCollision : entityCollision,
				entityDropList : entityDropList,
				entityFragment : entityFragment,
				entityFragmentCount : entityFragmentCount,
				entityHitScript : entityHitScript,
				entityHookable : entityHookable,
				entityNPC : entityNPC,
				entityShadow : entityShadow,
				entityThrowBreak : entityThrowBreak,
				entityThrowDistance : entityThrowDistance,
				// enemy object part
				enemyAggroRadius : enemyAggroRadius,
				enemyAttackRadius : enemyAttackRadius,
				enemyDamageTouch : enemyDamageTouch,
				enemyForceTouch : enemyForceTouch,
				enemyHP : enemyHP,
				enemySpeed : enemySpeed,
				enemyWanderDistance : enemyWanderDistance,
				state : state,
				hSpeed : hSpeed,
				vSpeed : vSpeed,
				xTo : xTo,
				yTo : yTo,
				dir : dir,
				aggroCheck : aggroCheck,
				aggroCheckDuration : aggroCheckDuration,
				stateTarget : stateTarget,
				statePrevious : statePrevious,
				stateWait : stateWait,
				stateWaitDuration : stateWaitDuration,
				timePassed : timePassed,
				waitDuration : waitDuration,
				wait : wait,
				target : target,
				entityDropList : entityDropList,
			};
		} else {
			_saveEntity = {
				// general object part
				obj : object_get_name(object_index),
				y : y,
				x : x,
				xstart : xstart,
				ystart : ystart,
				image_speed : image_speed,
				image_xscale : image_xscale,
				z : z,
				depth : depth,
				direction : direction,
				visible : visible,
				persistent : persistent,
				// entity object part
				old_id : old_id,
				lifted : lifted,
				thrown : thrown,
				entityActivateArgs : entityActivateArgs,
				entityActivateScript : entityActivateScript,
				entityActivateType : entityActivateType,
				entityCollision : entityCollision,
				entityDropList : entityDropList,
				entityFragment : entityFragment,
				entityFragmentCount : entityFragmentCount,
				entityHitScript : entityHitScript,
				entityHookable : entityHookable,
				entityNPC : entityNPC,
				entityShadow : entityShadow,
				entityThrowBreak : entityThrowBreak,
				entityThrowDistance : entityThrowDistance,	
			};
		}
		if (_saveEntity.lifted <= 0.0) {
			array_push(_saveData, _saveEntity);
		} else {
			_saveLifted = _saveEntity;
		}
	}

	var _saveStruct = {
		currentRoom: _roomname,
			
		playerHasAnyItems : global.playerHasAnyItems,
		playerEquipped : global.playerEquipped,
		playerAmmo : global.playerAmmo,
		playerItemUnlocked : global.playerItemUnlocked,
		
		targetRoom : global.targetRoom,
		targetXPlayer : global.targetXPlayer,
		targetYPlayer : global.targetYPlayer,
		targetDirectionPlayer : global.targetDirectionPlayer,

		targetXBot : global.targetXBot,
		targetYBot : global.targetYBot,
		targetDirectionBot : global.targetDirectionBot,

		questStatus : global.questStatus,
		
		playerAmmo: global.playerAmmo,
		playerHealth : global.playerHealth,
		playerHealthMax : global.playerHealthMax,
		playerEnergy : global.playerEnergy,
		playerEnergyMax : global.playerEnergyMax,
		deathReason : global.deathReason,
		lastEnemyHurt : global.lastEnemyHurt,
		saveXPlayer: global.gameSave ? oPlayer.x : global.saveXPlayer,
		saveYPlayer: global.gameSave ? oPlayer.y : global.saveYPlayer,
		saveDirection: global.gameSave ? oPlayer.direction : global.saveDirectionPlayer,
		lastX : global.lastX,
		lastY : global.lastY,
		coinsAmount : oPlayer.coinsAmount,
		iLifted : global.iLifted,
		lifted : _saveLifted,
		entities : _saveData,
		fragments : _fragData,
	};

	// Turn all this data into a JSON string and save it via a buffer
	var _string = json_stringify(_saveStruct);
	SaveJsonBuffer(_string, _filename);
	
	show_debug_message("Game saved! " + _string);
	global.gameSave = false;
}

function LoadGame(filename, _latest) {
	if (file_exists(GetSavePath(filename, _latest))) {
		var _string = ReadJsonBuffer(filename, _latest);
	
		var _loadData = json_parse(_string);
		
		global.playerHasAnyItems = _loadData.playerHasAnyItems;
		global.playerEquipped = _loadData.playerEquipped;
		global.playerAmmo = _loadData.playerAmmo;
		global.playerItemUnlocked =_loadData.playerItemUnlocked;

		global.targetRoom = _loadData.targetRoom;

		global.targetXBot = _loadData.targetXBot;
		global.targetYBot = _loadData.targetYBot;
		global.targetDirectionBot = _loadData.targetDirectionBot;

		global.questStatus = _loadData.questStatus;
			
		global.lastX = _loadData.lastX;
		global.lastY = _loadData.lastY;
		global.deathReason = _loadData.deathReason;
		global.lastEnemyHurt = _loadData.lastEnemyHurt;
	
		global.playerEnergy = _loadData.playerEnergy;
		global.playerEnergyMax = _loadData.playerEnergyMax;
		
		global.playerHealth = _loadData.playerHealth;
		global.playerHealthMax = _loadData.playerHealthMax;
		room_goto(asset_get_index(_loadData.currentRoom));
	}
}

function LoadRoom(_roomname, _latest) {
	if (global.gameLoad) {
		_roomname = "savegame";
	}
	if (file_exists(GetSavePath(_roomname, _latest))) {
		var _string = ReadJsonBuffer(_roomname, _latest);
	
		var _loadData = json_parse(_string);
		if (room == asset_get_index(_loadData.currentRoom)) {
			with (pEntity) {
				if (!lifted) {
					instance_destroy();
					show_debug_message("instance_destroy " + object_get_name(object_index));
				}
			}

			with (oFragment) {
				instance_destroy();
				show_debug_message("instance_destroy " + object_get_name(object_index));
			}

			while (array_length(_loadData.fragments) > 0) {
				var _loadEntity = array_pop(_loadData.fragments);
				var asset_id = asset_get_index(_loadEntity.obj);
				var obj_id = instance_create_layer(0, 0, layer, asset_id);
				with (obj_id) {		
					// general object
					y = _loadEntity.y;
					x = _loadEntity.x;
					xstart = _loadEntity.xstart;
					ystart = _loadEntity.ystart;
					image_speed = _loadEntity.image_speed;
					image_xscale = _loadEntity.image_xscale;
					z = _loadEntity.z;
					direction = _loadEntity.direction;
					visible = _loadEntity.visible;
					depth = _loadEntity.depth;
					persistent = _loadEntity.persistent;
					bounce = _loadEntity.bounce;
					bounceCount = _loadEntity.bounceCount;
					bounceSpeed = _loadEntity.bounceSpeed;
					bounceHeight = _loadEntity.bounceHeight;
					deteriorate = _loadEntity.deteriorate;
					deteriorateAfter = _loadEntity.deteriorateAfter;
					deteriorateTime = _loadEntity.deteriorateTime;
					spd = _loadEntity.spd;
					fric = _loadEntity.fric;
				}
			}
		
			while (array_length(_loadData.entities) > 0) {
				var _loadEntity = array_pop(_loadData.entities);
				var asset_id = asset_get_index(_loadEntity.obj);
				var obj_id = instance_create_layer(0, 0, layer, asset_id);
				with (obj_id) {				
					if (_loadEntity.obj == "oPlayer") {
						state = PlayerStateFree;
						global.targetXPlayer = _loadData.saveXPlayer;
						global.targetYPlayer = _loadData.saveYPlayer;
						global.targetDirectionPlayer = _loadData.saveDirection;
					}
					if (_loadEntity.obj == "oBot") {
						state = BotStateFree;
					}
					// general object
					y = _loadEntity.y;
					x = _loadEntity.x;
					xstart = _loadEntity.xstart;
					ystart = _loadEntity.ystart;
					image_speed = _loadEntity.image_speed;
					image_xscale = _loadEntity.image_xscale;
					z = _loadEntity.z;
					direction = _loadEntity.direction;
					visible = _loadEntity.visible;
					depth = _loadEntity.depth;
					persistent = _loadEntity.persistent;
					
					// entity object
					old_id = _loadEntity.old_id;
					lifted = _loadEntity.lifted;
					thrown = _loadEntity.thrown;
					entityActivateType = _loadEntity.entityActivateType;
					if (entityActivateType == "pickup") {
						entityActivateArgs = [id];
					} else {
						entityActivateArgs = _loadEntity.entityActivateArgs;
					}
					entityActivateScript = _loadEntity.entityActivateScript;
					entityCollision = _loadEntity.entityCollision;
					entityFragment = _loadEntity.entityFragment;
					entityFragmentCount = _loadEntity.entityFragmentCount;
					entityHitScript = _loadEntity.entityHitScript;
					entityNPC = _loadEntity.entityNPC;
					entityShadow = _loadEntity.entityShadow;
					entityThrowBreak = _loadEntity.entityThrowBreak;
					entityThrowDistance = _loadEntity.entityThrowDistance;
					
					if (object_is_ancestor(object_index, pEnemy)) {
						// enemy object
						enemyAggroRadius = _loadEntity.enemyAggroRadius;
						enemyAttackRadius = _loadEntity.enemyAttackRadius;
						enemyDamageTouch = _loadEntity.enemyDamageTouch;
						enemyForceTouch = _loadEntity.enemyForceTouch;
						enemyHP = _loadEntity.enemyHP;
						enemySpeed = _loadEntity.enemySpeed;
						enemyWanderDistance = _loadEntity.enemyWanderDistance;
						state = _loadEntity.state;
						hSpeed = _loadEntity.hSpeed;
						vSpeed = _loadEntity.vSpeed;
						xTo = _loadEntity.xTo;
						yTo = _loadEntity.yTo;
						dir = _loadEntity.dir;
						aggroCheck = _loadEntity.aggroCheck;
						aggroCheckDuration = _loadEntity.aggroCheckDuration;
						stateTarget = _loadEntity.stateTarget;
						statePrevious = _loadEntity.statePrevious;
						stateWait = _loadEntity.stateWait;
						stateWaitDuration = _loadEntity.stateWaitDuration;
						timePassed = _loadEntity.timePassed;
						waitDuration = _loadEntity.waitDuration;
						wait = _loadEntity.wait;
						target = _loadEntity.target;
						entityDropList = _loadEntity.entityDropList;
					}
				}
			}
			var _foundOldLifted = false;
			var _loadEntity = _loadData.lifted;
			if (_loadEntity != noone) {
				_foundOldLifted = CheckFoundOldLifted("rBeach", _loadEntity) 
									|| CheckFoundOldLifted("rBeachCamp", _loadEntity) 
									|| CheckFoundOldLifted("rBeachTent", _loadEntity) 
									|| CheckFoundOldLifted("rBeachShip", _loadEntity);
				if (_loadData.iLifted != noone && !_foundOldLifted) {
					var asset_id = asset_get_index(_loadEntity.obj);
					var obj_id = instance_create_layer(0, 0, layer, asset_id);
					with global.iLifted {
						instance_destroy();
					}
					global.iLifted = obj_id;
					with (obj_id) {
						// general object
						y = _loadEntity.y;
						x = _loadEntity.x;
						xstart = _loadEntity.xstart;
						ystart = _loadEntity.ystart;
						image_speed = _loadEntity.image_speed;
						image_xscale = _loadEntity.image_xscale;
						z = _loadEntity.z;
						direction = _loadEntity.direction;
						visible = _loadEntity.visible;
						depth = _loadEntity.depth;
						persistent = _loadEntity.persistent;
					
						// entity object
						old_id = _loadEntity.old_id;
						lifted = _loadEntity.lifted;
						grav = 0.1;
						thrown = _loadEntity.thrown;
						entityActivateType = _loadEntity.entityActivateType;
						entityActivateArgs = [id];
						entityActivateScript = _loadEntity.entityActivateScript;
						entityCollision = _loadEntity.entityCollision;
						entityFragment = _loadEntity.entityFragment;
						entityFragmentCount = _loadEntity.entityFragmentCount;
						entityHitScript = _loadEntity.entityHitScript;
						entityNPC = _loadEntity.entityNPC;
						entityShadow = _loadEntity.entityShadow;
						entityThrowBreak = _loadEntity.entityThrowBreak;
						entityThrowDistance = _loadEntity.entityThrowDistance;
					}

					with (oPlayer) {
						spriteIdle = sPlayerCarry;
						spriteRun = sPlayerRunCarry;
						spriteRoll = sPlayerRunCarry;
						sprite_index = spriteIdle;
					}
				}
			}
			with (oPlayer) {
				coinsAmount = _loadData.coinsAmount;
			}
			
			show_debug_message("Game loaded! " + _string);
			global.gameLoad = false;
			
			if (_roomname == "rBeach") {
				global.isLatest[ROOMS.R_BEACH] = false;
			}
			if (_roomname == "rBeachCamp") {
				global.isLatest[ROOMS.R_BEACH_CAMP] = false;
			}
			if (_roomname == "rBeachShip") {
				global.isLatest[ROOMS.R_BEACH_SHIP] = false;
			}
			if (_roomname == "rBeachTent") {
				global.isLatest[ROOMS.R_BEACH_TENT] = false;
			}
		}
	}
}

function UpdateAnimation() {
	// Update Sprite Index
	var _oldSprite = sprite_index;
	if (inputMagnitude != 0) {
		direction = inputDirection
		sprite_index = spriteRun;
		global.playerEnergy -= 0.0001;
	} else sprite_index = spriteIdle;
	if (_oldSprite != sprite_index) localFrame = 0;
}

function SaveLatestGame() {
	SaveGame("savegame");

	if (file_exists(GetSavePath("rBeach", false))) {
		CopyJsonBuffer("rBeach")
	}
	if (file_exists(GetSavePath("rBeachCamp", false))) {
		CopyJsonBuffer("rBeachCamp")
	}
	if (file_exists(GetSavePath("rBeachShip", false))) {
		CopyJsonBuffer("rBeachShip")
	}
	if (file_exists(GetSavePath("rBeachTent", false))) {
		CopyJsonBuffer("rBeachTent")
	}
	if (file_exists(GetSavePath("savegame", false))) {
		CopyJsonBuffer("savegame")
	}
}

function CheckFoundOldLifted(_roomname, _loadEntity) {
	var _foundOldLifted = false;
	if (file_exists(GetSavePath(_roomname, false))) {
		var _string = ReadJsonBuffer(_roomname, false);
	
		var _loadData = json_parse(_string);
		
		while (array_length(_loadData.entities) > 0) {
			var _oldEntity = array_pop(_loadData.entities);
			if (_oldEntity.old_id == _loadEntity.old_id) {
				_foundOldLifted = true;
				break;
			}
		}
	}
	return _foundOldLifted;
}