event_inherited();
state = BotStateFree;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
distanceRoll = 72;
botDirection = 0;
botMoving = 0;
spriteRoll = sBotRoll;
spriteRun = sBotRun;
spriteIdle = sBot;
localFrame = 0;
speedBonk = 1.5;
distanceBonk = 40;
distanceBonkHeight = 12;
z = 0;
