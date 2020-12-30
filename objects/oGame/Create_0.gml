/// @desc Initialise & Globals
randomize();
global.gamePausedImageSpeed = 0;
global.gamePaused = false;
global.textSpeed = .75;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
screenShot = -1;
global.lastX = -1;
global.lastY = -1;
global.deathReason = "Permadeath!";
global.targetDirection = 0;
global.playerHealthMax = 2;
global.playerHealth = global.playerHealthMax;
global.lastEnemyHurt = ""
global.playerEnergyMax = 2;
global.playerEnergy = global.playerEnergyMax;
gifRecord = false;
global.iRested = 0;
global.iLifted = noone;

global.iCamera = instance_create_layer(0,0,layer,oCamera);
global.iUi = instance_create_layer(0,0,layer,oUI);
global.iMap = 0;
global.lastRoom = -1;
surface_resize(application_surface,RESOLUTION_W,RESOLUTION_H);
display_set_gui_size(RESOLUTION_W, RESOLUTION_H);
room_goto(ROOM_START);

