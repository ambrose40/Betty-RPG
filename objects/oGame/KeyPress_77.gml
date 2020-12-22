/// @description Show map
if (global.iMap == 0) {
	global.lastX = oPlayer.x;
	global.lastY = oPlayer.y;
	global.lastRoom = room;
	global.targetRoom = rMap;
	global.targetDirection = oPlayer.direction;
	if (global.lastRoom == rBeach) {
		global.targetX = 216;
		global.targetY = 176;
	} else if (global.lastRoom == rBeachCamp) {
		global.targetX = 304;
		global.targetY = 232;
	} else if (global.lastRoom == rBeachShip) {
		global.targetX = 128;
		global.targetY = 176;
	}
	room_goto(rMap);
	global.iMap = 1;
	global.gamePaused = true;
	PlayMapMusic();
} else {
	global.gamePaused = false;
	global.targetX = global.lastX;
	global.targetY = global.lastY;
	room_goto(global.lastRoom);
	global.iMap = 0;
	global.lastRoom = -1;
	PlayMainMusic();
}