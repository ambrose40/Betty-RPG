state = PlayerStateFree;
stateAttack = AttackSlash;
lastState = state;

r_color = 1;
g_color = 1;
b_color = 1;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
speedBonk = 1.5;
speedHook = 3.0;

distanceHook = 88;
distanceRoll = 72;
distanceBonk = 40;
distanceBonkHeight = 12;

lifted = 0;
thrown = false;
invulnerable = 0;
hitByAttack = -1;

flash = 0;
flashShader = shWhiteFlash;

animationEndScript = -1;

coinsAmount = 0;

spriteRoll = sPlayerRoll;
spriteRun = sPlayerRun;
spriteIdle = sPlayer;

localFrame = 0;
z = 0;

hook = 0;
hookX = 0;
hookY = 0;
hookStatus = HOOKSTATUS.INACTIVE;
hookedEntity = noone;
hookedCollectible = false;
hookSize = sprite_get_width(sHookChain);

entityDropList = -1;

depth = -1000;
image_speed = 0;
