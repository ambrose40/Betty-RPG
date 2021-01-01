/// @description change room
global.gameLoaded = true;

global.targetRoom = rBeach;
global.targetDirectionPlayer = oPlayer.direction;
global.targetXPlayer = 112;
global.targetYPlayer = 80;
room_goto(rBeach);

global.gameLoaded = false;