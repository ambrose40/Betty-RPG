/// @desc Initialise & Globals
randomize();
global.saveFolder = "Save_" + CurrentTimeString();
global.gamePausedImageSpeed = 0;
global.gamePaused = false;
global.textSpeed = .75;
global.targetRoom = -1;
global.targetXPlayer = -1;
global.targetYPlayer = -1;
global.targetDirectionPlayer = 0;

global.saveXPlayer = -1;
global.saveYPlayer = -1;
global.saveDirectionPlayer = 0;

global.targetXBot = -1;
global.targetYBot = -1;
global.targetDirectionBot = 0;
global.gameLoad = false;
global.gameSave = false;

global.questStatus = array_create(QUEST.TYPE_COUNT, -1);
global.questStatus[QUEST.THE_HAT_QUEST] = 0;
global.coinsAmount = 0;
screenShot = -1;
global.lastX = -1;
global.lastY = -1;

global.deathReason = "Permadeath!";
global.lastEnemyHurt = ""

global.playerHealthMax = 3;
global.playerHealth = global.playerHealthMax;
global.playerEnergyMax = 3;
global.playerEnergy = global.playerEnergyMax;

//Items
global.playerHasAnyItems = false;
global.playerEquipped = ITEM.BOMB;
global.playerAmmo = array_create(ITEM.TYPE_COUNT, 0);
global.playerItemUnlocked = array_create(ITEM.TYPE_COUNT, false);

gifRecord = false;
global.iRested = 0;
global.iLifted = noone;

global.isLatest = array_create(ROOMS.TYPE_COUNT, false)
global.volume = 0.3;
global.snd = -1;

global.iMap = 0;
global.lastRoom = -1;
global.gameSaveSlot = 1;
surface_resize(application_surface,RESOLUTION_W,RESOLUTION_H);
display_set_gui_size(RESOLUTION_W, RESOLUTION_H);
global.iCamera = instance_create_layer(0, 0, layer, oCamera);
global.iUi = instance_create_layer(0, 0, layer, oUI);
room_goto(ROOM_START);
