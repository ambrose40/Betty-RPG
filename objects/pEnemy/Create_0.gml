// Inherit the parent event
event_inherited();

//Intrinsic variables
state = ENEMYSTATE.IDLE;
hSpeed = 0;
vSpeed = 0;
xTo = xstart;
yTo = ystart;
dir = 0;
aggroCheck = 0;
aggroCheckDuration = 5;
stateTarget = state;
statePrevious = state;
stateWait = 0;
stateWaitDuration = 0;
target = noone;
//Enemy Sprites
sprMove = sSlime;

//Enemy Stats
timePassed = 0
waitDuration = 60;
wait = 0;

//Enemy Scripts
//Enemy Scripts
enemyScript[ENEMYSTATE.WANDER] = EnemyWander;
enemyScript[ENEMYSTATE.CHASE] = EnemyChase;
enemyScript[ENEMYSTATE.ATTACK] = EnemyAttack;
enemyScript[ENEMYSTATE.HURT] = EnemyHurt;
enemyScript[ENEMYSTATE.DIE] = EnemyDie;
enemyScript[ENEMYSTATE.IDLE] = -1;
enemyScript[ENEMYSTATE.WAIT] = EnemyWait;






