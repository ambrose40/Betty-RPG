event_inherited();
state = ENEMYSTATE.WANDER;

//Enemy Sprites
sprMove = sBeholder;
sprAttack = sBeholderAttack;
sprDie = sBeholderDie;
sprHurt = sBeholderHurt;

//Enemy Scripts
enemyScript[ENEMYSTATE.WANDER] = BeholderWander;
enemyScript[ENEMYSTATE.CHASE] = BeholderChase;
enemyScript[ENEMYSTATE.ATTACK] = BeholderAttack;
enemyScript[ENEMYSTATE.HURT] = BeholderHurt;
enemyScript[ENEMYSTATE.DIE] = BeholderDie;