// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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
	with (pEntity)
	{
		var _saveEntity = 
		{
			obj : object_get_name(object_index),
			y : y,
			x : x,
			direction : direction,
			z : z,
			lifted : lifted,
			thrown : thrown,
			entityActivateArgs : entityActivateArgs,
			entityActivateScript : entityActivateScript,
			entityCollision : entityCollision,
			entityFragment : entityFragment,
			entityFragmentCount : entityFragmentCount,
			entityHitScript : entityHitScript,
			entityNPC : entityNPC,
			entityShadow : entityShadow,
			entityThrowBreak : entityThrowBreak,
			entityThrowDistance : entityThrowDistance,
			visible : visible,
		}
		array_push(_saveData, _saveEntity);
	}

	var _saveStruct = 
	{
		currentRoom: roomname,
		/*
		player : {
			x : oPlayer.x,
			y : oPlayer.y,
			direction : oPlayer.direction,
		},
		bot : {
			x : oBot.x,
			y : oBot.y,
			direction : oBot.direction,
		},
		*/
		playerHealth : global.playerHealth,
		playerHealthMax : global.playerHealthMax,
		playerEnergy : global.playerEnergy,
		playerEnergyMax : global.playerEnergyMax,
		deathReason : global.deathReason,
		lastEnemyHurt : global.lastEnemyHurt,
		entities : _saveData,
	};

	//turn all this data into a JSON string and save it via a buffer
	var _string = json_stringify(_saveStruct);
	var _buffer = buffer_create(string_byte_length(_string) +1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, filename + ".json");
	buffer_delete(_buffer);

	show_debug_message("Game (" + roomname + ") saved! " + _string);
}

function LoadGame(filename) {
	//erase current game state
	if (file_exists(filename + ".json")) {
		var _buffer = buffer_load(filename + ".json");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		
		
		if (filename == "savegame") {
			// RoomTransition(TRANS_TYPE.SLIDE, asset_get_index(_loadData.currentRoom));
			global.gameLoaded = true;
			room_goto(asset_get_index(_loadData.currentRoom));
		} else {
			global.gameLoaded = false;
		}
	}
}