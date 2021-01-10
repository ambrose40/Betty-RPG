/// @desc Initialise & Globals
randomize();
global.gamePausedImageSpeed = 0;
global.gamePaused = false;
global.textSpeed = .75;
global.targetRoom = -1;
global.targetXPlayer = -1;
global.targetYPlayer = -1;
global.targetDirectionPlayer = 0;

global.targetXBot = -1;
global.targetYBot = -1;
global.targetDirectionBot = 0;
global.gameLoaded = false;

global.questStatus = ds_map_create();
global.questStatus[? "TheHatQuest"] = 0;

screenShot = -1;
global.lastX = -1;
global.lastY = -1;
global.deathReason = "Permadeath!";

global.playerHealthMax = 3;
global.playerHealth = global.playerHealthMax;
global.lastEnemyHurt = ""
global.playerEnergyMax = 3;
global.playerEnergy = global.playerEnergyMax;
gifRecord = false;
global.iRested = 0;
global.iLifted = noone;

global.volume = 0.2;
global.snd = -1;

global.iMap = 0;
global.lastRoom = -1;
surface_resize(application_surface,RESOLUTION_W,RESOLUTION_H);
display_set_gui_size(RESOLUTION_W, RESOLUTION_H);
global.iCamera = instance_create_layer(0,0,layer,oCamera);
global.iUi = instance_create_layer(0,0,layer,oUI);
room_goto(ROOM_START);

