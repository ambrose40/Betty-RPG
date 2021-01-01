/// @description Show map
if (global.iMap == 0) {
	global.lastX = oPlayer.x;
	global.lastY = oPlayer.y;
	global.lastRoom = room;
	global.targetRoom = rMap;
	global.targetDirectionPlayer = oPlayer.direction;
	if (global.lastRoom == rBeach) {
		global.targetXPlayer = 216;
		global.targetYPlayer = 176;
	} else if (global.lastRoom == rBeachCamp) {
		global.targetXPlayer = 304;
		global.targetYPlayer = 232;
	} else if (global.lastRoom == rBeachShip) {
		global.targetXPlayer = 128;
		global.targetYPlayer = 176;
	}
	room_goto(rMap);
	global.iMap = 1;
	global.gamePaused = true;
	PlayMapMusic();
} else {
	global.gamePaused = false;
	global.targetXPlayer = global.lastX;
	global.targetYPlayer = global.lastY;
	room_goto(global.lastRoom);
	global.iMap = 0;
	global.lastRoom = -1;
	PlayMainMusic();
}