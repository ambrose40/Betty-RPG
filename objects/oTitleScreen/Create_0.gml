titleVisible = 0.0;
keyPressed = false;
slotsVisible = 0.0;
slotSelected = 0;
loadingStarted = false;

for (var _slot = 0; _slot <= 2; _slot++) {
	var _folderName = "save" + string(_slot) + ".sav";
	_loadData[_slot] = -1;
	if (file_exists(GetSavePathWithSlot("savegame", _folderName))) {
		var _string = ReadJsonBufferWithSlot("savegame", _folderName);
	
		_loadData[_slot] = json_parse(_string);
	}
}