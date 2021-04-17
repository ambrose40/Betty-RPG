function SaveGame(filename) {
	if (global.iMap == 0) {
		currentRoom = room;
		var roomname = room_get_name(room);
	} else {
		currentRoom = global.lastRoom;
		var roomname = room_get_name(global.lastRoom);
	}
	// make save array
	var _saveData = array_create(0);
	
	//for every instance, create a struct and add it to the array
	with (pEntity) {
		if (object_is_ancestor(object_index, pEnemy)) {
			var _saveEntity =  {
				obj : object_get_name(object_index),
				y : y,
				x : x,
				direction : direction,
				z : z,
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
				visible : visible,
				persistent : persistent,
				// enemy object
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
			}
			array_push(_saveData, _saveEntity);
		} else {
			var _saveEntity =  {
			obj : object_get_name(object_index),
			y : y,
			x : x,
			direction : direction,
			z : z,
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
			visible : visible,
			persistent : persistent,
		}
		array_push(_saveData, _saveEntity);
		}
		
	}

	var _saveStruct = 
	{
		currentRoom: roomname,
		
		player : {
			x : global.targetXPlayer,
			y : global.targetYPlayer,
			direction : global.targetDirectionPlayer,
		},
		/*
		bot : {
			x : oBot.x,
			y : oBot.y,
			direction : oBot.direction,
		},
		*/
		
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
		entities : _saveData,
	};

	//turn all this data into a JSON string and save it via a buffer
	var _string = json_stringify(_saveStruct);
	var _buffer = buffer_create(string_byte_length(_string) +1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, filename + ".json");
	buffer_delete(_buffer);

	show_debug_message("Game (" + roomname + ") saved! " + _string);
	global.gameSave = false;
}

function LoadGame(filename) {
	if (file_exists(filename + ".json")) {
		var _buffer = buffer_load(filename + ".json");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		
		global.playerHasAnyItems = _loadData.playerHasAnyItems;
		global.playerEquipped = _loadData.playerEquipped;
		global.playerAmmo = _loadData.playerAmmo;
		global.playerItemUnlocked =_loadData.playerItemUnlocked;

		global.targetRoom = _loadData.targetRoom;
		/*
		global.saveXPlayer = _loadData.saveXPlayer;
		global.saveYPlayer = _loadData.saveYPlayer;
		*/
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
		with (oPlayer) {
			coinsAmount = _loadData.coinsAmount;
		}
		
		room_goto(asset_get_index(_loadData.currentRoom));
	}
}

function LoadRoom(roomname) {
	if (global.gameLoad) {
		roomname = "savegame";
	}
	if (file_exists(roomname + ".json")) {
		var _buffer = buffer_load(roomname + ".json");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		if (room == asset_get_index(_loadData.currentRoom)) {
			with (pEntity) {
				instance_destroy();
				show_debug_message("instance_destroy " + object_get_name(object_index));
			}

			while (array_length(_loadData.entities) > 0) {
				var _loadEntity = array_pop(_loadData.entities);
				var asset_id = asset_get_index(_loadEntity.obj);
				var obj_id = instance_create_layer(0, 0, layer, asset_id);
				with (obj_id)
				{				
					if (_loadEntity.obj == "oPlayer") {
						state = PlayerStateFree;
						global.targetXPlayer = _loadData.saveXPlayer;
						global.targetYPlayer = _loadData.saveYPlayer;
						global.targetDirectionPlayer = _loadData.saveDirection;
					}
					if (_loadEntity.obj == "oBot") {
						state = BotStateFree;
					}
				
					y = _loadEntity.y;
					x = _loadEntity.x;
					z = _loadEntity.z;
					direction = _loadEntity.direction;
					visible = _loadEntity.visible;
				
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
					
					if (object_is_ancestor(asset_id, pEnemy)) {
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
			
			show_debug_message("Game loaded! " + _string);
			global.gameLoad = false;
		}
	}
}