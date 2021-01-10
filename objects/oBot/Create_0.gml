state = BotStateFree;
stateAttack = AttackSlash;
hitByAttack = -1;
lastState = state;

z = 0;
flash = 0;
r_color = 1;
g_color = 0;
b_color = 0;
lifted = 0;
thrown = false;
uFlash = shader_get_uniform(shWhiteFlash,"flash");
uRColor = shader_get_uniform(shWhiteFlash,"r_color");
uGColor = shader_get_uniform(shWhiteFlash,"g_color");
uBColor = shader_get_uniform(shWhiteFlash,"b_color");

liftZ[0] = 13;
liftZ[1] = 14;
liftZ[2] = 15;
liftZ[3] = 14;
liftZ[4] = 13;
liftZ[5] = 14;
liftZ[6] = 15;
liftZ[7] = 14;

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

// Taking damage
invulnerable = 0;
flashShader = shWhiteFlash;

animationEndScript = -1;

spriteRoll = sBotRoll;
spriteRun = sBotRun;
spriteIdle = sBot;
localFrame = 0;

targetX = -1;
targetY = -1;
targetDirection = -1;

if (global.targetXBot != -1)
{
	x = global.targetXBot;
	y = global.targetYBot;
	direction = global.targetDirectionBot;
}