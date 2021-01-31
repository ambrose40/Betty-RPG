state = PlayerStateFree;
stateAttack = AttackSlash;
hitByAttack = -1;
lastState = state;

r_color = 1;
g_color = 1;
b_color = 1;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));
depth = -1000;
image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
distanceRoll = 72;
speedBonk = 1.5;
distanceBonk = 40;
distanceBonkHeight = 12;
z = 0;

lifted = 0;
thrown = false;

// Taking damage
invulnerable = 0;
flash = 0;
flashShader = shWhiteFlash;

animationEndScript = -1;

coinsAmount = 666;

spriteRoll = sPlayerRoll;
spriteRun = sPlayerRun;
spriteIdle = sPlayer;
localFrame = 0;
