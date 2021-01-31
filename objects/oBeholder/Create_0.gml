event_inherited();
state = ENEMYSTATE.WANDER;

//Enemy Sprites
sprMove = sBeholder;
sprAttack = sBeholderAttack;
sprDie = sBeholderDie;
sprHurt = sBeholderHurt;
enemyScript[ENEMYSTATE.WANDER] = EnemyWander;
enemyScript[ENEMYSTATE.CHASE] = EnemyChase;
enemyScript[ENEMYSTATE.ATTACK] = EnemyAttack;
enemyScript[ENEMYSTATE.HURT] = EnemyHurt;
enemyScript[ENEMYSTATE.DIE] = EnemyDie;

entityDropList = [oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin, oCoin];