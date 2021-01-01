/// @desc Layer Management
show_debug_message("Enter: " + room_get_name(room));
if (instance_exists(oPlayer)) {
	show_debug_message("Enter: " + string(oPlayer.x));
	show_debug_message("Enter: " + string(oPlayer.y));
}
global.iCamera = instance_create_layer(0,0,layer,oCamera);
global.iUi = instance_create_layer(0,0,layer,oUI);

layer_set_visible("Col", false);

/// @description Save Room state
if (global.iMap == 0) {
	var roomname = room_get_name(room);
} else {
	var roomname = room_get_name(global.lastRoom);
}
if (!global.gameLoaded) {
//	LoadGame(roomname);
} else {
	filename = "savegame";
	//erase current game state
	if (file_exists(filename + ".json")) {
		var _buffer = buffer_load(filename + ".json");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		if (room == asset_get_index(_loadData.currentRoom)) {
			// layer_destroy_instances(layer)
			with (pEntity) {
				instance_destroy();
				show_debug_message("instance_destroy " + object_get_name(object_index));
			}

			while (array_length(_loadData.entities) > 0) {
				var _loadEntity = array_pop(_loadData.entities);
				with (instance_create_layer(0,0,layer,asset_get_index(_loadEntity.obj)))
				{
					if (_loadEntity.obj == "oPlayer") {
						state = PlayerStateFree;
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
					entityActivateArgs = _loadEntity.entityActivateArgs;
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
			}
		
			global.deathReason = _loadData.deathReason;
			global.lastEnemyHurt = _loadData.lastEnemyHurt;
	
			global.playerEnergy = _loadData.playerEnergy;
			global.playerEnergyMax = _loadData.playerEnergyMax;
		
			global.playerHealth = _loadData.playerHealth;
			global.playerHealthMax = _loadData.playerHealthMax;

			show_debug_message("Game loaded! " + _string);
		}
	}
}
